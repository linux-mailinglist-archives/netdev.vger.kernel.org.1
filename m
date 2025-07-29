Return-Path: <netdev+bounces-210836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 318E0B1507B
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 17:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829B4188380F
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 15:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C695029551E;
	Tue, 29 Jul 2025 15:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="l5FG3tLb"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B9BF507;
	Tue, 29 Jul 2025 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753804306; cv=none; b=WHSlXXHmlljFolNVYVbXPr+mC20QutoLz1fSUd08u6HSdnGQ1YV5Ke3YI76pNmKr0QBcQU69rRSgoUOAP36dY79/UX/Fqm/f37Vt5xn1IcMv1VMJIZk6yoVjDa7A8MTxlW+UtPM31uF3NXboDrRB0orsHGELaGl8BzBB5Os+raI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753804306; c=relaxed/simple;
	bh=MB5fh2uBPuAehbQY8QqFk4AryWaAIPon9NPjqNjtLx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gVP6/IYXGqeqIpb9X5oooKM1o29eL36juwbW8bkWXnwOdBOgimtz+ku7w92w9qQvc7rfvLIqW5wMEwq0IVy5Lz+2HS+pOYGR7hdt+sfx9JnwJH0EuLPyo4mgCM500K8QaoY2URmCRFLiwkw8sZHthv/iXqc9Zwj9E5E8OG6/1rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=l5FG3tLb; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753804305; x=1785340305;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MB5fh2uBPuAehbQY8QqFk4AryWaAIPon9NPjqNjtLx8=;
  b=l5FG3tLb9Wakz6dSGpEXJBBwjvpULTYTlkZjJg2wTl0d4kaCIM7I11ZD
   lt8SToL6o7XIT8oTnv+tH866vwIOn2H++NjM5k0uCHuSxdRpbSFXudojq
   MEalOrX0nqge9lJ27RrtXhaBuFP2EVjBOWK9XkQmk5wlaJSJA83yEFCID
   8AbYTFgtp62G4JDYyYUij+QcVXC83LqP/BojUHveyq/bOKcUgg5Gchiw7
   1NkeIcMrxon1IbGkf8nx04GBnfxF6zN1+v3J5JsiiJBcEKRDnIRngFQcK
   2TSvKtJdDzIIbS4y7fW1CxYiLjMroDSGAeJSiNduGcz68sSC3eO78g6C+
   A==;
X-CSE-ConnectionGUID: kwjiFHDITVCVqkiL+FzGcA==
X-CSE-MsgGUID: cYRXmoNxQqKn9Y6AII0baA==
X-IronPort-AV: E=Sophos;i="6.16,349,1744095600"; 
   d="scan'208";a="44033233"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2025 08:51:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 29 Jul 2025 08:51:16 -0700
Received: from [10.10.179.162] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 29 Jul 2025 08:51:16 -0700
Message-ID: <76e7b9fc-e0e2-4d21-ba5a-dac831522bb2@microchip.com>
Date: Tue, 29 Jul 2025 08:51:14 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] net: cadence: macb: sama7g5_emac: Remove USARIO
 CLKEN flag
To: claudiu beznea <claudiu.beznea@tuxon.dev>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <cover.1752510727.git.Ryan.Wanner@microchip.com>
 <1e7a8c324526f631f279925aa8a6aa937d55c796.1752510727.git.Ryan.Wanner@microchip.com>
 <fe20bc48-8532-441d-bc40-e80dd6d30ee0@tuxon.dev>
 <848529cc-0d01-4012-ae87-8a98b1307cbe@microchip.com>
 <681b063c-6eab-459b-a714-1967a735c37d@tuxon.dev>
From: Ryan Wanner <ryan.wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <681b063c-6eab-459b-a714-1967a735c37d@tuxon.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On 7/26/25 05:56, claudiu beznea wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know
> the content is safe
> 
> Hi, Ryan,
> 
> On 7/21/25 18:39, Ryan.Wanner@microchip.com wrote:
>> On 7/18/25 04:00, Claudiu Beznea wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>>> know the content is safe
>>>
>>> Hi, Ryan,
>>>
>>> On 14.07.2025 19:37, Ryan.Wanner@microchip.com wrote:
>>>> From: Ryan Wanner <Ryan.Wanner@microchip.com>
>>>>
>>>> Remove USARIO_CLKEN flag since this is now a device tree argument and
>>>
>>> s/USARIO_CLKEN/USRIO_HAS_CLKEN here and in title as well.
>>>
>>>> not fixed to the SoC.
>>>>
>>>> This will instead be selected by the "cdns,refclk-ext"
>>>> device tree property.
>>>>
>>>> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
>>>> ---
>>>>   drivers/net/ethernet/cadence/macb_main.c | 3 +--
>>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/
>>>> ethernet/cadence/macb_main.c
>>>> index 51667263c01d..cd54e4065690 100644
>>>> --- a/drivers/net/ethernet/cadence/macb_main.c
>>>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>>>> @@ -5113,8 +5113,7 @@ static const struct macb_config
>>>> sama7g5_gem_config = {
>>>>
>>>>   static const struct macb_config sama7g5_emac_config = {
>>>>        .caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII |
>>>> -             MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_MIIONRGMII |
>>>
>>> Will old DTBs still work with new kernels with this change?
>>
>> That was my assumption, but it seems it would be safer to keep this
>> property for this IP and implement this dt flag property on IPs that do
>> not already have  MACB_CAPS_USRIO_HAS_CLKEN property.
> 
> So, this patch should be reverted, right?

Yes you are right, more testing I see that this could break older DTs. I
am new to reverting patches, do I send a patch to revert this and would
it be an issue now?

Ryan
> 
> Thank you,
> Claudiu
> 
>>
>> Ryan
>>>
>>> Thank you,
>>> Claudiu
>>>
>>>> -             MACB_CAPS_GEM_HAS_PTP,
>>>> +             MACB_CAPS_MIIONRGMII | MACB_CAPS_GEM_HAS_PTP,
>>>>        .dma_burst_length = 16,
>>>>        .clk_init = macb_clk_init,
>>>>        .init = macb_init,
>>>
>>
> 


