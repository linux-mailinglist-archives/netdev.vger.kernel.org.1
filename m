Return-Path: <netdev+bounces-30748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D77F788D7A
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 18:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66CC31C20ED7
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 16:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C5F18003;
	Fri, 25 Aug 2023 16:56:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127FE101CA
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 16:56:00 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4058E67
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 09:55:59 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52a1ce529fdso1736501a12.1
        for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 09:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692982558; x=1693587358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CplWnnbQy7/LKKL7kZ4OrsUrPVf1W9czpfw1103nd2c=;
        b=Vwv9gIBIHwJGnZyOh07NQLq7oLPtPoeZz2lHsicpaAbSz3BPI5rFiqXw7GBOV/+lBQ
         Y9/rOOjzJv381yCboflqaGQEVOZgAIJ5GMNic7CI0oS4YWwLwydLZCfkC01ZCRJTsL8L
         P/mlCIQ6//6ojE6apoxNsnNt7rzNWYjCbYZHL35UNiUkXTv6gakf4kUL5Myu2BgpQO4K
         72s7T7QiFo+n7C8fFnI98tSrCuLY/hOG+SiRO0p9WTvOccQVefvzyH9Pvq3Xc6HBW+Ma
         Jj04wVHuuQuryQ5bns2uLAoh5SopRYEW55cSiYnxgmz9iF+ktLG3rcG7fj565hzNdN/A
         4BTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692982558; x=1693587358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CplWnnbQy7/LKKL7kZ4OrsUrPVf1W9czpfw1103nd2c=;
        b=NLl3I6bVCDB1offWt/ijMm09ojZvFdh68ABRYzvXOR+lBmBGlHqGmcITbGWCqpliiY
         CmNgvcC80lBmtPzQkSro20cHGD8MfHbt0SDYJWWkUZyOVg8Ac7T4cJx2MsI2PRW/TR9f
         fGWw4/wd4hkKXpU0YfXS71V5VoN+B8sG8UW6txD4/2EQ4umMjRXyfF0wO7KUGqQKys4y
         9Qg8gEYqR6hKMpnML8ARgojdREpldYEB12f49ORXou+wOnSlV6OkBph8GUtas7ADoZmX
         ie1KUn4iOr6Eu+7sX5CngVSbQN933OBnoZTcpc0wcWSNm67HM7qIUUHDlQmNmiw85EEa
         8BGw==
X-Gm-Message-State: AOJu0YwUwriSRaiNvxggolT+PS294HbCfzZI0sVbqTUMGjEkGgn/CSkM
	r4gxch5brwtd0fpG0x574FD5/AO6rQY=
X-Google-Smtp-Source: AGHT+IGAs6O0XAPu8b+2AqmCN5bB2u3aDOOpT6H+p+CO9Q1EpbXIg53GJaUGOwCBXgc8Z1R6DTUQ4Q==
X-Received: by 2002:a17:906:1dd:b0:9a0:9558:82a3 with SMTP id 29-20020a17090601dd00b009a0955882a3mr16561493ejj.58.1692982557709;
        Fri, 25 Aug 2023 09:55:57 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7278:9e00:3d6c:1d4d:484c:d423? (dynamic-2a01-0c22-7278-9e00-3d6c-1d4d-484c-d423.c22.pool.telefonica.de. [2a01:c22:7278:9e00:3d6c:1d4d:484c:d423])
        by smtp.googlemail.com with ESMTPSA id lx16-20020a170906af1000b0099bcd1fa5b0sm1131286ejb.192.2023.08.25.09.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 09:55:57 -0700 (PDT)
Message-ID: <97ec2232-3257-316c-c3e7-a08192ce16a6@gmail.com>
Date: Fri, 25 Aug 2023 18:55:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: r8169 link up but no traffic, and watchdog error
To: =?UTF-8?Q?Martin_Kj=c3=a6r_J=c3=b8rgensen?= <me@lagy.org>
Cc: nic_swsd@realtek.com, Jakub Kicinski <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <87zg30a0h9.fsf@lagy.org> <20230809125805.2e3f86ac@kernel.org>
 <87fs489agk.fsf@lagy.org> <ad71f412-e317-d8d0-5e9d-274fe0e01374@gmail.com>
 <87edjsx03e.fsf@lagy.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <87edjsx03e.fsf@lagy.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 24.08.2023 11:22, Martin Kjær Jørgensen wrote:
> 
> On Thu, Aug 24 2023, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> 
>> On 18.08.2023 13:49, Martin Kjær Jørgensen wrote:
>>>
>>> On Wed, Aug 09 2023, Jakub Kicinski <kuba@kernel.org> wrote:
>>>
>>>>
>>>> There were some fix in r8169 for power management changes recently.
>>>> Could you try the latest stable kernel? 6.4.9 ?
>>>>
>>>
>>> I have just upgraded to latest Debian testing kernel (6.4.0-3-amd64 #1 SMP
>>> PREEMPT_DYNAMIC Debian 6.4.11-1) but it doesn't seem to make much
>>> difference. I can trigger the same issue again, and get similar kernel error
>>> as before:
>>>
>> From the line above it's not clear which kernel version is used. Best test with a
>> self-compiled mainline kernel.
>>
>> Please test also with the different ASPM L1 states disabled, you can use the sysfs
>> attributes under /sys/class/net/enp3s0/device/link/ for this.
> 
> My BIOS doesn't seem to allow ASPM even though the BIOS option is set to
> "Auto" insteadof "Disabled".
> 
Good to know, in this the NIC doesn't trigger transitions to ASPM states.
Having said that your issue doesn't seem to be ASPM-related.

> ~ $ dmesg | grep -i aspm
> [    0.118432] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> [    0.199782] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [    0.201735] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
> [    0.750649] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
> [    0.771525] r8169 0000:04:00.0: can't disable ASPM; OS doesn't have ASPM control
> [    0.791797] r8169 0000:08:00.0: can't disable ASPM; OS doesn't have ASPM control
> [    0.807683] r8169 0000:09:00.0: can't disable ASPM; OS doesn't have ASPM control
> 
> I cannot see any ASPM files in /sys/class/net/enp*s*/device .
> 
> -r--r--r-- 1 root root 4096 aug 24 10:31 iflink
> -r--r--r-- 1 root root 4096 aug 24 10:32 link_mode
> -rw-r--r-- 1 root root 4096 aug 24 10:32 mtu
> -r--r--r-- 1 root root 4096 aug 24 10:31 name_assign_type
> 
>>
>> Best bisect between last known good kernel and latest 6.4 version.
>>


