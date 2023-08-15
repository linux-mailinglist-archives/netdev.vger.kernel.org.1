Return-Path: <netdev+bounces-27587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1440C77C76C
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 08:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4052F1C20AB4
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 06:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EA2566F;
	Tue, 15 Aug 2023 06:05:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D428D3207
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 06:05:31 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5C01FCE;
	Mon, 14 Aug 2023 23:05:11 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qVnAk-0003Qz-9Z; Tue, 15 Aug 2023 08:04:54 +0200
Date: Tue, 15 Aug 2023 08:04:54 +0200
From: Florian Westphal <fw@strlen.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Dong Chenchen <dongchenchen2@huawei.com>, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, davem@davemloft.net, fw@strlen.de,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	timo.teras@iki.fi, yuehaibing@huawei.com, weiyongjun1@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch net, v2] net: xfrm: skip policies marked as dead while
 reinserting policies
Message-ID: <20230815060454.GA2833@breakpoint.cc>
References: <20230814140013.712001-1-dongchenchen2@huawei.com>
 <20230815060026.GE22185@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815060026.GE22185@unreal>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Leon Romanovsky <leon@kernel.org> wrote:
> >  		dir = xfrm_policy_id2dir(policy->index);
> > -		if (policy->walk.dead || dir >= XFRM_POLICY_MAX)
> > +		if (dir >= XFRM_POLICY_MAX)
> 
> This change is unnecessary, previous code was perfectly fine.

Are you sure? AFAICS walker struct has no 'index' member.

