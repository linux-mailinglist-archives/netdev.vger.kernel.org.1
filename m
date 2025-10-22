Return-Path: <netdev+bounces-231495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD259BF9A48
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 03:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6933C19C5FEE
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150B91FA15E;
	Wed, 22 Oct 2025 01:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PU1Dr3hx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB1D1DDA18;
	Wed, 22 Oct 2025 01:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761097835; cv=none; b=FKHQGwMWt4I0ZQdsFr0gcpmDPA6ixmvT0/t7ViAygv4/vJVJsWVnCQlexfznxTZJKCGqVHrzzX1iuSW5klq/CuICGhjUWCLtCBrm43l5WK1sOKXGdbS4V7ic0MTC7fAQsismF3CD8A++xoEVTY1uPQXbgxzVIEnuR0wlEWhFF5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761097835; c=relaxed/simple;
	bh=TQ/mavWsHuoNpQiqCCMpP+RtoHVCdQRMg1o4FgK++1s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lmoj0BPWVZz0JMWZWERGtiRWYS/69F8/WWuqd6F9bEGN1UPtsok2Cx0WO4Bqgwa/ZQIHp8hc29Lg7Q80EkbCq0f/D01W7sHDyzV6KXElwSE3qgHV+OvJID4IOGQR073HQY1IBF2FwmimO24XbCNxtAxb11ZWdFb1C/Rp27LvxrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PU1Dr3hx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E612C4CEF1;
	Wed, 22 Oct 2025 01:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761097834;
	bh=TQ/mavWsHuoNpQiqCCMpP+RtoHVCdQRMg1o4FgK++1s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PU1Dr3hxWRFtjrVymeNyrYaXVVHFPC/51DC/vp9eO0jKF6nbFm2Khs8amaHnvhcNV
	 bNO8w+JGl9rkAWk5q3gDOKn/ujK/8DbOaNzsuuIEPI4yuDVgjzaVB7q+TY9UZe4Gyq
	 Pc3UvcAg+N1hBHK91D34u3QcY2H4cPcdhQCQdZAjOkqEaBLod9aBjsJyyjELGmd7FY
	 aFNOB8bxtQn2uiP3milEiXcWYqdkODlXO7CJguH2diVwSi4PBUQu5+HGQ9JEjs3ovA
	 uigedLQZjsVUpCcUXMejM7+FJVNkf85nTgrf8iS2t+tiYLyhRbCBxm81IiMDP/5R5I
	 HHeUTysa8ZNxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0E23A55FAA;
	Wed, 22 Oct 2025 01:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v14 0/4] net: dsa: yt921x: Add support for
 Motorcomm
 YT921x
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176109781575.1305042.9201504571790055583.git-patchwork-notify@kernel.org>
Date: Wed, 22 Oct 2025 01:50:15 +0000
References: <20251017060859.326450-1-mmyangfl@gmail.com>
In-Reply-To: <20251017060859.326450-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, horms@kernel.org,
 linux@armlinux.org.uk, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Oct 2025 14:08:52 +0800 you wrote:
> Motorcomm YT921x is a series of ethernet switches developed by Shanghai
> Motorcomm Electronic Technology, including:
> 
>   - YT9215S / YT9215RB / YT9215SC: 5 GbE phys
>   - YT9213NB / YT9214NB: 2 GbE phys
>   - YT9218N / YT9218MB: 8 GbE phys
> 
> [...]

Here is the summary with links:
  - [net-next,v14,1/4] dt-bindings: net: dsa: yt921x: Add Motorcomm YT921x switch support
    https://git.kernel.org/netdev/net-next/c/a9dff2b5f72b
  - [net-next,v14,2/4] net: dsa: tag_yt921x: add support for Motorcomm YT921x tags
    https://git.kernel.org/netdev/net-next/c/ca4709843b7e
  - [net-next,v14,3/4] net: dsa: yt921x: Add support for Motorcomm YT921x
    https://git.kernel.org/netdev/net-next/c/186623f4aa72
  - [net-next,v14,4/4] MAINTAINERS: add entry for Motorcomm YT921x ethernet switch driver
    https://git.kernel.org/netdev/net-next/c/0c5480ac96a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



