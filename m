Return-Path: <netdev+bounces-56505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D730A80F266
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 17:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80A8F1F214E4
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 16:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8198277F24;
	Tue, 12 Dec 2023 16:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HN2/RiPl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAECEAD
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 08:24:40 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b9f8c9307dso3005351b6e.0
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 08:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702398280; x=1703003080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IEZwD8ClPDjuRvrj1zEbFCEazT8L2WOGxED1jF5tzIQ=;
        b=HN2/RiPlRYAlHOEC4strM6sJJfpo6+8S1/KZ9tOKfcKCX8Ok+n6XKTGnwpM8EWXtch
         vfPxaTT2yoWocUee0q5wgHK8R+X9nu/rURj1YhWTOO0YSQatObv/f973Zyds56qdyfvD
         RB3ICYvCM2Ujrdsv80qghaDfMF+UHxFHUOKgDtF6YtJd+IDnzUcRj5fo+hhAa/PeOeon
         o6eHDU/Tl80t3APjaFZPAbnIoS0263idT6UUqeigkkWtdCKr8Y4pDHq9z/wwEmxSYYoa
         xzRdqxI53TfZqy9H+qcicRtnL7VNkHrI0gAJpM/E1AeiuljFucKpMk+PXtZ8BOe3CAFO
         0+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702398280; x=1703003080;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IEZwD8ClPDjuRvrj1zEbFCEazT8L2WOGxED1jF5tzIQ=;
        b=KITGg68m2y0jKO8DgU0KdDGaD8ny2nJT3szn2voo5GqPrnZoBy+iHmrG5EXljBl3pV
         dDZU/UflYgxLBGjJSPvH9wX7i8ra2P8bum0RsTgiUG+k/6jJQnpSMmc2TT2bRnidxb7R
         XeKJfZ9XbvNslpGG1gjUD6e8peCaZ1ubK+DgIkG3lMOESTdLduKhIQqmocEdEW2i2cB7
         CZPD5wUUFVE4uQNNRHr6Pe07+ca+56bHFUCR2M9w15ehDIDYuvTytLsj4o/dzGh3WZuP
         9gvlnWbaNQBGQ4ijjWH5zZshhMdzK9vSvjhzpNShL4A4KoXrJlavg5HhPLdWG6k6xrIK
         H3RQ==
X-Gm-Message-State: AOJu0YwmzZyVRKBMXhvtrMHJXB010eS3cF11h1a4iYPJ9d1FLsj8+Nzf
	GUVaburXIAKLylO13iu+h5w=
X-Google-Smtp-Source: AGHT+IEPqVN1mJMMw8hsjWdGN17gACKwSImTajrcw2+aDXDDkRJeuScDpT6iQgfNQN2Z/vRvvf4zkg==
X-Received: by 2002:a05:6808:1509:b0:3b8:5fec:5d6 with SMTP id u9-20020a056808150900b003b85fec05d6mr8073461oiw.27.1702398280180;
        Tue, 12 Dec 2023 08:24:40 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:39c5:ef31:3f45:740b? ([2600:1700:6cf8:1240:39c5:ef31:3f45:740b])
        by smtp.gmail.com with ESMTPSA id g93-20020a25a4e6000000b00da10d9e96cesm3350654ybi.35.2023.12.12.08.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 08:24:39 -0800 (PST)
Message-ID: <48b0c682-1b28-4da8-b05a-a2494916e80b@gmail.com>
Date: Tue, 12 Dec 2023 08:24:38 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] selftests: fib_tests: Add tests for
 toggling between w/ and w/o expires.
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: thinker.li@gmail.com, netdev@vger.kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, edumazet@google.com, kuifeng@meta.com
References: <20231208194523.312416-1-thinker.li@gmail.com>
 <20231208194523.312416-3-thinker.li@gmail.com> <ZXfDd_tzAwDbi66Q@Laptop-X1>
 <83a83ca3-3481-4e2d-a952-37437fca1800@gmail.com> <ZXfxIe1qzxMQC1jV@Laptop-X1>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <ZXfxIe1qzxMQC1jV@Laptop-X1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/11/23 21:35, Hangbin Liu wrote:
> On Mon, Dec 11, 2023 at 06:40:43PM -0800, Kui-Feng Lee wrote:
>>>> +	N_EXP_SLEEP=$($IP -6 route list |grep expires|wc -l)
>>>> +	if [ $N_EXP_SLEEP -ne 100 ]; then
>>>> +	    echo "FAIL: expected 100 routes with expires, got $N_EXP_SLEEP"
>>>
>>> Hi,
>>>
>>> Here the test failed, but ret is not updated.
>>>
>>>> +	fi
>>>> +	sleep $(($EXPIRE * 2 + 1))
>>>> +	N_EXP_SLEEP=$($IP -6 route list |grep expires|wc -l)
>>>> +	if [ $N_EXP_SLEEP -ne 0 ]; then
>>>> +	    echo "FAIL: expected 0 routes with expires," \
>>>> +		 "got $N_EXP_SLEEP"
>>>> +	    ret=1
>>>
>>> Here the ret is updated.
> 
> BTW, the current fib6_gc_test() use $ret to store the result. But the latter
> check would cover the previous one. e.g.
> 
> if [ $N_EXP_SLEEP -ne 0 ]; then
> 	ret=1
> else
> 	ret=0
> fi
> 
> do_some_other_tests
> if [ $N_EXP_SLEEP -ne 0 ]; then
> 	ret=1
> else
> 	ret=0
> fi
> 
> If the previous one failed, but later one pass, the ret would be re-write to 0.
> So I think we can use log_test for each checking.
> 
> Thanks
> Hangbin

Some of these tests has dependencies.  So, what I did is to perform the
following commands only if ret = 0.

if [ $N_EXP_SLEEP -ne 0 ]; then
     ret=1
else
     ret=0
fi

if [ $ret -eq 0 ]; then
   .....
   if [ ...]; then
       ret=1
   else
       ret=0
   fi
fi

if [ $ret -eq 0]; then
....
fi

