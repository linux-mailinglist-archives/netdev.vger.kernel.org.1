Return-Path: <netdev+bounces-14729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED0F74365A
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 10:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AEA81C20B71
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 08:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A628F50;
	Fri, 30 Jun 2023 08:02:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AAB187E
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 08:02:07 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5F82D55
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 01:02:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 86B5320743;
	Fri, 30 Jun 2023 10:02:03 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id osIJu4QKTxTk; Fri, 30 Jun 2023 10:02:02 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 9513E206E9;
	Fri, 30 Jun 2023 10:02:02 +0200 (CEST)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id 8EEC180004A;
	Fri, 30 Jun 2023 10:02:02 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 10:02:02 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 30 Jun
 2023 10:02:02 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id DB5CF3182B0C; Fri, 30 Jun 2023 10:02:01 +0200 (CEST)
Date: Fri, 30 Jun 2023 10:02:01 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Lin Ma <linma@zju.edu.cn>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <tgraf@suug.ch>, <simon.horman@corigine.com>
Subject: Re: [PATCH v3] net: xfrm: Amend XFRMA_SEC_CTX nla_policy structure
Message-ID: <ZJ6L+chlwapjZO+A@gauss3.secunet.de>
References: <20230630012241.2822225-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230630012241.2822225-1-linma@zju.edu.cn>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 09:22:41AM +0800, Lin Ma wrote:
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
> ---
> V1 -> V2: also amend compat_policy XFRMA_SEC_CTX
> V2 -> V3: fix typo
> 
>  net/xfrm/xfrm_compat.c | 2 +-
>  net/xfrm/xfrm_user.c   | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/xfrm/xfrm_compat.c b/net/xfrm/xfrm_compat.c
> index 8cbf45a8bcdc..655fe4ff8621 100644
> --- a/net/xfrm/xfrm_compat.c
> +++ b/net/xfrm/xfrm_compat.c
> @@ -108,7 +108,7 @@ static const struct nla_policy compat_policy[XFRMA_MAX+1] = {
>  	[XFRMA_ALG_COMP]	= { .len = sizeof(struct xfrm_algo) },
>  	[XFRMA_ENCAP]		= { .len = sizeof(struct xfrm_encap_tmpl) },
>  	[XFRMA_TMPL]		= { .len = sizeof(struct xfrm_user_tmpl) },
> -	[XFRMA_SEC_CTX]		= { .len = sizeof(struct xfrm_sec_ctx) },
> +	[XFRMA_SEC_CTX]		= { .len = sizeof(struct xfrm_user_sec_ctx) },
>  	[XFRMA_LTIME_VAL]	= { .len = sizeof(struct xfrm_lifetime_cur) },
>  	[XFRMA_REPLAY_VAL]	= { .len = sizeof(struct xfrm_replay_state) },
>  	[XFRMA_REPLAY_THRESH]	= { .type = NLA_U32 },
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index c34a2a06ca94..0c997a114d13 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -3015,7 +3015,7 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
>  	[XFRMA_ALG_COMP]	= { .len = sizeof(struct xfrm_algo) },
>  	[XFRMA_ENCAP]		= { .len = sizeof(struct xfrm_encap_tmpl) },
>  	[XFRMA_TMPL]		= { .len = sizeof(struct xfrm_user_tmpl) },
> -	[XFRMA_SEC_CTX]		= { .len = sizeof(struct xfrm_sec_ctx) },
> +	[XFRMA_SEC_CTX]		= { .len = sizeof(struct xfrm_user_sec_ctx) },
>  	[XFRMA_LTIME_VAL]	= { .len = sizeof(struct xfrm_lifetime_cur) },
>  	[XFRMA_REPLAY_VAL]	= { .len = sizeof(struct xfrm_replay_state) },
>  	[XFRMA_REPLAY_THRESH]	= { .type = NLA_U32 },
> @@ -3035,6 +3035,7 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
>  	[XFRMA_SET_MARK]	= { .type = NLA_U32 },
>  	[XFRMA_SET_MARK_MASK]	= { .type = NLA_U32 },
>  	[XFRMA_IF_ID]		= { .type = NLA_U32 },
> +	[XFRMA_MTIMER_THRESH]	= { .type = NLA_U32 },

The above line is apparently missing, but does it really belong to this
patch? At least it is not mentioned in the commit message.

