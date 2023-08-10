Return-Path: <netdev+bounces-26242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3596C7774E6
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 11:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02991C21446
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 09:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBD21EA94;
	Thu, 10 Aug 2023 09:51:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7A91EA87
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 09:51:44 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABB9212B
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 02:51:43 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe5c0e587eso6566765e9.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 02:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691661101; x=1692265901;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=59/x4KHCPdPrsos6hNP/XWr2AeXg5zeVnD/4XtP2tqk=;
        b=ije3nlhOpfwAvUDqB+H6Hq9ZfAUtO7vT50r8NtYEiWFqXAGP2AQymtsMK/vstqC0sZ
         erEzeKcP0HP/RiKIk6WXE6R/iQflY10fYF6/L5tWZduBLRJHq40pWxSL/WnN8lp5zXic
         QNVcmgXMNnEOBPEW2pccB9vNqeSkWjY+et68yoyR1G2qnmKZv59tOp+kMxUdDcpZvLKJ
         u0gP+sD0WTu60LJ/p671Zjkogei5ghBBKBPvHC+mUrJghSc/RfnPNLdiIvI+zmPWUbV+
         WLJnoTuJsda19jU9mR5cX8h+FWmpyrgtt1JZIXeW+3tOmiURx7JgU67u+ucyu4D4tWLz
         S6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691661101; x=1692265901;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=59/x4KHCPdPrsos6hNP/XWr2AeXg5zeVnD/4XtP2tqk=;
        b=S8edZMtQcwZK98ToGknfPkG9IwVAdLen4vc6Z0Qc4L7tMmEufYZN2CduAiMq978vXX
         NQhBNULzTUxd2iCkb+cGQNFzUOOZ8xA1zKEv1VPBzd5uGKPZ8Cem4tmjOFRtK7DDAG4k
         KKlXjttco7g4qc195vgQ08GwvySv/Owsy/q30Bse14gDHERLOQ6FWrCUiY8ZyJ2iOjm6
         N+swsVJ9JnS3OutrWeHJOnYsr3JAxtleTVWhZFzizqXDN5glla3Q5BvFGHAV6+6ZAvO3
         wMat4ehb7uDJUm9pmwFu1BY9yuhmePQm1dTsZZwZaC3tJ+uzInT9WIqrLVqVPvEx8+7d
         hmxw==
X-Gm-Message-State: AOJu0YwOk88yorYu62shKX/y/0LFJZWIUXbs3j4Brx+cVnEzzPgox4eB
	+LWyt7EUQBLARxcnSn6W8woirg==
X-Google-Smtp-Source: AGHT+IFGjzD1FeswWe5CtwueFCkSDyNERaZBnLUD/vjFu5Xsl/a7CkiROGYuzHVXAvfy3oZ4Kypozg==
X-Received: by 2002:a7b:cb97:0:b0:3fb:a100:2581 with SMTP id m23-20020a7bcb97000000b003fba1002581mr1708092wmi.14.1691661101419;
        Thu, 10 Aug 2023 02:51:41 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:99e1:a167:6a5a:9487? ([2a02:578:8593:1200:99e1:a167:6a5a:9487])
        by smtp.gmail.com with ESMTPSA id n24-20020a7bcbd8000000b003fbb0c01d4bsm1603826wmi.16.2023.08.10.02.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 02:51:40 -0700 (PDT)
Message-ID: <05c9cfb7-c704-4b72-8fa3-d280dae80c09@tessares.net>
Date: Thu, 10 Aug 2023 11:51:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 mptcp-next] mptcp: Remove unnecessary test for
 __mptcp_init_sock().
Content-Language: en-GB
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 Mat Martineau <martineau@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, mptcp@lists.linux.dev,
 netdev@vger.kernel.org
References: <20230809225918.21523-1-kuniyu@amazon.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <20230809225918.21523-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Kuniyuki,

On 10/08/2023 00:59, Kuniyuki Iwashima wrote:
> __mptcp_init_sock() always returns 0 because mptcp_init_sock() used
> to return the value directly.
> 
> But after commit 18b683bff89d ("mptcp: queue data for mptcp level
> retransmission"), __mptcp_init_sock() need not return value anymore.
> 
> Let's remove the unnecessary test for __mptcp_init_sock() and make
> it return void.

Thank you for your patch, it looks good to me!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

As the CI said (on MPTCP ML only), there is a conflict with another
patch already in MPTCP tree that is going to be sent later. But that's
fine, no need to rebase, it is fine to apply your patch as it is in our
tree before the other patch and modify the latter one to avoid
compilation issue.

So just to be clear, I just applied this patch in MPTCP tree and we will
send it to Netdev later. I hope it is OK if I change the Patchwork
status to "Deferred". (If it is the correct status because it looks like
the "Handled Elsewhere" status is not used in Netdev PW and the bot
doesn't support it).

pw-bot: defer


New patches for t/upstream:
- 769fb24aa39c: mptcp: Remove unnecessary test for __mptcp_init_sock()
- 1ba457522bce: mptcp: fix compilation issue in "mptcp: add sched in
mptcp_sock"
- Results: 3a7cf9f5d51c..649448c9126d (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230810T092803

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

