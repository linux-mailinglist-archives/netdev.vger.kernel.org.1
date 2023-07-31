Return-Path: <netdev+bounces-22984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDFF76A494
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 01:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98CF228007D
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 23:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B782B1EA64;
	Mon, 31 Jul 2023 23:11:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6691DDC1
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 23:11:57 +0000 (UTC)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E80A1A5;
	Mon, 31 Jul 2023 16:11:55 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-403a3df88a8so34001301cf.3;
        Mon, 31 Jul 2023 16:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690845114; x=1691449914;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tcfb3NZoLPAg2c5xUl4SvOV2x4oKNn83D39hBvygums=;
        b=oUjSX/pRfYdhxk2uCRnbc7IFrwPZ2E6Sa+RtxLAgpfglNHdx/ya0NHUjrQbq4m2FtE
         i7jhELdMGb4fjLlrvCLvd1PUTAC3pspQBa4XK+fkVMCELxW1OcaVco+uMc1spB5KNwNU
         SC5MvphyaWMSRLnZHUbBwYdXJqMezyfDIah+67mSeZbXXOHhIFevYMTG+w+dLdLXFgKM
         /8GAKJ79am35rf2RU1yUcMuCwO83jqNoNy5CM1zXiEykynff8ZV0nj/SsdXO6YfdDeYT
         C+T2AobpwuqJ361aYp/EeKfhdK1OjmWwKfdkHQ0/qCNs4mjow9PRHedUGnoOsU4JimD0
         kAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690845114; x=1691449914;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tcfb3NZoLPAg2c5xUl4SvOV2x4oKNn83D39hBvygums=;
        b=DaUouv8oF19oJ770RKRB5YHygV6o5OSNVsrGZy8DgcKXb4Hq3xxvbirK0+0VhusUV9
         nvioronYr2/uT6rP8q7u3odVfLKumvzsZEi/VK0Xbzdxyt7eaer7WJD1wfOxB4Mp/FR0
         IDgsypbSPMD1lftQJi1T6opS9R75v8eoL04xJXb3DQhzEkhJs8ZrUK0/UuTsTqVrwYfb
         s7ext/W8T+BPUYtHOKAayjYZSwGEAJy5b/HOY9jYBVS0ZQ7kUZPDzlGwQyos+qUVvXEG
         BzpjjipYQInbjcTDWnbWzyQgT33eyxgXHw5+8EBO8sCexn1ypjN1B0mRM3atCJkPrJKR
         vx8g==
X-Gm-Message-State: ABy/qLbSTMxyk0IOXCcQBVCOxGFgrZbsyFrpJHaOy8+biqHvO8rNBwOz
	CPNKVF3HmrYJgBjB4oK5DzE=
X-Google-Smtp-Source: APBJJlFM6m3NzlN2UxJKS6TKKewsBIGoNi1wHioere+07SnEymh6sR/R50gwVuVkrLUhLXvaqixDCA==
X-Received: by 2002:a05:622a:1a15:b0:405:516b:4e0e with SMTP id f21-20020a05622a1a1500b00405516b4e0emr14304491qtb.6.1690845114349;
        Mon, 31 Jul 2023 16:11:54 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id j10-20020ac8550a000000b003eabcc29132sm3898307qtq.29.2023.07.31.16.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 16:11:53 -0700 (PDT)
Message-ID: <1793e069-114e-1cbf-e5b8-dbe5e03b8095@gmail.com>
Date: Mon, 31 Jul 2023 16:11:51 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [net-next PATCH v3 5/5] net: dsa: qca8k: use dsa_for_each macro
 instead of for loop
Content-Language: en-US
To: Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yang Yingliang <yangyingliang@huawei.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Atin Bainada <hi@atinb.me>, Michal Kubiak <michal.kubiak@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230730074113.21889-1-ansuelsmth@gmail.com>
 <20230730074113.21889-5-ansuelsmth@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230730074113.21889-5-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/30/23 00:41, Christian Marangi wrote:
> Convert for loop to dsa_for_each macro to save some redundant write on
> unconnected/unused port and tidy things up.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


