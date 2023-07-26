Return-Path: <netdev+bounces-21521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46190763C9D
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528AF1C2141E
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC4D1AA63;
	Wed, 26 Jul 2023 16:37:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242C2A42
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 16:37:58 +0000 (UTC)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FDE94
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 09:37:57 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-766b22593faso484139385a.2
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 09:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690389477; x=1690994277;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RgsePXBKbSDp1kSCObKDaf6K6E6g2Ti2BShLV11QRxE=;
        b=giOQVG1gkrSZpLRzbkX05cERPMccjp/jczQqVntPJwSBYXPvd7u+akkWUtOREK0BH4
         cXiEbZtaN7AS167VFa7Fiyd1Cya19UR5BEQ54Xx5jrvR1f4IdZKgDjPJxcAmPSe5vgb0
         EHDiTlC/xQlrt78LgjrtaCrdSes7lm/8gpngJfQyt6rTNhtih7I2RbhXBQDtm0N7IBpP
         zDdMCF2bKXpQXxjrirFjMho/YTtmVJv9bZHplbVnRkfQyySb3INk72qY4JS7yYLRRaJg
         rdb6PuGDXK0N7s3UU1COMCLiqfflpTI8LUfQm4zYwk7irxHnupp3i+1pFLEFAkaI5OeK
         +FYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690389477; x=1690994277;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RgsePXBKbSDp1kSCObKDaf6K6E6g2Ti2BShLV11QRxE=;
        b=Gkxm4/9aGQFo+F7CyyE0qfJcJ7yZvTwvYx0c9HSDlxSGBOOCqZO74CRPsayS7a5syh
         zRodG+6ayd43l9rGszS7RMhPbTePddeUpmC67bl4GeTcLA+vQt6qLShn0Q1WQbQbZ8rr
         j+vQ3JTjV0+z/hmoelLSObtBm5kiYhE/bsGuI1/HfPk7gWiiE1nNVYnKzfsCZuwe6IrD
         VblPuxEi+9bJ0+jEWJV2QxwrbJE77hphBrWBtrobGc6aPJMGB7bJ3tW0ZlHqjukNLYmi
         wBE4wyB3sKxRveB7QdqVjZQJBhXCKn3uMdkHdgl7DP5ebPaL5AtQ29j+856dE+iX0A68
         Aikg==
X-Gm-Message-State: ABy/qLaDCQg0ZwZqVudCUgvdhusweIOJU+bmxLug2RvM6/5tII6paP9+
	h3JMn3OFrX+jj4Uxw/J86DA=
X-Google-Smtp-Source: APBJJlFlwqHSii7XFcBDXZ6ikEcu1Gtjecjl9jb4A+xtRWEw6BQ2XfKFQj+0Np4z8FpgawrZ0fbzow==
X-Received: by 2002:a0c:dd94:0:b0:63d:2902:638c with SMTP id v20-20020a0cdd94000000b0063d2902638cmr2104975qvk.24.1690389476781;
        Wed, 26 Jul 2023 09:37:56 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id z15-20020a0cf00f000000b0063d20b391dcsm1073627qvk.46.2023.07.26.09.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 09:37:56 -0700 (PDT)
Message-ID: <f20c3029-65bb-5390-6eec-664d802acf64@gmail.com>
Date: Wed, 26 Jul 2023 09:37:53 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net] net: dsa: fix older DSA drivers using phylink
Content-Language: en-US
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <E1qOflM-001AEz-D3@rmk-PC.armlinux.org.uk>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <E1qOflM-001AEz-D3@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/26/23 07:45, Russell King (Oracle) wrote:
> Older DSA drivers that do not provide an dsa_ops adjust_link method end
> up using phylink. Unfortunately, a recent phylink change that requires
> its supported_interfaces bitmap to be filled breaks these drivers
> because the bitmap remains empty.
> 
> Rather than fixing each driver individually, fix it in the core code so
> we have a sensible set of defaults.
> 
> Reported-by: Sergei Antonov <saproj@gmail.com>
> Fixes: de5c9bf40c45 ("net: phylink: require supported_interfaces to be filled")
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


