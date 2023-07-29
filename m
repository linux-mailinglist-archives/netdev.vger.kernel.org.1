Return-Path: <netdev+bounces-22555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF63767FD9
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 15:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73B71C20AEE
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 13:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B09168C3;
	Sat, 29 Jul 2023 13:58:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E2B16435
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 13:58:25 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FD01707;
	Sat, 29 Jul 2023 06:58:22 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C6A241C0004;
	Sat, 29 Jul 2023 13:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1690639101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cOPjuFWRIoL4Z0Eeol5gO6QE7SM7OBiqVr5rmWDNiY0=;
	b=EBG41HMYCfHzsxX3Lu9wjhkOhuazVRfwvQjx8aikqyaWwoErHMXsViXnbGoqg8Nond5/Ie
	HFcvgQ+1rSLKe6Noru8SdP36Q08DwtfLx+vnxlUmQwTyyJPL/qs3ONncHX5t9vasJE0DoX
	/eUthf9xVwmkfO/rLXQZWdtFLykvy0nRUlIhEylCGqp+qNxw+t3FQG17qIEomftqzei86U
	nf9JFAW3gXQsm8cxVOQEkEImwkkNkMtC/LEaxEvx4UslsC1bvpwcAcgGqreWQFtlGkpm8B
	phERC66B0NTICUCuh6LsJeHI82jprLe45uKr1PAdK/4+AvNSTuhPiGZt3sxqiQ==
Message-ID: <cef11e4e-d96e-8cc8-045c-adcf006bdcf0@arinc9.com>
Date: Sat, 29 Jul 2023 16:58:10 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: MediaTek Frame Engine Ethernet: does it need any resets?
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Network Development <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 linux-mips@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-mediatek <linux-mediatek@lists.infradead.org>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Daniel Golle <daniel@makrotopia.org>
References: <2a4da319-a78a-7cb1-6f18-f59180de779f@gmail.com>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <2a4da319-a78a-7cb1-6f18-f59180de779f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 29.07.2023 14:45, Rafał Miłecki wrote:
> Hi,
> 
> I'm trying to understand MediaTek's Ethernet controller resets.
> 
> I noticed there is sth fishy when checking dts files. See following
> errors:
> 
> arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: 
> ethernet@1e100000: resets: [[2, 6], [2, 23]] is too short
>          From schema: 
> Documentation/devicetree/bindings/net/mediatek,net.yaml
> arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: 
> ethernet@1e100000: reset-names:1: 'gmac' was expected
>          From schema: 
> Documentation/devicetree/bindings/net/mediatek,net.yaml
> arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: 
> ethernet@1e100000: reset-names: ['fe', 'eth'] is too short
>          From schema: 
> Documentation/devicetree/bindings/net/mediatek,net.yaml
> arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: 
> ethernet@1e100000: Unevaluated properties are not allowed 
> ('reset-names', 'resets' were unexpected)
>          From schema: 
> Documentation/devicetree/bindings/net/mediatek,net.yaml

Sigh, looks like this patch was applied regardless of my points here. 
Now we're here picking up the pieces.

https://lore.kernel.org/netdev/b6c7462d-99fc-a8e1-1cc2-d0a1efc7c34d@arinc9.com/

> 
> 
> 1. Binding mediatek,net.yaml
> It says that when present, there must be 3 resets: fe, gmac, ppe
> 
> 2. mt7621.dtsi
> It specifies 2 resets: fe, eth
> 
> 3. mt7622.dtsi
> It doesn't specify any resets
> 
> 4. mt7629.dtsi
> It doesn't specify any resets
> 
> 5. drivers/net/ethernet/mediatek/
> I don't see any reset_control_* code at all
> 
> 
> Can someone help me what's the actual case with resets? Are they needed?
> Are they used?

I'm adding Sergio to CC as they've been the one working on this on 
mt7621.dtsi.

There's relevant information here.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=64b2d6ffff862c0e7278198b4229e42e1abb3bb1

Arınç

