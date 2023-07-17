Return-Path: <netdev+bounces-18425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E83B9756DC3
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 21:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB7D28149C
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 19:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D71C2CE;
	Mon, 17 Jul 2023 19:55:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EF9C141
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 19:55:44 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4737D1719
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 12:55:22 -0700 (PDT)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1DEF73FA70
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 19:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1689623717;
	bh=RsZ80vHPsv7p3WHvik8ahbpar4KBJIeZVzI7m9eLzKg=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=gweQjIGoaBDKJ8CFx9O7nuAda197ThtqAXgDuui1GEcDsSSkQd3VDLMbqUgjqO0Ei
	 nSHScbuBJrK3ncHMKh+D2oxdNJ+22ozPiCrBTCUmStGscpMNGSJ9KnxsjQAPlr3a6m
	 z+Jn7nXYYtG04N3Gzzq7ET5e+WO7HbrWBd5q9GgKnVkAQvPeaEv+oEZgbOiPUhjazO
	 dTu7cZ8jzG6GTPK4qQnwFBIP2tIevVtc1XANTRNWAYvfo//bf8oOEh+JpnNeUS8Egw
	 mAZ+uU6NvV3jhhSeJZ6PRevSIRGoWzAN0brHcWJ2asW9vYs9BB0p0cVRENqoaHNRmH
	 g9nR/2RCgfHZw==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1b89f6463deso38128615ad.1
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 12:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689623714; x=1692215714;
        h=message-id:date:content-id:mime-version:comments:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RsZ80vHPsv7p3WHvik8ahbpar4KBJIeZVzI7m9eLzKg=;
        b=A0abZoVu1+rCz8fdjggpyObJLo0p0uldM6mRH+0c+JUijObSHdmQ+wKwMUYFXX6BB7
         uks/l2Ib4pWQi5UuWbJCk6TRIlq4qsSaUw6aJx+xs+MQeYGEMwBUIYfLI1ckOVqyuTP0
         /opgaQtvy0AVfsSyVmcCTdlDkYRCtiAY0a2ohXOqoqaS5FvRZNHiSAeOjcYIrH2yCuR1
         /7L2Ei9ApK1S+cabjm1r2r9qiEvldidEYIInfdWZRGvBkvN2RWyLtdjh240ZFG38ktbe
         7mNYzyKDpV2escEagp5LAs1frxY9Ub0dQcrFR9iJogmi/QvVEX0YDqnpTb56W2OYwA4f
         Q5Bw==
X-Gm-Message-State: ABy/qLb/hzqDtYmMo+z+U5PvdTTpnm4NT8iTU51KZVgnRojdIYgkB8vJ
	h+OT9rRWoo6lmiS/g6rrp5/NrMdJKVyKqFynxW0yA6E1pNJJR4nN4/Y2riWSKqIU4l89hxux27F
	V1VcT333UsdBE54e4WkZYg5LkoD5zdA71ng==
X-Received: by 2002:a17:902:6b4c:b0:1b8:400a:48f2 with SMTP id g12-20020a1709026b4c00b001b8400a48f2mr11658314plt.62.1689623713986;
        Mon, 17 Jul 2023 12:55:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGrOjtnY6lWiNfKGhtjqsBOM3t/HRtYVHIACSFW7pWvLs/xsm66kPBIrPbltatdXBvmmrKnDA==
X-Received: by 2002:a17:902:6b4c:b0:1b8:400a:48f2 with SMTP id g12-20020a1709026b4c00b001b8400a48f2mr11658306plt.62.1689623713638;
        Mon, 17 Jul 2023 12:55:13 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id w21-20020a170902a71500b001b9c5e0393csm238801plq.225.2023.07.17.12.55.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jul 2023 12:55:13 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id CB87160283; Mon, 17 Jul 2023 12:55:12 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id C5C689FABB;
	Mon, 17 Jul 2023 12:55:12 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>
cc: Wang Ming <machel@vivo.com>, Andy Gospodarek <andy@greyhouse.net>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Yufeng Mo <moyufeng@huawei.com>,
    Guangbin Huang <huangguangbin2@huawei.com>, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org, opensource.kernel@vivo.com,
    Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net v3] net: bonding: Fix error checking for debugfs_create_dir()
In-reply-to: <1051f5ae-82de-2e52-64f5-545fa2dedff9@gmail.com>
References: <20230717085313.17188-1-machel@vivo.com> <1051f5ae-82de-2e52-64f5-545fa2dedff9@gmail.com>
Comments: In-reply-to Tariq Toukan <ttoukan.linux@gmail.com>
   message dated "Mon, 17 Jul 2023 21:36:58 +0300."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2412.1689623712.1@famine>
Date: Mon, 17 Jul 2023 12:55:12 -0700
Message-ID: <2413.1689623712@famine>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tariq Toukan <ttoukan.linux@gmail.com> wrote:
>On 17/07/2023 11:53, Wang Ming wrote:
>> The debugfs_create_dir() function returns error pointers,
>> it never returns NULL. Most incorrect error checks were fixed,
>> but the one in bond_create_debugfs() was forgotten.
>> Fixes: 52333512701b ("net: bonding: remove unnecessary braces")
>
>It's not this commit to blame...
>Issue was there in first place, starting in commit f073c7ca29a4 ("bonding:
>add the debugfs facility to the bonding driver").

	Agreed; please upate the Fixes: commit and resubmit, thanks.

	-J

>
>> Signed-off-by: Wang Ming <machel@vivo.com>
>> ---
>>   drivers/net/bonding/bond_debugfs.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/drivers/net/bonding/bond_debugfs.c
>> b/drivers/net/bonding/bond_debugfs.c
>> index 594094526648..d4a82f276e87 100644
>> --- a/drivers/net/bonding/bond_debugfs.c
>> +++ b/drivers/net/bonding/bond_debugfs.c
>> @@ -88,7 +88,7 @@ void bond_create_debugfs(void)
>>   {
>>   	bonding_debug_root = debugfs_create_dir("bonding", NULL);
>>   -	if (!bonding_debug_root)
>> +	if (IS_ERR(bonding_debug_root))
>>   		pr_warn("Warning: Cannot create bonding directory in debugfs\n");
>>   }
>>   

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

