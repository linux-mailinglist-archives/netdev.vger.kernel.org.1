Return-Path: <netdev+bounces-144755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73159C8617
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A37E287A1A
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 09:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55FF1F7098;
	Thu, 14 Nov 2024 09:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ocg8pOXB"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46CF1F7080;
	Thu, 14 Nov 2024 09:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731576423; cv=none; b=ihmaS732inIcLew+1S+f0HGo+dNb5WnyRR4r0Gt5I748fn0pzIR6WA2lsC++F1gtc12IwekaVgbBLaHyKC7MFaDJbZX3nImiuWRTzwd0JKGGs0BmIXAVKiX3IhiF+oiaOH4eC2kAFmYNMIynIzXl6/mK/Ah097CSYMw3II+hO44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731576423; c=relaxed/simple;
	bh=R1UuyuwvMBWD8gJ/Fcy+U58DhFWCQIj7bRdSdDaqNf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eKLKfs1257htgNLtWIoUJ4yf/x7A+M4kDqrvKHhBz8Ef2swZ+QU14E0QayArVrgQ09KqX3xdVGpGgcKMFBnJbpLet1ZOKWn+CEDpBv6N4tjVkhQn88hP3zc0RkS78EV+m6MQ8Fg1H1nc5ZIswfAKb1yKhR2VojMV5/+PHBdERgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ocg8pOXB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731576420;
	bh=R1UuyuwvMBWD8gJ/Fcy+U58DhFWCQIj7bRdSdDaqNf0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ocg8pOXB/RFjyyLYKOx0U8otxoGt1VOSJt2PixWnbqJ+7x3kZRzCsSWpXnJZr3xtb
	 Fa8DwpRljft0AsOCd4WxjR9i+8xIeHkgjrlv5j9AmmgZGB1MVSzq7PAkwMcBdnmuTl
	 yM34YZG/egcITIYOH2mBP/Peh4K1RWXeNIEKV6stKkVCN4g9vmc68JDELT5NqOt1Ib
	 aB68Pqq4ohEF+q3/1xUF1IcCFWEdXoWx8bx+HGKUM9S9W+ZzkVwtl8PcBy1sWEuctz
	 g8YcoFA45nsmqcGKj4nsspQqx25NGJNx2W5bh0h2LX/AYRv26xSA96p7YHzlhIWByT
	 kgGqZ3D8yUHrQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5217817E1574;
	Thu, 14 Nov 2024 10:26:59 +0100 (CET)
Message-ID: <224443e5-2ba0-49e5-9d59-2b37c2d0ac4a@collabora.com>
Date: Thu, 14 Nov 2024 10:26:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] net: stmmac: dwmac-mediatek: Fix inverted handling
 of mediatek,mac-wol
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Biao Huang <biao.huang@mediatek.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Andrew Halaney <ahalaney@redhat.com>, Simon Horman <horms@kernel.org>
Cc: kernel@collabora.com, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com
References: <20241109-mediatek-mac-wol-noninverted-v2-0-0e264e213878@collabora.com>
 <20241109-mediatek-mac-wol-noninverted-v2-1-0e264e213878@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241109-mediatek-mac-wol-noninverted-v2-1-0e264e213878@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 09/11/24 16:16, Nícolas F. R. A. Prado ha scritto:
> The mediatek,mac-wol property is being handled backwards to what is
> described in the binding: it currently enables PHY WOL when the property
> is present and vice versa. Invert the driver logic so it matches the
> binding description.
> 
> Fixes: fd1d62d80ebc ("net: stmmac: replace the use_phy_wol field with a flag")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



