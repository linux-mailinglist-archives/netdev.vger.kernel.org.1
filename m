Return-Path: <netdev+bounces-41066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41097C9840
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 09:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07B93B20B78
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 07:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029031FC2;
	Sun, 15 Oct 2023 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ZVOR5zlD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6600185F
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 07:21:06 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FEFDA
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 00:21:03 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id rvQlqlOldkfHLrvQlqgQkx; Sun, 15 Oct 2023 09:21:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1697354461;
	bh=CkMEGgZwHRms+QfdcCyXBzqoAD058xSJsj4PCuedEAQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZVOR5zlDJkFJ22EOrV+ZfsTbTSzjgzsqCxZxSnUVlguN6lErURSadOdj2w+Mk9uMx
	 P99tBfga5DvYePOn/p3vjsbXzzwiTwWxDdHHY2SZdDgBVfLhtoJr8FE3oN9qND4K1a
	 V/mQzgQDkyiPUEMuEJf9b4Zfi8fSx3PIyQbQ0Lj1e30loOmLyyS9k1js+3Zampf6mF
	 sMCb8DNq+oVm40lKiPE72jZwKBpMKIQdpQOPQLbYgiFWbk770aK9qoXXVcv+X6EVKP
	 QT51jR2XXBLHV3wfVg4bMLChtItL1pC4otPGwlfDCi3fItU8IqDQ5KcnEM7qZJjjyM
	 WSgiA063ZpkHw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 15 Oct 2023 09:21:01 +0200
X-ME-IP: 86.243.2.178
Message-ID: <61b78f8e-98be-4392-9d3b-f1d211adb384@wanadoo.fr>
Date: Sun, 15 Oct 2023 09:20:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] net: openvswitch: Annotate struct mask_array with
 __counted_by
To: Julia Lawall <julia.lawall@inria.fr>, Kees Cook <keescook@chromium.org>
Cc: Pravin B Shelar <pshelar@ovn.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 netdev@vger.kernel.org, dev@openvswitch.org,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev
References: <e5122b4ff878cbf3ed72653a395ad5c4da04dc1e.1697264974.git.christophe.jaillet@wanadoo.fr>
 <ca5c8049f58bb933f231afd0816e30a5aaa0eddd.1697264974.git.christophe.jaillet@wanadoo.fr>
 <202310141928.23985F1CA@keescook>
 <alpine.DEB.2.22.394.2310150653070.3260@hadrien>
Content-Language: fr
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <alpine.DEB.2.22.394.2310150653070.3260@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Le 15/10/2023 à 06:53, Julia Lawall a écrit :
> 
> 
> On Sat, 14 Oct 2023, Kees Cook wrote:
> 
>> On Sat, Oct 14, 2023 at 08:34:53AM +0200, Christophe JAILLET wrote:
>>> Prepare for the coming implementation by GCC and Clang of the __counted_by
>>> attribute. Flexible array members annotated with __counted_by can have
>>> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
>>> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
>>> functions).
>>>
>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>> ---
>>> v2: Fix the subject  [Ilya Maximets]
>>>      fix the field name used with __counted_by  [Ilya Maximets]
>>>
>>> v1: https://lore.kernel.org/all/f66ddcf1ef9328f10292ea75a17b584359b6cde3.1696156198.git.christophe.jaillet@wanadoo.fr/
>>>
>>>
>>> This patch is part of a work done in parallel of what is currently worked
>>> on by Kees Cook.
>>>
>>> My patches are only related to corner cases that do NOT match the
>>> semantic of his Coccinelle script[1].
> 
> What was the problem with the semantic patch in this case?


The allocation in tbl_mask_array_alloc() looks like:
	new = kzalloc(sizeof(struct mask_array) +
		      sizeof(struct sw_flow_mask *) * size +
		      sizeof(u64) * size, GFP_KERNEL);


We allocated the struct, the ending flex aray *and* some more memory at 
the same time.

IIUC the cocci script, this extra space is not taken into account with 
the current script and it won't match.

CJ


> 
> thanks,
> julia
> 
> 
>>>
>>> In this case, in tbl_mask_array_alloc(), several things are allocated with
>>> a single allocation. Then, some pointer arithmetic computes the address of
>>> the memory after the flex-array.
>>>
>>> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
>>> ---
>>>   net/openvswitch/flow_table.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/openvswitch/flow_table.h b/net/openvswitch/flow_table.h
>>> index 9e659db78c05..f524dc3e4862 100644
>>> --- a/net/openvswitch/flow_table.h
>>> +++ b/net/openvswitch/flow_table.h
>>> @@ -48,7 +48,7 @@ struct mask_array {
>>>   	int count, max;
>>>   	struct mask_array_stats __percpu *masks_usage_stats;
>>>   	u64 *masks_usage_zero_cntr;
>>> -	struct sw_flow_mask __rcu *masks[];
>>> +	struct sw_flow_mask __rcu *masks[] __counted_by(max);
>>>   };
>>
>> Yup, this looks correct to me. Thanks!
>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>
>> --
>> Kees Cook
>>
> 


