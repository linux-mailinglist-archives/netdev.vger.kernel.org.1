Return-Path: <netdev+bounces-55109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2CB80969E
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 00:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7161C20B0A
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 23:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F0A57311;
	Thu,  7 Dec 2023 23:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRPnMDUi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE19510F9
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 15:33:59 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5d7a47d06eeso14298327b3.1
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 15:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701992039; x=1702596839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=slnotnDR17vicvjEUXM9keWAaM3TI39i0seWbBh11Mc=;
        b=cRPnMDUilGe/1HCqfUuWEcuV0W4pP9IbaBU7lKphsPhgv+eTBAHsZNqc6qmd+0C2GU
         3F2BhzaOadmXKp6SLoX8N1MH48IjU49TnsKZRm59k60PJ3yEkr9ZewntSI6e8rK786nz
         +9EBTkAJuFFG3vXaSrWh5qnemj2kPx9Yey9y+8zrttplP72QdVMqwJ2xD0B3QHEgNHcZ
         krz0pK3F3m1b4PMxeeMugozvo5dPewfkf3ZhEZ/npn84KAEd+RHdLU9P53mJHIkQTR9k
         80MBJmXrbLbOuN/17nt7Dqzi+i8R5vAeIBdSFjUhzPd/j2bSN6/7QFJ3OhlFMBFqpbLE
         ZgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701992039; x=1702596839;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=slnotnDR17vicvjEUXM9keWAaM3TI39i0seWbBh11Mc=;
        b=RP2DWBt8fhso4j/3/cXv6Qj55UnkrFSus7sH+lmiq2ONVq3jWD1kERvHYfoA3jYaUg
         BUFwuiKnskdIR0eZAl/caJ/4H1KILbaG9jpDeRh1tHBtJ9iBl6XGePn+LZuC6QEMBY+a
         KHrAX1m95DiUW+7ahJKmVUXKla8hb4RU4GdU6PbU77yrmT7NdNtZkQMrqTRZWi0bZfBD
         AnZxhP9ggeKWlfOL9SRTmg5L1Vdj51OjQqbSjpLCMS7dl3tDl8IU99tEluXLiBrrVgRk
         ERZsK9bY2+U6w2X3ikk+x6yyUp5R/CXjs1fK8qL/D8YLw2vReQJSxzRSoIesw2SqgrIt
         gWxA==
X-Gm-Message-State: AOJu0YzgUcUqMAosr7uHZw/we08KFrkFze0VPSpSf19GzlJqpUIAoFfO
	+UYXaqF1cz4owEo8edyRMQI=
X-Google-Smtp-Source: AGHT+IFjbX0EcCb7ZkpMpyc9lOj+zznPN+7qXfP9fEjHM0GvC4d1pXjuevPlniNzqIZ7cCzzGJyGhA==
X-Received: by 2002:a81:ce09:0:b0:5d7:1940:f3d9 with SMTP id t9-20020a81ce09000000b005d71940f3d9mr2855216ywi.65.1701992039010;
        Thu, 07 Dec 2023 15:33:59 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:57df:3a91:11ad:dcd? ([2600:1700:6cf8:1240:57df:3a91:11ad:dcd])
        by smtp.gmail.com with ESMTPSA id t123-20020a0dea81000000b005d878b0c26fsm252447ywe.3.2023.12.07.15.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 15:33:58 -0800 (PST)
Message-ID: <dbccbd5d-8968-43cb-9eca-d19cc12f6515@gmail.com>
Date: Thu, 7 Dec 2023 15:33:57 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/ipv6: insert the fib6 gc_link of a fib6_info
 only if in fib6.
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>, thinker.li@gmail.com,
 netdev@vger.kernel.org, martin.lau@linux.dev, kernel-team@meta.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: kuifeng@meta.com, syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com
References: <20231207221627.746324-1-thinker.li@gmail.com>
 <8f44514b-f5b4-4fd1-b361-32bb10ed14ad@kernel.org>
 <4eebd408-ee47-4ef0-bb72-0c7abad3eecf@kernel.org>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <4eebd408-ee47-4ef0-bb72-0c7abad3eecf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/7/23 15:20, David Ahern wrote:
> On 12/7/23 4:17 PM, David Ahern wrote:
>> On 12/7/23 3:16 PM, thinker.li@gmail.com wrote:
>>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>>
>>> Check f6i->fib6_node before inserting a f6i (fib6_info) to tb6_gc_hlist.
>>
>> any place setting expires should know if the entry is in a table or not.
>>
>> And the syzbot report contains a reproducer, a kernel config and other
>> means to test a patch.
>>
> 
> Fundamentally, the set and clear helpers are doing 2 things; they need
> to be split into separate helpers.

Sorry, I don't follow you.

There are fib6_set_expires_locked()) and fib6_clean_expires_locked(),
two separate helpers. Is this what you are saying?

Doing checks of f6i->fib6_node in fib6_set_expires_locked() should
already apply everywhere setting expires, right?

Do I miss anything?

