Return-Path: <netdev+bounces-61670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EA882492C
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 20:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0C61C22201
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 19:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9152C1A1;
	Thu,  4 Jan 2024 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="i7bTGjzR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625132C19E
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 19:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d9b267007fso570775b3a.3
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 11:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1704397211; x=1705002011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8CBLpVW29Ko/bKk530h9Ha4n7/bN3aJfLLpYNh1j4c8=;
        b=i7bTGjzRbbZwCuqzV5tnRIAH/mfG57avlrVzzdIa9BdZWIYtoK/6CyTb3jWIGEhLr8
         EIbquSszACmjQvmYrstM6PuEmiTrv/t4g1GZPxvSbT8cKrSWW1KxC+GBoNOL/i2DqL+n
         +T7oE4nwVNucWdIxZOnu3mMFDvkzzauDIR+02TbVLjdXWahj/R0zKB07IHKW7nBP5TWk
         OIZlhQ/igPLzMpF2oY5zcz/J377opxdVjJ3LOq/kG/lr0gbel8EXEUGe1PXSvxF4sZ5z
         dGsnXpHU+e4RJUi4HJIJpJLnXq4w1lX79j6h3mMz27m2Lqv0eEWIXuWkPmKyEH4aeTnI
         8TTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704397211; x=1705002011;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8CBLpVW29Ko/bKk530h9Ha4n7/bN3aJfLLpYNh1j4c8=;
        b=YxxxjKCvCAIPd94IH3QzRo7jAkbNqP+NngZahquIwQLZNSwjlMhC6LF3H2aSbFKfIN
         s/TvlchADSCFg9VEAkg3lcCvNVS2w6yKBmvkn3gNBhskgjZMv4YP3CIZ327oLGT4Uv22
         mirBsuAx5aaxXII9JYpmEITmylbcf8EAGsuoYTR51a/gmGFql07izXlcTTDuVKMqlorD
         j7bd9ektgBe+oYo08odaJYsSQ58mlvkkSj0UEDUqXv11+Iy70nLj0UeqreqRlNtsyTGh
         TbP69PoGHyCZhsRIIPUOsULfPgd8Lq8fu0xIHNI39s74NqbjzhAoosWdneOA1+Z2i/Ds
         k7mw==
X-Gm-Message-State: AOJu0YwLQYlD/JUv0bFJpEW02cmxwPukm/21fpZNONseygQiIrCCm5+H
	JAR6mVjREj2UaVeku2nEQrgemV55rnGL
X-Google-Smtp-Source: AGHT+IHQtRG7gnCOri6trb/ZAGQPks7Ndqu458huhYq7SL2JUm7mp3xW4apzj930VIC6ubTgK8TQdQ==
X-Received: by 2002:a05:6a00:1916:b0:6da:bed1:4566 with SMTP id y22-20020a056a00191600b006dabed14566mr1089363pfi.41.1704397210407;
        Thu, 04 Jan 2024 11:40:10 -0800 (PST)
Received: from ?IPV6:2804:7f1:e2c0:aba3:7663:8830:3d6b:aa9f? ([2804:7f1:e2c0:aba3:7663:8830:3d6b:aa9f])
        by smtp.gmail.com with ESMTPSA id a21-20020a62bd15000000b006d99e005ea6sm27522pff.160.2024.01.04.11.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 11:40:09 -0800 (PST)
Message-ID: <1fd82f42-9f9c-4e4a-9031-2ab51898c899@mojatatu.com>
Date: Thu, 4 Jan 2024 16:40:04 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/1] net/sched: We should only add appropriate
 qdiscs blocks to ports' xarray
Content-Language: en-US
To: Kui-Feng Lee <sinquersw@gmail.com>, jhs@mojatatu.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Cc: idosch@idosch.org, mleitner@redhat.com, vladbu@nvidia.com,
 paulb@nvidia.com, pctammela@mojatatu.com, netdev@vger.kernel.org,
 kernel@mojatatu.com, syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com,
 syzbot+806b0572c8d06b66b234@syzkaller.appspotmail.com,
 syzbot+0039110f932d438130f9@syzkaller.appspotmail.com
References: <20231231172320.245375-1-victor@mojatatu.com>
 <eb4261f0-a5b7-4438-87f2-21207d86185d@gmail.com>
 <c5b1da91-924f-43f8-8fba-6295d4a77d13@gmail.com>
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <c5b1da91-924f-43f8-8fba-6295d4a77d13@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/01/2024 15:49, Kui-Feng Lee wrote:
>>> [...]
>> Hi Vector,
>>
>> Thank you for fixing this issue!
>> Could you also add a test case to avoid regression in future?
>> We have BPF test cases that fails for this issue. However,
>> not everyone run BPF selftest for netdev changes.
>> It would be better to have a test case for net as well.
>>
> 
> The following links are about the errors of bpf selftest. FYI!
> 
>   - 
> https://github.com/kernel-patches/bpf/actions/runs/7401181881/job/20136944224
>   - 
> https://lore.kernel.org/netdev/ce8d3e55-b8bc-409c-ace9-5cf1c4f7c88e@gmail.com/

Thank you for the suggestion and pointers, will do.

cheers,
Victor

