Return-Path: <netdev+bounces-211511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FE2B19DBD
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 10:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47065163771
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 08:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463BE241696;
	Mon,  4 Aug 2025 08:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GEWJMHXX"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A7917D346;
	Mon,  4 Aug 2025 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754296594; cv=none; b=s9NXQqHacf+oxBpMCrhN544kYLlS4OUtTPf4aMtX4wxHhEwG+zala8YZiLvz/jtguJed6iwUDVlfKrqIhYmt6pyvnkUJHvicTCVQsuor3GasunC48rLiVzkK2lLa52UKWq0eTwLeySM55Y7u3iIsJSung05feNKtm/KudNdIYbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754296594; c=relaxed/simple;
	bh=q5NIFYfPGBPjvoRsywWnULzZC4/llLvrlCsM4PPmad8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUgj0kdI15kLWuhBXOII0nuO0sK0tBI/NHLCyIshqIO0KIX/lFJFnUlPPrEN8Kyrj705GsCaD/BFKsGNvXx8uCjhiR/KKgxQkpykfVI9WTeH0dbHByPudTcLikd8DrvVj3UfXljeovimIyWLuCTZFeZ/7Ko9pcEerpw47g8+4bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GEWJMHXX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754296589;
	bh=q5NIFYfPGBPjvoRsywWnULzZC4/llLvrlCsM4PPmad8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GEWJMHXX5RsnmTOJN70LagzbEdSWbWeG4Gm61w/fGPuV9/F2aWcIOTOKQ7vzDwUyN
	 OkenWlIlBSnw9Tv6NaFVkxYARemn6szzVyFYaTjo5LWRmmRwvElFOoEDQLZ4e7uR6v
	 XXeCXGjhOr0eUfI56Cv8Ca62P7gl4EJ1YuCCOW41LGr3PbvaZI1DjnARAP02ZgAgxR
	 1fm88wpkzejL8TBWl0wcpl1Yxz9Pgf0lAC2MAJ2ACjY+qOFmbnP9+y2CA9p+F7co5W
	 cR1Ah377dwBdY/0CVgJzYZ4zDm2DJlbVoSdh/NJDYcbIrtNhKBQNPPe3LPLwiV4FU1
	 aErpIcMLRVAww==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:169:2004:39f0:9afe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 38AC217E0B8C;
	Mon,  4 Aug 2025 10:36:28 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: krzk@kernel.org
Cc: angelogioacchino.delregno@collabora.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	guangjie.song@mediatek.com,
	kernel@collabora.com,
	krzk+dt@kernel.org,
	laura.nao@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	matthias.bgg@gmail.com,
	mturquette@baylibre.com,
	netdev@vger.kernel.org,
	nfraprado@collabora.com,
	p.zabel@pengutronix.de,
	richardcochran@gmail.com,
	robh@kernel.org,
	sboyd@kernel.org,
	wenst@chromium.org
Subject: Re: [PATCH v3 09/27] dt-bindings: clock: mediatek: Describe MT8196 clock controllers
Date: Mon,  4 Aug 2025 10:35:40 +0200
Message-Id: <20250804083540.19099-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <fbe7b083-bc3f-4156-8056-e45c9adcb607@kernel.org>
References: <fbe7b083-bc3f-4156-8056-e45c9adcb607@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 8/3/25 10:17, Krzysztof Kozlowski wrote:
> On 01/08/2025 15:57, Rob Herring wrote:
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  '#clock-cells':
>>> +    const: 1
>>> +
>>> +  '#reset-cells':
>>> +    const: 1
>>> +    description:
>>> +      Reset lines for PEXTP0/1 and UFS blocks.
>>> +
>>> +  mediatek,hardware-voter:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description:
>>> +      On the MT8196 SoC, a Hardware Voter (HWV) backed by a fixed-function
>>> +      MCU manages clock and power domain control across the AP and other
>>> +      remote processors. By aggregating their votes, it ensures clocks are
>>> +      safely enabled/disabled and power domains are active before register
>>> +      access.
>>
>> I thought this was going away based on v2 discussion?
>
> Yes, I asked to drop it and do not include it in v3. There was also
> discussion clarifying review.
>
> I am really surprised that review meant nothing and code is still the same.
>

This has been re-submitted as-is, following the outcome of the discussion 
here: https://lore.kernel.org/all/242bf682-cf8f-4469-8a0b-9ec982095f04@collabora.com/

We haven't found a viable alternative to the current approach so far, and
the thread outlines why other options don’t apply. I'm happy to continue 
the discussion there if anyone has further suggestions or ideas on how 
to address this.

Thanks,

Laura

> Best regards,
> Krzysztof


