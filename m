Return-Path: <netdev+bounces-41846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE647CC039
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 12:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8CE7B20FAE
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E864122F;
	Tue, 17 Oct 2023 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1945D3FB24
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 10:09:46 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438F88E;
	Tue, 17 Oct 2023 03:09:45 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qsh19-0007UK-8J; Tue, 17 Oct 2023 12:09:39 +0200
Date: Tue, 17 Oct 2023 12:09:39 +0200
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [net-next PATCH v2] net: skb_find_text: Ignore patterns
 extending past 'to'
Message-ID: <20231017100939.GC10901@breakpoint.cc>
References: <20231017093906.26310-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017093906.26310-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Phil Sutter <phil@nwl.cc> wrote:
> Assume that caller's 'to' offset really represents an upper boundary for
> the pattern search, so patterns extending past this offset are to be
> rejected.
> 
> The old behaviour also was kind of inconsistent when it comes to
> fragmentation (or otherwise non-linear skbs): If the pattern started in
> between 'to' and 'from' offsets but extended to the next fragment, it
> was not found if 'to' offset was still within the current fragment.
> 
> Test the new behaviour in a kselftest using iptables' string match.

Reviewed-by: Florian Westphal <fw@strlen.de>

