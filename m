Return-Path: <netdev+bounces-38777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE427BC6F2
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 12:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D141C2094B
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 10:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B66B18624;
	Sat,  7 Oct 2023 10:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D441FD1
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 10:53:42 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C1E92;
	Sat,  7 Oct 2023 03:53:41 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qp4wB-00060Y-2a; Sat, 07 Oct 2023 12:53:35 +0200
Date: Sat, 7 Oct 2023 12:53:35 +0200
From: Florian Westphal <fw@strlen.de>
To: George Guo <dongtai.guo@linux.dev>
Cc: pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, George Guo <guodongtai@kylinos.cn>
Subject: Re: [PATCH] netfilter: remove inaccurate code comments from struct
 nft_table
Message-ID: <20231007105335.GB20662@breakpoint.cc>
References: <20231007102528.1544295-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007102528.1544295-1-dongtai.guo@linux.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

George Guo <dongtai.guo@linux.dev> wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> afinfo is no longer a member of struct nft_table, so remove the comment
> for it.

Correct, but could you please send a v2 that fixes up
all the comments and gets them back in sync with the structure?

Eg. nlpid, family, udlen and udata exist in struct
but are not mentioned in the comments.

