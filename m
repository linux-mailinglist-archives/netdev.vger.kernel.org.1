Return-Path: <netdev+bounces-18093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0704E754CE8
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 02:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41371C209D1
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 00:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707917E5;
	Sun, 16 Jul 2023 00:35:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63847161
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 00:35:55 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CF72715;
	Sat, 15 Jul 2023 17:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=mE9+71SpcGsafbLERUBD51p4fXq4pCC+GFqB11xSv5M=; b=Ug+2GIzIZbSN72q9ekRkGYBv94
	hTsJx9IlKFxSw+d93vnKSKnQ5VBjD1EiE0M15cB01ZiAAxKhAbcxsO2KOkeTNESLS4b7fiVXyxf6+
	bvagVEvfUW1VvU7wM5thK/fZ3bEXnHMQTm+ztTZzVSkfXWTjnvJN+NZpUlzIb1V2A1Gr9T+a8ZEZl
	1EifUYjP3j2OtCVxVnM/pxRgdv1nGcNkS6nnMhNf8lCkpOuJiBJQxbDkBA2Vd3G+CzOXr5cqSFjPO
	86i39noH1h5v6nHq30iGX0ncNMKMvWQDoLQKaTMexHqqEoR2s9UIPSkfJdB4/oa4ylBuRhiR3++Pq
	+m5Z2mrQ==;
Received: from 50-198-160-193-static.hfc.comcastbusiness.net ([50.198.160.193] helo=[10.150.81.113])
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qKpji-0078Xu-2P;
	Sun, 16 Jul 2023 00:35:43 +0000
Message-ID: <5e5ee5f1-6391-dea3-77eb-c55dd7bff0a3@infradead.org>
Date: Sat, 15 Jul 2023 17:35:30 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH docs] scripts: kernel-doc: support private / public
 marking for enums
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
To: Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-doc@vger.kernel.org, arkadiusz.kubalewski@intel.com,
 netdev@vger.kernel.org
References: <20230621223525.2722703-1-kuba@kernel.org>
 <399c98c8-fbf5-8b90-d343-e25697b2e6fa@infradead.org>
 <d5727371-e580-a956-7846-b529f17048ca@infradead.org>
 <875y6m39ll.fsf@meer.lwn.net>
 <f5c04cf1-c6ca-70d6-1903-4603acc30df4@infradead.org>
In-Reply-To: <f5c04cf1-c6ca-70d6-1903-4603acc30df4@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/14/23 08:15, Randy Dunlap wrote:
> 
> 
> On 7/14/23 06:29, Jonathan Corbet wrote:
>> Randy Dunlap <rdunlap@infradead.org> writes:
>>
>>> Hi Jon,
>>>
>>> On 6/21/23 20:10, Randy Dunlap wrote:
>>>>
>>>>
>>>> On 6/21/23 15:35, Jakub Kicinski wrote:
>>>>> Enums benefit from private markings, too. For netlink attribute
>>>>> name enums always end with a pair of __$n_MAX and $n_MAX members.
>>>>> Documenting them feels a bit tedious.
>>>>>
>>>>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>>>>
>>>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>>>> Tested-by: Randy Dunlap <rdunlap@infradead.org>
>>>>
>>>> Thanks.
>>>
>>> I have a need for this patch. Are you planning to merge it?
>>
>> It's commit e27cb89a22ad in 6.5-rc1 ...
> 
> Oops, my bad, sorry about that.
> 
> I'm testing with linux-next. Something is rotten here /methinks.
> 
> I will check it out.

Apparently this was due to user error -- it works today.
Sorry about the noise.


