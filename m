Return-Path: <netdev+bounces-43287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F18E7D2351
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 16:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ACD61C2091C
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 14:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C782DDB2;
	Sun, 22 Oct 2023 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHJpq33p"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A943C33DC
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 14:07:32 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B970E7
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 07:07:31 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32dbbf3c782so2002121f8f.1
        for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 07:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697983649; x=1698588449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LDzB+S9X2UaEmbrlHtACQE/gbvsqypTC0hwieTTqRrQ=;
        b=NHJpq33pjNVMhOGI3sEeWj8mCUPs9ZCqo6ZsR113vVoNesgaYhVEKEtGAn9f9bPssK
         GYlpsY4bZOsYa7+URDYqSX1izgueQkJzBsGurRaVsKiF7b8QPtV+QBJ2TrQK+MtrI14K
         blPGGJLlCJlmTVvdsgqnEDyhQGxCq9rncyWAj6RiDmTWWp+wiDcMf/xwzz51ORSpAIxm
         JjH0yrx7XmTB7B3z0jvE6OBK9lHpEFHTm0XEWx9zLbPGzHqICcl431PjXRiMnOqOsF/C
         OfW7qmJas9Ga3oVZpXPmGZ0M4W+eWPz9Rg06Xwvbz5rGvI0IGXbAiTcrNBsDUekagCl6
         XrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697983649; x=1698588449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LDzB+S9X2UaEmbrlHtACQE/gbvsqypTC0hwieTTqRrQ=;
        b=Sx1QRtn8XmX4QuBqKKrJogovNvqnRdwrqrruu1TyIPAgdCBFEiA2nkKAkWD40b1Cx6
         /MAoz1/XlW7eE9uThsUdiEwcWDHXYtrEllv7V5esuZh2hqvVeDFqJl/kNS7EBYID8wsC
         gUgarnl3fhVT8J75n1I5AeVVs6lH8Vk3hU58Hj2VSqMXz7RyyemC+bYmqX3v0u3i/CoN
         4FFX+2AO6a8v2mgSCZqYsLWqqfkBJR0PTBmrxgcnZ8lYNaMbFkDHk5z+/MEPCZ+kATTK
         n08ota7lA/kfvGA7mcjXRc6OIKHSTyAVD9AfAXTzi5IWFtuohdB2Vno8d3hYqvuOAW8w
         zykQ==
X-Gm-Message-State: AOJu0YwYTajsAuEe+6exjSu9ydBsMj1aaKRdPF8Uf3hwZC1d1bMlFiPf
	MnYyPPseYENzJggds9GO/Ns=
X-Google-Smtp-Source: AGHT+IEgy12VzVPHIrRpsIMEe/ihgR+4YCFl927OOrXolzFHcMG5zkjz9dGDaUsbsb0IbPZhMZnSEQ==
X-Received: by 2002:a5d:5956:0:b0:32d:de4f:140b with SMTP id e22-20020a5d5956000000b0032dde4f140bmr10673723wri.6.1697983648859;
        Sun, 22 Oct 2023 07:07:28 -0700 (PDT)
Received: from [192.168.0.101] ([77.126.80.27])
        by smtp.gmail.com with ESMTPSA id q6-20020adfb186000000b0032326908972sm5780207wra.17.2023.10.22.07.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 07:07:28 -0700 (PDT)
Message-ID: <765388b9-3653-4baa-b922-58f034f62fb1@gmail.com>
Date: Sun, 22 Oct 2023 17:07:27 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tls: don't reset prot->aad_size and
 prot->tail_size for TLS_HW
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Boris Pismenny <borisp@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 John Fastabend <john.fastabend@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, tariq Toukan <tariqt@nvidia.com>,
 Ran Rozenstein <ranro@nvidia.com>
References: <979d2f89a6a994d5bb49cae49a80be54150d094d.1697653889.git.sd@queasysnail.net>
 <20231020171448.484dcf2a@kernel.org>
 <daa80210-255e-48f4-837d-0a1aec3f6f70@gmail.com>
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <daa80210-255e-48f4-837d-0a1aec3f6f70@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 22/10/2023 15:02, Tariq Toukan wrote:
> 
> 
> On 21/10/2023 3:14, Jakub Kicinski wrote:
>> On Fri, 20 Oct 2023 16:00:55 +0200 Sabrina Dubroca wrote:
>>> Prior to commit 1a074f7618e8 ("tls: also use init_prot_info in
>>> tls_set_device_offload"), setting TLS_HW on TX didn't touch
>>> prot->aad_size and prot->tail_size. They are set to 0 during context
>>> allocation (tls_prot_info is embedded in tls_context, kzalloc'd by
>>> tls_ctx_create).
>>>
>>> When the RX key is configured, tls_set_sw_offload is called (for both
>>> TLS_SW and TLS_HW). If the TX key is configured in TLS_HW mode after
>>> the RX key has been installed, init_prot_info will now overwrite the
>>> correct values of aad_size and tail_size, breaking SW decryption and
>>> causing -EBADMSG errors to be returned to userspace.
>>>
>>> Since TLS_HW doesn't use aad_size and tail_size at all (for TLS1.2,
>>> tail_size is always 0, and aad_size is equal to TLS_HEADER_SIZE +
>>> rec_seq_size), we can simply drop this hunk.
>>>
>>> Fixes: 1a074f7618e8 ("tls: also use init_prot_info in 
>>> tls_set_device_offload")
>>> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
>>> ---
>>> Tariq, does that solve the problem you reported in
>>> https://lore.kernel.org/netdev/3ace1e75-c0a5-4473-848d-91f9ac0a8f9c@gmail.com/
>>> ?
>>
>> In case Tariq replies before Monday and DaveM wants to take it, LGTM:
>>
>> Acked-by: Jakub Kicinski <kuba@kernel.org>
> 
> Hi,
> 
> We're testing this fix and will reply ASAP.
> 

Test passes:
Tested-by: Ran Rozenstein <ranro@nvidia.com>

We suspect that it was not the only degradation introduced by this series.
We are going to run more comprehensive tests with the recent series and 
this new fix. Of course we'll update about any remaining issues.

Tariq

