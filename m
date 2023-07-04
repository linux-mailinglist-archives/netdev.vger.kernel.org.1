Return-Path: <netdev+bounces-15281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3156A746924
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 07:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7249C280D2D
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 05:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E117FC;
	Tue,  4 Jul 2023 05:45:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9674A3C
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 05:45:32 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67455E49
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 22:45:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 3BAAF20764;
	Tue,  4 Jul 2023 07:45:30 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KtaZWDAfM4uY; Tue,  4 Jul 2023 07:45:29 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id BBF5520520;
	Tue,  4 Jul 2023 07:45:29 +0200 (CEST)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id B45A780004A;
	Tue,  4 Jul 2023 07:45:29 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 07:45:29 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 4 Jul
 2023 07:45:29 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id A792C3182B55; Tue,  4 Jul 2023 07:45:28 +0200 (CEST)
Date: Tue, 4 Jul 2023 07:45:28 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Lin Ma <linma@zju.edu.cn>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <tgraf@suug.ch>, <simon.horman@corigine.com>
Subject: Re: [PATCH v4] net: xfrm: Amend XFRMA_SEC_CTX nla_policy structure
Message-ID: <ZKOx+MPDbCpESzwi@gauss3.secunet.de>
References: <20230630081911.2983347-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230630081911.2983347-1-linma@zju.edu.cn>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 04:19:11PM +0800, Lin Ma wrote:
> According to all consumers code of attrs[XFRMA_SEC_CTX], like
> 
> * verify_sec_ctx_len(), convert to xfrm_user_sec_ctx*
> * xfrm_state_construct(), call security_xfrm_state_alloc whose prototype
> is int security_xfrm_state_alloc(.., struct xfrm_user_sec_ctx *sec_ctx);
> * copy_from_user_sec_ctx(), convert to xfrm_user_sec_ctx *
> ...
> 
> It seems that the expected parsing result for XFRMA_SEC_CTX should be
> structure xfrm_user_sec_ctx, and the current xfrm_sec_ctx is confusing
> and misleading (Luckily, they happen to have same size 8 bytes).
> 
> This commit amend the policy structure to xfrm_user_sec_ctx to avoid
> ambiguity.
> 
> Fixes: cf5cb79f6946 ("[XFRM] netlink: Establish an attribute policy")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

Applied, thanks a lot Lin!

