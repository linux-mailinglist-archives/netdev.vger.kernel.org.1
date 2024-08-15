Return-Path: <netdev+bounces-118902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7529C953748
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87DA1C236DF
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7F22562E;
	Thu, 15 Aug 2024 15:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuFc7DwZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9896053365
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 15:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735831; cv=none; b=o11RTFQxXlZg7EQFLDthrUvRHn/0UTQrYVRQX8GCuNvAUoCYGe0XODHPT/Tg1ya38atD3XNwZf99BGfTlGQiLhbKWlwO3u0uBLJwn1ROYR2dbMkk7oH73zOLWU7uUYsZcARHWF1hNsAV4Cx8VHAqXfEEzKDsQdDeB+q1FXyyTXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735831; c=relaxed/simple;
	bh=3/AENTPsyst1+S6R1n+5acS1+PeXRxsoYGTHpCN6KAg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IVIt7Qnxx7EjWM5u98vqwSKNywUDp0NoQIRUumjyiXBRzRlfc7eDEiwef2c0inBlo3msqtcn5c75+qy6n9cip58s5U+YTusz2fAqPTVETzEOGG9WELnWqNz1ZRq5zjILW5HKAGakeOa656JIzacvLoounojaLBPnVMuYhl11Pbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuFc7DwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF70C32786;
	Thu, 15 Aug 2024 15:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723735831;
	bh=3/AENTPsyst1+S6R1n+5acS1+PeXRxsoYGTHpCN6KAg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LuFc7DwZIFTyXMjP0/HMVjSJeZi1XAjvHSFsH2Wc7aVo849nsPJ/GM2kNF/J837g/
	 r46UWvNiCM/JKhxeT/x/YUD66WuLaVYUtDP2n2lxypAQ2xW/VxC48zSMWKGic3VuYt
	 LF4XkcaKwvs8Vo7z2ymItsccZEJItPZdJuwH1tqfok11JC3gkL51yZQoBVQjcD1t10
	 y5ijSxbbqiH47sc983ju1wggjiFvicYy2mfzkjWgZcKtIXesBay0ORJJhQLZ3D7M/I
	 FoRRdA6mPNJvfll3NUcgDtO2Q831FmfcM7YT9p1sahZ1XbSwz795tjVESWAJOFgpJh
	 uEii8bZXvtARw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADED6382327A;
	Thu, 15 Aug 2024 15:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] iproute2: ss: clarify build warnings when building with
 libbpf 0.5.0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172373583050.2888429.15348991883247460843.git-patchwork-notify@kernel.org>
Date: Thu, 15 Aug 2024 15:30:30 +0000
References: <20240811223135.1173783-1-stefan.maetje@esd.eu>
In-Reply-To: <20240811223135.1173783-1-stefan.maetje@esd.eu>
To: =?utf-8?b?U3RlZmFuIE3DpHRqZSA8c3RlZmFuLm1hZXRqZUBlc2QuZXU+?=@codeaurora.org
Cc: dsahern@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon, 12 Aug 2024 00:31:33 +0200 you wrote:
> Hi,
> when building current iproute2 source on Ubuntu 22.04 with libbpf0
> 0.5.0 installed, I stumbled over the warning "libbpf version 0.5 or
> later is required, ...". This prompted me to look closer having the
> version 0.5.0 installed which should suppress this warning.
> The warning lured me into the impression that building without
> warning should be possible using libbpf 0.5.0.
> 
> [...]

Here is the summary with links:
  - [1/2] configure: provide surrogates for possibly missing libbpf_version.h
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=0ddadc93e54f
  - [2/2] ss: fix libbpf version check for ENABLE_BPF_SKSTORAGE_SUPPORT
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=e9096586e070

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



