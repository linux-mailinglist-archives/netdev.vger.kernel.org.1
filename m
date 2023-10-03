Return-Path: <netdev+bounces-37713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9F27B6B5C
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 16:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 005B11C20754
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 14:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEAF31A94;
	Tue,  3 Oct 2023 14:23:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA98130FA5
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 14:23:50 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E71A3;
	Tue,  3 Oct 2023 07:23:46 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qngJL-0002O4-4o; Tue, 03 Oct 2023 16:23:43 +0200
Date: Tue, 3 Oct 2023 16:23:43 +0200
From: Florian Westphal <fw@strlen.de>
To: Xin Long <lucien.xin@gmail.com>
Cc: Simon Horman <horms@kernel.org>, network dev <netdev@vger.kernel.org>,
	netfilter-devel@vger.kernel.org, linux-sctp@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: Re: [PATCH nf] netfilter: handle the connecting collision properly
 in nf_conntrack_proto_sctp
Message-ID: <20231003142343.GA8405@breakpoint.cc>
References: <6ee630f777cada3259b29e732e7ea9321a99197b.1696172868.git.lucien.xin@gmail.com>
 <ZRwOVyKQR8MBjpBh@kernel.org>
 <CADvbK_fK03UO3R=70J+VoGVm_LJuzZbh+_=0doceS8DCPJYBVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvbK_fK03UO3R=70J+VoGVm_LJuzZbh+_=0doceS8DCPJYBVA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Xin Long <lucien.xin@gmail.com> wrote:
> > The type of vtag is u32. But the type of ct->proto.sctp.vtag[!dir] and init_tag
> > is __be32. This doesn't seem right (and makes Sparse unhappy).
> You're right, I will fix it and re-post with tag:
> 
> Fixes: 9fb9cbb1082d ("[NETFILTER]: Add nf_conntrack subsystem.")

I'm fine with this, the bug is likely inherited from
ipt_conntrack_sctp.c, but that doesn't exist anymore.

Would you also fix up the __be32/u32 confusion?

Better to not add more sparse warnings...

Thanks!

