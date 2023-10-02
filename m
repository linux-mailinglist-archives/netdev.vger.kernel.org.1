Return-Path: <netdev+bounces-37477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C977B5805
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 18:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id E9AF21C20823
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 16:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7011C1DA4E;
	Mon,  2 Oct 2023 16:48:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648901A5BE
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 16:48:41 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03102A9;
	Mon,  2 Oct 2023 09:48:39 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qnM60-0002xv-B8; Mon, 02 Oct 2023 18:48:36 +0200
Date: Mon, 2 Oct 2023 18:48:36 +0200
From: Florian Westphal <fw@strlen.de>
To: Xin Long <lucien.xin@gmail.com>
Cc: Florian Westphal <fw@strlen.de>, network dev <netdev@vger.kernel.org>,
	netfilter-devel@vger.kernel.org, linux-sctp@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: Re: [PATCH nf] netfilter: handle the connecting collision properly
 in nf_conntrack_proto_sctp
Message-ID: <20231002164836.GA9274@breakpoint.cc>
References: <6ee630f777cada3259b29e732e7ea9321a99197b.1696172868.git.lucien.xin@gmail.com>
 <CADvbK_fE2KGLtqBxFUVikrCxkRjG_eodeHjRuMGWU=og_qk9_A@mail.gmail.com>
 <20231002151808.GD30843@breakpoint.cc>
 <CADvbK_edFWwc3JGyyexCw+vKbpKsbftRDZD34sjRXCCWtGYLYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvbK_edFWwc3JGyyexCw+vKbpKsbftRDZD34sjRXCCWtGYLYg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Xin Long <lucien.xin@gmail.com> wrote:
> On Mon, Oct 2, 2023 at 11:18 AM Florian Westphal <fw@strlen.de> wrote:
> >
> > Xin Long <lucien.xin@gmail.com> wrote:
> > > a reproducer is attached.
> > >
> > > Thanks.
> >
> > Do you think its worth it to turn this into a selftest?
> I think so, it's a typical SCTP collision scenario, if it's okay to you
> I'd like to add this to:
> 
> tools/testing/selftests/netfilter/conntrack_sctp_collision.sh

LGTM, thanks!

> should I repost this netfilter patch together with this selftest or I
> can post this selftest later?

Posting it later is fine.

