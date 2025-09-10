Return-Path: <netdev+bounces-221757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 330CFB51C7D
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 17:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1D71884F98
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 15:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97CD326D4C;
	Wed, 10 Sep 2025 15:50:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B386A24DCF6;
	Wed, 10 Sep 2025 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519454; cv=none; b=P7kpj83HSM8zA0SZm0mH9RVP1y1NtfzKoEiS55g/FSvNrW4c3g5zSYof60o8VAxytg2NjekRLlUIs2YOUZLZ4AH2y6LZd2PdttIAMncGv7ScYkQig/p4IERtU8uNjaZF6KE1lwiqg9hnNHWj5MSBYAR+yRHo182B7J3GuTARa/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519454; c=relaxed/simple;
	bh=FcFvgis55L47qEJ7zful+jCKTI6LPmwp786tGmcpUls=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FJ2q2OId7RZTTgCqW9LBgoQT9t4xfhmMfq77rOVqrmRB4t/AHwtgCHqZzKBgWiqlAP8bhq7r4o9dCcPDZ9Ndct3gASHUKuSOzuV0fdk5oYXO4o4NhKvStG0Sx9NPmDXHsTWkdWNKj+CM5hSJ8ZA0pdRHjvK05b9Qb8mg/d0iWZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16944C4CEEB;
	Wed, 10 Sep 2025 15:50:54 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 835C65F752;
	Wed, 10 Sep 2025 23:50:51 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec <jernej@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20250908181059.1785605-1-wens@kernel.org>
References: <20250908181059.1785605-1-wens@kernel.org>
Subject: Re: (subset) [PATCH net-next v4 00/10] net: stmmac: Add support
 for Allwinner A523 GMAC200
Message-Id: <175751945151.2643898.2670725057873426599.b4-ty@csie.org>
Date: Wed, 10 Sep 2025 23:50:51 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 09 Sep 2025 02:10:49 +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> Hi everyone,
> 
> This is v4 of my Allwinner A523 GMAC200 support series.
> 
> Changes since v3:
> - driver
>   - Fixed printf format specifier warning
> - Link to v3
>   https://lore.kernel.org/all/20250906041333.642483-1-wens@kernel.org/
> 
> [...]

Applied to sunxi/dt-for-6.18 in local tree, thanks!

[06/10] arm64: dts: allwinner: a527: cubie-a5e: Add ethernet PHY reset setting
        commit: a15f095b590bcc1968fbf2ced8fe87fbd8d012e0
[08/10] arm64: dts: allwinner: t527: avaota-a1: Add ethernet PHY reset setting
        commit: 8dc3f973b2ff7ea19f7637983c11b005daa8fe45

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


