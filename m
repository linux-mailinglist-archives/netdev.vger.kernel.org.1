Return-Path: <netdev+bounces-44966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4927DA588
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 09:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1753F282624
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 07:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B89611B;
	Sat, 28 Oct 2023 07:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="kT7eWWpp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B71C10F5;
	Sat, 28 Oct 2023 07:49:58 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A7DF2;
	Sat, 28 Oct 2023 00:49:55 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D6C8F60003;
	Sat, 28 Oct 2023 07:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1698479391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2mdXs4jO1aTG733culD1fnuhp1heOXs/uBd46li3Efg=;
	b=kT7eWWppAYUP29gVi46y5xd0ZAN/xREeCAtKIbJVDDukXnA2g6iZ+T5p5Y8WUBghN7YqoX
	Bd9IoKnYb4/40ycVtf09qG8UF7RKCqOlt7X/4p1OhNya+pDPkSWj4347jfHYfhfksbYygM
	LGXVfNoIn7pkWzW6AS8fm7AqYkLoeERCRyNzHTQLqE3ndc1fvH5+CUauxPbiaADP0PElDS
	8G3jbhpvN9sWO1f+PpTTk29xFIMhhxt/XyP+ebllSM5kxIun2+C2ATwAdob6njKXNXamEi
	uPnRC5z9lDzkJyrInpqavm+nSv0M5KaB3jxJaDJQL7nOiFkzbC+kxuHp+Fwbng==
Message-ID: <a6c48622-913a-4750-8173-7e5d1bf4c8dd@arinc9.com>
Date: Sat, 28 Oct 2023 10:49:23 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] dt-bindings: net: dsa: realtek:
 reset-gpios is not required
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 vivien.didelot@gmail.com, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzk+dt@kernel.org, devicetree@vger.kernel.org
References: <20231027190910.27044-1-luizluca@gmail.com>
 <20231027190910.27044-2-luizluca@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20231027190910.27044-2-luizluca@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 27.10.2023 22:00, Luiz Angelo Daros de Luca wrote:
> The 'reset-gpios' should not be mandatory. although they might be
> required for some devices if the switch reset was left asserted by a
> previous driver, such as the bootloader.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Acked-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç

