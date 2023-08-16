Return-Path: <netdev+bounces-28152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E9377E661
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 18:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3EC1C21054
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731F716436;
	Wed, 16 Aug 2023 16:29:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686F516414
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 16:29:35 +0000 (UTC)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193F51980;
	Wed, 16 Aug 2023 09:29:31 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-649921ec030so912886d6.1;
        Wed, 16 Aug 2023 09:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692203370; x=1692808170;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XZoiawh33EN8egkU31l+X3dd1VdBtDLA5RvWoX+ot10=;
        b=it+m/f27p3Xv9yPNgEvDmy8ksdTIyC3AP6snE7vGudLdFOFQRrfUr2MwJcCvN3JEAY
         1Rd106fgNEJnl/ukfu1L9/JwsuBcJleYKjmkCL9sG7A3NwpK7KrIzhN01NBbA9ARM9hV
         SJS0X/nJum0laNlaQ5ZGvZRZiLAwdpO2BfOx9AOGaTAKR5IEPTV2zN+vNv96eS18Ni5M
         OQdwmEhPfXd2hJK2A9EROjJyevDr2gpVc2zo9GR/g0cMcibIcWxmB4Rr8Zudg6dP7kII
         9FeSRWA5ZZF+cprOdTwRT+SJ9BaGaY29vrLCSiCHnj9r0CJDDhYa0pvGeEPhGARF1zAl
         jJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692203370; x=1692808170;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZoiawh33EN8egkU31l+X3dd1VdBtDLA5RvWoX+ot10=;
        b=iGeVLxzSyi9I4BJ70thtGvWK/+QJGurZ6qoV2bYQ4k089HLvqTjn0WI1/riQs/sMr2
         6KV/7Mmnb+oZ2U2lmI3mHiWrT3TiKo0xL8gt6iD2rbiqO4elPvK+dRIZaov8sxjTh4SK
         AD39DGEVnYvASjrEYVgIOAaTWBCPKvdCQgk+e6jiYSLHXbYPUK8/I/kPdhNUS03LemSR
         nUucGaLnaVL75WYBpj97OwfQdoS/gPRz4Y6XufmQLeMPE0HT24+vceVgHF539vSwW5fO
         LzZqxHf82z5Pyr13HWSajNLqBJWzOywDOeb9hqFpKoUaUTOHUF92rDa+dSeiOGY6ANMY
         IcJw==
X-Gm-Message-State: AOJu0YylHGtCcxn4caoxYksEjxo1DlxoZ9HReTrtESDXPITvE2ygY/iE
	5+1czohnfxKoa0nkv95qhTE=
X-Google-Smtp-Source: AGHT+IH2zLks0E7Y4TfQ5mZXZCXk86892jlNYmBii+ktZG2i0ZIzA4KnSgdIUoi9+5AIZpP1uON+Zg==
X-Received: by 2002:a0c:e44d:0:b0:636:f84f:f0c5 with SMTP id d13-20020a0ce44d000000b00636f84ff0c5mr1998219qvm.38.1692203369991;
        Wed, 16 Aug 2023 09:29:29 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id p6-20020a0ce186000000b00632191a70aesm4949859qvl.88.2023.08.16.09.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 09:29:28 -0700 (PDT)
Message-ID: <8fb144a7-92ac-2107-8a7c-19acc109bad8@gmail.com>
Date: Wed, 16 Aug 2023 09:29:01 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/4] dt-bindings: net: dsa: microchip,lan937x: add missing
 ethernet on example
Content-Language: en-US
To: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>,
 UNGLinuxDriver@microchip.com, Linus Walleij <linus.walleij@linaro.org>,
 =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alsi@bang-olufsen.dk>,
 Daniel Golle <daniel@makrotopia.org>, Landen Chao
 <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20230812091708.34665-1-arinc.unal@arinc9.com>
 <20230812091708.34665-2-arinc.unal@arinc9.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230812091708.34665-2-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/12/23 02:17, Arınç ÜNAL wrote:
> The port@5 node on the example is missing the ethernet property. Add it.
> Remove the MAC bindings on the example as they cannot be validated.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


