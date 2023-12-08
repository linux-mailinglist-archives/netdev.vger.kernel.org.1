Return-Path: <netdev+bounces-55397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AD480ABF3
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 19:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398C01C2096C
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 18:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B9147A53;
	Fri,  8 Dec 2023 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="illhEbZD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4656F19A4
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 10:20:36 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5d7a47d06eeso23031327b3.1
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 10:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702059635; x=1702664435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3+stFk45P4mX0uCydM2OcHvjKLv55UJK/nYdB4eIGjE=;
        b=illhEbZDziVK3QjR6Q7vVjUm3dFMADtdZAM/6WyTdWtbdQkTY/UeMXAbw7Vt82kqaY
         FSIjCYKkWewLBG1mtTUOOoluWrcMcgywvrPuXLPdqcyeYe7YQGFWPHCXdDU4RIb+Zv6+
         RMD7if50heRD0TQzDdJ21f4ijFx8VaVqnoim8cHH6hPzMxvwjAxXQOH4cmEzZXUO82D7
         e8hMOH2o13j6pE+AZkgODIfjY9aTwuCKm62VrN4yKSoX90sdil34PnqGiJzhI38y0ASg
         OGxnDpskFR9rZ14QbUvHZu9631KN2GWi1ipdUVvqfA64ZSNOkPT9R5/DTBjNqC/JVL36
         uwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702059635; x=1702664435;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+stFk45P4mX0uCydM2OcHvjKLv55UJK/nYdB4eIGjE=;
        b=oTbNzVPVEJRQ/Cc0xIb20f4QReYjU3I6EmE4GFo8OxHL/qMnQ5ZKHz8QFSvF71o1ZR
         mKEQ0hzfZhe2GBBmiadtYZKa7HmaITnj0a0fQhF6oee4W633JW4NfA9BCtz4SriYkvFT
         JHztY+GJP7DrIOsuokjprhq3b/xvj/GvF1MnM+oMDQsXcEYcqR/wxT8NM5i38fXlDKQS
         t0pt2F+DtyS/300r62Z2adOOWtxGZP9H6v4HIstWtDJJ/xfTlqYvOqmG+4vwE4zXK8b+
         ySqYvI8E7hSHUhxRVgtRj4q7AQ1iJeU52WO+ULJmrBXpvGMX+xWkysUQwdTenw6TNwcg
         zCOQ==
X-Gm-Message-State: AOJu0YxJlvt7Rbcv3+eOJr8PeQwaWs3xL5JnsT4Uyy1wpRgGWtiTeNl+
	xSlMN8/Do2eSXIqfx+QBGho=
X-Google-Smtp-Source: AGHT+IHwWDuHdhNyIsLKa46LS8v55SHLyjuygSgJUs4usrosCse4wV87dftmVBZjYEC1+HzR4EC91w==
X-Received: by 2002:a0d:d8d0:0:b0:5de:a315:b727 with SMTP id a199-20020a0dd8d0000000b005dea315b727mr402668ywe.25.1702059635273;
        Fri, 08 Dec 2023 10:20:35 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:65fe:fe26:c15:a05c? ([2600:1700:6cf8:1240:65fe:fe26:c15:a05c])
        by smtp.gmail.com with ESMTPSA id r190-20020a0de8c7000000b005d33b03acd1sm839974ywe.39.2023.12.08.10.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 10:20:34 -0800 (PST)
Message-ID: <8d5af093-54d2-48b3-9753-cc1684598934@gmail.com>
Date: Fri, 8 Dec 2023 10:20:33 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: add debug checks in fib6_info_release()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20231205173250.2982846-1-edumazet@google.com>
 <2133401f-2ba5-42eb-9158-dcc74db744f5@gmail.com>
 <CANn89iKTLoBUkOyNnRy486n3HEUKoeFmA90TDc2xiWunK6n_Fg@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CANn89iKTLoBUkOyNnRy486n3HEUKoeFmA90TDc2xiWunK6n_Fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/8/23 01:18, Eric Dumazet wrote:
> On Fri, Dec 8, 2023 at 12:02 AM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>
>> Hi Eric, could you also open a bug for this incident?
> 
> What are you asking for exactly ?
> 
> We have thousands of syzbot bugs, it is done by a bot, not a human.

You mentioned "let me release the bug." [1] Then we have [2].

By the way, although I am not fixing the issue described by [2],
I am using that email to talk with syzbot.

[1] 
https://lore.kernel.org/all/CANn89iKpM33oQ+2dwoLHzZvECAjwiKJTR3cDM64nE6VvZA99Sg@mail.gmail.com/
[2] https://lore.kernel.org/all/000000000000cb5b07060bef7ac0@google.com/

