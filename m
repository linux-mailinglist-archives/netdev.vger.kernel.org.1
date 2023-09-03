Return-Path: <netdev+bounces-31847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8449790D2F
	for <lists+netdev@lfdr.de>; Sun,  3 Sep 2023 19:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80CEA1C203B2
	for <lists+netdev@lfdr.de>; Sun,  3 Sep 2023 17:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D343FE6;
	Sun,  3 Sep 2023 17:14:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7959D23AA
	for <netdev@vger.kernel.org>; Sun,  3 Sep 2023 17:14:30 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7583918C;
	Sun,  3 Sep 2023 10:14:02 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-500aed06ffcso1138777e87.0;
        Sun, 03 Sep 2023 10:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693761240; x=1694366040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3THjcGL5hRvsuJ11sDDHbC2saUxG2YuXWXrRVQzw/Dc=;
        b=JsXin7ssAGHDqCbB89Xy6WugOGlLurpwjlhVyCWoTW6gM9+mXKtXRhmgub4eRYz04+
         0Tf2crIqsJgfH5jQQS7/w4P+PN7f/ScjOfAvZbIFy9aCyghbB9rEjn8ppy6rf6Zm7ZhF
         eiBiylyXzXcG0g2a6tHRT1F/NILxMhhj0IwOSVz1SSV9fBnJVE+jAqQWulgs0HHKiqSY
         1oclecOQ1TdPokCXHlqHhWKRMVJaH+lMAtEPrDanWBn0XS5Y6VYUQ6MA0RX0p7vrVo+Y
         bMPZYQVMVLYExyJoCU+EzEaP6pNHyqcCE5vDU1IVrRzzvRneI0Enc2y9kI6JCM2/fKae
         GapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693761240; x=1694366040;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3THjcGL5hRvsuJ11sDDHbC2saUxG2YuXWXrRVQzw/Dc=;
        b=EnHImfgM/5efVuqeS7R+QAEtt7bBdd82aNwtU5g0lzQyHMft4HPKo5fE9oGOf3qOyT
         gGnkjOp1b70e1oIJngOU6hJidL+faY2fxuXXhAC8Z9KuenXxt2PX/YstzywerWMZ24Mu
         5gtjERxiU9irXAtXOx1Oz2b13/48hbq5JJUrpQuWojDgcQA1CYVqZr4QNqE+Wf9cpXhF
         PY/LyETjyzDSNnZV1A915OvXnDbB/xrcKhmv0mhSP/+0ETiwKJGnuI7MGR/h2BpZx/Tk
         e3JOrX4GNKhlYstePPlsAU710XTFU54v0WHtHP+Y7UqFSl6QUvnFZH34ER+PIdjwBimU
         1jNQ==
X-Gm-Message-State: AOJu0YwgfmfEKBpBUeQXQZF7KePo/tFR92kWV7CMJg6+nfp6M5iL5lk3
	dM1ryLxrhZdOXZtkCBDlvbI=
X-Google-Smtp-Source: AGHT+IG7WwHW2aLJI6OwCHzQv02MmzgsReiH3BxUEYYN6Sxqbm/aE2RP69zQm84O6SMA99Jpb/jurQ==
X-Received: by 2002:a05:6512:114d:b0:500:7e70:ddf7 with SMTP id m13-20020a056512114d00b005007e70ddf7mr6637224lfg.52.1693761239920;
        Sun, 03 Sep 2023 10:13:59 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.78.188])
        by smtp.gmail.com with ESMTPSA id n6-20020a195506000000b004fe36e673b8sm1338430lfe.178.2023.09.03.10.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 10:13:59 -0700 (PDT)
Subject: Re: [PATCH net] net: ravb: Fix possible UAF bug in ravb_remove
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
To: Salvatore Bonaccorso <carnil@debian.org>,
 Zheng Hacker <hackerzheng666@gmail.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, Zheng Wang <zyytlz.wz@163.com>,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 1395428693sheep@gmail.com, alex000young@gmail.com
References: <20230309100248.3831498-1-zyytlz.wz@163.com>
 <cca0b40b-d6f8-54c7-1e46-83cb62d0a2f1@huawei.com>
 <CAJedcCy2n9jHm+uS5RG1T7u8aK8RazrzrC-sQhxFQ_v_ZphjWA@mail.gmail.com>
 <ZPNH7bdwe4Zir6EQ@eldamar.lan>
 <e9c182ea-d992-4872-9bc5-1b03846e80bf@gmail.com>
Message-ID: <6a205c01-4870-cb52-c273-8e3708494412@gmail.com>
Date: Sun, 3 Sep 2023 20:13:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e9c182ea-d992-4872-9bc5-1b03846e80bf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sorry, had to reply from my Gmail account as the work server rejected
the msg for unknown reason... :-/

MBR, Sergey

