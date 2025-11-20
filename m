Return-Path: <netdev+bounces-240489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46091C757AE
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B2294E0712
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 16:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF9B366DB3;
	Thu, 20 Nov 2025 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xpm6++JA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6312C2C21E1;
	Thu, 20 Nov 2025 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763657131; cv=none; b=ft4gYcoii89DdR4yyOgtwP7y3QeWFgr+jbwmvWHiUOKjVNiNt3OymQrCI3A7yfgi27IsFvC/DUinOdRKt5P0ZLMjUivQ+mZbKsjs0hIitl7oiy11Okh659w5cXLzIha15az51XkBuaYlBq1kCo03d+RX8jPZJ98DAgVd8//NXVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763657131; c=relaxed/simple;
	bh=/b8wo8RQC/52zHrc7Ma+n9mzkmbtEkBpqda8kVXqdCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VcST4VFeG1usOQWIkN5L4gFIJYqxEv7iU9Q1jGeJfu3vNDdxksJDvytbHzzDIB3tTZ3cFxHkVEHh0lmIL5twlHGGTwITBG7zUcqw+MFQC6Iyv8mHHVVRoPK/+VzIep0f5bdDg0U/aXI2YOZU4CITgreZhEpV8r761J772B7tpXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xpm6++JA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37505C4CEF1;
	Thu, 20 Nov 2025 16:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763657130;
	bh=/b8wo8RQC/52zHrc7Ma+n9mzkmbtEkBpqda8kVXqdCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xpm6++JA3mHsnaa43KeQt5lZ7q/K+Hb/4Fzl/p/xnftEpXMRcv58sxc0AWqYgBCdV
	 Wl2NdSsWOT3ASQy+Jm+YiQEfooupCVFyQLKn6Wc0GCfIkrcRrrJ0WGS0qIuB7xufnx
	 9T+7iLP0lInzi4dQFRBGHJNdpINFQJ4o8uqMzBg+98J5oFQLqGmrzTqPU5M+JdNlJy
	 a56lRXMRp2qxh3CAi9OMIeagZyC4sBpNDVJxFDLqkkRRo5lN0vprdoFw7bHmUR60Fq
	 zWhlfHpNkG/qvbud5tCNBkXb3G3ZUrKHMoY8mV3jKRuuDnfDf9Wugn8fXwU+Te1trk
	 Qe2Qv4PkiL2PA==
Date: Thu, 20 Nov 2025 08:45:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Chen Minqiang <ptpt52@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, "Chester A. Unal"
 <chester.a.unal@arinc9.com>, Daniel Golle <daniel@makrotopia.org>, DENG
 Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, Andrew
 Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH] ARM64: dts: mediatek: fix MT7531 reset polarity and
 reset sequence
Message-ID: <20251120084529.2e5dbd77@kernel.org>
In-Reply-To: <20251120162225.13993-1-ptpt52@gmail.com>
References: <20251120162225.13993-1-ptpt52@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Nov 2025 00:22:24 +0800 Chen Minqiang wrote:
>  arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 2 +-
>  arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts             | 2 +-
>  arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts | 2 +-
>  arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts             | 2 +-
>  arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts             | 2 +-
>  drivers/net/dsa/mt7530.c                                 | 4 ++--

The dts and drivers/net changes must be in separate patches, they go
via different trees. Please note that we ask contributors to wait
24h before reposting in case there's more feedback for this version:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
-- 
pw-bot: cr

