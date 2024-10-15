Return-Path: <netdev+bounces-135386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B51C99DAC5
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 02:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB2B1F21F5A
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 00:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799F0D53C;
	Tue, 15 Oct 2024 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9uyC0pL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5552B482EB
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728952828; cv=none; b=kkza2DWU3nPzESMzx+Fv1h3qismItEEXCirVqKnJLL8lsR6Vo5s44FlIlqlk/kj3X9fM5YCtPPo6dkFgtItB2PvDqpFApFuMHkpJ7b/1zp8ISJb6cROIT4ijI1EBPhQthlYu1/crTKLzjIcyEDUAvuxD5cox85rFBqS0PxoAWzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728952828; c=relaxed/simple;
	bh=zdQrTLgccUBh/8kyWcvQwVmHt6rPT6KV07EdhOsClbk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mfG/ufKfVbVL3ioJ8O+geqndSsoNDTTPEAdSgSyLAvu5CLWP5+1Li8aFWe0qVMG7JEDXnSW5mP3ezf/hH9yNevF/AyXLsZ+w/B36/ovIwYHBnY6J6RN1Ffms5YggMG8DwdLdM1ctg7ORdAFoSOyC5LS41mvm+g8NY/B+jPNj/iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9uyC0pL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F04C4CEC3;
	Tue, 15 Oct 2024 00:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728952827;
	bh=zdQrTLgccUBh/8kyWcvQwVmHt6rPT6KV07EdhOsClbk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c9uyC0pLeLRpErwq1SMxq1sEIIVlKCBj5TKoaXo1tYAczTbbjTkuxKrFx2vHNjRHq
	 OP8GM/Yp5/rkWHrGW9pAou0jzlMgaLDgFsNysOSCF2y5ZG+kU0MbLHUz802+4k7xNn
	 sU382RjSWaOGeTx4/AaFPrcDB1rTU+r1dLmCOQibEtw9yLOsm/cQRZpIn4DCFCiW3T
	 /HKs1Hsr/6bi7Cf4LZ87sZhRRo4vUl4A9hHxL/OjDGCTq6qyXgAjweplIaTqc1wjYE
	 JbmadrFY42k2S/SydpOrg6T7FLNTFduhZqYcmPho8EoIkm91zVjvMYp9/kTMVvtBpO
	 +uOZFLfXekTqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D2D3822E4C;
	Tue, 15 Oct 2024 00:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tg3: Address byte-order miss-matches
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172895283273.680495.1637733802747237511.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 00:40:32 +0000
References: <20241009-tg3-sparse-v1-1-6af38a7bf4ff@kernel.org>
In-Reply-To: <20241009-tg3-sparse-v1-1-6af38a7bf4ff@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: pavan.chebbi@broadcom.com, mchan@broadcom.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 09 Oct 2024 10:40:10 +0100 you wrote:
> Address byte-order miss-matches flagged by Sparse.
> 
> In tg3_load_firmware_cpu() and tg3_get_device_address()
> this is done using appropriate types to store big endian values.
> 
> In the cases of tg3_test_nvram(), where buf is an array which
> contains values of several different types, cast to __le32
> before converting values to host byte order.
> 
> [...]

Here is the summary with links:
  - [net-next] tg3: Address byte-order miss-matches
    https://git.kernel.org/netdev/net-next/c/76d37e4fd638

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



