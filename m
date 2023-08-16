Return-Path: <netdev+bounces-28180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A2F77E84C
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 20:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1B11C21141
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 18:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67955174F9;
	Wed, 16 Aug 2023 18:07:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C227174ED
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 18:07:55 +0000 (UTC)
X-Greylist: delayed 4202 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Aug 2023 11:07:50 PDT
Received: from 6.mo545.mail-out.ovh.net (6.mo545.mail-out.ovh.net [46.105.48.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC9C10C0
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 11:07:50 -0700 (PDT)
Received: from ex4.mail.ovh.net (unknown [10.108.20.92])
	by mo545.mail-out.ovh.net (Postfix) with ESMTPS id 306BA24474
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 15:39:47 +0000 (UTC)
Received: from [192.168.1.131] (93.21.160.242) by DAG10EX1.indiv4.local
 (172.16.2.91) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.31; Wed, 16 Aug
 2023 17:39:46 +0200
Message-ID: <3c35f154-1ce7-4e82-9850-8d3401762b37@naccy.de>
Date: Wed, 16 Aug 2023 17:39:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: <netdev@vger.kernel.org>
From: Quentin Deslandes <qde@naccy.de>
Subject: ss: support for BPF sk local storage
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [93.21.160.242]
X-ClientProxiedBy: CAS9.indiv4.local (172.16.1.9) To DAG10EX1.indiv4.local
 (172.16.2.91)
X-Ovh-Tracer-Id: 17132537408914517623
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedruddtledgleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefkffggfgfvhffutgfgihesthejredttddvjeenucfhrhhomhepsfhuvghnthhinhcuffgvshhlrghnuggvshcuoehquggvsehnrggttgihrdguvgeqnecuggftrfgrthhtvghrnhepvdekieeitedvhfdvteffveehledujeegudfgveejgfdvteeigeelgeeitdeujefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpleefrddvuddrudeitddrvdegvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehquggvsehnrggttgihrdguvgeqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehgeehpdhmohguvgepshhmthhpohhuthdpughkihhmpehnohhnvg
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

