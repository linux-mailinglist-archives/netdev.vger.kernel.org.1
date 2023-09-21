Return-Path: <netdev+bounces-35502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A53CC7A9C14
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35755B21480
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A1A48EBA;
	Thu, 21 Sep 2023 17:50:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E0547350
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:50:55 +0000 (UTC)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD1655BA;
	Thu, 21 Sep 2023 10:50:37 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-564af0ac494so853685a12.0;
        Thu, 21 Sep 2023 10:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695318636; x=1695923436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Lp00J6zbysQ8U2olBiWnBUllQFV2OnKj6qqlkk1XgQ=;
        b=Q7v18kTul10IvqQPubPDEojMgN+1Jp1HZd+yZvRRY4XpEInWmZtJuSLn7WmQKBYKRY
         tSdpH9nFdeyyl54GzXLJOJwH1iDnevLW1P20vrnOvmqMj277wudK5x0gVT53C1AkiFc1
         h0yzlKW0AoHg7pliRDIdA/pi/1iecSvSiOyHNl1iEXSifJJG0Nme2gH01EDQ6tFk8NHp
         WVV2eZWtgsq6p6PFh+c+MyidQw4OIzU4oz0Rb2bDpq4zxUeNThAqRF+YteJ4DJ5Smuux
         bsj2KYSwcv0TDyjo+EHxrjh+rkw5RzTSIATlaQuhNbbeVHoMAcmeMdEg1PW9FpGAAxgM
         BRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318636; x=1695923436;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Lp00J6zbysQ8U2olBiWnBUllQFV2OnKj6qqlkk1XgQ=;
        b=G7hbs9QMXSCXH1uSII5e5vXZ3ExMsLEH9GB0HAWP7+JHD9gfPgwhcmKo+xeb6lpC0F
         RWZ4R3lHBrpIAe4m8IutPVlOLcEZVnQWxJtnqZAKh4lyeQ26gIzGrCF+QIBRtwBtZefn
         i8VgVTnUT3+hWtsb845UCMxOEKvBkQFct07Dt1zoBgWSA93shKxoWcqtvbZyd1pWHld6
         5J3CPKiEHMgPGUTc2YR09lGhg+O5PUaRuxhIZf7ID5tdbFmwaCnRiHZAcX7g4/eMvO5m
         RFJThjwfrNstDlh/oKTkZ43r5Dc6xFQbfesFq1jlA0RlwJmv5mesDUHhSSoCGxy7r6vH
         a5cA==
X-Gm-Message-State: AOJu0YzE8XK7+EXEArowZyGxRyVrARb1G5rNtKNdiQTB1yDokwlqdBwq
	hPGBFv1DyzvYg3H6FmhsxlM=
X-Google-Smtp-Source: AGHT+IE7UJ6hYq2t3odvKnj1OZgtt6CWAdhXxSjFmzJDNiIjPTZrtGFl/0+W4Cg0cp1PsPUwW0M7Mg==
X-Received: by 2002:a17:90b:3786:b0:274:77df:50cd with SMTP id mz6-20020a17090b378600b0027477df50cdmr6002734pjb.9.1695318635785;
        Thu, 21 Sep 2023 10:50:35 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id r6-20020a17090a438600b00263f41a655esm1817452pjg.43.2023.09.21.10.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 10:50:35 -0700 (PDT)
Message-ID: <ab3076e2-5f65-e517-17f9-00249aabe51f@gmail.com>
Date: Thu, 21 Sep 2023 10:50:33 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 net-next 3/5] net: dsa: tag_ksz: Extend ksz9477_xmit()
 for HSR frame duplication
Content-Language: en-US
To: Lukasz Majewski <lukma@denx.de>, Tristram.Ha@microchip.com,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 davem@davemloft.net, Woojung Huh <woojung.huh@microchip.com>,
 Vladimir Oltean <olteanv@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230920114343.1979843-1-lukma@denx.de>
 <20230920114343.1979843-4-lukma@denx.de>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230920114343.1979843-4-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/20/23 04:43, Lukasz Majewski wrote:
> The KSZ9477 has support for HSR (High-Availability Seamless Redundancy).
> One of its offloading (i.e. performed in the switch IC hardware) features
> is to duplicate received frame to both HSR aware switch ports.
> 
> To achieve this goal - the tail TAG needs to be modified. To be more
> specific, both ports must be marked as destination (egress) ones.
> 
> The NETIF_F_HW_HSR_DUP flag indicates that the device supports HSR and
> assures (in HSR core code) that frame is sent only once from HOST to
> switch with tail tag indicating both ports.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


