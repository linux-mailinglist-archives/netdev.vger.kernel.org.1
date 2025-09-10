Return-Path: <netdev+bounces-221661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A603B51748
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 14:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4D91BC72E8
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 12:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC2F31CA5E;
	Wed, 10 Sep 2025 12:52:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113D231CA4C;
	Wed, 10 Sep 2025 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757508742; cv=none; b=dKLur58brTPcKpMrNap91jY1+9GQPHlmxPiXVCGOsGRcbIAp1H8Imduh/Fj4CHAxoqV57xUe2VEzrDPBd2sRNzGoii7+4Y9TvqrEfTC3pjzPL1fK7J51ulmuMAMXEYd5HxQZjBPRAX97zMyopJep8EOlbNzXsfoZWOgDw9QGDtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757508742; c=relaxed/simple;
	bh=u4MtrbVggNOeGuUPoasRtsmuiD+SWq522C5ibLwqSjY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q77q1Yf/g2brHd6hN69qUfdjUvNzLhDvXbhxr4WsPJq6n1ej6K8H/Qk2lCR0F1EG7SLohj/wNiTysvuQ1MXHmiPc/RVWGPjO/2bE/h71fgfMk/JdGPc4oG3MPAASm6tg+nKJJX/yyPCuWEtDKhQpFIU6a/TkuSAdR2MoAATQDAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3C4C4CEF8;
	Wed, 10 Sep 2025 12:52:21 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 12CEE5F846;
	Wed, 10 Sep 2025 20:52:19 +0800 (CST)
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
Message-Id: <175750873902.2588463.10161966012825754065.b4-ty@csie.org>
Date: Wed, 10 Sep 2025 20:52:19 +0800
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

Applied to sunxi/drivers-for-6.18 in local tree, thanks!

[03/10] soc: sunxi: sram: add entry for a523
        commit: 30849ab484f7397c9902082c7567ca4cd4eb03d3
[04/10] soc: sunxi: sram: register regmap as syscon
        commit: e6b84cc2a6fe62b4070d73f2d2d7b2544a11df87

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


