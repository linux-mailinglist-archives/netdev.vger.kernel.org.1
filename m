Return-Path: <netdev+bounces-78455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0335875303
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 16:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9144C1F23B8E
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 15:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD3212DDBA;
	Thu,  7 Mar 2024 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8TacDjK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3729E1DFC1
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709824887; cv=none; b=ZG6nv1qoehcqLpzICCOSOb5y/7XBBt4nFBuyTXVhpeo8bxGqn26Eg1vS2VvKrP0BPWyugYCsmvFDlObDobWjcyK/Z94PfNKgAat8njYigfc6KKSkQ/Jgyl/ciZuzwHCBWB/i5t1Ye8+k1vbP723SBnOlouD8xWuSIc+khbbgspU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709824887; c=relaxed/simple;
	bh=NuuWUySIWRYHHcbzKGjhvB9LP4iVI6gOtcvuKJA7u3c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUyWvSdVLCDRgArnH+miuNvFenLMhFKSmMPKvYomJl99TsDJL/WKJ1D2zjhnAXPU3yYoF+yi5hoGjx0YmTv25YH7y31et2S5dMnYAWv+EbmKWLkiqgPKywW6c9K+X1yYjkRJ33XUk+GAQgZ95HxLG/DOKOhtVKiU10kZyEe9Zo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8TacDjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F55C433C7;
	Thu,  7 Mar 2024 15:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709824886;
	bh=NuuWUySIWRYHHcbzKGjhvB9LP4iVI6gOtcvuKJA7u3c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T8TacDjKYlJOswwpfPJYzluYpUT9p9dLL4CAgrbwbDR3FCPB9o0FtV4gW2eKmJG7N
	 /F2N43EKbPByvduPkDef1H6hh/Nh4sSSEJ06Z6VmDWecyCAOCvbHRUzhPtSG0OMLa7
	 DDfetUoTqb+ev2VNRHi2UbRY6TcwYKogjkhsrEcXwGQ4SvEM+H9bjcsqh1VFbcLDZh
	 aAbLztOr80f74eTECHqizQ5OURweGVXSi8wRz0JLhVx6ALTcq1y5+zPJlC5SHwwnxi
	 g5PAhZjU9Txen9adZgO6NxsNVGDU6qiiGwn0eTXJ57f7LP/Q3h5e1YVRMaKlxiGsUo
	 wGsB0ZNhxa2hA==
Date: Thu, 7 Mar 2024 07:21:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jacob
 Keller <jacob.e.keller@intel.com>, Jiri Pirko <jiri@resnulli.us>, Stanislav
 Fomichev <sdf@google.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v3 5/6] doc/netlink: Allow empty enum-name in
 ynl specs
Message-ID: <20240307072125.6391e8fc@kernel.org>
In-Reply-To: <m2a5nah0j5.fsf@gmail.com>
References: <20240306231046.97158-1-donald.hunter@gmail.com>
	<20240306231046.97158-6-donald.hunter@gmail.com>
	<20240306182620.5bc5ecc2@kernel.org>
	<m2a5nah0j5.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 07 Mar 2024 09:08:30 +0000 Donald Hunter wrote:
> > On Wed,  6 Mar 2024 23:10:45 +0000 Donald Hunter wrote:  
> >> Update the ynl schemas to allow the specification of empty enum names
> >> for all enum code generation.  
> >
> > Does ethtool.yaml work for you without this change? 
> > It has an empty enum.
> >
> > IDK how the check the exact schema version, I have:
> >
> > $ rpm -qa | grep jsonschema
> > python3-jsonschema-specifications-2023.7.1-1.fc39.noarch
> > python3-jsonschema-4.19.1-1.fc39.noarch
> >
> > The patch seems legit, but would be good to note for posterity 
> > what made this fail out of the sudden.  
> 
> As I mentioned in the earlier thread, the schema already allowed empty
> enum-name in definitions. The patch adds it to enum-name in
> attribute-sets and operations.

Not sure how I missed that, thanks!

