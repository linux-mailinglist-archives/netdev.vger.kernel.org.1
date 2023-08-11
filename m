Return-Path: <netdev+bounces-26703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B067789FC
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 11:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70728282136
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EC763D6;
	Fri, 11 Aug 2023 09:30:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1971163A3
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 09:30:51 +0000 (UTC)
Received: from out-108.mta0.migadu.com (out-108.mta0.migadu.com [91.218.175.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1364A2D5B
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 02:30:49 -0700 (PDT)
Message-ID: <8d52ab61-e532-0ef8-4227-ea1ab469f4cb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691746247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZUyYZ+8XJKTUbZKK1DdFQCGq8cNFYsFwnq8YwkTDfs=;
	b=GxU9QjIRAA/RVyaUj1LaqCJKMOW/MhFBn7HuPQpEBaRlc0/os4PZM4k8PctvTdV7pEAoit
	sd1dFvUpsQz3nw3NVmf7QCM1FNKzCmMtDo//9eCKoYRlJZ/7qlzkuUvSisYCAl8riGEODZ
	YMhbjwuujNIc9Px/jlE4XGJ9iWNOP5U=
Date: Fri, 11 Aug 2023 10:30:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 6/9] ice: add admin commands to access cgu
 configuration
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Milena Olech <milena.olech@intel.com>,
 Michal Michalik <michal.michalik@intel.com>,
 linux-arm-kernel@lists.infradead.org, poros@redhat.com, mschmidt@redhat.com,
 netdev@vger.kernel.org, linux-clk@vger.kernel.org,
 Bart Van Assche <bvanassche@acm.org>, intel-wired-lan@lists.osuosl.org
References: <20230809214027.556192-1-vadim.fedorenko@linux.dev>
 <20230809214027.556192-7-vadim.fedorenko@linux.dev>
 <20230810192102.2932d58f@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230810192102.2932d58f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 11/08/2023 03:21, Jakub Kicinski wrote:
> On Wed,  9 Aug 2023 22:40:24 +0100 Vadim Fedorenko wrote:
>> From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>
>> Add firmware admin command to access clock generation unit
>> configuration, it is required to enable Extended PTP and SyncE features
>> in the driver.
>> Add definitions of possible hardware variations of input and output pins
>> related to clock generation unit and functions to access the data.
> 
> Doesn't build, but hold off a little with reposting, please hopefully
> I'll have more time tomorrow to review.

Yeah, we've found the issue already and Arkadiusz has prepared a patch
to fix it. I can do the repost once you are ok to review.

