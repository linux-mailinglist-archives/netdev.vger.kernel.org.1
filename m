Return-Path: <netdev+bounces-38889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968967BCE4F
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 14:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908FD1C208B8
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 12:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A392DC135;
	Sun,  8 Oct 2023 12:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA203BE7F
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 12:19:38 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D50B9;
	Sun,  8 Oct 2023 05:19:35 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qpSkW-0002mQ-QP; Sun, 08 Oct 2023 14:19:08 +0200
Date: Sun, 8 Oct 2023 14:19:08 +0200
From: Florian Westphal <fw@strlen.de>
To: xiaolinkui <xiaolinkui@126.com>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	David Miller <davem@davemloft.net>, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, justinstitt@google.com,
	kuniyu@amazon.com, coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH] netfilter: ipset: wait for xt_recseq on all cpus
Message-ID: <20231008121908.GA29696@breakpoint.cc>
References: <20231005115022.12902-1-xiaolinkui@126.com>
 <20231005123107.GB9350@breakpoint.cc>
 <2c9efd36-f1f6-b77b-d4eb-f65932cfaba@netfilter.org>
 <6ed069d2-0201-a2c0-de92-bd6fc8f33ed7@126.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ed069d2-0201-a2c0-de92-bd6fc8f33ed7@126.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

xiaolinkui <xiaolinkui@126.com> wrote:
> crash> struct seqcount_t ffff8003fff3bf88
> struct seqcount_t {
>   sequence = 804411271
> }
> 
> The seqcount of CPU7 is odd, xt_replace_table should have waited, but it
> didn't.

Likely missing backport of
175e476b8cdf ("netfilter: x_tables: Use correct memory barriers.")?

