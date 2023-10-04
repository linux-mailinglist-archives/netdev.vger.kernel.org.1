Return-Path: <netdev+bounces-37887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B96BF7B7964
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 10:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 0C432B207B4
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 08:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF28101DD;
	Wed,  4 Oct 2023 08:00:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A7FD307
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 08:00:49 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54283B7;
	Wed,  4 Oct 2023 01:00:46 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qnwo9-0008ME-VA; Wed, 04 Oct 2023 10:00:37 +0200
Date: Wed, 4 Oct 2023 10:00:37 +0200
From: Florian Westphal <fw@strlen.de>
To: Henrik =?iso-8859-15?Q?Lindstr=F6m?= <lindstrom515@gmail.com>
Cc: Florian Westphal <fw@strlen.de>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: macvtap performs IP defragmentation, causing MTU problems for
 virtual machines
Message-ID: <20231004080037.GC15013@breakpoint.cc>
References: <CAHkKap3sdN4wZm_euAZEyt3XB4bvr6cV-oAMGtrmrm5Z8biZ_Q@mail.gmail.com>
 <20231002092010.GA30843@breakpoint.cc>
 <2197902.NgBsaNRSFp@pc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2197902.NgBsaNRSFp@pc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Henrik Lindström <lindstrom515@gmail.com> wrote:
> Had to change "return 0" to "return vif" but other than that your changes
> seem to work, even with macvlan defragmentation removed.

Oh, right, that should have been "return vid" indeed.

> I tested it by sending 8K fragmented multicast packets, with 5 macvlans on
> the receiving side. I consistently received 6 copies of the packet (1 from the
> real interface and 1 per macvlan). While doing this i had my VM running with
> a macvtap, and it was receiving fragmented packets as expected.
> 
> Here are the changes i was testing with, first time sending a diff over mail
> so hope it works :-)

Can you submit this formally, with proper changelog and Signed-off-by?
See scripts/checkpatch.pl in the kernel tree.

It might be a good idea to first mail the patch to yourself and see if
you can apply it (sometimes tabs get munged into spaces, long lines get
broken, etc).

You could also mention in changelog that this is ipv4 only because
ipv6 already considers the interface index during reassembly.

Thanks!

