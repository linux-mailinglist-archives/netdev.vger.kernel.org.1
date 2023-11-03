Return-Path: <netdev+bounces-45948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B377E07C9
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 18:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E717B2126C
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 17:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA7D210F4;
	Fri,  3 Nov 2023 17:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629182D625
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 17:55:22 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD29136;
	Fri,  3 Nov 2023 10:55:21 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qyyO4-0007Hr-5V; Fri, 03 Nov 2023 18:55:16 +0100
Date: Fri, 3 Nov 2023 18:55:16 +0100
From: Florian Westphal <fw@strlen.de>
To: Simon Horman <horms@kernel.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, fw@strlen.de
Subject: Re: [PATCH net-next 02/19] netfilter: nft_set_rbtree: prefer sync gc
 to async worker
Message-ID: <20231103175516.GH8035@breakpoint.cc>
References: <20231025212555.132775-1-pablo@netfilter.org>
 <20231025212555.132775-3-pablo@netfilter.org>
 <20231103173442.GB768996@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103173442.GB768996@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Simon Horman <horms@kernel.org> wrote:
> Hi Florian and Pablo,
> 
> I understand that this patch has been accepted upstream,
> and that by implication this feedback is rather slow,
> but I noticed that with this patch nft_net is now
> set but otherwise unused in this function.

There is a patch queued for this, we'll pass this to -net next week.

