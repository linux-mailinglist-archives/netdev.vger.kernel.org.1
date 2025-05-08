Return-Path: <netdev+bounces-188811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD9AAAF006
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 02:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7A74C126D
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 00:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D2A54769;
	Thu,  8 May 2025 00:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0TBgbu6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A60136E
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 00:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746664990; cv=none; b=i27CuV9zAbOsMIbjE3N4Tev+8oQgZzCrl+GqMiBK9lqw5FE4/IxXQQ3HIDzGiNKCD26yIbN+EhiRcUCUinZ5jDtrH3hUccHKmGDwY6Pb+v1gazVaCxRmft4EaX0TtZA/yZzXVMqK5lGCufB0+V7aYVLddn/PAH4iSw8qBkhbz4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746664990; c=relaxed/simple;
	bh=tL5P9l59cxur9AbeTerRhcI4xrC16HkdPdL/pv6sTRg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lTuRJ5mwqL7v1t0RwmnULFlYpXhaOD76Mc99bBPBaMVYblx2k+3gZw5aROjgOdgOaLdBjjQAPEaQdWmge0pu+2m9cXiyn4SE6C2ldG0qQ3FLpwm1DyGtTS6my5yQfo8CFPph0kXKlZDIDjg2NPL9eI2B6ZUWzrnqVCvE4ZXgNys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0TBgbu6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471D2C4CEE2;
	Thu,  8 May 2025 00:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746664989;
	bh=tL5P9l59cxur9AbeTerRhcI4xrC16HkdPdL/pv6sTRg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b0TBgbu67PpCDNGjMLzMQjvuKSk21Rrrr6KU9ubHUP3lJcwO5Hzsh9YeU/JiW6zc7
	 qDnEkJlzaYcAlB8my7VZo9ZvSC3tn0kW30QEylpqr73mKQUJF11aNaYAGU5eiDhZv2
	 UwIHEUC0iBvUrHsml3MlfOJzlMfBT+RnbQj6b87bPAHju6M7TIx6nlkjW8utOOaGks
	 8b/NerjdQwi8UjVupanELvhOV6m+3V92NCWRia/2diJQ4f0QqoiDbE20FUH5sbM4PI
	 A68B3ZupK6Co1RFbF2RuLpkiBY83TWg9PntaFccXt1descjp+/vViw6DvGdrqTIibg
	 jppD3XbT82hpg==
Date: Wed, 7 May 2025 17:43:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Moshe Shemesh <moshe@nvidia.com>, netdev@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet
 <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Tariq Toukan
 <tariqt@nvidia.com>
Subject: Re: [RFC net-next 0/5] devlink: Add unique identifier to devlink
 port function
Message-ID: <20250507174308.3ec23816@kernel.org>
In-Reply-To: <aa57da6b-bb1b-4d77-bffa-9746c3fe94ba@nvidia.com>
References: <1745416242-1162653-1-git-send-email-moshe@nvidia.com>
	<20250424162425.1c0b46d1@kernel.org>
	<95888476-26e8-425b-b6ae-c2576125f484@nvidia.com>
	<20250428111909.16dd7488@kernel.org>
	<507c9e1f-f31a-489c-8161-3e61ae425615@nvidia.com>
	<20250501173922.6d797778@kernel.org>
	<d5241829-bd20-4c41-9dec-d805ce5b9bcc@nvidia.com>
	<20250505115512.0fa2e186@kernel.org>
	<c19e7dec-7aae-449d-b454-4078c8fbd926@nvidia.com>
	<20250506082032.1ab8f397@kernel.org>
	<aa57da6b-bb1b-4d77-bffa-9746c3fe94ba@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 May 2025 18:34:22 +0300 Mark Bloch wrote:
> >> Flow:
> >> 1. A user requests a container with networking connectivity.
> >> 2. Kubernetes allocates a VF on host X. An agent on the host handles VF
> >>    configuration and sends the PF number and VF index to the central
> >>    management software.  
> > 
> > What is "central management software" here? Deployment specific or
> > some part of k8s?  
> 
> It's the k8s API server.
> 
> >   
> >> 3. An agent on the DPU side detects the changes made on host X. Using
> >>    the PF number and VF index, it identifies the corresponding
> >>    representor, attaches it to an OVS bridge, and allows OVN to program
> >>    the relevant steering rules.  
> > 
> > What does it mean that DPU "detects it", what's the source and 
> > mechanism of the notification?
> > Is it communicating with the central SW during  the process?  
> 
> The agent (running in the ARM/DPU) listens for events from the k8s API server.

Interesting. So a deployment with no security boundaries. The internals
of the IPU and the k8s on the host are in the same domain of control.

So how does the user remotely power cycle the hosts?

What I'm getting at is that your mental model seems to be missing any
sort of HW inventory database, which lists all the hosts and how they
plug into the DC. The administrator of the system must already know
where each machine is exactly in the chassis for basic DC ops. And
that HW DB is normally queried in what you describe. If there is any
security domain crossing in the picture it will require cross checking
against that HW DB.

I don't think this is sufficiently well established to warrant new uAPI.
You can use a UUID and pass it via ndo_get_phys_port_id.

