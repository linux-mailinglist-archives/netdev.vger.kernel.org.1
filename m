Return-Path: <netdev+bounces-215239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 847FCB2DB33
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 13:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55FAC176EB8
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A256F2EB87C;
	Wed, 20 Aug 2025 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Lsu1LkDT"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BFF2E7179;
	Wed, 20 Aug 2025 11:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689707; cv=none; b=ULKxk8AUV/oeMM8vsgoJNOjw/agUTg++8EcnFTAY+2to3VxQ2IgmouFDt4UMyD8clI6418FtL8XgTKOamtVN5xOYPu5cEXwEZDsyyW7ufQt6Na9BfFbeJ2T72o2c4JYi2S7k9359DHJfFq/qat4eR2RjU8Kf4vTutorulnbzmvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689707; c=relaxed/simple;
	bh=QOHtLk5QqbgZtnm43GlNAZR0h56vCGCpRCGU58YU9R8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agki5rTEzEsuNOH1eBFK6SBQh+fDHTfu1Bd4pLrNOOcwa/oSm8AQGNW18G0I15IrN6Fcgm8qTFip/lADn8Z5ngRncvAOyMGoZWiBdgWJki+op0vE9gCoIK+ZHoNyBpQ7o22l33bhzPriT4mafJWI+llv8387439A0evdzDsklLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Lsu1LkDT; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8EA974E40C47;
	Wed, 20 Aug 2025 11:35:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 58B9D606A0;
	Wed, 20 Aug 2025 11:35:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 658B71C22D8F8;
	Wed, 20 Aug 2025 13:34:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755689701; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=QOHtLk5QqbgZtnm43GlNAZR0h56vCGCpRCGU58YU9R8=;
	b=Lsu1LkDTMPB1LU5muwhWVRn23FMJLNqKfUMsR9IDJHWjE45qmCxx5AP6d9b55ZECZsgZpb
	q9hc/A+lIm20Lru3taO2asF6l6H/8VyMy+Jum/cCxT2ReEVhkFLPRayceA0Qdix1PO4W5m
	gr5lQUmpUdJOlRtGpmwloQSI0I9fO65qPP7lXklBAtQVw0p08f1bi1F++WujW+Rs5+xTGV
	NqypZSpQHsuLa2kCClB4Ihvb2bTrT0sGGeYb881pGLbvQofXGZUT24IIxf2eLwmT/h0yRD
	4XXsx7oq8udgN9HrcROhny4ywakOpELNa1sr97A5W7qm6hufK1fy9+/QcwrSnA==
Message-ID: <3c8d191c-efd6-4756-9c71-109236d4c54c@bootlin.com>
Date: Wed, 20 Aug 2025 13:34:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/5] net: spacemit: Add K1 Ethernet MAC
To: Vivian Wang <wangruikang@iscas.ac.cn>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Vivian Wang <uwu@dram.page>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250820-net-k1-emac-v6-0-c1e28f2b8be5@iscas.ac.cn>
 <20250820-net-k1-emac-v6-2-c1e28f2b8be5@iscas.ac.cn>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20250820-net-k1-emac-v6-2-c1e28f2b8be5@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Vivian,

On 20/08/2025 08:47, Vivian Wang wrote:
> The Ethernet MACs found on SpacemiT K1 appears to be a custom design
> that only superficially resembles some other embedded MACs. SpacemiT
> refers to them as "EMAC", so let's just call the driver "k1_emac".
>
> Supports RGMII and RMII interfaces. Includes support for MAC hardware
> statistics counters. PTP support is not implemented.
>
> Tested-by: Junhui Liu <junhui.liu@pigmoral.tech>
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>

I've read through the driver and it's looking good to me

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


