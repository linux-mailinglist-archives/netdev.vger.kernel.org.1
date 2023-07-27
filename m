Return-Path: <netdev+bounces-21940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D89765571
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 15:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF6C282331
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 13:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD7E174E2;
	Thu, 27 Jul 2023 13:58:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018AE16439
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 13:58:29 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8905430CF;
	Thu, 27 Jul 2023 06:58:28 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qP1VZ-0003OL-KQ; Thu, 27 Jul 2023 15:58:25 +0200
Date: Thu, 27 Jul 2023 15:58:25 +0200
From: Florian Westphal <fw@strlen.de>
To: Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Cc: Maciej =?utf-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Linux Network Development Mailing List <netdev@vger.kernel.org>,
	Netfilter Development Mailing List <netfilter-devel@vger.kernel.org>,
	Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH netfilter] netfilter: nfnetlink_log: always add a
 timestamp
Message-ID: <20230727135825.GF2963@breakpoint.cc>
References: <20230725085443.2102634-1-maze@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230725085443.2102634-1-maze@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Maciej Żenczykowski <maze@google.com> wrote:
> Compared to all the other work we're already doing to deliver
> an skb to userspace this is very cheap - at worse an extra
> call to ktime_get_real() - and very useful.

Reviewed-by: Florian Westphal <fw@strlen.de>

