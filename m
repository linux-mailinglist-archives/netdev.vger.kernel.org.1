Return-Path: <netdev+bounces-74654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB9786214C
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 01:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB933B20AB0
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 00:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C212A41;
	Sat, 24 Feb 2024 00:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUEMcwBN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584DAEDF
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 00:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708735465; cv=none; b=rBnpvdNNo9uImJg4SCkEfZWGrTjWRzsVFceX5BNyiy+vgjpP/+FPDwom2LxanaI5vK2WW0MwplKX6pjzSZKtkqKgRKg/I/29gO4fwVCSZoo8nLVnGLqCXczdOk2glRIIVWrVpTGRC98Kh9IWN0MEP7IIA5x5pe1F+HxELclPhXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708735465; c=relaxed/simple;
	bh=kVgYB4KBoUevpnHg/P2UrKHz5e84CyifIeqS0gwo8ys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P47fNP3fH2RCFJbXh/FmD+/aRVT9AHkw2Y3EgzYMA2KNduASUNiRTqd66oFztvHvpfhhdkCWOy5QQKPBGGtEGC9D55A6ybBGLhlHpLTQ2z51nQ9fNHyMozapPRZOtm8cucvIO2DejSxDVqPiHve/50OhsVHE43CejbdckzKsc2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUEMcwBN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D55C433F1;
	Sat, 24 Feb 2024 00:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708735464;
	bh=kVgYB4KBoUevpnHg/P2UrKHz5e84CyifIeqS0gwo8ys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LUEMcwBNtuK8mX7FF0IusVA9Bn+V2dPq/qHskAxQ3GPaAOe+2507EIgqQg+O1qJQh
	 D1qO5t8Zm7OfudM5UvDwh1CffnQIMUXg6j8/cA2nGHWuwp2YRJMobVMwPi0XlVYaKW
	 jmEc+dHgweNT/Wg2j0x2P+Tv1tmlnQ6ZaVOFe1Qd+UaOsw1iYyYqDSE3qasnVFntx8
	 GA32KHB3DAh9q/xhjYy4s9cJVrqNMmLy1Q/t8BuoecGMPu7CLxtiTl0zHXfxvMs1ww
	 FDZEJtbPWGjW5SLTmueRPPcHU0V6wrjoGN7Rv8ptlhAXyxqm3TgviuMxEMNn1vFKb/
	 dnkm0fg1n95sg==
Date: Fri, 23 Feb 2024 16:44:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 maciek@machnikowski.net, horms@kernel.org, netdev@vger.kernel.org, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v13 1/4] netdevsim: allow two netdevsim ports
 to be connected
Message-ID: <20240223164423.6b77cf09@kernel.org>
In-Reply-To: <20240222050840.362799-2-dw@davidwei.uk>
References: <20240222050840.362799-1-dw@davidwei.uk>
	<20240222050840.362799-2-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 21:08:37 -0800 David Wei wrote:
> +	if (!netdev_is_nsim(dev_b)) {
> +		pr_err("Device with ifindex %u in netnsfd %d is not a netdevsim\n", ifidx_b, netnsfd_b);

nit: the string format can overflow the 80 char limit, but if there 
are arguments and they don't fit in the limit, please put them on 
the next line.

> +		goto out_err;
> +	}
> +
> +	if (dev_a == dev_b) {
> +		pr_err("Cannot link a netdevsim to itself\n");
> +		goto out_err;
> +	}
> +
> +	err = 0;

Why zero.. 

> +	nsim_a = netdev_priv(dev_a);
> +	peer = rtnl_dereference(nsim_a->peer);
> +	if (peer) {
> +		pr_err("Netdevsim %d:%u is already linked\n", netnsfd_a, ifidx_a);
> +		goto out_err;

I'd think if we hit this we should return -EBUSY?
Unless peer == dev_b, but that may be splitting hair.

You should also implement .ndo_get_iflink, so that ip link can display
the peer information.
-- 
pw-bot: cr

