Return-Path: <netdev+bounces-55001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA70809247
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 21:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87A328132D
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 20:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED62750271;
	Thu,  7 Dec 2023 20:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kW4kiRaQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360211713
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 12:27:42 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5d3d5b10197so11158927b3.2
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 12:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701980861; x=1702585661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qnX4PYjOIoEdGuX259f5fNZPQBTHPTtQzr1PMenmvvQ=;
        b=kW4kiRaQA6efjYqga7VPz/Qvmh3URuF2blk9KVdnaoNQ5ZbDhUREuIIE6Ub+8WHOT+
         FEeGBlt7Y24y3iiOliJrTPL5biHmmsrowNowJNYDT7gC1NWFRqLZLJ8cdCq8adB9BfUa
         LWJi2M8nW8VL9dhc14DOmDFtx236R9jSTmV6MqMzgCX5e/MhVhghVvNaGcC2s0dn8rhR
         JBwqARMWqHTNoQkHwKV1nbSD8nu5c1ipDP9FLNysgONJxhFwW8trcV3El7MdeGmk1TCZ
         CC5wIuajzpW8OYsj4ZnQmXktBG4LbPMcdtb+FE0AanaEnbhc5mllOU80zwVb17DwLCkN
         arQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701980861; x=1702585661;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qnX4PYjOIoEdGuX259f5fNZPQBTHPTtQzr1PMenmvvQ=;
        b=JziDfiPDkcZpLDS0KLau93wseizWGMeeLisd3/Qg+0+vqvafJ8bhzUhzb4JCp47STG
         b1ACKohilyB6dMsEesXtBjC+oiiBj44jLTq+mV2pBM00kfHoZQFgOtut/Ew7ZsSdNLmf
         geprtzeBzkbLz5eIFScQN+39x71vUEYEYX7ASpJDIvGWMKo/9IWWfBY+yeMFgb+htRUI
         qaGGGlbzQ0sERz6jqSubCylVBiZ5Ukgne8QJM87LwTxv4ZoPSAEE8FYhGFXW/uLyqKEM
         HZfn1WWz1/iJGDCkxmS27FfHjUokCalXgWjLoR+ioy2t1sRPR2ca3ov+Fhu7D+OM93v0
         G24Q==
X-Gm-Message-State: AOJu0YxjoPfbhL6X6wON2iy5DTcvSsDf8u/A1HsIhh3UqfzwCvsGKaom
	rWGabSZ8ProBIdm/uPOGd5c=
X-Google-Smtp-Source: AGHT+IGNNj5N4fqd0hmiS7G0r5mSK5G+pTdeBUjjhxH/6+0rhZLmcFKN5lW6WTX3Ndn3rYPglA3paQ==
X-Received: by 2002:a81:7e51:0:b0:5cc:e5a5:d951 with SMTP id p17-20020a817e51000000b005cce5a5d951mr2859658ywn.45.1701980861408;
        Thu, 07 Dec 2023 12:27:41 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:57df:3a91:11ad:dcd? ([2600:1700:6cf8:1240:57df:3a91:11ad:dcd])
        by smtp.gmail.com with ESMTPSA id d18-20020a81d352000000b0059a34cfa2a8sm134725ywl.62.2023.12.07.12.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 12:27:41 -0800 (PST)
Message-ID: <15cfe914-592a-40e1-8b73-f83ed8234c68@gmail.com>
Date: Thu, 7 Dec 2023 12:27:39 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: do not check fib6_has_expires() in
 fib6_info_release()
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com,
 Kui-Feng Lee <thinker.li@gmail.com>
References: <20231207201322.549000-1-edumazet@google.com>
 <c76916fb-4d92-442a-b72a-516aa9236d73@kernel.org>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <c76916fb-4d92-442a-b72a-516aa9236d73@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/7/23 12:25, David Ahern wrote:
> On 12/7/23 1:13 PM, Eric Dumazet wrote:
>> My prior patch went a bit too far, because apparently fib6_has_expires()
>> could be true while f6i->gc_link is not hashed yet.
> 
> yes, and I got distracted by that stack trace and avoiding errors in the
> create function. The diff I sent does not solve any corruption with list
> since the newly allocated f6i is not linked (and gc-link is initialized).
> 
> Kui-Feng: no need to send that patch again since it is not really
> changing anything. Let's see if the other warn on triggers.

Got it!

> 
>>
>> fib6_set_expires_locked() can indeed set RTF_EXPIRES
>> while f6i->fib6_table is NULL.
>>
>> Original syzbot reports were about corruptions caused
>> by dangling f6i->gc_link.
>>
>> Fixes: 5a08d0065a91 ("ipv6: add debug checks in fib6_info_release()")
>> Reported-by: syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com
>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>> Cc: David Ahern <dsahern@kernel.org>
>> Cc: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   include/net/ip6_fib.h | 1 -
>>   1 file changed, 1 deletion(-)
>>
> 
> 
> Reviewed-by: David Ahern <dsahern@kernel.org>
> 
> 

