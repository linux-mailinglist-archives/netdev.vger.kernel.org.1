Return-Path: <netdev+bounces-17060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B99474FFC0
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 08:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73912281759
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 06:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB97620FD;
	Wed, 12 Jul 2023 06:53:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD2720F2
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 06:53:50 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22D81711
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 23:53:48 -0700 (PDT)
Message-ID: <7c638163-38dc-ac9e-3d90-54a3491f3396@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1689144826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jvptVGyOtVH8eS44pCZCG/LAA/7E7Pw46vYNpHJdvFo=;
	b=PUE+8VH7a4wgDNjY3IyefLOUrVibOa5XakUJ0WC+ZMmI7TEB8pWJUU2Y2YNhijUpPGieGs
	YLB4VFHX3a6wqurV/t81lQ0YV11S27aFRaNoAAQtp52ermKHWssE1uFqXg1DymQyDE5SR0
	I3X9WmK3dSJD2USLIkC+97L07RPlUg3+9kqC449Puwm9511aknDow/zQMIcMWFNx2IODvD
	QGsplW8gN06+GFjsyLttm3pageQLVTVU6a8fFYli/NvTkl90o6JvCc4jdluJ2OSsUwWV5l
	S+l+zvDJU65M9WvfLNSm8xb6tQEdwEVuFADPAajwTpXEJmfNt0V2O4+Elb/pvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1689144826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jvptVGyOtVH8eS44pCZCG/LAA/7E7Pw46vYNpHJdvFo=;
	b=pUu4aERaTr48h/27Oy3ccM0dp38DkkBybV2W/6gxbCNhiLamQFpEiR9fsWqy/IcxRGIWm+
	StOPSr0YlAHAzNAg==
Date: Wed, 12 Jul 2023 08:53:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org,
 kurt@linutronix.de, vinicius.gomes@intel.com,
 muhammad.husaini.zulkifli@intel.com, tee.min.tan@linux.intel.com,
 aravindhan.gunasekaran@intel.com, sasha.neftin@intel.com,
 Naama Meir <naamax.meir@linux.intel.com>
References: <20230710163503.2821068-1-anthony.l.nguyen@intel.com>
 <20230710163503.2821068-2-anthony.l.nguyen@intel.com>
 <20230711070130.GC41919@unreal>
 <51f59838-8972-73c8-e6d2-83ad56bfeab4@linutronix.de>
 <20230711073201.GJ41919@unreal>
 <275f1916-3f23-45e5-ae4d-a5d47e75e452@linutronix.de>
 <20230711175825.0b6dbbcd@kernel.org>
From: Florian Kauer <florian.kauer@linutronix.de>
Subject: Re: [PATCH net 1/6] igc: Rename qbv_enable to taprio_offload_enable
In-Reply-To: <20230711175825.0b6dbbcd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jakub,

On 12.07.23 02:58, Jakub Kicinski wrote:
> On Tue, 11 Jul 2023 09:51:34 +0200 Florian Kauer wrote:
>>> I understand the intention, but your second patch showed that rename was
>>> premature.
> 
> I think it's fine. It's a rename, it can't regress anything.
> And the separate commit message clearly describing reasoning
> is good to have.
> 
>> The second patch does not touch the rename in igc.h and igc_tsn.c...
>> (and the latter is from the context probably the most relevant one)
>> But I see what you mean. I am fine with both squashing and keeping it separate,
>> but I have no idea how the preferred process is since this
>> is already so far through the pipeline...
> 
> "This is so far through the pipeline" is an argument which may elicit 
> a very negative reaction upstream :)

Sorry, I didn't mean to use that as an argument to push it through.
It is just that since this is my first patch series (except a small
contribution some years ago), I just honestly do not know what the
usual practice in such a situation would be.

E.g. if I would just send a new version and if yes, which tags I would
keep since it would just be a squash. Especially, if it needs to be
retested. Or if Tony would directly squash it on his tree, or...

I personally would have no problem with doing extra work if it improves
the series, I just do not want to provoke unnecessary work or confusion
for others by doing it in an unusual way.

Greetings,
Florian

