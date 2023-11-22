Return-Path: <netdev+bounces-50271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEA77F52C5
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 22:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E8D1C20B5A
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 21:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E231CA84;
	Wed, 22 Nov 2023 21:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lat7p4OH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CBDDA;
	Wed, 22 Nov 2023 13:44:20 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-543c3756521so331337a12.2;
        Wed, 22 Nov 2023 13:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700689459; x=1701294259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xtanoWGCY7h+4tm6qQcmMOcUxKcUNh5lJMouYq8Ssrc=;
        b=lat7p4OH63n6qdxPc+6ykgrfcBC1Qq/R7mi0mjfm2BbRgSQIRmsdLxiIkQiuGHPP/w
         RIPBvkiECCfu6DjeGcEirUxeYIG+daLHwcF+tG9nStRs/+KRWLmk5DnN5sRXafD4uZu+
         jeoyc9ImaC5d1TlZRtQWEjQQGNKjQNc2fV8aCh1JayaklEv9a8I7mH2i7gRodXLafHP5
         MngX6tz59P8Z+lMiPWV2ToR6thz9fZICcJ8f2yEmNwYCQqlUse0RwSjJ+F0bPh7am55j
         BOk9Jkm8+yFmb2h92MQzY2XGJB+hzHbxykTQLczfeHvY4u8bfnzl64WfRje8snrWjTWm
         UMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700689459; x=1701294259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xtanoWGCY7h+4tm6qQcmMOcUxKcUNh5lJMouYq8Ssrc=;
        b=sCWi3hHvoiHNz6gUYSYwj4DRlLYuiMWf+PsFpZXE5iYD7MUb/JAQXa9+yht7CSY93n
         5Ojxs+I1YrGYjmVun7qPOWaRQekLU+gxgECdFG1pAcHGos9pri5DWCGJIi5H/YEFYmWg
         rUtjPLu4CFUCQqV4nFM0o0U3szwN8rWMxG7J0g2xcmfs4lycP7F7xGCCzziISVyFXvJW
         FIt0i+EX3RtN60N6khhLSHK2691EO6qQq16rtRKRxKJEhneT8Z/6VCXfWKUdff4tdKti
         YMwZbTqXjMJwTLHNcZ7U8rGKqGEMUsSJPPBYZ+ATSWPm8vGNLwU2mjZr0LunLoCwWuPV
         o7BA==
X-Gm-Message-State: AOJu0YyJyRXZbDc7ZRpAuRZWFn18cb6XkX3SsW0ps2RJM6EceCA/Hpxo
	D95mFlHZLZZGgbalSoM1ApJDkGvWqY6KgQ==
X-Google-Smtp-Source: AGHT+IFoLjbOpmkIEULy5gbxKooTudQDxiArLI8S7wXYkZ1p88cJRrIDvnnjd2TG4kAGIdT+hiYc1A==
X-Received: by 2002:aa7:c715:0:b0:548:657c:9110 with SMTP id i21-20020aa7c715000000b00548657c9110mr2624490edq.38.1700689458596;
        Wed, 22 Nov 2023 13:44:18 -0800 (PST)
Received: from [192.168.50.20] (077222239035.warszawa.vectranet.pl. [77.222.239.35])
        by smtp.gmail.com with ESMTPSA id b9-20020aa7c6c9000000b005484c7e30d8sm224480eds.1.2023.11.22.13.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 13:44:18 -0800 (PST)
Message-ID: <381e90eb-a744-450b-967d-bc67afb0aa9c@gmail.com>
Date: Wed, 22 Nov 2023 22:44:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: possible proble with skb_pull() in smsc75xx_rx_fixup()
To: Oliver Neukum <oneukum@suse.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 USB list <linux-usb@vger.kernel.org>
References: <7f704401-8fe8-487f-8d45-397e3a88417f@suse.com>
 <EB9ACA9B-78ED-48C3-99D6-86E886557FBC@gmail.com>
 <73f614e6-796e-415d-9954-8a94105f5e1c@suse.com>
Content-Language: en-US
From: Szymon Heidrich <szymon.heidrich@gmail.com>
In-Reply-To: <73f614e6-796e-415d-9954-8a94105f5e1c@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/11/2023 13:35, Oliver Neukum wrote:
> On 16.11.23 21:09, Szymon Heidrich wrote:
>> Hello Oliver,
>>
>> Could you please give me some hints how this could be practically exploited to cause mischief?
> 
> Hi,
> 
> it seems to me like you can easily feed stuff that is not
> part of a packet into the network layer, but you cannot overflow the buffer.
> In other words, the issue exists, but using it to do harm is hard.
> 
>     Regards
>         Oliver
> 

Hello Olivier,

Perhaps I'm missing something but as far as I can tell I can't do here anything special compared
to crafting the packet itself. Please let me know in case I'm wrong.

Best regards,
Szymon

