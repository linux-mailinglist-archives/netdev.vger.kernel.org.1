Return-Path: <netdev+bounces-57845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D488144E9
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 10:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959371F24201
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 09:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5517618AF4;
	Fri, 15 Dec 2023 09:55:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5939C18AEE;
	Fri, 15 Dec 2023 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rE4uM-0002VP-Tt; Fri, 15 Dec 2023 10:55:03 +0100
Message-ID: <cdf72778-a314-467d-8ac8-163d2007fd70@leemhuis.info>
Date: Fri, 15 Dec 2023 10:55:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Bug report connect to VM with Vagrant
Content-Language: en-US, de-DE
To: Eric Dumazet <edumazet@google.com>, Shachar Kagan <skagan@nvidia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "kuba@kernel.org" <kuba@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>, Ido Kalir <idok@nvidia.com>,
 Topaz Uliel <topazu@nvidia.com>, Shirly Ohnona <shirlyo@nvidia.com>,
 Ziyad Atiyyeh <ziyadat@nvidia.com>
References: <MN2PR12MB44863139E562A59329E89DBEB982A@MN2PR12MB4486.namprd12.prod.outlook.com>
 <CANn89iKvG5cTNROyBF32958BzATfXysh4zLk5nRR6fgi08vumA@mail.gmail.com>
 <MN2PR12MB4486457FC77205D246FC834AB98BA@MN2PR12MB4486.namprd12.prod.outlook.com>
 <CANn89i+e2TcvSU1EgrVZRUoEmZ5NDauXd3=kEkjpsGjmaypHOw@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <CANn89i+e2TcvSU1EgrVZRUoEmZ5NDauXd3=kEkjpsGjmaypHOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1702634106;f996b060;
X-HE-SMSGID: 1rE4uM-0002VP-Tt

On 08.12.23 11:49, Eric Dumazet wrote:
> On Thu, Dec 7, 2023 at 2:03 PM Shachar Kagan <skagan@nvidia.com> wrote:
>>>> On Thu, Nov 30, 2023 at 2:55 PM Shachar Kagan <skagan@nvidia.com> wrote:
>>>>
>>>> I have an issue that bisection pointed at this patch:
>>>> commit 0a8de364ff7a14558e9676f424283148110384d6
>>>> tcp: no longer abort SYN_SENT when receiving some ICMP
>>>
>>> Please provide tcpdump/pcap captures.
>>>
>>>  It is hard to say what is going on just by looking at some application logs.
>>
>> I managed to capture the tcpdump of ‘Vagrant up’ step over old kernel and new kernel where this step fails. Both captures are attached.
>> The tcpdump is filtered by given IP of the nested VM.
> 
> I do not see any ICMP messages in these files, can you get them ?
> 
> Feel free to continue this exchange privately, no need to send MB
> email to various lists.

Here this thread died, so I assume this turned out to be not a
regression at all or something like that? If not please speak up!

#regzbot inconclusive: radio silence

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

