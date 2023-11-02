Return-Path: <netdev+bounces-45670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B41337DEEC8
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 10:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D81841C20E4D
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 09:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B7411701;
	Thu,  2 Nov 2023 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFDA1094B
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 09:25:30 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADB3FB;
	Thu,  2 Nov 2023 02:25:27 -0700 (PDT)
Received: from dggpemm500011.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SLdKN3Nm8zvQ77;
	Thu,  2 Nov 2023 17:06:32 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggpemm500011.china.huawei.com
 (7.185.36.110) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 2 Nov
 2023 17:06:34 +0800
From: Ren Mingshuai <renmingshuai@huawei.com>
To: <kuba@kernel.org>
CC: <caowangbao@huawei.com>, <davem@davemloft.net>, <khlebnikov@openvz.org>,
	<liaichun@huawei.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <oneukum@suse.com>, <renmingshuai@huawei.com>,
	<yanan@huawei.com>
Subject: Re: [PATCH] net: usbnet: Fix potential NULL pointer dereference
Date: Thu, 2 Nov 2023 17:06:30 +0800
Message-ID: <20231102090630.938759-1-renmingshuai@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231101213832.77bd657b@kernel.org>
References: <20231101213832.77bd657b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500011.china.huawei.com (7.185.36.110)
X-CFilter-Loop: Reflected

>> >23ba07991dad said SKB can be NULL without describing the triggering 
>> >scenario. Always Check it before dereference to void potential NULL 
>> >pointer dereference.
>> I've tried to find out the scenarios where SKB is NULL, but failed.
>> It seems impossible for SKB to be NULL. If SKB can be NULL, please 
>> tell me the reason and I'd be very grateful.
>
>What do you mean? Grepping the function name shows call sites with NULL getting passed as skb.

Yes And I just learned that during the cdc_ncm_driver.probe, it is possible to pass a NULL SKB to usbnet_start_xmit().

