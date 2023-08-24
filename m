Return-Path: <netdev+bounces-30257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4207869DC
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 10:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88EE28149C
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 08:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3FFAD38;
	Thu, 24 Aug 2023 08:19:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D013AAD33
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 08:19:07 +0000 (UTC)
Received: from anon.cephalopo.net (anon.cephalopo.net [128.76.233.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C5A171C
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 01:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lagy.org; s=def2;
	t=1692864192; bh=9x1Vux2ulNAysitgAgSLt1UJDWzyCDuaN37yMWaMqDc=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=tTH4MJXQ9ONzvrGo7SwvfSt0sjy1eXKABgsI9Ycof/kRIEMlrxA7jSVlP7m58EhGK
	 oAyARmpgZIOlsy1GXW2ZuKK9MiuiM6bVnCrRfmcX8vywwo55vEbQJTBNMvmRDymTd5
	 ECSQ90vkZYkQlTALns7WA4G51od0ZTktqdsLJxtrubQB5MlDkrR9CRp/L8pIbrluxx
	 Q7i3s9fviBLDoCpGji/pq6dBqxS9AZmc/aZRBU6aQubasK68AFbXW+2bdLMZesgp/C
	 VFbCFt6gSWikjgUTfJnDC+jut8SFlrecbttMwvrtQQiBnwjbHlYXfrk5SOk2aTV3G7
	 9T6FyBxbAMRzQ==
Authentication-Results: anon.cephalopo.net;
	auth=pass smtp.auth=u1 smtp.mailfrom=me@lagy.org
Received: from localhost (unknown [109.70.55.226])
	by anon.cephalopo.net (Postfix) with ESMTPSA id 1093E11C00BE;
	Thu, 24 Aug 2023 10:03:12 +0200 (CEST)
References: <87zg30a0h9.fsf@lagy.org> <20230809125805.2e3f86ac@kernel.org>
 <87fs489agk.fsf@lagy.org> <ad71f412-e317-d8d0-5e9d-274fe0e01374@gmail.com>
User-agent: mu4e 1.8.13; emacs 29.1
From: Martin =?utf-8?Q?Kj=C3=A6r_J=C3=B8rgensen?= <me@lagy.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, Jakub Kicinski <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: r8169 link up but no traffic, and watchdog error
Date: Thu, 24 Aug 2023 10:01:13 +0200
In-reply-to: <ad71f412-e317-d8d0-5e9d-274fe0e01374@gmail.com>
Message-ID: <87bkew98ai.fsf@lagy.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On Thu, Aug 24 2023, Heiner Kallweit <hkallweit1@gmail.com> wrote:

> On 18.08.2023 13:49, Martin Kj=C3=A6r J=C3=B8rgensen wrote:
>>
>> On Wed, Aug 09 2023, Jakub Kicinski <kuba@kernel.org> wrote:
>>
>>>
>>> There were some fix in r8169 for power management changes recently.
>>> Could you try the latest stable kernel? 6.4.9 ?
>>>
>>
>> I have just upgraded to latest Debian testing kernel (6.4.0-3-amd64 #1 S=
MP
>> PREEMPT_DYNAMIC Debian 6.4.11-1) but it doesn't seem to make much
>> difference. I can trigger the same issue again, and get similar kernel e=
rror
>> as before:
>>


> From the line above it's not clear which kernel version is used. Best tes=
t with a
> self-compiled mainline kernel.
>

It should be based on 6.4.11 , but I can try with a self-compiled version t=
oo.

>
> Please test also with the different ASPM L1 states disabled, you can use =
the sysfs
> attributes under /sys/class/net/enp3s0/device/link/ for this.
>

I will try that.


> Best bisect between last known good kernel and latest 6.4 version.
>

I do not know of any working version. My machine/system have had this behav=
ior
ever since I've got it. At least for 9 months ...

