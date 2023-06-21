Return-Path: <netdev+bounces-12841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B87739161
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 23:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6701C20D23
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 21:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C9D1C778;
	Wed, 21 Jun 2023 21:19:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEFA19E52
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 21:19:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82416197;
	Wed, 21 Jun 2023 14:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=0LvSQUp8WvXtAGQ4Ez7xlJWh7l4nI8L2oKtIOhjswdU=; b=1A8p1HhmdadYqjMQnx+zVWyu5+
	Ladz/59FpJjBs3OqTVrvo4cgy2X0TAsG1qf9oCRCfJ9HsvgKIH0tgtH90GUWaUNi/H0fUCxIxBEUl
	8qlTGD1mUcbgEI+vEtmoOvrBdB/l7JHljqlh0FsNd0ej7hlWvhl+pCWfjlzLCvy4Ap5xfqitK/pQN
	WIxrjcshc+HPms5Jx+J/7ihZeW4OWL5aAuRac0aOZyRFTB8aVe4M85XJpJlh1ijiszehnHn1m/5+s
	i7jRvnuMvPc9lDT4L6axQ3BIc8fjOFBSr06RW1CgobbtIs7FMp/un9dUYKicv3kqItFyjZGlnR8kE
	zkFsLRDA==;
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qC5ER-00FllS-36;
	Wed, 21 Jun 2023 21:19:16 +0000
Message-ID: <b5306c89-eaaa-b357-0518-bdb9a0e5ae9f@infradead.org>
Date: Wed, 21 Jun 2023 14:19:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] s390/net: lcs: use IS_ENABLED() for kconfig detection
Content-Language: en-US
To: Simon Horman <simon.horman@corigine.com>
Cc: linux-kernel@vger.kernel.org, Alexandra Winter <wintera@linux.ibm.com>,
 Wenjia Zhang <wenjia@linux.ibm.com>, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>
References: <20230615222152.13250-1-rdunlap@infradead.org>
 <ea55623d-d469-ddaf-92ce-3daf1d2d726f@infradead.org>
 <ZJMc3oS2nxORPASN@corigine.com>
 <66fd6106-16a5-d61a-4202-02ff99b84f76@infradead.org>
 <ZJNRZZCkGdvp+k34@corigine.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZJNRZZCkGdvp+k34@corigine.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/21/23 12:37, Simon Horman wrote:
> On Wed, Jun 21, 2023 at 11:08:05AM -0700, Randy Dunlap wrote:
>> Hi Simon,
>>

>>> I did have better luck with this.
>>>
>>> diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
>>> index 9c67b97faba2..303220251495 100644
>>> --- a/drivers/s390/net/Kconfig
>>> +++ b/drivers/s390/net/Kconfig
>>> @@ -6,6 +6,7 @@ config LCS
>>>         def_tristate m
>>>         prompt "Lan Channel Station Interface"
>>>         depends on CCW && NETDEVICES && (ETHERNET || FDDI)
>>> +       depends on FDDI=y || FDDI=n
>>>         help
>>>           Select this option if you want to use LCS networking on IBM System z.
>>>           This device driver supports FDDI (IEEE 802.7) and Ethernet.
>>>
>>> I am assuming that LCS=m and FDDI=m can't work at runtime
>>> because there is no guarantee that FDDI is loaded before LCS.
>>> But I could well be wrong here.
>>
>> There's probably some way to make that work, but I don't know.
>>
>> I think that your patch is acceptable.
>> I would prefer to also add to the help text that if FDDI is used,
>> it must be builtin (=y).
> 
> Thanks Randy,
> 
> Feel free to take the snippet above and work it into a proper patch.
> Else I can take a shot at it.
> 

OK, I'll send that. Thanks.

-- 
~Randy

