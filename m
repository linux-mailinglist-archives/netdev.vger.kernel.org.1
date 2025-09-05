Return-Path: <netdev+bounces-220253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1637CB45134
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 10:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D63188A1FF
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 08:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB54C304BAE;
	Fri,  5 Sep 2025 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aolFvpWn"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20832FE579;
	Fri,  5 Sep 2025 08:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060438; cv=none; b=ns2T7fk7nE/ZvkjBS/XxKB6+DK6LRsmawOS1wp9dg4x0wIOlZWvP+L3qWjed2ReI+yJd0Bq8f/UOJvM7M7RolIwc1LlLsUgnWr3XzXyOsipZPpINQw9NLFZk8qNhROrI2MsA83eW0IKvAyfkrEr5YI1P+ITu7co9NGs45iQY0gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060438; c=relaxed/simple;
	bh=OAnRq+EFKKwYtkRHr0XwJ5eAzkcTuotAqvUJYtyAA7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pDNBvnBC05j5m6KYmVqfSCFC/mwq+Dfw82bodBJKyiQjKiIbJhCxk1WnbGkdT7X4p5cC9O+fhQhvlXS5bogO681S4KyallP//PwfAOlTTxQEHfcHaijrYQtMx9+DoDLPc2zPDQHgyxFQIZNXSTPPJABncXwYg83tqNn+66TAFxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aolFvpWn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757060435;
	bh=OAnRq+EFKKwYtkRHr0XwJ5eAzkcTuotAqvUJYtyAA7w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aolFvpWn/tCj2yIGSvsHAhJDidaC+yNPqGzu1ARtT+PyBYBTtd+fcOWCWjFkbTlv5
	 uFoQNUncMb9hUb0NDMi8pur6WyqqDA5e4reB8ZVZuxc0rZ0Vaat3d9bLvb59nsKtT+
	 isbHtl4x2zbtuoZeqxvrKXW+VperMTogzjNhSEhblCaJO7jVrIuFuVAp94HThD4V+a
	 6aC82FaNcKQYbGnbHCXfvkIvV9+S5W4b5AQCtRKGpcwSzh8NSOBSK7GPHB3mkn4pNp
	 58HdvIOIyLzkxrV+JQHJ9ZQwpRUFk7RrxazV1WhYJ4eHS4rcMjt8cRn6Erl8yrkrVv
	 EqP28fESmLtPg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6957517E0AC3;
	Fri,  5 Sep 2025 10:20:34 +0200 (CEST)
Message-ID: <000a0636-2a78-433b-8bfe-2534ae0a9bee@collabora.com>
Date: Fri, 5 Sep 2025 10:20:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/27] clk: mediatek: clk-gate: Refactor
 mtk_clk_register_gate to use mtk_gate struct
To: Laura Nao <laura.nao@collabora.com>, mturquette@baylibre.com,
 sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, p.zabel@pengutronix.de, richardcochran@gmail.com
Cc: guangjie.song@mediatek.com, wenst@chromium.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 kernel@collabora.com
References: <20250829091913.131528-1-laura.nao@collabora.com>
 <20250829091913.131528-7-laura.nao@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250829091913.131528-7-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/08/25 11:18, Laura Nao ha scritto:
> MT8196 uses a HW voter for gate enable/disable control, with
> set/clr/sta registers located in a separate regmap. Refactor
> mtk_clk_register_gate() to take a struct mtk_gate, and add a pointer to
> it in struct mtk_clk_gate. This allows reuse of the static gate data
> (including HW voter register offsets) without adding extra function
> arguments, and removes redundant duplication in the runtime data struct.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Nice cleanup.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



