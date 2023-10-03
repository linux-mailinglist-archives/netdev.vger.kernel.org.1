Return-Path: <netdev+bounces-37737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A56F97B6E43
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 18:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0B8ED2811A5
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 16:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C9738DE8;
	Tue,  3 Oct 2023 16:21:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C363331A82
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 16:21:20 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41AF9E;
	Tue,  3 Oct 2023 09:21:19 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S0NKn0q8Wz67ydC;
	Wed,  4 Oct 2023 00:18:37 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 3 Oct
 2023 17:21:17 +0100
Date: Tue, 3 Oct 2023 17:21:16 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Andrew Jeffery <andrew@aj.id.au>
CC: Konstantin Aladyshev <aladyshev22@gmail.com>, Tomer Maimon
	<tmaimon77@gmail.com>, Corey Minyard <minyard@acm.org>, Patrick Venture
	<venture@google.com>, <openbmc@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Tali Perry <tali.perry1@gmail.com>, "Avi
 Fishman" <avifishman70@gmail.com>, Eric Dumazet <edumazet@google.com>, netdev
	<netdev@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>, "Joel Stanley"
	<joel@jms.id.au>, Jakub Kicinski <kuba@kernel.org>, "Jeremy Kerr"
	<jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>, Paolo
 Abeni <pabeni@redhat.com>, <openipmi-developer@lists.sourceforge.net>, David
 Miller <davem@davemloft.net>, <linux-arm-kernel@lists.infradead.org>,
	"Benjamin Fair" <benjaminfair@google.com>
Subject: Re: [PATCH 3/3] mctp: Add MCTP-over-KCS transport binding
Message-ID: <20231003172116.0000736e@Huawei.com>
In-Reply-To: <1fd97872-446e-42f3-84ad-6e490d63e12d@app.fastmail.com>
References: <20230928123009.2913-1-aladyshev22@gmail.com>
	<20230928123009.2913-4-aladyshev22@gmail.com>
	<20230929120835.0000108e@Huawei.com>
	<1fd97872-446e-42f3-84ad-6e490d63e12d@app.fastmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> Thanks for the drive-by comments!

No problem and keep up the good work in tidying this up.
Many dark and interesting corners in the kernel and not all of them get
the work they deserve :)

Feel free to CC me and I'll take a look at any cleanup you propose.
At least KCS is small so there aren't 100s of drivers to change :)

Jonathan

> 
> Andrew


