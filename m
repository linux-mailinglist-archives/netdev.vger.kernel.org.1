Return-Path: <netdev+bounces-99531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6DE8D52EE
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 22:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8F91F25C2D
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 20:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74849612EB;
	Thu, 30 May 2024 20:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyErECBT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFB4208A0
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 20:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100112; cv=none; b=BVGApf39o2Oh3m9AtQskMfV8hwmJS2err0kLV6h0IUR9YMSrt6dZuClJfQMpWDLO01Cq5/qoaT/NdvJrY6vdtKVTe+vaBjZXLmQkVblqOGTMCtpRxJ8OLlKTedWayL5cnXs8F86si/Kq/gpDNlj3SJOxRmrxyPFh7Lf0+lqnuyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100112; c=relaxed/simple;
	bh=ZludX/d2a+c0a9UqFll3Zz2zxUlaAMTXsc+Gi5nKSP4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XvPCdKx1fJThNLxq/w5beH3Jge5e1auaUp7fpMH/qKk0JsOQbuK3uYlV0gonwfucTYb8EvIcMYGHSY7L/u4FMfG9c/zdEQqoDjWHlCO1GMJEEirUKN/+m6Lalz/ONdjdpqFTO+vxACDDA7kp8ve/tgUG4LQ5PZKcUBATEMXA7kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyErECBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7934DC32781;
	Thu, 30 May 2024 20:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717100111;
	bh=ZludX/d2a+c0a9UqFll3Zz2zxUlaAMTXsc+Gi5nKSP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HyErECBTL1H6WY3lVjQguN76wV8L9MNBEVpdIg3ZXslcQud0u1ipfJqjISamlmGbd
	 xVromlf2NoIP97n358CNSEq1kqppcdkTRQdq8KN5KU9HzgGbnUuDTMhpQFZp+tuOzO
	 hmg8QyhixiXujLtP2NJzsW7ikiJEpkYTxF/rXEnl6fka8FXv6ZM9onGCjpI9ib1QlZ
	 /xlq+0NL5awfZUt6BuE8WcvcBygHEAxG8hNuNN7EqU+SfQcKA279Sg5lMYIPAqnqzy
	 1eVuRHNDsbz+MgZY+3SCuCECNRcOH8FsHRt6EvhJ2q/w50IQqBZaQfYFjpdZe7okr2
	 4bzTx2oPCivxg==
Date: Thu, 30 May 2024 13:15:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, borisp@nvidia.com,
 gal@nvidia.com, cratiu@nvidia.com, rrameshbabu@nvidia.com,
 steffen.klassert@secunet.com, tariqt@nvidia.com
Subject: Re: [RFC net-next 01/15] psp: add documentation
Message-ID: <20240530131510.21243c94@kernel.org>
In-Reply-To: <20240530125120.24dd7f98@kernel.org>
References: <20240510030435.120935-1-kuba@kernel.org>
	<20240510030435.120935-2-kuba@kernel.org>
	<66416bc7b2d10_1d6c6729475@willemb.c.googlers.com.notmuch>
	<20240529103505.601872ea@kernel.org>
	<6657cc86ddf97_37107c29438@willemb.c.googlers.com.notmuch>
	<20240530125120.24dd7f98@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2024 12:51:20 -0700 Jakub Kicinski wrote:
> > I've mostly been concerned about the below edge cases.
> > 
> > If both peers are in TCP_ESTABLISHED for the during of the upgrade,
> > and data is aligned on message boundary, things are straightforward.
> > 
> > The retransmit logic is clear, as this is controlled by skb->decrypted
> > on the individual skbs on the retransmit queue.
> > 
> > That also solves another edge case: skb geometry changes on retransmit
> > (due to different MSS or segs, using tcp_fragment, tso_fragment,
> > tcp_retrans_try_collapse, ..) maintain skb->decrypted. It's not
> > possible that skb is accidentally created that combines plaintext and
> > ciphertext content.
> > 
> > Although.. does this require adding that skb->decrypted check to
> > tcp_skb_can_collapse?  
> 
> Good catch. The TLS checks predate tcp_skb_can_collapse() (and MPTCP).
> We've grown the check in tcp_shift_skb_data() and the logic
> in tcp_grow_skb(), both missing the decrypted check.
> 
> I'll send some fixes, these are existing bugs :(

I take that back, we can depend on EOR like TLS does.

