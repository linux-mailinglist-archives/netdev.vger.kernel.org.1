Return-Path: <netdev+bounces-45576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6F77DE691
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 20:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DC4AB20E1D
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 19:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A45019BDB;
	Wed,  1 Nov 2023 19:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jk9GWi1U"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E6618040
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 19:58:20 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48F99F
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 12:58:15 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso269683a12.1
        for <netdev@vger.kernel.org>; Wed, 01 Nov 2023 12:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698868694; x=1699473494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7ltzMCn2siBmD8yun9Uf7pKX6TP4IHro5wicVbd6Mc=;
        b=Jk9GWi1UIbA44qkHqOyH2O9oJKLH4/0/Ue1WF6jGjvQRLdwOEUEyniDWpOGHuPlZnQ
         SZ3dzG5jcFQ1laFodtGe9mWcOMGSlIltsDxXGCw2guF/iMJuLWUffRR+DSAYN9wRFTzn
         8c7KcVktv4zD/g436aG3TaEVJstjxNjaD05DsCsCSSWj5CQBaeLX7pNpHCUQqN9pKivL
         0yTtxo0eY2SYulcC2yn6HmlnyBPX1cW+prEX0Q/n7PtzH6o4hwbIU6zEpSX47dkV5Ilz
         nJHwH8AO3T/aSeDXXzoRurz7Lq3YZmHBQHSSUAVeuAa53L+H/Xvl/Zgz2NhRZAcjAfp4
         BSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698868694; x=1699473494;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7ltzMCn2siBmD8yun9Uf7pKX6TP4IHro5wicVbd6Mc=;
        b=oPjmfGRGXFSoWtCATykDfcBu3pevfSz90/FjnwkZrdxbanM8vrtis13VGDGq07ZyNY
         JGAPeQYuchqpNqTN9ursyEaqqf0/Ah83p+yx4ltx58v5g8Iynf+JP2Z8jRAp3U7952g6
         7u6ETWsUXBLCLoVzdFbK8PW45RfrwXNLwTA9QMuc9EwUtwGDWgyRbI5SP6qYFxnO65XB
         fwTuFZqHmt89FnXZQfP/m1o2XVdYVD2NLsOsjX2Hjl0wPB4GeLEqP0zq9JkPWU+DG2uS
         XWCYohc8iDi4eOpjVsWiFXWuE6NPy7Y9Gty/b/7+Sh3wMquREvQ0kujNqAtVBJQY2Mx4
         9/ZQ==
X-Gm-Message-State: AOJu0YwilAJKaLwuHKCoai5HHZUMS1UB4N1qsxAIaPplrCPZwe6+pDFi
	Oy4FbwRnDxKV1b5VBdnxdSA=
X-Google-Smtp-Source: AGHT+IGGNpLsrSBAQ6Q79Z4gRHerVd/N4Chmdlxf89gMtOxi9An2BpXMuNeHzFY1iOLefIyC0tATaA==
X-Received: by 2002:a17:907:1b10:b0:9be:834a:f80b with SMTP id mp16-20020a1709071b1000b009be834af80bmr2644332ejc.75.1698868693986;
        Wed, 01 Nov 2023 12:58:13 -0700 (PDT)
Received: from [172.16.42.2] ([188.42.216.83])
        by smtp.gmail.com with ESMTPSA id l12-20020a1709062a8c00b0099315454e76sm298298eje.211.2023.11.01.12.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 12:58:13 -0700 (PDT)
Message-ID: <31a5cfe8-133d-4548-9814-cf3e61d89307@gmail.com>
Date: Wed, 1 Nov 2023 21:58:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [PATCH net] tg3: power down device only on
 SYSTEM_POWER_OFF
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: netdev@vger.kernel.org, Andrew Gospodarek
 <andrew.gospodarek@broadcom.com>, Michael Chan <michael.chan@broadcom.com>
References: <20231101130418.44164-1-george.shuklin@gmail.com>
 <CALs4sv37sniGKkYADvHwwMjFzp5tBbBnpfOnyK-peM=rnp63Bw@mail.gmail.com>
Content-Language: en-US
From: George Shuklin <george.shuklin@gmail.com>
In-Reply-To: <CALs4sv37sniGKkYADvHwwMjFzp5tBbBnpfOnyK-peM=rnp63Bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/11/2023 17:20, Pavan Chebbi wrote:
> On Wed, Nov 1, 2023 at 6:34 PM George Shuklin <george.shuklin@gmail.com> wrote:
>> Dell R650xs servers hangs if tg3 driver calls tg3_power_down.
>>
>> This happens only if network adapters (BCM5720 for R650xs) were
>> initialized using SNP (e.g. by booting ipxe.efi).
>>
>> This is partial revert of commit 2ca1c94ce0b.
>>
>> The actual problem is on Dell side, but this fix allow servers
>> to come back alive after reboot.
> How are you sure that the problem solved by 2ca1c94ce0b is not
> reintroduced with this change?

I contacted the author of original patch, no reply yet (1st day). Also, 
I tested it on few generations of available Dell servers (R330, R340, 
R350 and R650sx, for which this fix should help). It does produce log 
message from 
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1917471, but, at 
least, it reboots without issues.

Actually, original patch is regression: 5.19 rebooting just fine, 6.0 
start to hang. I also reported it to dell support forum, but I'm not 
sure if they pick it up or not.

What would be the proper course of actions for such problem (outside of 
fixing UEFI SNP, for which I don't have access to sources)?


