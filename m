Return-Path: <netdev+bounces-13958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C04A773E308
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 17:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FBE1280DD6
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 15:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10BEBA45;
	Mon, 26 Jun 2023 15:17:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966C2BA29
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 15:17:44 +0000 (UTC)
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC3BE191;
	Mon, 26 Jun 2023 08:17:42 -0700 (PDT)
Date: Mon, 26 Jun 2023 17:17:40 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] linux/netfilter.h: fix kernel-doc warnings
Message-ID: <ZJmsFCv3CjVmXsWr@calendula>
References: <20230623061101.32513-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230623061101.32513-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 11:11:01PM -0700, Randy Dunlap wrote:
> kernel-doc does not support DECLARE_PER_CPU(), so don't mark it with
> kernel-doc notation.
> 
> One comment block is not kernel-doc notation, so just use
> "/*" to begin the comment.
> 
> Quietens these warnings:
> 
> netfilter.h:493: warning: Function parameter or member 'bool' not described in 'DECLARE_PER_CPU'
> netfilter.h:493: warning: Function parameter or member 'nf_skb_duplicated' not described in 'DECLARE_PER_CPU'
> netfilter.h:493: warning: expecting prototype for nf_skb_duplicated(). Prototype was for DECLARE_PER_CPU() instead
> netfilter.h:496: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Contains bitmask of ctnetlink event subscribers, if any.

Applied to nf.git, thanks

