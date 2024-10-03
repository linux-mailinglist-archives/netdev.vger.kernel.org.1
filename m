Return-Path: <netdev+bounces-131815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 591E898FA49
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 01:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027B31F23144
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 23:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC8C1CEAC4;
	Thu,  3 Oct 2024 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIaU8vKw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165AB186E3D
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 23:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727997029; cv=none; b=tCFrVFLqU1yXDq5fTPKhBhafJB0uPrrKOdwSkwRGcdfg5k2/nHX1NsRL8fxzFEzEdJie/tWTB91vBod7+8cHsd+BwgMThoBnj/eznbZ+wCm85zOh/xukLoLz97ruVRp4uy+r/pwx0+s0HVshko/1N7Za0V3MftFFZBbdWCu+6zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727997029; c=relaxed/simple;
	bh=sHt3od08IqwOZa8i8InzNHju5aiGgOUVs09R/D0N9o4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RnpQw3UkZjq7p5YwFvmt9ev4rItGOl/EpDVig+GbgqZrdzh9pVxUKFJRclCJDT8XoDdMTNr92q0rvvWAPQ9Oxo2CPs3oTyVZm62UGfSRM6EPsTqcDmyb1GkcO7Cl09BI1GcsgPKveygunCNiiTuPcEOPb8VJu6GnuWO+Bs38/CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIaU8vKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977A3C4CEC5;
	Thu,  3 Oct 2024 23:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727997028;
	bh=sHt3od08IqwOZa8i8InzNHju5aiGgOUVs09R/D0N9o4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cIaU8vKw5yGEQlW0hQouUIkzR4no68KGegdkMljQksA9JbDwOoBPh+WyLHJKXxe22
	 xF/NgBcv3zh85zln/UT1CcUwFagx/Av+o9h+B5Wu0CkvgtZNhGFqXWU2IFojrljfNw
	 D0L8ccpFwE7bdW83dDkw6q5kltql0LEUkkNgz9ETUB5YCdjG4pPssrxGcvObRj3afT
	 c5FOZcxv3JnhKXFlSJJPgs/0XD2AuhqA1vmyDTgjijaltpJ0wexaKWycAiDnM5a6QU
	 58L8FZHEMAIj/MA5EDq+ZXjvVBugXleN/Oj+AxIQ3ak2bAzJe0cP8fpmydwmVVgccB
	 t43PnjBdCM3Rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F0D3803263;
	Thu,  3 Oct 2024 23:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/10] packing: various improvements and KUnit
 tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172799703201.2022430.15712045546993450620.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 23:10:32 +0000
References: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-0-8373e551eae3@intel.com>
In-Reply-To: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-0-8373e551eae3@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: akpm@linux-foundation.org, olteanv@gmail.com, davem@davemloft.net,
 netdev@vger.kernel.org, vladimir.oltean@nxp.com, przemyslaw.kitszel@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 02 Oct 2024 14:51:49 -0700 you wrote:
> This series contains a handful of improvements and fixes for the packing
> library, including the addition of KUnit tests.
> 
> There are two major changes which might be considered bug fixes:
> 
> 1) The library is updated to handle arbitrary buffer lengths, fixing
>    undefined behavior when operating on buffers which are not a multiple of
>    4 bytes.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/10] lib: packing: refuse operating on bit indices which exceed size of buffer
    https://git.kernel.org/netdev/net-next/c/8b3e26677bc6
  - [net-next,v2,02/10] lib: packing: adjust definitions and implementation for arbitrary buffer lengths
    (no matching commit)
  - [net-next,v2,03/10] lib: packing: remove kernel-doc from header file
    https://git.kernel.org/netdev/net-next/c/816ad8f1e498
  - [net-next,v2,04/10] lib: packing: add pack() and unpack() wrappers over packing()
    https://git.kernel.org/netdev/net-next/c/7263f64e16d9
  - [net-next,v2,05/10] lib: packing: duplicate pack() and unpack() implementations
    https://git.kernel.org/netdev/net-next/c/28aec9ca29f0
  - [net-next,v2,06/10] lib: packing: add KUnit tests adapted from selftests
    (no matching commit)
  - [net-next,v2,07/10] lib: packing: add additional KUnit tests
    https://git.kernel.org/netdev/net-next/c/fcd6dd91d0e8
  - [net-next,v2,08/10] lib: packing: fix QUIRK_MSB_ON_THE_RIGHT behavior
    https://git.kernel.org/netdev/net-next/c/e7fdf5dddce5
  - [net-next,v2,09/10] lib: packing: use BITS_PER_BYTE instead of 8
    https://git.kernel.org/netdev/net-next/c/fb02c7c8a577
  - [net-next,v2,10/10] lib: packing: use GENMASK() for box_mask
    https://git.kernel.org/netdev/net-next/c/46e784e94b82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



