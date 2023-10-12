Return-Path: <netdev+bounces-40560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646307C7AAE
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 01:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876FC1C20B41
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 23:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21552C843;
	Thu, 12 Oct 2023 23:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Es9zu6N1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7533F2C842
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 23:57:42 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990D8C0;
	Thu, 12 Oct 2023 16:57:40 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-692a885f129so1266100b3a.0;
        Thu, 12 Oct 2023 16:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697155060; x=1697759860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IMk7ef3z6b35hTlTRh2H+b/l6njrMDplSZDZc4/1mAU=;
        b=Es9zu6N1QSqtN0wWh6wcdjSs6t5r607Dpekx+F9OOHCU+KEPbDlPl05S2R7eH44GBJ
         FluZwcsDmGjBEVJsNV0uNOC4RWC1XBjUK44ibPRqC4ZAyypx5UPZo10aGy9VTYO0l+jU
         GF4ZKKva51YGoLSUsCAm2E0xIVgDuque+PZz1OScRqCXvrrnlkoqSZY1UocoLZfLy/cU
         aQQX4zjQEPz42lJhHTGbbpacpakkAVvrTXfs972mt6MNbLqbtcjjajqy2tvhu7VmRttu
         NiQTt9vZ4nZMtumB+lGjh7Ng9EXdD9+X5Z5dlqz0gvsJhDKb10T2HIV63k0ueQclXo6f
         hY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697155060; x=1697759860;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IMk7ef3z6b35hTlTRh2H+b/l6njrMDplSZDZc4/1mAU=;
        b=GfjEl/NTOg564u17I4ZEMHzmWbo5RPlx6LRbTNFup/vpH1o5kN0fwe9XP7nuTqEbP8
         AjdvgAgZUAMxkBPQ0OrWhr452Py++k6EHWa8EvkvKEDiJoe+erY5Invv7CvQ3i98qfI0
         EbsxUOxZjklYhpuvuh+qmV93FgR5v3kRNjeVDcgYv/QZlQ4FmWEvRneiPpFs2ZN2hEXl
         XyICH7roUT6Fx/q22IXPJdQm/F1wEg5lccWE+syfJkzhl8c/E9zjXtnLULRfzdVmco04
         +gOsEOVsGti5AzmJlDd06ji8KO3tk+0loeDBZ8gFf2yhBnIWlNgPqAH4wJcMtcTGRT3L
         HpTA==
X-Gm-Message-State: AOJu0Yy76fl8WdcrieiadlqILyi/ToqS2/7sbsPedxR54/omi8FpFPEh
	AxrVrsUNIv+/+tBxyNbJfZGA8YZm93o=
X-Google-Smtp-Source: AGHT+IGXYpN9ClsEETOLPh4A+17Ca/iEmHa91MMqRHzbAa627nCzyd9VHmCdfnui/FFLZ8NActc9kg==
X-Received: by 2002:a05:6a21:1f16:b0:152:1ce8:ce3a with SMTP id ry22-20020a056a211f1600b001521ce8ce3amr20185803pzb.18.1697155059665;
        Thu, 12 Oct 2023 16:57:39 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902edc200b001b7f40a8959sm2553077plk.76.2023.10.12.16.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 16:57:38 -0700 (PDT)
Message-ID: <d1354343-8fe0-4338-8d71-b8a90c960017@gmail.com>
Date: Fri, 13 Oct 2023 06:57:33 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Intel 7560 LTE Modem stops working after resuming from
 standby
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux Networking <netdev@vger.kernel.org>,
 Linux Intel Wireless WAN <linuxwwan@intel.com>
Cc: M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Loic Poulain <loic.poulain@linaro.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>
References: <267abf02-4b60-4a2e-92cd-709e3da6f7d3@gmail.com>
Content-Language: en-US
In-Reply-To: <267abf02-4b60-4a2e-92cd-709e3da6f7d3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 12/10/2023 16:52, Bagas Sanjaya wrote:
> Hi,
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
>> I noticed a few days ago, after Fedora moved to Kernel 6.5, that my Intel LTE Modem was not working anymore after resuming from standby. 
>>
>> The journal listed this error message multiple times:
>> kernel: iosm 0000:01:00.0: msg timeout
>>
>> It took me a while to determine the root cause of the problem, since the modem did not work either in the following warm reboots. 
>> Only a shutdown revived the modem.
>>
>> I did a bisection of the error and I was able to find the culprit:
>>
>> [e4f5073d53be6cec0c654fac98372047efb66947] net: wwan: iosm: enable runtime pm support for 7560
> 
> See Bugzilla for the full thread.
> 
> Anyway, I'm adding this regression to regzbot:
> 
> #regzbot introduced: e4f5073d53be6c https://bugzilla.kernel.org/show_bug.cgi?id=217996
> #regzbot title: pm support for Intel 7560 makes the modem stops working after resume
> 

FYI, the reporter had uploaded full dmesg output on Bugzilla.
Also, he noted shutdown abnormality:

> also I should mention, that if this error occurs, I am unable to shutdown my system anymore. "poweroff" does not turn the laptop off, it simply triggers a reboot, where the modem is still not functional. Only pressing the powerbutton >4 secs "resets" the device.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara


