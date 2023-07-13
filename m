Return-Path: <netdev+bounces-17555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B42F751FB1
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 13:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574F2281C86
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 11:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635BF10978;
	Thu, 13 Jul 2023 11:16:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5830DFBFB
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 11:16:25 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A75211F
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 04:16:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso4991455e9.2
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 04:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689246982; x=1691838982;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/t01C0EN/QpTHgEBz222IZKPLFehmewtEJJGjauLMaI=;
        b=eRP3N/6ImevwUzf9czr7Mdt+g6cvqkQ7wpsBpGJHV8fbjaClh7al/4pY9OBafDFXYA
         D5TdzfwwF2JW1E/2TjAQmgik9OXcJalB1dLjaOeaO2ITcgq3u2mxIoqJlZ1B/PdvVULq
         jbEAGF9XLNZZpgq9dS/BlGBYpEVagd0o9mskBHewBAV95kCHgUzR3XylysPYiz+frBXz
         glgLnxxraooy6deqE2iRPcirfNU3mtSea43nn7beyTfS5aD1PbQ51yh64ceH8hJtJWZo
         La54GOgtvu8KVi7v78PRVbsRls5NHtkdWRIOZVeyWopj/iIw0gT8dFXTeOAhnieXx7oJ
         MgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689246982; x=1691838982;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/t01C0EN/QpTHgEBz222IZKPLFehmewtEJJGjauLMaI=;
        b=B8kUQvY6yN51v+4bI0eob4CKjg51mCfPCVAc58ixxeUf5+s7JxsWBcp7dI0c2fagdl
         fC96IVE2sG8c1xJ8iyHmJVs4tYVqPTijZuUBbB+46Nusr3eppDwM2Pd8CcgPZ0l4VMKZ
         AEQ2K3Onz7rle5lxXBJZxPAP1M3ClApuvNL6AvTauNIxqyGVowGjg4p20QqlQR3fA+H6
         Zosu2KFjh5Zi0O99SBNHOLyzXBHq61rT2vOyVeHqox4bY9psJpDv728Y01K6NpeOKJ8H
         DVJG0EIRKTySZR1jx8mK8+E/bRzg4ltrnKkiLYAtOZWStNTb7Wdt+SWmz6ces/hEkz7G
         fgvA==
X-Gm-Message-State: ABy/qLZphKsQR5V1IdNf88nljDBrEjJ7PGNepfACRXsCC9wA6qBfvlpV
	tHiqKBCzpgcsf0vrhgY+uAo4jA==
X-Google-Smtp-Source: APBJJlGmlptlgLgKMVcHCZdHYBHYEoZEjp0eeJuOJ8LpxrUplb1P3+Uoj54fMqYDX19vmUDfuXT51w==
X-Received: by 2002:a05:6000:181b:b0:313:f86f:2851 with SMTP id m27-20020a056000181b00b00313f86f2851mr1336211wrh.3.1689246982433;
        Thu, 13 Jul 2023 04:16:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id k4-20020a056000004400b00314326c91e2sm7702997wrx.28.2023.07.13.04.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 04:16:21 -0700 (PDT)
Message-ID: <f2cf63ac-9bf4-157a-b24e-58dc31336d63@linaro.org>
Date: Thu, 13 Jul 2023 13:16:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 net-next 1/9] dt-bindings: net: mediatek,net: add
 missing mediatek,mt7621-eth
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 John Crispin <john@phrozen.org>, Sean Wang <sean.wang@mediatek.com>,
 Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>, =?UTF-8?Q?Bj=c3=b8rn_Mork?=
 <bjorn@mork.no>, Florian Fainelli <f.fainelli@gmail.com>,
 Greg Ungerer <gerg@kernel.org>
References: <cover.1689012506.git.daniel@makrotopia.org>
 <c472c5611c9c7133978b312a766295a975a0e91a.1689012506.git.daniel@makrotopia.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c472c5611c9c7133978b312a766295a975a0e91a.1689012506.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 13/07/2023 04:17, Daniel Golle wrote:
> Document the Ethernet controller found in the MediaTek MT7621 MIPS SoC
> family which is supported by the mtk_eth_soc driver.
> 
> Fixes: 889bcbdeee57 ("net: ethernet: mediatek: support MT7621 SoC ethernet hardware")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


