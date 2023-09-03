Return-Path: <netdev+bounces-31846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF19790D2D
	for <lists+netdev@lfdr.de>; Sun,  3 Sep 2023 19:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B4B1C203A3
	for <lists+netdev@lfdr.de>; Sun,  3 Sep 2023 17:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F1B3D9C;
	Sun,  3 Sep 2023 17:12:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00477256A
	for <netdev@vger.kernel.org>; Sun,  3 Sep 2023 17:12:49 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4053A1709;
	Sun,  3 Sep 2023 10:12:22 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bd6611873aso9474041fa.1;
        Sun, 03 Sep 2023 10:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693761078; x=1694365878; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xBzijayOiB502VuG+2bLFsv5gx69/lnYAE9VN6aef0=;
        b=MrS6xW7WHhsetKKdDkvNX5ApOm6cwq3cxUTjL+wrPKMI1FuVBCYJ4qzT+GdMSyFpgO
         S/7nuN1W3MEI93GLepv5TMpSDZdXoJsXZyHro7Z4ygDNP1mpyxF/wmt/K4usFCe5gFCU
         vCrCp7KjQbUvkChCI1HkyHZPrwe6B4lzQYIY4gNEHaQRGF4FWCApqHCo0mkMP7GZuODs
         OFJbhgRwRICyFYe/mb4sEXKbYKUcjVfBws70WOUqhpFylxnieJWLSKIcK7RXKA7/iE2Y
         gvWrhFS28KUXzcphBVNGiTTBK2L+enJu6z3NJO/lBIB8CeDlvV+Fne1x+frgpvf6zRVM
         eccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693761078; x=1694365878;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7xBzijayOiB502VuG+2bLFsv5gx69/lnYAE9VN6aef0=;
        b=Z5zto9hpV1D024ixtf0BKWOJmGp0HoxoHfZvZdUMQwQ5LSfz75Vf0yIub8EJtXg8WR
         62kgsDLbaJkd7eTcz7ku8XpvZ6xZluuO3KoPfaXlyjwXSx30pxKiu7NOcN1o/AlSXqFS
         NDji20DJwgio2ba8yok34aXBIs6SUBA7mdt8YgabaIAG6nrP5u3gdv/Uh8RmIwa2CcTK
         w5KP9UJs5PnrjKcCpcqqgCsTnQyo7CjJqBZlGHK3fXO+/Nf4pDSEUwYzEBPPvPLfAnP1
         iFiDefpMHhq19dty9a9YA0DgWYmpxWAWldsgFSxUshvlAYMcPYWJqCJ3I+tsxJ4B5pay
         zJTw==
X-Gm-Message-State: AOJu0Yz7XyWx4qczkbuEE81FvaXn8gMgb1w9JsCyEvqQfuZUmLpx4EJO
	bEhfefpEo1Jr7e4wn3FtNyM=
X-Google-Smtp-Source: AGHT+IGU1tdhgtXKEc74IFAODz1w1kj3pNblJ1fbVMtYp7kZyNR8YCS4oEy4WDhoJH3v3b51aHXYPQ==
X-Received: by 2002:a2e:8e93:0:b0:2b9:eeaa:1074 with SMTP id z19-20020a2e8e93000000b002b9eeaa1074mr5885056ljk.35.1693761077500;
        Sun, 03 Sep 2023 10:11:17 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.78.188])
        by smtp.gmail.com with ESMTPSA id o14-20020a2e9b4e000000b002b6d68b520esm1572518ljj.65.2023.09.03.10.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 10:11:16 -0700 (PDT)
Subject: Re: [PATCH net] net: ravb: Fix possible UAF bug in ravb_remove
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
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <e9c182ea-d992-4872-9bc5-1b03846e80bf@gmail.com>
Date: Sun, 3 Sep 2023 20:11:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZPNH7bdwe4Zir6EQ@eldamar.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello!

On 9/2/23 5:34 PM, Salvatore Bonaccorso wrote:
[...]
>>>> In ravb_probe, priv->work was bound with ravb_tx_timeout_work.
>>>> If timeout occurs, it will start the work. And if we call
>>>> ravb_remove without finishing the work, ther may be a use
>>>
>>> ther -> there
>>>
>>
>> Sorry about the typo, will correct it in the next version.
>>
>>>> after free bug on ndev.

   BTW, is UAF a common abbreviation? I for one didn't know it...

>>>>
>>>> Fix it by finishing the job before cleanup in ravb_remove.
>>>>
>>>> Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
>>>> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
>>>> ---
>>>>  drivers/net/ethernet/renesas/ravb_main.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>>>> index 0f54849a3823..07a08e72f440 100644
>>>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>>>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>>>> @@ -2892,6 +2892,7 @@ static int ravb_remove(struct platform_device *pdev)
>>>>       struct ravb_private *priv = netdev_priv(ndev);
>>>>       const struct ravb_hw_info *info = priv->info;
>>>>
>>>> +     cancel_work_sync(&priv->work);
>>>
>>> As your previous patch, I still do not see anything stopping
>>> dev_watchdog() from calling dev->netdev_ops->ndo_tx_timeout
>>> after cancel_work_sync(), maybe I missed something obvious
>>> here?
>>>
>> Yes, that's a keyed suggestion. I was hurry to report the issue today
>> so wrote with many mistakes.
>> Thanks agagin for the advice. I will review other patch carefully.
>>
>> Best regards,
>> Zheng
> 
> Looking through some older reports and proposed patches, has this even
> been accepted later?

   No, the latest patch was v4 and it still didn't seem acceptable; I for one
don't agree that Zheng does his things in ravb_remove(), not ravb_close().

> Or did it felt trough the cracks?

   No, there are just too long delays between versions... and the patch still
doesn't seem correct enough... :-/

> Regards,
> Salvatore

MBR, Sergey

