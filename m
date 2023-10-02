Return-Path: <netdev+bounces-37539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB4A7B5DB0
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 01:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BABC8281388
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 23:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EA1208C2;
	Mon,  2 Oct 2023 23:24:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15351E521
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 23:24:52 +0000 (UTC)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7C0AD
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 16:24:51 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-578d791dd91so201915a12.0
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 16:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696289091; x=1696893891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bRL3/7Khkbg2e6woqRlv5wpaZ7o8kFg/B18p22kS+Kc=;
        b=iPjUqE5vALc6dPjft0XvrISwPgBpla0uxJ4hKdwEU431nIHzMEX7/pg+8jz6bvGbiL
         FjJXR373j4wSBz0dSp0xj6Kz+DeYkqQ1PJBNNNrHBHhqDdavxVGTT4bHekjTPe4p/TOx
         lHTUuDdOJvc+gbdebqoJZnXsop8B7QYMnEkyutD3QdIkm0ANgKpP3JxbRXns2/kSH0Hl
         sCtniPdfcZJr4JswALNvEJuHKgzZjA7BCXfGNmvhUn3yQmFzVvz3EmIEWgB+6hCVVdvW
         OUjypeIChRuXz2ZbicGEsB41gLNIB7K5p7ENpOMlQV9MCNK+Yxf2LH/ZiqMNHQdWyIeR
         PzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696289091; x=1696893891;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bRL3/7Khkbg2e6woqRlv5wpaZ7o8kFg/B18p22kS+Kc=;
        b=vfHQ5dm1M0NUZSVsgHpz8/q83Qwj7KgM1jhn0advl3kQRLaV6tAf5QL3Tf0cbNuOTQ
         zvOZVhEGxVDJW5IHXdLL5kJ4ke6EMUobkokGrAax9xZkMeq0auMJ16e9HeR2Ioy18H9x
         h6PxhHr86ey6y0z2Ul8o6ZWGvdq1218wbNyLVeA4XQHIvMJK4d/dr4PyxjLq01yFEewZ
         gbW1rJI/hGhDRbw+2s899YPADauMRCUrze6OOQfjJ2FMfI9K4iukBqqhouGiZpaheMZ+
         ofm4p8I1Z96ATpaEyk1USsOzQ11NIHiIKG2TWSWXd0hmk5J7vXbRRB9QDtGDk2ywvdri
         s1Jw==
X-Gm-Message-State: AOJu0YxjMXCqf5TPL/LgsAI9IqrGSUstVCAgZKFgg7rIIb0ZDNfQDaLd
	HHDVtekE6yUaS9eB3az9XIQ=
X-Google-Smtp-Source: AGHT+IGiRKnM19FETZdHmytSO7pAOV0MKx3juucoMJ4Hq570a6/MVewnuwoLdQCjx3N4PrrivmwRsA==
X-Received: by 2002:a05:6a20:7d8c:b0:15d:4cf1:212e with SMTP id v12-20020a056a207d8c00b0015d4cf1212emr1678170pzj.4.1696289090943;
        Mon, 02 Oct 2023 16:24:50 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id p22-20020a637416000000b0056c2de1f32esm4140pgc.78.2023.10.02.16.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 16:24:50 -0700 (PDT)
Message-ID: <1331726d-2cd4-03a1-6a15-ec145b197da5@gmail.com>
Date: Mon, 2 Oct 2023 16:24:48 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next] net: dsa: mt753x: remove
 mt753x_phylink_pcs_link_up()
Content-Language: en-US
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ar__n__ __NAL <arinc.unal@arinc9.com>,
 Daniel Golle <daniel@makrotopia.org>, Landen Chao
 <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <E1qlTQS-008BWe-Va@rmk-PC.armlinux.org.uk>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <E1qlTQS-008BWe-Va@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/27/23 05:13, Russell King (Oracle) wrote:
> Remove the mt753x_phylink_pcs_link_up() function for two reasons:
> 
> 1) priv->pcs[i].pcs.neg_mode is set true, meaning it doesn't take a
>     MLO_AN_FIXED anymore, but one of PHYLINK_PCS_NEG_*. However, this
>     is inconsequential due to...
> 2) priv->pcs[port].pcs.ops is always initialised to point at
>     mt7530_pcs_ops, which does not have a pcs_link_up() member.
> 
> So, let's remove mt753x_phylink_pcs_link_up() entirely.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


