Return-Path: <netdev+bounces-31952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FCA791A96
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 17:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF241C204D6
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 15:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79E2C14D;
	Mon,  4 Sep 2023 15:26:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB693D8B
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 15:26:07 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DB5CCC
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 08:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693841165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qn0Q7H7evoRHH4Nj4axR0mmpgO4f23pEiMyC9/o6s5w=;
	b=U0xQqTSNVBNeBzoeKckde4un3INeNJhDlCJDNARQWwQHpAG3ZW43HyCY9o9vjIGfEBbr5v
	iSO+S+Npks6P1FLUXf15liCASjzu+RrXzQvSP11mMOiYR0lIT1rRsPTrPCtfFo7fKA7kTk
	LC49E+CAI6E6veqksyXBuaz/gdP8sXk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-38-9jhrxafXNFKPiZSlWo4y5A-1; Mon, 04 Sep 2023 11:25:59 -0400
X-MC-Unique: 9jhrxafXNFKPiZSlWo4y5A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDDCA868012;
	Mon,  4 Sep 2023 15:25:58 +0000 (UTC)
Received: from [10.22.8.119] (unknown [10.22.8.119])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 28049200A86A;
	Mon,  4 Sep 2023 15:25:58 +0000 (UTC)
Message-ID: <c98e6c5b-d334-075f-71b8-1c2a3b73b205@redhat.com>
Date: Mon, 4 Sep 2023 11:25:57 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: ARM BCM53573 SoC hangs/lockups caused by locks/clock/random
 changes
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Florian Fainelli
 <f.fainelli@gmail.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: openwrt-devel@lists.openwrt.org, bcm-kernel-feedback-list@broadcom.com
References: <a03a6e1d-e99c-40a3-bdac-0075b5339beb@gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <a03a6e1d-e99c-40a3-bdac-0075b5339beb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 9/4/23 04:33, Rafał Miłecki wrote:
> As those hangs/lockups are related to so many different changes it's
> really hard to debug them.
>
> This bug seems to be specific to the slow arch clock that affects
> stability only when kernel locking code and symbols layout trigger some
> very specific timing.
>
> Enabling CONFIG_PROVE_LOCKING seems to make issue go away but it affects
> so much code it's hard to tell why it actually matters.
>
> Same for disabling CONFIG_SMP. I noticed Broadcom's SDK keeps it
> disabled. I tried it and it improves stability (I had 3 devices with 6
> days of uptime and counting) indeed. Again it affects a lot of kernel
> parts so it's hard to tell why it helps.
>
> Unless someone comes up with some magic solution I'll probably try
> building BCM53573 images without CONFIG_SMP for my personal needs.

All the locking operations rely on the fact that the instruction to 
acquire or release a lock is atomic. Is it possible that it may not be 
the case under certain circumstances for this ARM BCM53573 SoC? Or maybe 
some Kconfig options are not set correctly like missing some errata that 
are needed.

I don't know enough about the 32-bit arm architecture to say whether 
this is the case or not, but that is my best guess.

Cheers,
Longman


