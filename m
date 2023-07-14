Return-Path: <netdev+bounces-17975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5471B753E96
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 17:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 854F61C2149B
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 15:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE711426D;
	Fri, 14 Jul 2023 15:15:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6521914264
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 15:15:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1882702;
	Fri, 14 Jul 2023 08:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=iFtv9mCGic614M6FWth3bvzYHnqpm1RRWk85paMAB/c=; b=dBqo3And9bsM2JRA9G4yCPhiXQ
	1g8+uvrj9qqCmDt4V8iFwbkBkIgjzFjKHiz0LU9d3iThEzA81rlutMlMiXB/Dd7sZpYffTmoOX22X
	ncOF/DwVUpIgjz8FVTV/onYTnKmqrVAgFTeQHrC+WjRhR9oiL0B85/e6S4aHxMvekoaOK1OomzRvE
	/vKPhrtAib2Ey9mkb1EwPPwb1IA3C236iFQNh4OMQhhZVM1gzo9AnPh2mB53KqUIse5AqqN6fZrN+
	xg1ABy3xb9SqJ8NEg54v1nZOM9rFH9M4oP5+vk6F1iBVDVSuyKoKgA76jTTcO4jgrZ6JouPrIk/N8
	ACXdMpJQ==;
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qKKW7-006UoV-25;
	Fri, 14 Jul 2023 15:15:35 +0000
Message-ID: <f5c04cf1-c6ca-70d6-1903-4603acc30df4@infradead.org>
Date: Fri, 14 Jul 2023 08:15:35 -0700
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
To: Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-doc@vger.kernel.org, arkadiusz.kubalewski@intel.com,
 netdev@vger.kernel.org
References: <20230621223525.2722703-1-kuba@kernel.org>
 <399c98c8-fbf5-8b90-d343-e25697b2e6fa@infradead.org>
 <d5727371-e580-a956-7846-b529f17048ca@infradead.org>
 <875y6m39ll.fsf@meer.lwn.net>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <875y6m39ll.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/14/23 06:29, Jonathan Corbet wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
>> Hi Jon,
>>
>> On 6/21/23 20:10, Randy Dunlap wrote:
>>>
>>>
>>> On 6/21/23 15:35, Jakub Kicinski wrote:
>>>> Enums benefit from private markings, too. For netlink attribute
>>>> name enums always end with a pair of __$n_MAX and $n_MAX members.
>>>> Documenting them feels a bit tedious.
>>>>
>>>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>>>
>>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>>> Tested-by: Randy Dunlap <rdunlap@infradead.org>
>>>
>>> Thanks.
>>
>> I have a need for this patch. Are you planning to merge it?
> 
> It's commit e27cb89a22ad in 6.5-rc1 ...

Oops, my bad, sorry about that.

I'm testing with linux-next. Something is rotten here /methinks.

I will check it out.

-- 
~Randy

