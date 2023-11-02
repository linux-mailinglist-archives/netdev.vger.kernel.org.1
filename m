Return-Path: <netdev+bounces-45738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ABF7DF4B4
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 15:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1172B2105F
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 14:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4F01B280;
	Thu,  2 Nov 2023 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmQ/FvDb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC29F18E23
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 14:15:02 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0849E128
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 07:14:58 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50931355d48so1207002e87.3
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 07:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698934496; x=1699539296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y7ZDPYaEXidRnVjS2Ex4y3Rshx/fWtd37iAYju4s7Go=;
        b=XmQ/FvDbcs5lUV6oeTcp6X5bF9VlzXeqm1fIOcBoq3WWjF3VxjcanvpDAHu32snmnY
         4Im3LtW4mLYyRUqibjZmj0ZZ/9d4muAvMILZwiJW7II0Ol+HVD01xQyIeHBbUNumQVu3
         wV1DZqrYmIpMvDZfnAseEXTGilrQSZuiX36vrMFLFXvfLW76JJ3HFiikKy0NRv8qhM4d
         nkpZbxkut4LG24+mhPnMsYLFUNh/HHbTmqNPl4Uy67EO7oB9exe8hy0sFMqluLYBG/HR
         HAu+cCuhUeemWwP5JtJ+naArdQaxNulNyOIud2ZF7gu3ZGHGEQ08Xytd021utTESs3jU
         T5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698934496; x=1699539296;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7ZDPYaEXidRnVjS2Ex4y3Rshx/fWtd37iAYju4s7Go=;
        b=EXlyolvbfYYWDUeoTcBfDssGQvzgAsfqNPXRf0JSx1/sNQlP+wXxDnUdafrRbMeH6u
         lxyxGo+M1kmwOgY92QwWOh6tjJr1yuKPTN5x51M72rR8tsGKJPVZ8bVdDnrDjyML4I5m
         Zg2kTnFTf2CQ9Cd8dO63VBt8XqUXbwWcOyNhTtczYtbLAYnFTNBdFMWrn586rUb753SP
         S1cFd9FT0SuvZ5W3PUNLKvJvfuIUtNzGW9wfR5uvV3MQRlWJQLsAG9bJUm04b74qbPWY
         k/CHJ/xq2M2x9LB2iqNRxJYOqCWE6XT2RQg/JzXKFaRJigBrzNnHnuwwoCjDC6ElcPlq
         vogA==
X-Gm-Message-State: AOJu0YyLUOyjvJ2qHklgjUcyUAuSLS+YSVJExOdhINg2CeIDLzi5wHUv
	orfGDr6aU0cTQafZqPocX28=
X-Google-Smtp-Source: AGHT+IGSf/xYiAlURsvECGiCwA1UX8F3SdpBtRxFQ77OboS+6FLzxa8WG/bBZVZFs+2+qUNuTzhLNA==
X-Received: by 2002:a05:6512:491:b0:507:b0a1:6088 with SMTP id v17-20020a056512049100b00507b0a16088mr14603373lfq.46.1698934495955;
        Thu, 02 Nov 2023 07:14:55 -0700 (PDT)
Received: from [192.168.7.165] (buscust41-118.static.cytanet.com.cy. [212.31.107.118])
        by smtp.googlemail.com with ESMTPSA id e5-20020a05600c4e4500b0040772934b12sm3262761wmq.7.2023.11.02.07.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 07:14:55 -0700 (PDT)
Message-ID: <5c778d51-ec87-4e74-9fd6-63dc4a9ae2a6@gmail.com>
Date: Thu, 2 Nov 2023 16:14:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [PATCH net] tg3: power down device only on
 SYSTEM_POWER_OFF
Content-Language: en-US
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: netdev@vger.kernel.org, Andrew Gospodarek
 <andrew.gospodarek@broadcom.com>, Michael Chan <michael.chan@broadcom.com>
References: <20231101130418.44164-1-george.shuklin@gmail.com>
 <CALs4sv37sniGKkYADvHwwMjFzp5tBbBnpfOnyK-peM=rnp63Bw@mail.gmail.com>
 <31a5cfe8-133d-4548-9814-cf3e61d89307@gmail.com>
 <CALs4sv1-6mgQ2JfF9MYiRADxumJD7m7OGWhCB5aWj1tGP0OPJg@mail.gmail.com>
From: George Shuklin <george.shuklin@gmail.com>
In-Reply-To: <CALs4sv1-6mgQ2JfF9MYiRADxumJD7m7OGWhCB5aWj1tGP0OPJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/2/23 09:04, Pavan Chebbi wrote:
> On Thu, Nov 2, 2023 at 1:28 AM George Shuklin <george.shuklin@gmail.com> wrote:
>> On 01/11/2023 17:20, Pavan Chebbi wrote:
>>> On Wed, Nov 1, 2023 at 6:34 PM George Shuklin <george.shuklin@gmail.com> wrote:
>>>> Dell R650xs servers hangs if tg3 driver calls tg3_power_down.
>>>>
>>>> This happens only if network adapters (BCM5720 for R650xs) were
>>>> initialized using SNP (e.g. by booting ipxe.efi).
>>>>
>>>> This is partial revert of commit 2ca1c94ce0b.
>>>>
>>>> The actual problem is on Dell side, but this fix allow servers
>>>> to come back alive after reboot.
>>> How are you sure that the problem solved by 2ca1c94ce0b is not
>>> reintroduced with this change?
>> I contacted the author of original patch, no reply yet (1st day). Also,
>> I tested it on few generations of available Dell servers (R330, R340,
>> R350 and R650sx, for which this fix should help). It does produce log
>> message from
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1917471, but, at
>> least, it reboots without issues.
>>
>> Actually, original patch is regression: 5.19 rebooting just fine, 6.0
>> start to hang. I also reported it to dell support forum, but I'm not
>> sure if they pick it up or not.
>>
>> What would be the proper course of actions for such problem (outside of
>> fixing UEFI SNP, for which I don't have access to sources)?
>>
> Thanks for the explanation. I am not sure if we should make this
> change unless we are 100pc sure that this patch won't cause
> regression.
> I feel Dell is in the best position to debug this and they can even
> contact Broadcom if they see any problem in UEFI.

I'm right now with dell support, and what they asked is to 'try this on 
supported distros', which at newest are 5.15. I'll try to bypass their 
L1 with Ubuntu + HWE to get to 6+ versions...

I was able to reproduce hanging at reboot there (without ACPI messages), 
and patching helps there too.


