Return-Path: <netdev+bounces-40040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63B17C587F
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 17:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23DDB1C20BF3
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 15:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5268F208DB;
	Wed, 11 Oct 2023 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbpiWXiT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1C020311
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 15:50:03 +0000 (UTC)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CB4AF;
	Wed, 11 Oct 2023 08:50:02 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so784703a12.0;
        Wed, 11 Oct 2023 08:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697039401; x=1697644201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sDYBKIS55V1uI8CU7rsbxpgMy6trEjU+BP4wxaqMQ+0=;
        b=RbpiWXiThoJuR4h0y/Qaunp6jjoPgMue3yLOXZCkq5MmfMmkFakTa6WzQFqdlnZDNm
         x12Rsp6ipYngIIzSvdu59/VFhEd0E+1o31MkAjS2Hcz2PG76jtLdLrW2TKdqffF43LA0
         lkH2SPtF1OuXLHVo8K43KAdeIajhZv1Y1KFG7B2q5mzez2cQK7+k/8gnwwNZx8BHCVGl
         nt1Y6F1IS4lX7d/FdsVt6X4uw0jwBIdAlU2sP9ss792MsBYnFrZ+OMGdcjLSWNuYZI9Z
         tr4RqhnDu0ippyaT7IEwxd7Lz0XQkTSNhRFwOacJm8uj1jtVgnlETrlA2HyFywibzsh/
         KHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697039401; x=1697644201;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sDYBKIS55V1uI8CU7rsbxpgMy6trEjU+BP4wxaqMQ+0=;
        b=DLWUxhet/yVkWZFlYDafQKPlSa2dZQrw+CfxZSJ3LJThHJUcfTUXKfB7120e4Jp8EQ
         rHDnbRMpqf2h7SlPv1TUx3nf/bvnXadkYx+3tFCeMntJMoyeQD1vRswkrfxDldFQgbHf
         H+GhrnGhlxcHXgjKRTYYYoAglDUZqZz2w6DXOlRbqqcwTmvLfm33Nj1/noDZikWfDEdh
         92V0LTaRbx5itSLf1Hplcm/RN7A8J3LkxD5QwhoshtBTa7nGXETXz58nWPy8lSnDjTMa
         RELI1lPaAjq9jfD0iWpqOdZudoaEl0O+9WhqOdr8k+mzd3fLVavE/HvIUIWd5u2fm6ff
         Trfg==
X-Gm-Message-State: AOJu0YyDWTb44cjcBe5lsSwIC/sXxYKunzBKxQJ9mgKMX0yJDe3bzveW
	IQAO1rhRghs5EUza6im4x48=
X-Google-Smtp-Source: AGHT+IHEXzo3nG4oHvAYaUxMtuOcdqDQ+lFQZSBrGVmbjQPPHV2ObamtR1Pq50KuZb10ox7FWz/T5A==
X-Received: by 2002:a17:90b:1496:b0:27c:f88f:11a5 with SMTP id js22-20020a17090b149600b0027cf88f11a5mr3826613pjb.2.1697039401382;
        Wed, 11 Oct 2023 08:50:01 -0700 (PDT)
Received: from [192.168.0.152] ([103.75.161.210])
        by smtp.gmail.com with ESMTPSA id mz14-20020a17090b378e00b0027722832498sm59877pjb.52.2023.10.11.08.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 08:50:00 -0700 (PDT)
Message-ID: <3073e9a6-9f10-4326-9734-7e203d509888@gmail.com>
Date: Wed, 11 Oct 2023 21:19:51 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Remove extra unlock for the mutex
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20231010224630.238254-1-singhabhinav9051571833@gmail.com>
 <2023101136-irritate-shrine-cde6@gregkh>
From: Abhinav Singh <singhabhinav9051571833@gmail.com>
In-Reply-To: <2023101136-irritate-shrine-cde6@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/11/23 12:00, Greg KH wrote:
> On Wed, Oct 11, 2023 at 04:16:30AM +0530, Abhinav Singh wrote:
>> There is a double unlock on mutex. This can cause undefined behaviour.
>>
>> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
>> ---
>>   net/ipv4/inet_connection_sock.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
>> index aeebe8816689..f11fe8c727a4 100644
>> --- a/net/ipv4/inet_connection_sock.c
>> +++ b/net/ipv4/inet_connection_sock.c
>> @@ -597,7 +597,6 @@ int inet_csk_get_port(struct sock *sk, unsigned short snum)
>>   	}
>>   	if (head2_lock_acquired)
>>   		spin_unlock(&head2->lock);
>> -	spin_unlock_bh(&head->lock);
> 
> How was this tested?
> 
> And where is the now-needed unlock of the head->lock?
> 
> How was this change found?
> 
> And your subject line needs a lot of work...
> 
> thanks,
> 
> greg k-h
Hello, I used sparse tool and got it this warning message "warning: 
context imbalance in 'inet_csk_get_port' - unexpected unlock"
Due to my over excitement of sending a good patch to kernel I didnt see 
correctly and misread `head` as `head2` and thought it was double 
unlocking the mutex. I m very sorry. But on a different note think we 
should do a check for `head->lock` as well before unlocking. Unlocking a 
non locked mutex can also trigger a undefined behaviour.

Thank you,
Abhinav Singh

