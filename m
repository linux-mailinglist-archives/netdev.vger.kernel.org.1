Return-Path: <netdev+bounces-137454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 551779A67D5
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA3B1C21814
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8471F470D;
	Mon, 21 Oct 2024 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CVz+U6Ha"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258B41EABDA;
	Mon, 21 Oct 2024 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513057; cv=none; b=I8tDI6YplocxSVBJSchstmjcXAl0o/utjBnilrXZ2oz4UuG8q3XOfPFJr0i3JIn8pZJAzNVtECzVMlWiAzVXHkOZW3shCZRxDF+ynfQOfuYct/OM0f3CJrjB3bHL+MP2hwolA1aLomlgVsasPqt+FJ/fftf4ST3Mg93xgZR4ALo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513057; c=relaxed/simple;
	bh=Q6FrehBPezcu/K5sUqprTUnBKcG9qqOb9+zf/UbhhmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMzRMUGAEJHarnlyVI2Tw1QNDE0LLmL3ufGqcwrWH1W/Fkos6/SIJ6lioIf7iQE/6I74WN0r48/6jXYbNV85YDGYCDwTY8nq+wn7yKuVo81bBiYSnOat2n9p97FcJx/sDpj/eK3yhQ8s7gQ6xz7OK7e9vQd5bvrFaSIrR3AHyEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CVz+U6Ha; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729513053;
	bh=Q6FrehBPezcu/K5sUqprTUnBKcG9qqOb9+zf/UbhhmU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CVz+U6Haz1KNYI1ov1vdgJxaxNy5YKnGl42KGAvRrcSYHqEik+wwwwP+NVCw7k82/
	 D7AcF0QnMkE40Q1z6Mz26Y1S6AiT/259ZNmFE508JOqWe0UDGnDCvi+nClUzlSjo6K
	 7WtmXi9yVIjWqYJejSwogfRQ+aAO5lw3quhYR00Qh8S5uM+lnpZ/tBLQjnntZ6fmZd
	 JwGE+imTI1Bqz4WOkdODhPc0ZqNCSBnjI9rIaOGNC5SIGf+glHwzZq51fJKzjpT+IS
	 vB1FPqHdrnlu3fKfnlLEHghRq2BAFxh6OSbSs6KbeHdzVc1gTJjdSMjJyG1uzs9o62
	 J4+nWJx3cL/pg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 81A9517E11FA;
	Mon, 21 Oct 2024 14:17:32 +0200 (CEST)
Message-ID: <219f2873-2ae0-437d-83de-ca7fb8d2751a@collabora.com>
Date: Mon, 21 Oct 2024 14:17:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: mt8390-genio-700-evk: Enable
 ethernet
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Richard Cochran <richardcochran@gmail.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Jianguo Zhang <jianguo.zhang@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Hsuan-Yu Lin <shane.lin@canonical.com>, Pablo Sun <pablo.sun@mediatek.com>,
 fanyi zhang <fanyi.zhang@mediatek.com>
References: <20241018-genio700-eth-v2-0-f3c73b85507b@collabora.com>
 <20241018-genio700-eth-v2-2-f3c73b85507b@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241018-genio700-eth-v2-2-f3c73b85507b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 18/10/24 17:19, Nícolas F. R. A. Prado ha scritto:
> Enable ethernet on the Genio 700 EVK board. It has been tested to work
> with speeds up to 1000Mbps.
> 
> Signed-off-by: Jianguo Zhang <jianguo.zhang@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Signed-off-by: Hsuan-Yu Lin <shane.lin@canonical.com>
> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
> Signed-off-by: fanyi zhang <fanyi.zhang@mediatek.com>
> [Cleaned up to pass dtbs_check, follow DTS style guidelines, and split
> between mt8188 and genio700 commits, and addressed further feedback from
> the mailing list]
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



