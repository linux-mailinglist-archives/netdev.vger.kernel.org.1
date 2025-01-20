Return-Path: <netdev+bounces-159821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AC8A170BB
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 17:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF283A0306
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 16:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7287A1EB9E3;
	Mon, 20 Jan 2025 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIx31Q3g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7CC1E9B37
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737391808; cv=none; b=BwTvJYm5lYMaRPPc37/+vThdijMvBeNLOS7p7+IGduMKLWcCszLIEgz+mqPfo0KnOsNhAB/H7PLJfO6H1CUsVuWd7yYR+Wv3qM7jWe3PobMJeZOtZ4SQEhpX/VrfInFuI1inIBAhl1Vy7u228wdeA0kLpVzVSIMD9fdB9dLey78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737391808; c=relaxed/simple;
	bh=KrArXC5UxZDe4aRI3/NUDH/Yv+VFXYyF6TRYd0Ru5qQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ErzWFj3oew4BsqiblV4L2WPZ67AKTsJC+PF5trkLHQTbQanBiZ3k2HGSobjAYPw6WPsYHCZ26Nu5vkw85+Ioshajfd4jJmfa/2SJsFAni0tKm77/N10dbDeYPmK9DiaEQxvuiIkuHQJOusRWbB/JoVmiYHp669FkcRc6mePAImM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIx31Q3g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D9CC4CEDD;
	Mon, 20 Jan 2025 16:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737391807;
	bh=KrArXC5UxZDe4aRI3/NUDH/Yv+VFXYyF6TRYd0Ru5qQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PIx31Q3gL1rvvXc9yJcA7NVr7JVtZEBET2gCIFzIBDlyloc2rshPYT8ysGe4eQ6D1
	 rNCk1iLob2+rtcy8wz1cN1/m2wdCRyTzddd0lPgp7oKOx6PAQof+9WQ6h368D6pfTz
	 Jp0/RuMzytobCXKZtcXW+/5IRvnnadD3LjguVy9cyIsD4r1td0XEgulFqxTRrc66/f
	 tyf0xFTQLvzhuQ/7CBgTsAyAA7Zl70JrNJgycFOeLs/KAJIdrDkZgXtukMFDihEazq
	 OSehRFrDiSn1hiEHcsFRPTX2PDwu9ZQjMByGDtPQiCNToF2YNUK2ewRO/0DPynGic5
	 DAp4WDyTJe76w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBE94380AA62;
	Mon, 20 Jan 2025 16:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] ip: vxlan: Support IFLA_VXLAN_RESERVED_BITS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173739183175.3583404.7779729992198774050.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jan 2025 16:50:31 +0000
References: <5eaf7a5df51b687f3354d9e065c3358f56b5ad34.1737387719.git.petrm@nvidia.com>
In-Reply-To: <5eaf7a5df51b687f3354d9e065c3358f56b5ad34.1737387719.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: stephen@networkplumber.org, dsahern@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Mon, 20 Jan 2025 16:43:06 +0100 you wrote:
> A new attribute, IFLA_VXLAN_RESERVED_BITS, was added in Linux kernel
> commit 6c11379b104e ("vxlan: Add an attribute to make VXLAN header
> validation configurable") (See the link below for the full patchset).
> 
> The payload is a 64-bit binary field that covers the VXLAN header. The set
> bits indicate which bits in a VXLAN packet header should be allowed to
> carry 1's. Support the new attribute through a CLI keyword "reserved_bits".
> 
> [...]

Here is the summary with links:
  - [iproute2-next] ip: vxlan: Support IFLA_VXLAN_RESERVED_BITS
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=1db4f568789b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



