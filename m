Return-Path: <netdev+bounces-38570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9FC7BB756
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 14:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F4E1C209CE
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 12:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D29F1CF99;
	Fri,  6 Oct 2023 12:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYkSxcpA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3556D2F58
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 12:08:25 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558FEC6;
	Fri,  6 Oct 2023 05:08:22 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-690bf8fdd1aso1711773b3a.2;
        Fri, 06 Oct 2023 05:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696594102; x=1697198902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GhjdRY56jgRSIuP3aQcgGNFAel5n/yEYrUWn7j91LdY=;
        b=WYkSxcpAk9FDQWiioBf0f67b9ZC+7xwm6ZDKOuKsJpNaAFHYhYRq2uylBNlJsOLjEC
         U2sQWD3Hn+BOxrRD0PAcDcw1hcCrjjlnT8b6YYafjsPPF16oYDBR+ZOmoTzfenUJUZ7J
         YoFtk3cQ7/oUtE2bPv1+gGLAkcOJM/RR+Gn9Qio4wRGGi+SOoEwF8aZoSBWdTdC4dAyP
         ysGqWFCksaQLlUAqWBSI32/RhHu9GyylYR1imnFsriIX1rBIYZaRNR+Dz10+dke1OeM8
         wXwSvOENpQA5lHvVxwxMU793JBUsybA8zAXThk5DL0yw4pE2Wu9bEkFyWzqbI1eZa0jS
         eO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696594102; x=1697198902;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GhjdRY56jgRSIuP3aQcgGNFAel5n/yEYrUWn7j91LdY=;
        b=hB1rklmTEdmXAdiVBT7XLWmxf3tQqMeVF30+xWL+b1w4NQ7YQJinzaz3QIV4LFAvkg
         6MQyzm/19qShKSayfQXFb5CR7mTrLA5ZgntaDpngrknStxn2ZEOIbBhNjomADUOIPaWo
         ZG8iah61c1f9JE4tRg//ccNb+XKsEUCHgNu/Z0jNL41SffHrQyntbqzdahE4G/rtxkYl
         VeuEEzC3UWfjte+X5gL0FxPq1tpYpFx5nZkLZCXakIYYjlcrwI9UyLYdTn3T/4YOXvOV
         JhrMo6LF/uf9g9uE7nDzNjKJTmxfOXRxoVCbuLdisGlu8eyOafTuCWSU+JoZCQzcHsNp
         rBgg==
X-Gm-Message-State: AOJu0YxAjThkHfm1/0nEEEvCxq8lfJJ7k7L+Pjv5ysxEfz0UPko4XiUf
	U4scpr9SzC/ENKX6IXaHBrI=
X-Google-Smtp-Source: AGHT+IESL25NgxvA5K5j4FVoyq4yZiaAddmZox6puWn7+EyDgVvjaE4G2SaBXrdeVSWytJc5ZdbOEA==
X-Received: by 2002:a05:6a00:1355:b0:690:25fb:bac1 with SMTP id k21-20020a056a00135500b0069025fbbac1mr9101792pfu.18.1696594101635;
        Fri, 06 Oct 2023 05:08:21 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id y5-20020aa78545000000b0068e12e6954csm1307513pfn.36.2023.10.06.05.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 05:08:21 -0700 (PDT)
Message-ID: <982dc76d-0832-4c8a-a486-5e6a2f5fb49a@gmail.com>
Date: Fri, 6 Oct 2023 19:07:34 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Userland interface breaks due to hard HFSC_FSC
 requirement
To: Christian Theune <ct@flyingcircus.io>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
References: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
 <207a8e5d-5f2a-4b33-9fc1-86811ad9f48a@leemhuis.info>
 <879EA0B7-F334-4A17-92D5-166F627BEE6F@flyingcircus.io>
 <740b0d7e-c789-47b5-b419-377014a99f22@leemhuis.info>
 <BBEA77E4-D376-45CE-9A93-415F2E0703D7@flyingcircus.io>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <BBEA77E4-D376-45CE-9A93-415F2E0703D7@flyingcircus.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 06/10/2023 17:51, Christian Theune wrote:
> Hi,
> 
> sorry, no I didn’t. I don’t have a testbed available right now to try this out quickly.
> 

Please don't top-post; reply inline with appropriate context instead.

You need to have testing system, unfortunately. It should mimic your
production setup as much as possible. Your organization may have one
already, but if not, you have to arrange for it.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara


