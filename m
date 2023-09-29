Return-Path: <netdev+bounces-36973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A36F7B2C24
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 08:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id EA3C5282675
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 06:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966EE8C17;
	Fri, 29 Sep 2023 06:03:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0D0882E
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 06:03:37 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BDD199;
	Thu, 28 Sep 2023 23:03:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 493022089F;
	Fri, 29 Sep 2023 08:03:34 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jUWheq-XtF3e; Fri, 29 Sep 2023 08:03:28 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id C3B0720861;
	Fri, 29 Sep 2023 08:03:28 +0200 (CEST)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id B476D80004A;
	Fri, 29 Sep 2023 08:03:28 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 08:03:28 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 29 Sep
 2023 08:03:28 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id BD4FB3182B50; Fri, 29 Sep 2023 08:03:27 +0200 (CEST)
Date: Fri, 29 Sep 2023 08:03:27 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Yue Haibing <yuehaibing@huawei.com>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<leon@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] xfrm: Remove unused function declarations
Message-ID: <ZRZorz8IUECFUaa1@gauss3.secunet.de>
References: <20230729122858.25776-1-yuehaibing@huawei.com>
 <de3b9e86-92c6-108b-272a-9480f9b91f21@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <de3b9e86-92c6-108b-272a-9480f9b91f21@huawei.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 03:26:28PM +0800, Yue Haibing wrote:
> ping..
> 
> On 2023/7/29 20:28, Yue Haibing wrote:
> > commit a269fbfc4e9f ("xfrm: state: remove extract_input indirection from xfrm_state_afinfo")
> > left behind this.
> > 
> > Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Sorry, that one slipped through the cracks.
Now applied to ipsec-next, thanks!

