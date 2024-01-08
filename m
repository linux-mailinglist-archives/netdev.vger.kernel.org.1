Return-Path: <netdev+bounces-62290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5936826723
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 02:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC8D281889
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 01:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0308A7F;
	Mon,  8 Jan 2024 01:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIxlv1rC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA31EBE
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 01:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55719cdc0e1so1395658a12.1
        for <netdev@vger.kernel.org>; Sun, 07 Jan 2024 17:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704678122; x=1705282922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ro01lNa7upsgOOAZp+z7myhtax4FsB7jcFWvloXiMrc=;
        b=EIxlv1rCZ0MJNn6IOLqGQDwS9DVCUw2OWW8twDXBKQQng4LO6TCavHwpS5BAfX13Yt
         xFjxLSnfz1YaDgMNX5J4nhnypYBFccg0WGJVmTKXlZ12FGlOtPrWbDMG2TjDl7K2FiAN
         o8a/Kqag8wnFCDdcq9DrXQZT2+sX3fIWao9kDpPWve4rJ56JJUMZfDG+CwSrOh0JCA8+
         WmxtZ4DWzO6Fq7WQd2HTWioBm1JrDKFpaaPr+lptMFMFGnJzo1w36zvkWFTAqR3mOnRu
         zGPYWZpWE58WgZADZ8F22xuvsZRE5g0DR5BP8XicMhFUqHQ/nRfUixhEL530Z/xWzrHV
         gX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704678122; x=1705282922;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ro01lNa7upsgOOAZp+z7myhtax4FsB7jcFWvloXiMrc=;
        b=XvYJ88e1zwbKwp+WQ1RfaXCSuJJ9G7LXEKp04CwsSFus6tYwFmZCgHK48BEHOT3K2U
         2s00IGc9Qkh8qQdtXcc77pdWlUzyYC2PG9aD9ZOJgmXYAKTo1JvTemfxF/j4iugPGyrH
         lNhDRJesEJMfExMRfte/yk/pN1OarKYfoovFSicckx5IpPeUSW6klVuYCrvpWNH0746C
         y1GN6wsn2kFvGkItVYLr/ihFuGweZro2VYt5v9TLVFzU05YqVNNJrFi8wEHmUW4fti/C
         6gA9wqnItvY9Pi10k9yVRFMyVRaRVuFZzkFSeD5RPX/i25PpovQeXj7pXvwvc9/EguTQ
         3+fg==
X-Gm-Message-State: AOJu0YwMr39jH4ecErirfSe5a15URY4WCWFPo9ZHsLP6T2jdXr4tsy40
	BSW4s4PDUPu3JTgSswGxcwU=
X-Google-Smtp-Source: AGHT+IEH61HNfamRkkQX3nQHzu4xkEEDZomLEUsIj896a4Rp+D/5Pqdd47aGeEWxK94RxnIqXf+BWw==
X-Received: by 2002:a17:906:73c5:b0:a26:8660:5f34 with SMTP id n5-20020a17090673c500b00a2686605f34mr1410345ejl.109.1704678122320;
        Sun, 07 Jan 2024 17:42:02 -0800 (PST)
Received: from [192.168.0.3] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090617c100b00a26a80a58fcsm3421789eje.196.2024.01.07.17.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jan 2024 17:42:01 -0800 (PST)
Message-ID: <fa23dd13-81e4-4454-9d00-c9f64842e59c@gmail.com>
Date: Mon, 8 Jan 2024 03:42:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/1] Introducing OpenVPN Data Channel Offload
Content-Language: en-US
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
References: <20240106215740.14770-1-antonio@openvpn.net>
 <d807ea60-c963-43cd-9652-95385258f1ad@gmail.com>
 <68a6d8a0-e98f-4308-a1b8-c11b5fa09fdf@openvpn.net>
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <68a6d8a0-e98f-4308-a1b8-c11b5fa09fdf@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Antonio,

On 08.01.2024 01:32, Antonio Quartulli wrote:
> Hi Sergey,
> 
> Thanks for jumping in
> 
> On 06/01/2024 23:29, Sergey Ryazanov wrote:
>> Hi Antonio,
>>
>> On 06.01.2024 23:57, Antonio Quartulli wrote:
>>> I tend to agree that a unique large patch is harder to review, but
>>> splitting the code into several paches proved to be quite cumbersome,
>>> therefore I prefered to not do it. I believe the code can still be
>>> reviewed file by file, despite in the same patch.
>>
>> I am happy to know that project is ongoing. But I had stopped the 
>> review after reading these lines. You need AI to review at once "35 
>> files changed, 5914 insertions(+)". Last time I checked, I was human. 
>> Sorry.
>>
>> Or you can see it like this: if submitter does not care, then why 
>> anyone else should?
> 
> I am sorry - I did not mean to be careless/sloppy.

Sure. I would not say this, I just gave you a hint how it can be look 
like. Looks like you did a great job implementing it, lets do a final 
good review before merging it.

> I totally understand, but I truly burnt so much time on finding a 
> reasonable way to split this patch that I had to give up at some point.

Yep, but if submitter did not properly split it, then a reviewer have to 
do this. Right?

> I get your input, but do you think that turning it into 35 patches of 1 
> file each (just as a random example), will make it easier to digest?

It is a pleasure to review a good arranged series that in step-by-step 
manner explains how a functional should be implemented and will work.

Splitting some huge driver into item files is neither a good approach. 
As you already mentioned, it gives almost nothing in terms of the review 
simplification. E.g. some file can contain a set of library functions, 
so checking them without calling examples is nonsense, etc.

Thus, I would suggest to choose a regular approach and turn the code 
into implementation steps. Just imagine a set of steps you would take to 
implement the functionality if you were do it from scratch. You can also 
think of it as a presentation.

Just an example of how I would break such work into separate patches:
1. changes to common kernel components: one patch per changed subsystem 
(e.g. netlink, socket helpers, whatever);
2. skeleton of the future module: initialization, deinitialization, 
registration in the necessary subsystems (genetlink), most of the 
required callbacks are just stubs;
3. basic tunnel management implementation: tunnel creation and 
destroying, network interface creation, etc, again minimalistic, no 
actual packet processing, just drop packets at this stage;
4. tx path implementation: bare minimal data processing;
5. rx path implementation: again bare minimal;
6. various service functions: keepalive, rekeying, peer source address 
updating, etc. better in one-patch-per-feature manner.

This was just a clue. You, as the author, for sure know better how to 
present this in the most understandable way.

Just a couple of general tips. Common changes to other parts of the 
kernel (e.g. mentioned NLA_POLICY_MAX_LEN) should come as a dedicated 
patch with justification for how it makes life easier. Exception here is 
identifiers that the code is going to use (e.g. UDP_ENCAP_OVPNINUDP), it 
is better to add them together with the implementation. Each item patch 
must not break the kernel build. If you use any macro or call any 
routine, they should be added in the same patch or before. Build bot 
will be strongly against patches that break something. As you have 
already seen, it is even intolerant of new compilation warnings :)

> Anyway, I will give it another try (the test robot complained about 
> something, so it seems I need to resend the patch anyway) and I'll see 
> where I land.
> 
> Cheers!

Cheers!

--
Sergey

