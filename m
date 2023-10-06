Return-Path: <netdev+bounces-38684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F46C7BC21B
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 00:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0504C282043
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 22:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67827450F4;
	Fri,  6 Oct 2023 22:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5CA450C9
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 22:14:45 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CFDC5
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 15:14:44 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qot5m-0002xp-RD; Sat, 07 Oct 2023 00:14:42 +0200
Date: Sat, 7 Oct 2023 00:14:42 +0200
From: Florian Westphal <fw@strlen.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, alexander.duyck@gmail.com,
	fw@strlen.de, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next 0/3] add skb_segment kunit coverage
Message-ID: <20231006221442.GE29258@breakpoint.cc>
References: <20231005134917.2244971-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005134917.2244971-1-willemdebruijn.kernel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> As discussed at netconf last week. Some kernel code is exercised in
> many different ways. skb_segment is a prime example. This ~350 line
> function has 49 different patches in git blame with 28 different
> authors.

Thanks for this work, and especially for adding commit ids
for relevant features that are tested.

Reviewed-by: Florian Westphal <fw@strlen.de>

