Return-Path: <netdev+bounces-174345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04205A5E58A
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 21:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4DF63B4159
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 20:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41DA1EE00D;
	Wed, 12 Mar 2025 20:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSi0zR4T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF932136A
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 20:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812148; cv=none; b=nlMXmUhoZJ9iKa5XzCBzgu4LaEnhCdFLolXzhvgmqU4CTYVBD24FhnVLy+8YG4bGUBTLH4jf/ZSGoykYrugzBqE6V/ie6Vf7XMAzCHlc2OUXclJ38xRZS+Myz2BM7ABE2V4YKl/uQtzEbOOMeK+PC52rQZowJvF0AtoDmVRY76Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812148; c=relaxed/simple;
	bh=O/H1A6Kcv0oy2d6d42mJsjBE8c6sMN1FEH53WedKkdE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5Xqlkdx8YQvtzHMiKUgvsjqznqY+9cmmqsGU1PcG2BdamhSh3eEkYphb8gFA62UcS3cXBOSeaZtZngqCGx8SeQ4u+EfBAwa30DrCIQIWDWakvZqh62CAYr2IV4e2YAcyE8zUpM86iwOeOczFakWQ1dZs0aazhAjnqQWxf9FGVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSi0zR4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E6DC4CEDD;
	Wed, 12 Mar 2025 20:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741812148;
	bh=O/H1A6Kcv0oy2d6d42mJsjBE8c6sMN1FEH53WedKkdE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VSi0zR4T8ngUQClByrPoHVy15hn4KH/MV2zKAXamBeHTxeaZkowJMPRGqk54PW9K4
	 iHf8YYnpPY7E9vEdyf77pq0mCt1gWL/bcMhUSSaNbZhp1GWGgLTLlHFCNXTFM2STQA
	 NTJLlj7+o9CB9iWk2ngE7JZDApCW8kOblXCb5iND/GDCZaxzUMWn8IIrotMWXJuxv7
	 gx7tDpC4xvTzI/ffQe9PjOYdWsq/dbRtNkiBhTr1mgkYLUQgJVbX/1GjA9Agg6ulb2
	 e+HOf46HGWQvFDfCkEueAZKA4mbzfPgSyu3I9i4IKXIRf8YVtdCI1XOu7MpRTgYmA+
	 u/4c38sOQG0ow==
Date: Wed, 12 Mar 2025 21:42:22 +0100
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
 <sdf@fomichev.me>
Subject: Re: [PATCH net-next] netdevsim: 'support' multi-buf XDP
Message-ID: <20250312214222.0feb96ec@kernel.org>
In-Reply-To: <Z9AVs2laMDqYPp6S@localhost.localdomain>
References: <20250311092820.542148-1-kuba@kernel.org>
	<Z9AVs2laMDqYPp6S@localhost.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Mar 2025 11:51:31 +0100 Michal Kubiak wrote:
> > -	if (ns->netdev->mtu > NSIM_XDP_MAX_MTU) {
> > +	if (bpf->prog && !bpf->prog->aux->xdp_has_frags &&
> > +	    ns->netdev->mtu > NSIM_XDP_MAX_MTU) {
> >  		NSIM_EA(bpf->extack, "MTU too large w/ XDP enabled");  
> 
> Would it make sense to extend this error message to indicate that single-buf
> XDP is being used? For example: "MTU too large w/ single-buf XDP enabled"?
> (Please consider this as a suggestion only.)

Fair point, tho I'd rather push as is. It fixes the CI and some other
tests match on this exact error message so I'd need to fully retest 
the respin..

