Return-Path: <netdev+bounces-44968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E7C7DA58C
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 09:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75212825D8
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 07:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E428F63A5;
	Sat, 28 Oct 2023 07:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="UOh8HkQx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122E6442B;
	Sat, 28 Oct 2023 07:50:40 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB29F2;
	Sat, 28 Oct 2023 00:50:39 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 70ECD60003;
	Sat, 28 Oct 2023 07:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1698479438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xNMoOx16tHee+gyB18QUWfLE1gNQXL0jPMq/+CuPw8U=;
	b=UOh8HkQxqaiI9Z1qonEayx3oxBKw+Lexem3D1OGzkkS49NfFCOSdBoUU7KIfl0pMcnXIZi
	00Prk3ZNKKa9Y53s4f9KmrE3GVlzUgMUKeUo1NE5ghOc4UvrxxGVbS11Poii0mlvjmDQ2O
	QylAtAqAi8jrYmpM8U3dNZEIa/oiEaUxH4fbOFoVJtgG9N0z9w02sm2XLsMTGrMQIV4Hjj
	xipjDZXz8vPisgUa7QMaAx9Z652XhFssmwGIzGRfdgOUJ6uFN3k8HgDfwFJ40/oHdSKuJd
	AXRk1oguzfFVi5HW+ilde7gH90vvMvYWzoPrx0M3js/TnBWUOW9s8g1wD4Y47Q==
Message-ID: <dd2eca86-aa11-4ed2-b7bb-19ac17196cc5@arinc9.com>
Date: Sat, 28 Oct 2023 10:50:12 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] dt-bindings: net: dsa: realtek: add reset
 controller
Content-Language: en-US
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 vivien.didelot@gmail.com, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzk+dt@kernel.org, devicetree@vger.kernel.org
References: <20231027190910.27044-1-luizluca@gmail.com>
 <20231027190910.27044-3-luizluca@gmail.com>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20231027190910.27044-3-luizluca@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 27.10.2023 22:00, Luiz Angelo Daros de Luca wrote:
> Realtek switches can use a reset controller instead of reset-gpios.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Acked-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç

