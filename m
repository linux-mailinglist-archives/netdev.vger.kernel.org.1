Return-Path: <netdev+bounces-16724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A2874E867
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 09:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D091B281612
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 07:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55040174DA;
	Tue, 11 Jul 2023 07:51:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A120174C9
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 07:51:39 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A397E67
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 00:51:36 -0700 (PDT)
Message-ID: <275f1916-3f23-45e5-ae4d-a5d47e75e452@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1689061895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mSM1G7KgTgwYfNZgmLIgwm9P8ynrBtJCmKIcbX57WLc=;
	b=QFUoCaggx/dNO1IkZ0H5hnFmChP5SOyMfedqb6J+simMmBccz0567GdKWm+Zs49ScZWqEh
	XXzFMcwxwSoreYn8CNHmcBBubLWFpiFmDaxBVipoySvUGP/Z6e3kLHxtY0HCQ2gCVsB1QB
	hwiHM9dOQJrN652B7QdNOknTCQu3rWrXFsVruNFWR8GBijzvAe0P8AgynzjXJcjCiwBhWo
	VqvzznHRyUfmRBejBwPzEA51VAjpQvWHWNrIkwZsn3N/w3mn8MQ6KuIdb2SpeOuJAi/HTR
	oq+u/qoo+OKHokmDRnvLefU5+MAYTvwsf19tg7dbvgcvCKKQpRYuu3bdYvpaQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1689061895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mSM1G7KgTgwYfNZgmLIgwm9P8ynrBtJCmKIcbX57WLc=;
	b=tQEtaFakJB6R2wv3G4HZHy46vtRmIqNpgnae8XgUUwMUtodhyS0rdHye6UajzIl1Rx9zyC
	ildYqatHROx4hfAg==
Date: Tue, 11 Jul 2023 09:51:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, kurt@linutronix.de, vinicius.gomes@intel.com,
 muhammad.husaini.zulkifli@intel.com, tee.min.tan@linux.intel.com,
 aravindhan.gunasekaran@intel.com, sasha.neftin@intel.com,
 Naama Meir <naamax.meir@linux.intel.com>
References: <20230710163503.2821068-1-anthony.l.nguyen@intel.com>
 <20230710163503.2821068-2-anthony.l.nguyen@intel.com>
 <20230711070130.GC41919@unreal>
 <51f59838-8972-73c8-e6d2-83ad56bfeab4@linutronix.de>
 <20230711073201.GJ41919@unreal>
From: Florian Kauer <florian.kauer@linutronix.de>
Subject: Re: [PATCH net 1/6] igc: Rename qbv_enable to taprio_offload_enable
In-Reply-To: <20230711073201.GJ41919@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 11.07.23 09:32, Leon Romanovsky wrote:
> On Tue, Jul 11, 2023 at 09:18:31AM +0200, Florian Kauer wrote:
>> Hi Leon,
>>
>> On 11.07.23 09:01, Leon Romanovsky wrote:
>>> On Mon, Jul 10, 2023 at 09:34:58AM -0700, Tony Nguyen wrote:
>>>> From: Florian Kauer <florian.kauer@linutronix.de>
>>>>
>>>> In the current implementation the flags adapter->qbv_enable
>>>> and IGC_FLAG_TSN_QBV_ENABLED have a similar name, but do not
>>>> have the same meaning. The first one is used only to indicate
>>>> taprio offload (i.e. when igc_save_qbv_schedule was called),
>>>> while the second one corresponds to the Qbv mode of the hardware.
>>>> However, the second one is also used to support the TX launchtime
>>>> feature, i.e. ETF qdisc offload. This leads to situations where
>>>> adapter->qbv_enable is false, but the flag IGC_FLAG_TSN_QBV_ENABLED
>>>> is set. This is prone to confusion.
>>>>
>>>> The rename should reduce this confusion. Since it is a pure
>>>> rename, it has no impact on functionality.
>>>
>>> And shouldn't be sent to net, but to net-next.> 
>>> Thanks
>>
>> In principle I fully agree that sole renames are not intended for net.
>> But in this case the rename is tightly coupled with the other patches
>> of the series, not only due to overlapping code changes, but in particular
>> because the naming might very likely be one root cause of the regressions.
> 
> I understand the intention, but your second patch showed that rename was
> premature.
> 
> Thanks

The second patch does not touch the rename in igc.h and igc_tsn.c...
(and the latter is from the context probably the most relevant one)
But I see what you mean. I am fine with both squashing and keeping it separate,
but I have no idea how the preferred process is since this
is already so far through the pipeline...

Thanks,
Florian

