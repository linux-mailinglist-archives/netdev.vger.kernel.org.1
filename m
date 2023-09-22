Return-Path: <netdev+bounces-35750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 986797AAEBF
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 11:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id E8C7DB209F9
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 09:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB1E1E530;
	Fri, 22 Sep 2023 09:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBB91E527
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 09:50:20 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613EA195
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 02:50:15 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qjcnb-0000O5-6N; Fri, 22 Sep 2023 11:50:11 +0200
Message-ID: <bab8164c-f74f-44fe-ac3e-c078d30ab1e4@leemhuis.info>
Date: Fri, 22 Sep 2023 11:50:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Urgent Bug Report Kernel crash 6.5.2
Content-Language: en-US, de-DE
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Martin Zaharinov <micron10@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev <netdev@vger.kernel.org>, patchwork-bot+netdevbpf@kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>, kuba+netdrv@kernel.org,
 dsahern@gmail.com, Florian Westphal <fw@strlen.de>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Wangyang Guo <wangyang.guo@intel.com>,
 Arjan Van De Ven <arjan.van.de.ven@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux Regressions <regressions@lists.linux.dev>
References: <A416E134-BFAA-45FE-9061-9545F6DCC246@gmail.com>
 <CANn89iKXxyAQG-N+mdhNA8H+LEf=OK+goMFxYCV6yU1BpE=Xvw@mail.gmail.com>
 <BB129799-E196-428C-909D-721670DD5E21@gmail.com> <ZQqOJOa_qTwz_k0V@debian.me>
 <94BC75CD-A34A-4FED-A2EA-C18A28512230@gmail.com>
 <CANn89iKvv7F9G8AbYTEu7wca_SDHEp4GVTOEWk7_Yq0KFJrWgw@mail.gmail.com>
 <CANn89iJCJhJ=RWqPGkdbPoXhoa1W9ovi0s1t4242vsz-1=0WLw@mail.gmail.com>
 <85F1F301-BECA-4210-A81F-12CAEEC85FD7@gmail.com>
 <be58d429-90d1-42ff-a36b-da318db6ee68@gmail.com>
 <6A98504D-DB99-42A5-A829-B81739822CB2@gmail.com> <ZQ0EtyRxjzQTrPNd@debian.me>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZQ0EtyRxjzQTrPNd@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695376215;8675bce1;
X-HE-SMSGID: 1qjcnb-0000O5-6N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 22.09.23 05:06, Bagas Sanjaya wrote:
> On Thu, Sep 21, 2023 at 11:13:55AM +0300, Martin Zaharinov wrote:
>>
>> Its not easy to make this on production, have too many users on it.
>>
>> i make checks and find with kernel 6.3.12-6.5.13 all is fine.
>> on first machine that i have with kernel 6.4 and still work run kernel 6.4.2 and have problem.

This is confusing and hard to follow. You want to describe more
carefully which kernels worked (avoid ranges, as I doubt you have tested
everything between 6.3.12-6.5.13) and try to avoid complexity (you seem
to have two machines? if everything works on one, don't even bring it up
except maybe as a side note)

>> in my investigation problem is start after migration to kernel 6.4.x 
>>
>> in 6.4 kernel is add rcuref : 
>>
>> https://cdn.kernel.org/pub/linux/kernel/v6.x/ChangeLog-6.4 
>>
>> commit bc9d3a9f2afca189a6ae40225b6985e3c775375e
>> Author: Thomas Gleixner <tglx@linutronix.de>
>> Date: Thu Mar 23 21:55:32 2023 +0100
>>
>> net: dst: Switch to rcuref_t reference counting
> 
> Is it the culprit you look for? Had you done the bisection and it points
> the culprit to that commit

Martin, if you suspect this to be the culprit try to revert it on top of
the latest kernel; if the problem then goes away it likely is the cause.

> [...]
>> but this is my thinking
> 
> What do you think that above causes your regression?
> 
> Confused...
> 
> [To Thorsten: I'm unsure if the reporter do the bisection and suddenly he found
> the culprit commit. Should I add it to regzbot?

For now: no, things are too confusing and without knowing the culprit I
guess nobody will look into this unless we are extremely lucky.

Ciao, Thorsten




