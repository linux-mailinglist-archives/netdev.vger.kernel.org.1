Return-Path: <netdev+bounces-43941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CE67D5879
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 18:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51743281A9F
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8BF2B5D7;
	Tue, 24 Oct 2023 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZTRAspK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96543A26E;
	Tue, 24 Oct 2023 16:34:12 +0000 (UTC)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D4E10D5;
	Tue, 24 Oct 2023 09:34:09 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-779f2718accso29025585a.1;
        Tue, 24 Oct 2023 09:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698165248; x=1698770048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uxlGF2huoBf3gQegLGUHLrMjlaXDURjhRNvYADg8LmE=;
        b=lZTRAspKjdwRxLc/oVqNLvu7WgUKp06fseGeuhQMTeegc1y1udsm9uOSSFyYg7lGEo
         jNQpdOz1YUgKdsteB8MoCvdepcqg/eC2BXv2mE+vNTgJia2oQF7Dl0L/pzxB+UiKBXYp
         R+rIet+eg81PYcJm+AAE6nGFxHEjCLslZd7PUwQZyqr52mWvwunMbH+nmphNNZSjbATE
         BC2P0OFoMYvaZAOvjfSeU13ObFl8Mh8AKe7WcAM+aW+CXQT1Ia+wi5tyYjxQvDFPVus2
         I7O8HKLEGk8L/ghBceD2ufiBPb9mCl0SCwp7C3wYat89RADLutoqbB5UeIy9CK/k6tBq
         ecqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698165248; x=1698770048;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uxlGF2huoBf3gQegLGUHLrMjlaXDURjhRNvYADg8LmE=;
        b=EuVylJMVAcUduTfkavJoc/rCsDy4vL0bzBXa/VNdz/9b24EJmS0CK/j4VYBLRzL5aN
         TSz9qPAwLs8ut4oEOzxlkaBk27tGHW04AN5uL8mwDxrK4LoRIDQGa14rVrkOGsQnfYwe
         fHucD3DlqHyNulAJBPe4XdIV9D0/09kNes4Ja3QV3j88K18OzBjQQAnrQYeN2SgELGvj
         HRnDwg4h3WkQBJLqqRFK//v+SvtI91v3oaMblMLxkREqYkDitWWsQly2W2GCwyti5GAZ
         L2NeVAgWGGflcmEiDzl8NLodECpGNjeMANP2P3/92vTXwlqdRacTlUG1DDG3TGSxH1Da
         JCiA==
X-Gm-Message-State: AOJu0Yxej7O3C5/369zKdHXFszTzNBBA8ZaqpWNv0KEYHy9yw2UQSEcl
	7Jo+vIfbB4yoJUmko/8CYhQ=
X-Google-Smtp-Source: AGHT+IHg2hQOyHtXeTUA7PVDYJ0xqDkt8W6ms2wylLaxLKy0rZaAjlYf2EDHPdQicvzSqZgO826bvw==
X-Received: by 2002:a05:620a:25c6:b0:774:193c:94bd with SMTP id y6-20020a05620a25c600b00774193c94bdmr14838663qko.4.1698165248609;
        Tue, 24 Oct 2023 09:34:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id h21-20020ac87455000000b00419b094537esm3590812qtr.59.2023.10.24.09.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 09:34:06 -0700 (PDT)
Message-ID: <d5871a55-a699-470c-a41d-ff457699d9c0@gmail.com>
Date: Tue, 24 Oct 2023 09:34:02 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 1/7] dt-bindings: net: dsa: Require ports or
 ethernet-ports
Content-Language: en-US
To: Linus Walleij <linus.walleij@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Rob Herring <robh@kernel.org>
References: <20231024-marvell-88e6152-wan-led-v7-0-2869347697d1@linaro.org>
 <20231024-marvell-88e6152-wan-led-v7-1-2869347697d1@linaro.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231024-marvell-88e6152-wan-led-v7-1-2869347697d1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/23 06:20, Linus Walleij wrote:
> Bindings using dsa.yaml#/$defs/ethernet-ports specify that
> a DSA switch node need to have a ports or ethernet-ports
> subnode, and that is actually required, so add requirements
> using oneOf.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


