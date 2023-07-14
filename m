Return-Path: <netdev+bounces-17815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF327531F4
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 08:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FDFF2820F1
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 06:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D8D3FC2;
	Fri, 14 Jul 2023 06:30:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BCD6FD2
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 06:30:12 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A728310D4
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 23:30:11 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qKCJY-0005eS-8P; Fri, 14 Jul 2023 08:30:04 +0200
Message-ID: <fff3067d-5a7f-b328-ef65-fa68138f8b0f@leemhuis.info>
Date: Fri, 14 Jul 2023 08:30:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net] r8169: fix ASPM-related problem for chip version 42
 and 43
Content-Language: en-US, de-DE
To: Heiner Kallweit <hkallweit1@gmail.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, joey.joey586@gmail.com
References: <82ea9e63-d8c8-0b86-cd88-913cc249fa9a@gmail.com>
 <d644f048-970c-71fe-a556-a2c80444dae2@leemhuis.info>
 <17c638ca-5343-75e0-7f52-abf86026f75d@gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <17c638ca-5343-75e0-7f52-abf86026f75d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1689316211;37d37d2b;
X-HE-SMSGID: 1qKCJY-0005eS-8P
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 14.07.23 07:34, Heiner Kallweit wrote:
> On 14.07.2023 05:31, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 13.07.23 21:46, Heiner Kallweit wrote:
>
>>> Fixes: 5fc3f6c90cca ("r8169: consolidate disabling ASPM before EPHY access")
>>  Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217635 # [0]
>> A "Cc: stable@vger.kernel.org" would be nice, too, to get this fixed in
>> 6.4, where this surfaced (reminder: no, a Fixes: tag is not enough to
>> ensure the backport there).
> That's different in the net subsystem. The net (vs. net-next) annotation
> ensures the backport.

Huh, how does that work? I thought "net" currently means "for 6.5" while
"net-next" implies 6.6?

Ciao, Thorsten

