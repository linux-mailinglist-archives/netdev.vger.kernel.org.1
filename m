Return-Path: <netdev+bounces-30015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1346C785A19
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 16:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDBF728128B
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 14:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C010C150;
	Wed, 23 Aug 2023 14:11:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904A4C131
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 14:11:52 +0000 (UTC)
X-Greylist: delayed 960 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Aug 2023 07:11:50 PDT
Received: from 8.mo547.mail-out.ovh.net (8.mo547.mail-out.ovh.net [46.105.58.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C79FE4E
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 07:11:49 -0700 (PDT)
Received: from ex4.mail.ovh.net (unknown [10.108.16.147])
	by mo547.mail-out.ovh.net (Postfix) with ESMTPS id 173E9205F0;
	Wed, 23 Aug 2023 13:55:47 +0000 (UTC)
Received: from [192.168.1.131] (93.21.160.242) by DAG10EX1.indiv4.local
 (172.16.2.91) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.31; Wed, 23 Aug
 2023 15:55:45 +0200
Message-ID: <95161136-5834-4176-9faf-8531268705dc@naccy.de>
Date: Wed, 23 Aug 2023 15:55:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: <netdev@vger.kernel.org>, <dsahern@kernel.org>,
	<stephen@networkplumber.org>
From: Quentin Deslandes <qde@naccy.de>
Subject: ss: support for BPF sk local storage
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [93.21.160.242]
X-ClientProxiedBy: CAS8.indiv4.local (172.16.1.8) To DAG10EX1.indiv4.local
 (172.16.2.91)
X-Ovh-Tracer-Id: 1144758732118748873
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedruddvgedgieelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefkffggfgfvhffutgfgihesthejredttddvjeenucfhrhhomhepsfhuvghnthhinhcuffgvshhlrghnuggvshcuoehquggvsehnrggttgihrdguvgeqnecuggftrfgrthhtvghrnhepvdekieeitedvhfdvteffveehledujeegudfgveejgfdvteeigeelgeeitdeujefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpleefrddvuddrudeitddrvdegvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehquggvsehnrggttgihrdguvgeqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdgushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdpshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdfovfetjfhoshhtpehmohehgeejpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

Could it be possible to print BPF sk local storage data from ss?
Reading the original patch [1], it appears to have been thought
out this way, and it seems (to me) that it would fit ss' purpose.

Please correct me if my assumptions are wrong.

1. https://lore.kernel.org/netdev/20190426233938.1330361-1-kafai@fb.com/

Regards,
Quentin Deslandes

