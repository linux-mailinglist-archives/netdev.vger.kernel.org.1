Return-Path: <netdev+bounces-220250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7840B450F6
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 10:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9E237A3CCA
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 08:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DB52FD7A5;
	Fri,  5 Sep 2025 08:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Cou6lLEc"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1885E2045B7;
	Fri,  5 Sep 2025 08:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757059918; cv=none; b=eaTYhQlea3fx6L1MET5urRJjOBCk3wQhI9zmpBNe7GSV3BjlW0+UPDHcSwqLiHdNCZrRWjXL2r8/IVnOHBezh1fd7Rp9O89UPGaM/rZPqSK77tYfyK9nEi2VYq5M1eCX8HnuRSTKhiG2p+PO3NPXwdmInSWBipXL8ke8bctyA8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757059918; c=relaxed/simple;
	bh=UIitS/BrAV5TC2kzay8yvqoEA1Xou313F2oKC/IdHNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDkOSNRnj+qQcUUrFOx71Ce8eUEJraaO6pRpig6lf7Cj2IzsWilh/lPQA4tAb+X+XlPGhx+PMfdoawfNiyzuldcSAXnO2ipGbR1qbe28CJuvet+s/RBPqDEJ8cvT6hHT56cNoaFX7euw8gYbRhEogW6RTKj+kESFwrhj3cfoDJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Cou6lLEc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757059914;
	bh=UIitS/BrAV5TC2kzay8yvqoEA1Xou313F2oKC/IdHNs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Cou6lLEcxEINkpQGfimSKKIWWcAbo+MdxXQjYZFPNNR2yIAlRw8uyMHj4oWSylfiN
	 28Pn9kh9sOM4k5PVEtEa7zx5p7NgEAImXzEplalngZKZuHAeS8jaPeeG6NrxMj2fJk
	 CzuIrGyAxM5Izl1GrzQoctTgWFQCaGU6JFjd1WaBJvX2d+NI5/ptpaOQemXGLGbVUt
	 smiqE15JQ+xrl+PDad4IWGoYdXS15vco7rK8mtto8oSTjj0YaI9QsAj6QNFdAZpA8f
	 vATYKCAkU+G6Xz6HRV84OFT1Iqs64MFkA802+usc8pAI+O2HPnq+p3xNMCUFNc+LIm
	 bFpry9LDd9K5g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5D5FB17E12B9;
	Fri,  5 Sep 2025 10:11:53 +0200 (CEST)
Message-ID: <2c681013-ca03-4f0f-8fe9-44475a97dfef@collabora.com>
Date: Fri, 5 Sep 2025 10:11:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/27] clk: mediatek: Add MT8196 peripheral clock
 support
To: Chen-Yu Tsai <wenst@chromium.org>, Laura Nao <laura.nao@collabora.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 p.zabel@pengutronix.de, richardcochran@gmail.com,
 guangjie.song@mediatek.com, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, kernel@collabora.com
References: <20250829091913.131528-1-laura.nao@collabora.com>
 <20250829091913.131528-15-laura.nao@collabora.com>
 <CAGXv+5Fj9Hwmk2y_bZhGX0EUEY42tm3t0nTrjtV-sYhD_B-xVg@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAGXv+5Fj9Hwmk2y_bZhGX0EUEY42tm3t0nTrjtV-sYhD_B-xVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 05/09/25 07:05, Chen-Yu Tsai ha scritto:
> On Fri, Aug 29, 2025 at 5:21 PM Laura Nao <laura.nao@collabora.com> wrote:
>>
>> Add support for the MT8196 peripheral clock controller, which provides
>> clock gate control for dma/flashif/msdc/pwm/spi/uart.
>>
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> 
> Not sure why CLK_OPS_PARENT_ENABLE was removed, but it does seem like the
> right thing to do, since this block is always on and doesn't require a
> clock to be enabled before accessing the registers.
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org> # CLK_OPS_PARENT_ENABLE change
> 
> Note that I did not go through the bit definitions. I assume the other
> Collabora folks did a good job of reviewing those.

Yes, I did :-)

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers,
Angelo

