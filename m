Return-Path: <netdev+bounces-23120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C909676B027
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 12:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B215280DD8
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 10:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E515200B5;
	Tue,  1 Aug 2023 10:00:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731B01ED40
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 10:00:36 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F591BD2;
	Tue,  1 Aug 2023 03:00:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 0BD0A2065A;
	Tue,  1 Aug 2023 12:00:34 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n7Cd7D-Z3Ez1; Tue,  1 Aug 2023 12:00:33 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 85C0620561;
	Tue,  1 Aug 2023 12:00:33 +0200 (CEST)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 7F91A80004A;
	Tue,  1 Aug 2023 12:00:33 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 12:00:33 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 12:00:33 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id CD87C3182B3B; Tue,  1 Aug 2023 12:00:32 +0200 (CEST)
Date: Tue, 1 Aug 2023 12:00:32 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Lin Ma <linma@zju.edu.cn>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] xfrm: add forgotten nla_policy for XFRMA_MTIMER_THRESH
Message-ID: <ZMjXwBJbUPwS5fpB@gauss3.secunet.de>
References: <20230723074110.3705047-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230723074110.3705047-1-linma@zju.edu.cn>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jul 23, 2023 at 03:41:10PM +0800, Lin Ma wrote:
> The previous commit 4e484b3e969b ("xfrm: rate limit SA mapping change
> message to user space") added one additional attribute named
> XFRMA_MTIMER_THRESH and described its type at compat_policy
> (net/xfrm/xfrm_compat.c).
> 
> However, the author forgot to also describe the nla_policy at
> xfrma_policy (net/xfrm/xfrm_user.c). Hence, this suppose NLA_U32 (4
> bytes) value can be faked as empty (0 bytes) by a malicious user, which
> leads to 4 bytes overflow read and heap information leak when parsing
> nlattrs.
> 
> To exploit this, one malicious user can spray the SLUB objects and then
> leverage this 4 bytes OOB read to leak the heap data into
> x->mapping_maxage (see xfrm_update_ae_params(...)), and leak it to
> userspace via copy_to_user_state_extra(...).
> 
> The above bug is assigned CVE-2023-3773. To fix it, this commit just 
> completes the nla_policy description for XFRMA_MTIMER_THRESH, which 
> enforces the length check and avoids such OOB read.
> 
> Fixes: 4e484b3e969b ("xfrm: rate limit SA mapping change message to user space")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

Also applied, thanks Lin!

