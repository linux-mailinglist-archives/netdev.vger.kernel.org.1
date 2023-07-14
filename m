Return-Path: <netdev+bounces-17951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0AE753BD0
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 15:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C50281FD1
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 13:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB48B8494;
	Fri, 14 Jul 2023 13:29:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF5211CA4
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 13:29:13 +0000 (UTC)
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BB02691;
	Fri, 14 Jul 2023 06:29:12 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 563BD2DC;
	Fri, 14 Jul 2023 13:29:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 563BD2DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1689341351; bh=H9tz5ldsMO8c9+uUJZhkOeHUmpPUNR2Ib1G3wp49Bhc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Am+uUs2BwqV9EprXa3PcWPC88FAiB/JW4muHNqUgE1Bb2D1ucDfL3OUhaitAOxBV9
	 5ub7+WpXxnZj+b48CHRMgCArIuz7MDzjyxV5vr2Ts/MsKQZqo5puhALartHPwMC7y6
	 3a2e/xSi9HFmOGylEJhy8MnJGsSdILHyYbjElZfoOMOl5ip1BSvgozGQTkdzvLiONq
	 gOYz8kbDW3efmAB3qMCnK81IWXYbGPq8CAqRukJwl9tZwmizIMVSFisi3VO0WilPBH
	 hOPjhXuG0KSwxsNJ91RQbgXiKtRr2gIDDFiZS21pmoOpnU3rk6lKFkq6XbaA9VqVLr
	 RTdoyIVbHO/rg==
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-doc@vger.kernel.org, arkadiusz.kubalewski@intel.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH docs] scripts: kernel-doc: support private / public
 marking for enums
In-Reply-To: <d5727371-e580-a956-7846-b529f17048ca@infradead.org>
References: <20230621223525.2722703-1-kuba@kernel.org>
 <399c98c8-fbf5-8b90-d343-e25697b2e6fa@infradead.org>
 <d5727371-e580-a956-7846-b529f17048ca@infradead.org>
Date: Fri, 14 Jul 2023 07:29:10 -0600
Message-ID: <875y6m39ll.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Randy Dunlap <rdunlap@infradead.org> writes:

> Hi Jon,
>
> On 6/21/23 20:10, Randy Dunlap wrote:
>> 
>> 
>> On 6/21/23 15:35, Jakub Kicinski wrote:
>>> Enums benefit from private markings, too. For netlink attribute
>>> name enums always end with a pair of __$n_MAX and $n_MAX members.
>>> Documenting them feels a bit tedious.
>>>
>>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> 
>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>> Tested-by: Randy Dunlap <rdunlap@infradead.org>
>> 
>> Thanks.
>
> I have a need for this patch. Are you planning to merge it?

It's commit e27cb89a22ad in 6.5-rc1 ...

Thanks,

jon

