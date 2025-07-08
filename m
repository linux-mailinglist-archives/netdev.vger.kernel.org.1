Return-Path: <netdev+bounces-205032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04A2AFCE9F
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 17:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4344156068C
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458082E11C7;
	Tue,  8 Jul 2025 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdYNNuvp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187252E11B6;
	Tue,  8 Jul 2025 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987390; cv=none; b=uwhFhhuAb/Eykhb+bRu7OOKTuUngG/NerjKG/JmNv2o0ZPBL5gW+eAn8VGHMiODo3CBDHqBbd3I1FYGpdkqSvirAZWA2M4z1wLpjlrlRsVf+GTfE8pJ8wbP+dvh6NocR4tDBNCyWvF+r8MA0gqYprtJAZEVGonYS7auzwH1b4V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987390; c=relaxed/simple;
	bh=Obbbwl3W/HPhrDX90tjKTuctvfC+PqY+HxmknvNnqrw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=scn+jBcmVFG88L84ISooy6fIrBmt2SZYZsBDRwyhxa9IE+1htu5bdLykKo1ywBLOt/RTjAeYvGNn589Qr6XL//KdPdSrICkz4L6rxkRYQp625NwqVR9J4jVyg3nDdnl/q8092jPFGPuruaYB7oGZDZfYTzyYgnmOGh3PHNh62WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdYNNuvp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C27C4CEED;
	Tue,  8 Jul 2025 15:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751987389;
	bh=Obbbwl3W/HPhrDX90tjKTuctvfC+PqY+HxmknvNnqrw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BdYNNuvpVKXd+jDJfxVt2lgxXXn7O+szpMyFGVvGowV1/fR31lF/VeCFCRvhxrxAg
	 0o8UEXGoNMRhoIO0SrxerDtvnpuZecQn4HbGnHban2BqeJFElyXP8tEVnvXikgbN3h
	 DEI/SuB+iph1eKriiRB70HPx1+ViIVU0WOHC6m/OlKgyizdyLtkSYVKs4HC+8sijsl
	 gplc9KvjZZ2S91WYeZYh0n5uCFmf7zf0j82YDhVXtAxv0b886hYBmMwRKEQSSD/Vgu
	 Xacvl1npLLwiRqDND8D6Pi60lUOFMAzNFhn9i+evgm62CDE4TEuBFgtSeOrvzXVRxU
	 lcDQIe2DkfKLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE908380DBEE;
	Tue,  8 Jul 2025 15:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] allwinner: a523: Rename emac0 to gmac0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175198741250.4099273.971241156715124516.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 15:10:12 +0000
References: <20250628054438.2864220-1-wens@kernel.org>
In-Reply-To: <20250628054438.2864220-1-wens@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andre.przywara@arm.com, wens@csie.org,
 jernej@kernel.org, samuel@sholland.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 28 Jun 2025 13:44:36 +0800 you wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> Hi folks,
> 
> This small series aims to align the name of the first ethernet
> controller found on the Allwinner A523 SoC family with the name
> found in the datasheets. It renames the compatible string and
> any other references from "emac0" to "gmac0".
> 
> [...]

Here is the summary with links:
  - [net,1/2] dt-bindings: net: sun8i-emac: Rename A523 EMAC0 to GMAC0
    https://git.kernel.org/netdev/net/c/b3603c0466a8
  - [net,2/2] arm64: dts: allwinner: a523: Rename emac0 to gmac0
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



