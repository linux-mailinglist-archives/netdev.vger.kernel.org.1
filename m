Return-Path: <netdev+bounces-114858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8726E944652
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 10:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA451F22EE1
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 08:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EFA15748A;
	Thu,  1 Aug 2024 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="es24NWfR"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4980157493;
	Thu,  1 Aug 2024 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722500245; cv=none; b=AZdqarePU3up4Bw5ATdq7diQX4s8cqPikGjEQPhk+H1jkmviyIVDgeirq3pbqri1hsi5dWAVcCaQQ2aAQpFDFow92MHffNlSq0Fwe8ajFUWMUMUFOKq09Cm2BGB76+79+bHPqhMSBCT3yA5+kYXdcXgmtT4KpJUK8WCMdPsQAME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722500245; c=relaxed/simple;
	bh=Z20sUPXblItMvwwJf8f0PrCd/E4FCSbEM2nHiZVvswY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BEDSa4cRlAPnEFcY8rS8cTOKjA0QEGFt2g4oj8D1dHQPNA9EDJy2Vmlq7/vLfQh4Z3BIvlnlygeXng01CWo2dRqfduhxED05FududlAOXGHSxZcb2i8Y6QDmB0qXstIV41uSgXBL7HjRU3oBngJNy5qeT9hRMZyb5f8wVp+U6F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=es24NWfR; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CFBB7FF806;
	Thu,  1 Aug 2024 08:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1722500240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hCJih/CXWpDjaOxDp/PsThEXnkiMVnmo5tPOCzOaqSY=;
	b=es24NWfRSi6ySnzlmCw0Ll9C/NaYLOHOV3+3vfBwZKskgf+5cpSsxcuh3lQX7os2rlUcgB
	Yzc+djhXoiP2lPh2PNraFzPP+nV3OorzFOzpk1MmZPE1sn5TrBsotLzQCZlsHOmej1bgbR
	S297KK73Q4v7Gzjfw+CHtqE+UZ376IyjIa11ipFT3iW1VNpoFUuYQS15LrBaQUA7cjsziL
	SCHHmk1K7ZvJv+wuuU9xH2j7H9Wn5rzpjZPUGrdzsXJW1qrEVAbZ/wfZCwb/V435N+TLvB
	MJhUwoFeag8EV+OOvmCIRj8y1vM2OgdDLB/xhtB9rQdXTDu49ZUyGFDMZE/eWg==
Message-ID: <09f80df8-07be-47e4-b224-cb1e0a7910ce@arinc9.com>
Date: Thu, 1 Aug 2024 11:17:14 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 1/2] dt-bindings: net: dsa: mediatek,mt7530:
 Add airoha,en7581-switch
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: daniel@makrotopia.org, dqfext@gmail.com, sean.wang@mediatek.com,
 andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 lorenzo.bianconi83@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, upstream@airoha.com
References: <cover.1722496682.git.lorenzo@kernel.org>
 <f149c437e530da4f1848030ff9cec635d3f3c977.1722496682.git.lorenzo@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <f149c437e530da4f1848030ff9cec635d3f3c977.1722496682.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 01/08/2024 10:35, Lorenzo Bianconi wrote:
> Add documentation for the built-in switch which can be found in the
> Airoha EN7581 SoC.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç

