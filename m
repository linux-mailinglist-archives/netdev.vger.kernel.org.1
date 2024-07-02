Return-Path: <netdev+bounces-108321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35F091ED5A
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 05:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4E061C2136B
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 03:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E492179B2;
	Tue,  2 Jul 2024 03:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSls/s+h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4D815E85;
	Tue,  2 Jul 2024 03:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719889937; cv=none; b=BujYR7csuSakCWBg7TTBjdty+281MJwLvaFrX3EAVKVXMsQA7DFpc+RrpMuQXmPSI6ZwgzwvT9Q4nzD7WlwyaDD8Rzvr4Vmovir1rFRAOVFvIHyh9nxEBb1bDhTfBMKvVe9ybqPevR5mWt19NBECej6mHyoRVcY+clDNQfkfdx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719889937; c=relaxed/simple;
	bh=g57wDJqO51QRd2mNXPafAwNNLUrIUIKYgDxCev0y2i0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jxhq/rOB4dogPw39BT59XNBOOsRtDp1U+DiLF1E0M8ivya1WDxARa/+lQnxd7g5Qh/Ljje1yPjekXKHkaKAisxjCkO9qm+0jSroofgLE24fn9/k8/hFQBIeFVYpr/ggLM+5iL19RShZpUCU2WMMa0cVtyRvgdrTNw3q8pthYdZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSls/s+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCCAC116B1;
	Tue,  2 Jul 2024 03:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719889936;
	bh=g57wDJqO51QRd2mNXPafAwNNLUrIUIKYgDxCev0y2i0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uSls/s+hRtaUrTGpU5VcbgzIn67F/rRF8hCHQIg6ofzNGguzw/0agKRfvpMZWJpKC
	 H7ufFdv9JzxP56S6KkfZ/AfCTPHUC1UHs7Xw8VvJWbX0nOBoz9273rykfVA5n/ZPdn
	 eRQqKkzPRiwycFXnRAHNztvWy4691OzmjHMWgr5JBho/9kju1anEHX6Nbw+/rYG0Jq
	 tjmWgr+sq0iyIkiGg1LwQRFqyu8jJAoGs0A1ikdgA44diVPtd1ITerFXr35S9tKSQ3
	 OeWxasPOTOV1etDCNHKsOHnl0dFh5hiMO9cv1oyUsob1B7UGPJj57OGd3ZvCePmiJ2
	 sd/gG56zMqqug==
Date: Mon, 1 Jul 2024 20:12:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
 <sgoutham@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: Re: [net-next PATCH v7 00/10] Introduce RVU representors
Message-ID: <20240701201215.5b68e164@kernel.org>
In-Reply-To: <20240628133517.8591-1-gakula@marvell.com>
References: <20240628133517.8591-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jun 2024 19:05:07 +0530 Geetha sowjanya wrote:
> This series adds representor support for each rvu devices.
> When switchdev mode is enabled, representor netdev is registered
> for each rvu device. In implementation of representor model, 
> one NIX HW LF with multiple SQ and RQ is reserved, where each
> RQ and SQ of the LF are mapped to a representor. A loopback channel
> is reserved to support packet path between representors and VFs.
> CN10K silicon supports 2 types of MACs, RPM and SDP. This
> patch set adds representor support for both RPM and SDP MAC
> interfaces.
> 
> - Patch 1: Refactors and exports the shared service functions.
> - Patch 2: Implements basic representor driver.
> - Patch 3: Add devlink support to create representor netdevs that
>   can be used to manage VFs.
> - Patch 4: Implements basec netdev_ndo_ops.
> - Patch 5: Installs tcam rules to route packets between representor and
> 	   VFs.
> - Patch 6: Enables fetching VF stats via representor interface
> - Patch 7: Adds support to sync link state between representors and VFs .
> - Patch 8: Enables configuring VF MTU via representor netdevs.
> - Patch 9: Add representors for sdp MAC.
> - Patch 10: Add devlink port support.
> 
> Command to create VF representor
> #devlink dev eswitch set pci/0002:1c:00.0 mode switchdev
> VF representors are created for each VF when switch mode is set switchdev on representor PCI device
> # devlink dev eswitch set pci/0002:1c:00.0  mode switchdev 
> # ip link show
> 25: r0p1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/ether 32:0f:0f:f0:60:f1 brd ff:ff:ff:ff:ff:ff
> 26: r1p1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/ether 3e:5d:9a:4d:e7:7b brd ff:ff:ff:ff:ff:ff
> 
> #devlink dev
> pci/0002:01:00.0
> pci/0002:02:00.0
> pci/0002:03:00.0
> pci/0002:04:00.0
> pci/0002:05:00.0
> pci/0002:06:00.0
> pci/0002:07:00.0
> 
> ~# devlink port
> pci/0002:1c:00.0/0: type eth netdev r0p1v0 flavour pcipf controller 0 pfnum 1 vfnum 0 external false splittable false
> pci/0002:1c:00.0/1: type eth netdev r1p1v1 flavour pcivf controller 0 pfnum 1 vfnum 1 external false splittable false
> pci/0002:1c:00.0/2: type eth netdev r2p1v2 flavour pcivf controller 0 pfnum 1 vfnum 2 external false splittable false
> pci/0002:1c:00.0/3: type eth netdev r3p1v3 flavour pcivf controller 0 pfnum 1 vfnum 3 external false splittable false

Please document the state before and after switching modes, and record
this information in 
Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst

In the commands above you seem to operate on a pci/0002:1c:00.0 devlink
instance, and yet devlink dev does not list it. You have 2 netdevs,
8 devlinks, 4 ports, and no PF instance. It does not add up..

