Return-Path: <netdev+bounces-241356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DB9C831FE
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 03:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 298684E4C7B
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 02:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66A51D5ACE;
	Tue, 25 Nov 2025 02:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXZHO44d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB96C17A586;
	Tue, 25 Nov 2025 02:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764038540; cv=none; b=dAHkZohSMJ50XGIu9KNF5+L8NGd4aRBo+DlPn6LlSrXrpivaLqeAdlUwHjPR1i82zZCur6DW9cYFyCIcaN7gB0JzG0SUdM5hUboKmAc5Ocxg6y9Qs+RncgLlw2esCot3zYP96+DrFQTMQ2xzskQAX4NFX8fEBqULf4T5n5DOfBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764038540; c=relaxed/simple;
	bh=HxIBb6IJuj1ay7v2huR39TeIaAqU2Qf7YlCaC+lE1cs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YB6Tsmg6MIAy/AadAiHDEbqSX9lxDo+84I15LSP0ShQAUrpnrMVeibS+9diB/hGwRBT/ZviwRm6xFg/SbkTCtjnaP2w9h3j5eVQgcXii7+WskUzTeatHIVPjYxgmkBUbM8H6a/7xAGc6gid4YMYNBu3TIFPsflESp3IV1bcOIMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXZHO44d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60A6C4CEF1;
	Tue, 25 Nov 2025 02:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764038540;
	bh=HxIBb6IJuj1ay7v2huR39TeIaAqU2Qf7YlCaC+lE1cs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dXZHO44d3osgJpkicr3TDmAZ++WJ08wFW2gB9Kp7gTFFCQOnUG0YJEm978I0SuOwI
	 q2Gf1XhEeJjT713bJQk8F6K2QPcm7fffuf7TszMOTA9Kul6K1bS3SFWM/XgXbP6njl
	 74LVNoD3rRGBHDFcezIrChankE2LbSo7QM++0t3Sw6zuFfvrds7CqCCirGDvcVXJsi
	 l4hMli1eVmfFy29CP1OEyk/EcN7HjB/23NAOoCL42dPxz0Rz+R5PD6bbQP6VoR2j4b
	 Dh5C7ucFJC6/EdRbhKczo2scUwIpfrtJB41T0tahLcV3jJ+TvxMiTbEUmet6tz/KzM
	 JK0y7rWiQWZ/Q==
Date: Mon, 24 Nov 2025 18:42:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Slark Xiao" <slark_xiao@163.com>
Cc: "Loic Poulain" <loic.poulain@oss.qualcomm.com>, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, mani@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: wwan: mhi: Keep modem name match with Foxconn
 T99W640
Message-ID: <20251124184219.0a34e86e@kernel.org>
In-Reply-To: <623c5da7.9de2.19ab555133e.Coremail.slark_xiao@163.com>
References: <20251120114115.344284-1-slark_xiao@163.com>
	<20251121180827.708ef7cd@kicinski-fedora-PF5CM1Y0>
	<605b720.2853.19ab3b330e3.Coremail.slark_xiao@163.com>
	<CAFEp6-07uXzDdXrw=A5dxhNc81LN3e-UXyw9ht7iAJr44M9A4A@mail.gmail.com>
	<623c5da7.9de2.19ab555133e.Coremail.slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Nov 2025 18:07:22 +0800 (CST) Slark Xiao wrote:
> I see. Actually this patch was generated in mhi code base.
> But I didn't see any difference of this file between mhi and net.
> And, there is another commit may affect this change:
> 
> https://lore.kernel.org/netdev/20251119105615.48295-3-slark_xiao@163.com/
> -	    strcmp(cntrl->name, "foxconn-t99w515") == 0)
> +	    strcmp(cntrl->name, "foxconn-t99w515") == 0 ||
> +	    strcmp(cntrl->name, "foxconn-t99w760") == 0)
> 
> I edited above commit firstly and now it's reviewed status but not applied.
> If I update this change based net or net-dev, above T99W760 support 
> commit then would have a conflict since they are not a common
> series. How shall I do to avoid this potential conflict?

Are you saying you have to concurrent submissions changing one file?
If yes please repost them as a series.

