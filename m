Return-Path: <netdev+bounces-24552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A877770928
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 21:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8B01C20AF5
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 19:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D491BF13;
	Fri,  4 Aug 2023 19:41:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B8D440E
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 19:40:59 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFE3E7;
	Fri,  4 Aug 2023 12:40:58 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qS0fP-0007ip-9T; Fri, 04 Aug 2023 21:40:55 +0200
Date: Fri, 4 Aug 2023 21:40:55 +0200
From: Florian Westphal <fw@strlen.de>
To: Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Cc: Florian Westphal <fw@strlen.de>, coreteam@netfilter.org,
	kadlec@netfilter.org, Pablo Neira Ayuso <pablo@netfilter.org>,
	Linux Network Development Mailing List <netdev@vger.kernel.org>,
	Netfilter Development Mailing List <netfilter-devel@vger.kernel.org>,
	Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH netfilter] netfilter: nfnetlink_log: always add a
 timestamp
Message-ID: <20230804194055.GO30550@breakpoint.cc>
References: <20230725085443.2102634-1-maze@google.com>
 <20230727135825.GF2963@breakpoint.cc>
 <CANP3RGfL1k6g8XCi50iEMEYwOfsMmr-y-KB=0N=jGV8hzcoSeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANP3RGfL1k6g8XCi50iEMEYwOfsMmr-y-KB=0N=jGV8hzcoSeA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Maciej Żenczykowski <maze@google.com> wrote:
> On Thu, Jul 27, 2023 at 3:58 PM Florian Westphal <fw@strlen.de> wrote:
> >
> > Maciej Żenczykowski <maze@google.com> wrote:
> > > Compared to all the other work we're already doing to deliver
> > > an skb to userspace this is very cheap - at worse an extra
> > > call to ktime_get_real() - and very useful.
> >
> > Reviewed-by: Florian Westphal <fw@strlen.de>
> 
> I'm not sure if there's anything else that needs to happen for this to
> get merged.

This is fine, it'll be merged for -next.

