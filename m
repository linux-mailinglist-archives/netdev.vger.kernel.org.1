Return-Path: <netdev+bounces-15881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3867374A3D3
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 20:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E725D281414
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 18:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52558AD33;
	Thu,  6 Jul 2023 18:32:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4066815AE7
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 18:32:17 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9B11FD9
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 11:32:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1688668153; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=iBa/rYpTrhYcudjK231eDbysygTsl3c+WkEhTgyoKoThMY28w8DFhjnlehdJNGTr+P
    kbQLEnsGCMnGCmXGP+xvAdP9+vNHbExsZmLT0Ztek6jWX8AZ3wcrX7A17NVer1weT8l9
    MRc+/5x3B99Lxm2br11YIgUnBhYdaiGONCunPRwJLtseItYZw02b7PSmI8Ezot1PDpSO
    X6DPXFaVWgjeiZS+tIEQCAByQ/ScxmO1EToAEH/+2f99+FRMwiTxCuWaJsNzT3P9Vb7z
    zKYkZa68pnzalnZTqeI9zKSsGbJyTw/QSBO8tE0XCCtIU56MA/I5hQSxZ6eF6s8vsNM/
    qYiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1688668153;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=1NeheGUcAybSgshyvCWxGc+L75hjKHZwV+htD2/1P2c=;
    b=ElxXTxgubhGxQMVKe3zJFOpe5MtuhJdjQEy4O3TsG9rZtb1S6Te/MtQnxAS1xlnH+Z
    yOSwckGjJtdDK45dm644upWQEyFTWWcwU/nYVXI4EK7iSqfaZdj3FPzPddy4IDdFsrij
    Uo+65oFCTrBZ6qarJghpexVlcrJp18+HRHhrWlhde1FxyN3Jk3zTzjjuj+n92xQVk2es
    Zc241VwvDhH0SULwsUf2jYa93UdSOroKFfik5ApCdUWdCgH5//NVvIwR6zBeFlC2Z68g
    JiAttaDDGJPwBOJYKwc9d9hrljVJ8vJRYN1VWJeU/giVp8b+7S1M2RUVPGp94GSj+pYl
    4npw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1688668153;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=1NeheGUcAybSgshyvCWxGc+L75hjKHZwV+htD2/1P2c=;
    b=LrVvc9EJbH7RkfVN5NaIAR5+T223/4RkeS1e9/aSrOmKKiveudGH5WVnqqdO3Tl9Yx
    +nduGBkiChvmQopZlZpR8l/I98EPOZCWULNzNbJ8BLPENJ2hNjd+qXoxvx4GyCRPjVSR
    9MpG+B1Pl+IGPKM23Fn6x2ZxqnPtjwNxyvSg/ebFOm2FgDCH+OoFEqt9aXqjwlGhTft+
    lvYo3r9NZ7dDgw3QPNaaQ1jD48p9TdntSFvDTHCwYtcBX72U6tdBUzJLZIuPQZux1OyB
    RWuYQnXpgV8U8yDVDsij+YyejMvQwXmiUEpQWD1QHMktLZmrQUMK+R4vw263OdkzCu9W
    NxuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1688668153;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=1NeheGUcAybSgshyvCWxGc+L75hjKHZwV+htD2/1P2c=;
    b=hCIsOnMMG4pcUFQCAgXcjv8i/5koYLQwnJidKaHu3zpF7Uka4Xehk8j7EtyKZSzW4P
    0lUSwwG5hVgXja+oG7AQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDUQnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::923]
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id J16f43z66ITCEfC
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 6 Jul 2023 20:29:12 +0200 (CEST)
Message-ID: <2a035aab-d10a-bb6f-d056-ea93c454a51d@hartkopp.net>
Date: Thu, 6 Jul 2023 20:29:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net] can: raw: fix receiver memory leak
To: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>,
 mkl@pengutronix.de, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp
References: <20230705092543.648022-1-william.xuanziyang@huawei.com>
 <2aa65b0c-2170-46c0-57a4-17b653e41f96@hartkopp.net>
 <4880eff5-1009-add8-8c58-ac31ab6771db@huawei.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <4880eff5-1009-add8-8c58-ac31ab6771db@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 06.07.23 14:48, Ziyang Xuan (William) wrote:

(..)

>>>        }
>>>       out:
>>>        release_sock(sk);
>>> +    rtnl_unlock();
>>
>> Would it also fix the issue when just adding the rtnl_locks to raw_bind() and raw_release() as suggested by you?
> 
> This patch just add rtnl_lock in raw_bind() and raw_release(). raw_setsockopt() has rtnl_lock before this. raw_notify()
> is under rtnl_lock. My patch has been tested and solved the issue before send. I don't know if it answered your doubts.

My question was whether adding rtnl_locks to raw_bind() and 
raw_release() would be enough to fix the issue.

Without introducing the additional ro->dev element!?

Best regards,
Oliver

