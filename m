Return-Path: <netdev+bounces-142716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4009C014D
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 10:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC00D1C215E4
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 09:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E521E1337;
	Thu,  7 Nov 2024 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lY5rWTkU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9F51D79BB
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730972420; cv=none; b=GRcoApiLu8H0nHtTHSqvWoiKb+ilDrmlfvATjsq7KBzc296cayn/786IKQDJsZMr4TH1/OKI11W/3UuF2MIc/EgpNrHE8BkNvE0e1+9QrrVnB4CmcQ4cThXZ8ZlewKdSgG8Dm4NM7k8CYRzfejPtU372gay2LZHPIIomoOcLeCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730972420; c=relaxed/simple;
	bh=gl1wjdRDJdtn70hDXUaZ4Znvye7udTkkjCL6xvmk/pY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r4L9TNVtNjcBtpyWvgt3pu1sKOgBohU8dXrCqH9se57jHs2Ivrz2cOliFdCsh2LmDIzPmscG+P2ebB/4eH+akdkNrXfxbubcieV16WNpZVm3LXKsVAyeeNUkryDTIQK6wpI1A091nRI1CIn2rD4MQjbJFprs8A0ZXFEAc6wgAHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lY5rWTkU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB46C4CECC;
	Thu,  7 Nov 2024 09:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730972420;
	bh=gl1wjdRDJdtn70hDXUaZ4Znvye7udTkkjCL6xvmk/pY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lY5rWTkUgaUYEBCaAiCII1mNiKYVUfiXUexiZ3OqOKa2gFHTiqCgbPQl7U8zo/l/j
	 ZDEfg/jKZeEnlgv9i0vkWcP4EOKy9isFV5WaM0fJmHuQ9C0juRuxsvqh1/VomS389r
	 oH8VZQVBpvocWpc7t57Zc0cAtky0mwvgwxleS50c0LH4XHkTbQ9ktPSJA/xwCnVOgV
	 FyYGwDPQNilsmdx7gzEuJO9LKahbsvrKv8FG7EC1XcpkN6AKfbJH0MXWo6LzNV2gws
	 TqzgCIWVno7UuDgLIoaeQt+2Yv0P4yWEaal+1+BfVvbxF5AcU3YTna4aJRN/RLe7SQ
	 76mQKKUcadIVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712F43809A80;
	Thu,  7 Nov 2024 09:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: nfc: Propagate ISO14443 type A target ATS to
 userspace via netlink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173097242925.1585374.10680931770070501247.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 09:40:29 +0000
References: <20241103124525.8392-1-juraj@sarinay.com>
In-Reply-To: <20241103124525.8392-1-juraj@sarinay.com>
To: =?utf-8?q?Juraj_=C5=A0arinay_=3Cjuraj=40sarinay=2Ecom=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, krzk@kernel.org, kuba@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  3 Nov 2024 13:45:25 +0100 you wrote:
> Add a 20-byte field ats to struct nfc_target and expose it as
> NFC_ATTR_TARGET_ATS via the netlink interface. The payload contains
> 'historical bytes' that help to distinguish cards from one another.
> The information is commonly used to assemble an emulated ATR similar
> to that reported by smart cards with contacts.
> 
> Add a 20-byte field target_ats to struct nci_dev to hold the payload
> obtained in nci_rf_intf_activated_ntf_packet() and copy it to over to
> nfc_target.ats in nci_activate_target(). The approach is similar
> to the handling of 'general bytes' within ATR_RES.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: nfc: Propagate ISO14443 type A target ATS to userspace via netlink
    https://git.kernel.org/netdev/net-next/c/9907cda95fcb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



