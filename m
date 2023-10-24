Return-Path: <netdev+bounces-43841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11B97D4FCF
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 14:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E5C11C20B3D
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 12:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792A41C20;
	Tue, 24 Oct 2023 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACE5273D9
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 12:32:47 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7F390;
	Tue, 24 Oct 2023 05:32:46 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qvGaR-0007R8-2s; Tue, 24 Oct 2023 14:32:43 +0200
Message-ID: <c36ebd70-0b2c-487f-a7ef-d13256f68c5c@leemhuis.info>
Date: Tue, 24 Oct 2023 14:32:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: kernel tried to execute NX-protected page - exploit attempt?
 (uid: 0) (qbittorrent with tx-nocache-copy)
Content-Language: en-US, de-DE
To: Eric Dumazet <edumazet@google.com>, Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Networking <netdev@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 "David S. Miller" <davem@davemloft.net>, Benjamin Poirier
 <bpoirier@suse.de>, Tom Herbert <therbert@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, CM76 <cmaff76@gmail.com>
References: <2bf06faa-a0a7-4dee-90cd-a054b4e4c947@gmail.com>
 <17a017b9-9807-48ef-bc7b-be8f5df750c5@gmail.com>
 <CANn89iJxCqGeEM2sJbs8TU00Rj-iddoyoabvB7x4eEaPwCKTMA@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CANn89iJxCqGeEM2sJbs8TU00Rj-iddoyoabvB7x4eEaPwCKTMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1698150766;a946f30f;
X-HE-SMSGID: 1qvGaR-0007R8-2s

On 24.10.23 11:25, Eric Dumazet wrote:
> On Tue, Oct 24, 2023 at 10:53 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>
>> On 24/10/2023 15:15, Bagas Sanjaya wrote:
>>>
>>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>>> I believe this is also an issue with the Broadcom bnx2 drivers since it only seem to happen when I enable "tx-nocache-copy" in ethtool.
>>[...]
>> Thanks.
>
> This has been fixed already two weeks ago.
> 
> commit 71c299c711d1f44f0bf04f1fea66baad565240f1

Eric, thx for letting us know!

#regzbot fix: 71c299c711d1f44f0

Bagas, maybe in a case like this wait with forwarding the report until
the reporter confirmed that the bug happens with a really fresh kernel.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.



