Return-Path: <netdev+bounces-46021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DF27E0EBD
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 11:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C4F281569
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 10:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C74C11C88;
	Sat,  4 Nov 2023 10:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CB317D5
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 10:15:16 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC0FD44;
	Sat,  4 Nov 2023 03:15:15 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qzDgN-0002ZA-HS; Sat, 04 Nov 2023 11:15:11 +0100
Date: Sat, 4 Nov 2023 11:15:11 +0100
From: Florian Westphal <fw@strlen.de>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH] netfilter: nat: add MODULE_DESCRIPTION
Message-ID: <20231104101511.GC23268@breakpoint.cc>
References: <20231104034017.14909-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231104034017.14909-1-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Randy Dunlap <rdunlap@infradead.org> wrote:
> Add a MODULE_DESCRIPTION() to iptable_nat.c to avoid a build warning:
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/netfilter/iptable_nat.o
> 
> This is only exposed when using "W=n".

Thanks, but I have just sent a patch to fill all of them,
so I would take that one instead.

