Return-Path: <netdev+bounces-38776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E99D7BC6ED
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 12:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18FB281FCB
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 10:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049B218622;
	Sat,  7 Oct 2023 10:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A099F18048
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 10:50:54 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6A89E;
	Sat,  7 Oct 2023 03:50:52 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qp4t1-0005zZ-Dj; Sat, 07 Oct 2023 12:50:19 +0200
Date: Sat, 7 Oct 2023 12:50:19 +0200
From: Florian Westphal <fw@strlen.de>
To: George Guo <dongtai.guo@linux.dev>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, George Guo <guodongtai@kylinos.cn>
Subject: Re: [PATCH] tcp: fix secure_{tcp, tcpv6}_ts_off call parameter order
 mistake
Message-ID: <20231007105019.GA20662@breakpoint.cc>
References: <20231007092337.1540036-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007092337.1540036-1-dongtai.guo@linux.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

George Guo <dongtai.guo@linux.dev> wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> Fix secure_tcp_ts_off and secure_tcpv6_ts_off call parameter order mistake

Could you please send a v2, targetting net-next, that clearly
says that this is a cleanup?

[ It doesn't matter if we pass "saddr, daddr" or
  "daddr, saddr" as long as both "init" and "check"
  functions agree on the ordering ]

