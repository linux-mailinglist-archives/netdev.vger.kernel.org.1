Return-Path: <netdev+bounces-57888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A5E81467B
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618171F23A01
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A00200A8;
	Fri, 15 Dec 2023 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="kK1CQUWA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF85E249EF
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 11:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ceba6c4b8dso428690b3a.1
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702638725; x=1703243525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dXP6s66q9ntTfbLUAFz49osaIwyE5w6Ya+xKP7fpd10=;
        b=kK1CQUWAIrhWz3SYA1OlMOJXORUhqYGo+VMPxPe1B6hhilsEiL1L4jdmCslpwydOKu
         fKZBBxNGM2KDMbicjb37IhBzpbUuOpZ32yquskmqecXrj/Q1NzPvini5UuTCt5hBWyo2
         IuNCJu2eXRVUTvHcT4eTRf376DvMH1UB6uNR6Cj9G6WXK0lVDzzhLHY48hGROKhuk5hQ
         70i39VrVsg8vg5VMwYTX4ZNOAy/EfaS9nhFe/2Vs9bUk+SxRJMIgEGhGkl96aItd/ONW
         YI+bzWtkR8HI4VeYdFUQKtjfSAw87lO2X0ia6/AsoU4yVJHJQW2Ul+YCm4bQs24qjiLW
         AH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702638725; x=1703243525;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dXP6s66q9ntTfbLUAFz49osaIwyE5w6Ya+xKP7fpd10=;
        b=kr3kjy0QdBCRwjHbQUQuMSxdWeCgWBbzQc28NcBSVyrKgTJ0haKp8y5eXP/lVRhlic
         tFIOTusbnaH2yDOzZ2yKfQSPro9p6lKq9/8nsaomfgiYEdTPoWC2sGrJ7+jrjxzxQhBx
         L1Nkr+y7/KgEGWyZSlm16Vr2382wq3rGPJPEWyGd4883ow1Vw8ETdyj5tKkM4Ig/b12/
         sEQ0EoNlGFxUmjkAVCK2V2AY41HoX0P9cPpK97IzEok1jy8VNvcsf8vDsU3z4k6cuiD2
         OikyKEqS0hbJtshm/5daSemIceWXgj9KhLwLjPynjouPU+U1l1QLeu4tnyIGZEnWCOlV
         tQcA==
X-Gm-Message-State: AOJu0YwSo1OO4yT9wGv7JiigFfyy2TCES1Z1aYO8K01n7e9lqcN1c/8N
	3LajR365m/gQL+uomMaDA/xLNg==
X-Google-Smtp-Source: AGHT+IEXkw6jspAvr3Xj+cY9qC6Lf80UWcR3sDS+5fUNBsa5Bx2Y7Qm2kp1iFPT6jKWwlroUcfRyug==
X-Received: by 2002:a05:6a20:ba7:b0:18b:5a66:3f70 with SMTP id i39-20020a056a200ba700b0018b5a663f70mr12153042pzh.2.1702638725121;
        Fri, 15 Dec 2023 03:12:05 -0800 (PST)
Received: from ?IPV6:2804:7f1:e2c0:60e3:4c1:486f:7eda:5fb5? ([2804:7f1:e2c0:60e3:4c1:486f:7eda:5fb5])
        by smtp.gmail.com with ESMTPSA id n8-20020a654508000000b005c65fcca22csm11324422pgq.85.2023.12.15.03.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 03:12:04 -0800 (PST)
Message-ID: <a478ab7c-0fa1-4233-95ac-61ebbd7ba0f1@mojatatu.com>
Date: Fri, 15 Dec 2023 08:12:00 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 3/3] net/sched: act_mirred: Allow mirred to
 block
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: jhs@mojatatu.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 mleitner@redhat.com, vladbu@nvidia.com, paulb@nvidia.com,
 pctammela@mojatatu.com, netdev@vger.kernel.org, kernel@mojatatu.com
References: <20231214141006.3578080-1-victor@mojatatu.com>
 <20231214141006.3578080-4-victor@mojatatu.com>
 <20231214190919.2b446e31@kernel.org>
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20231214190919.2b446e31@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/12/2023 00:09, Jakub Kicinski wrote:
> On Thu, 14 Dec 2023 11:10:06 -0300 Victor Nogueira wrote:
>> So far the mirred action has dealt with syntax that handles mirror/redirection for netdev.
>> A matching packet is redirected or mirrored to a target netdev.
>>
>> In this patch we enable mirred to mirror to a tc block as well.
>> IOW, the new syntax looks as follows:
>> ... mirred <ingress | egress> <mirror | redirect> [index INDEX] < <blockid BLOCKID> | <dev <devname>> >
>>
>> Examples of mirroring or redirecting to a tc block:
>> $ tc filter add block 22 protocol ip pref 25 \
>>    flower dst_ip 192.168.0.0/16 action mirred egress mirror blockid 22
>>
>> $ tc filter add block 22 protocol ip pref 25 \
>>    flower dst_ip 10.10.10.10/32 action mirred egress redirect blockid 22
> 
> net/sched/act_mirred.c:424:6: warning: variable 'err' set but not used [-Wunused-but-set-variable]
>    424 |         int err = 0;
>        |             ^

Thank you for the catch.
Sent a v7 fixing it.

cheers,
Victor

