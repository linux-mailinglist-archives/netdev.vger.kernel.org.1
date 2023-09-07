Return-Path: <netdev+bounces-32470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BABD797B88
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 20:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E3F1C2095D
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 18:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D30013FFD;
	Thu,  7 Sep 2023 18:19:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFDA13FF7
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 18:19:47 +0000 (UTC)
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FF610F9
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 11:19:34 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
	(envelope-from <n0-1@orbyte.nwl.cc>)
	id 1qeCHp-0000Ig-UN; Thu, 07 Sep 2023 12:30:57 +0200
Date: Thu, 7 Sep 2023 12:30:57 +0200
From: Phil Sutter <phil@nwl.cc>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netfilter-devel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH net 6/6] netfilter: nf_tables: Unbreak audit log reset
Message-ID: <ZPmmYayuzmMPJXqu@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netfilter-devel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>
References: <20230906162525.11079-1-fw@strlen.de>
 <20230906162525.11079-7-fw@strlen.de>
 <ZPjyB48c+y6P9MOZ@orbyte.nwl.cc>
 <ZPkAIUSuc0lZl3yu@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPkAIUSuc0lZl3yu@strlen.de>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 07, 2023 at 12:41:37AM +0200, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > On Wed, Sep 06, 2023 at 06:25:12PM +0200, Florian Westphal wrote:
> > > From: Pablo Neira Ayuso <pablo@netfilter.org>
> > > 
> > > Deliver audit log from __nf_tables_dump_rules(), table dereference at
> > > the end of the table list loop might point to the list head, leading to
> > > this crash.
> > 
> > There are a few issues with this patch, can we please drop it from this
> > MR for now?
> 
> If this were a change that *adds* a kernel crash, then, sure.
> But this fixes a crash, so I see no reason to keep it back.
> 
> Please do an incremental followup instead.

ACK, I'll do that instead.

Thanks, Phil

