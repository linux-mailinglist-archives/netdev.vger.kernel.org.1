Return-Path: <netdev+bounces-116658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D4B94B520
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 04:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BBAB1C20E95
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 02:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DEC11187;
	Thu,  8 Aug 2024 02:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQ5Lrh9A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0A5C121;
	Thu,  8 Aug 2024 02:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723085209; cv=none; b=Sn3p/olnFmGLEIRKuWI+bfeSITQMQDb09EPg+mIRa6n01W7YHiTsLwETR+mp6k20AEnDCcldW7euC3ZICd9XA+DR66sIIC4nWBktJwenMVFhFctvZVJeHN8o6zU2/mFCcC0AlUPTBuIptItt9FAskuOnQvbEyQE0EpPaAFTMWUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723085209; c=relaxed/simple;
	bh=7T/V2C8Eblb4PUGERApZuw5X6Pwobawq2MHePU27TFU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L/iGi9SRijOPbKZme2ZXYzPlZehEtkoRJFuCDLcaFync3C3PnQEr2Y2dMGGqvx1uTbHsRD8Oq17qA0QKf6vB9MENIo9ehkEyfPgEd7zCYbjhv8+AvJVNsTsa+D6LKkAPVZFPX3ILewbbrH2EUZB+3d7/ZXprr6gQUrgNozOdo7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQ5Lrh9A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E47C32781;
	Thu,  8 Aug 2024 02:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723085209;
	bh=7T/V2C8Eblb4PUGERApZuw5X6Pwobawq2MHePU27TFU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jQ5Lrh9AoupooZgvSMK57JIun8ONNB8tvb70XSPEP5zyLFwlhjzwmnu0UG0COjl4J
	 Ci4r1FAKbvqQAo/MnwG8PW34zqUxmOGuIWgToxVCcRDaOZvEPluu4/+TFvLhhV188N
	 SNe5KfRczm9XW7P1jCIJ/MImzkgvcgmREkPDSLR+xiTZf09x0HCOv+PkbBeHwX1gDS
	 lmHTIqawf7Z4xJzh+OfUuxEvnuWe2tLgr7yvYn1e2txpIEPLHSJhFCJrr1rEsigy0H
	 2bwpOI4R3ox7M3F42bzYgr4sQcgWdXkr0f5NMAzbArZV/knoKBHsuIUjXR60fjXud+
	 mbu0xBiFU21gg==
Date: Wed, 7 Aug 2024 19:46:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>, Jiri Pirko <jiri@resnulli.us>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
 <sgoutham@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: Re: [net-next PATCH v10 00/11] Introduce RVU representors
Message-ID: <20240807194647.1dc92a9e@kernel.org>
In-Reply-To: <20240805131815.7588-1-gakula@marvell.com>
References: <20240805131815.7588-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Aug 2024 18:48:04 +0530 Geetha sowjanya wrote:
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

I can't bring myself to apply this.
Jiri do you have an opinion?
The device is a NPU/SmartNIC/DPU/IPU, it should be very flexible.
Yet, instead of just implementing the representors like everyone 
else you do your own thing and create separate bus devices.
Not sure if this breaks anything today, but it certainly subverts 
the model where representors represent bus devices. 
You can't represent all bus devices, because of the obvious cycle.

Also your documentation is full of typos.

