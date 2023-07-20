Return-Path: <netdev+bounces-19531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E8C75B1CA
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 16:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE6B1C2147E
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 14:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDBC18AEE;
	Thu, 20 Jul 2023 14:54:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D71171A9
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 14:54:40 +0000 (UTC)
X-Greylist: delayed 363 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Jul 2023 07:54:36 PDT
Received: from out-18.mta1.migadu.com (out-18.mta1.migadu.com [95.215.58.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A922704
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 07:54:36 -0700 (PDT)
Message-ID: <e4531880-7904-114e-9d4d-24b4a77a3565@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1689864511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PqpxIaHBRk8xxnz7Hdg9ZoxK/nTzDsDxJQBDdoeP+q0=;
	b=wKkmkI7zWECYryWudv8WwXejFM9fQVXOYPItQC7Vr2+bUrtnphnf/7+MnLeelaJoddxerT
	G3x/jZXMDwU0LYiaVKPG7MaIONfFPw6eNZmiwlewAH42RXBuzIU7xgQlce228EOuW4bZCL
	tjLZgZ7MLhEA2s8gn6octroI1IJTY7g=
Date: Thu, 20 Jul 2023 15:48:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 01/11] tools: ynl-gen: fix enum index in
 _decode_enum(..)
Content-Language: en-US
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 "Olech, Milena" <milena.olech@intel.com>,
 "Michalik, Michal" <michal.michalik@intel.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>,
 mschmidt <mschmidt@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Bart Van Assche <bvanassche@acm.org>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
 <20230720091903.297066-2-vadim.fedorenko@linux.dev>
 <ZLk5MMjChnRFNU49@nanopsycho>
 <DM6PR11MB46577F18C3C4229FEC00D7DA9B3EA@DM6PR11MB4657.namprd11.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <DM6PR11MB46577F18C3C4229FEC00D7DA9B3EA@DM6PR11MB4657.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 20.07.2023 14:58, Kubalewski, Arkadiusz wrote:
>> -----Original Message-----
>> From: Jiri Pirko <jiri@resnulli.us>
>> Sent: Thursday, July 20, 2023 3:40 PM
>>
>> Thu, Jul 20, 2023 at 11:18:53AM CEST, vadim.fedorenko@linux.dev wrote:
>>> From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>
>>> Remove wrong index adjustement, which is leftover from adding
>>
>> s/adjustement/adjustment/
>>
> 
> Sure will fix,
> Although those "tools: ynl" patches were not intended to be a part of dpll
> Series, they are being discussed on the other thread:
> https://lore.kernel.org/netdev/20230718162225.231775-1-arkadiusz.kubalewski@intel.com/
> 
> I think Vadim have sent them, because I included them in the branch candidate
> for next version, seems was not clear enough on that..
> I think we can skip them for next submission.

Yeah, I just realised that these patches have been sent earlier as separate
series and are still under review. Once they are committed I'll remove them
from DPLL series, but for now they are needed for spec generation of DPLL
yaml, so it's good to have them anyway.

> Thank you!
> Arkadiusz
> 
>>
>>> support for sparse enums.
>>> enum.entries_by_val() function shall not subtract the start-value, as
>>> it is indexed with real enum value.
>>>
>>> Fixes: c311aaa74ca1 ("tools: ynl: fix enum-as-flags in the generic
>>> CLI")
>>> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>
>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> 


