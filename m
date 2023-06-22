Return-Path: <netdev+bounces-13098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D228F73A364
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 16:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16AE91C21169
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 14:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2686A1E539;
	Thu, 22 Jun 2023 14:44:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A99C18AF0
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 14:44:00 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F2426A5;
	Thu, 22 Jun 2023 07:43:38 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qCLWv-0000VU-6n; Thu, 22 Jun 2023 16:43:25 +0200
Date: Thu, 22 Jun 2023 16:43:25 +0200
From: Florian Westphal <fw@strlen.de>
To: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc: Simon Horman <simon.horman@corigine.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Patrick McHardy <kaber@trash.net>,
	"netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
	"coreteam@netfilter.org" <coreteam@netfilter.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH] netfilter: nf_conntrack_sip: fix the
 ct_sip_parse_numerical_param() return value.
Message-ID: <20230622144325.GC29784@breakpoint.cc>
References: <20230426150414.2768070-1-Ilia.Gavrilov@infotecs.ru>
 <ZEwdd7Xj4fQtCXoe@corigine.com>
 <d0a92686-acc4-4fd8-0505-60a8394d05d8@infotecs.ru>
 <ZFEYpNsp/hBEJAGU@corigine.com>
 <f9d9ac80-704a-91d7-b120-449b921e8bb0@infotecs.ru>
 <ZFEuazEvNWHfEH93@corigine.com>
 <6f2b5c12-82b5-2496-23a3-05ab22d7b14b@infotecs.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f2b5c12-82b5-2496-23a3-05ab22d7b14b@infotecs.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru> wrote:
> Hi, Simon.
> I'm sorry to bother you.
> Will this patch be applied or rejected?

Please resend, keeping Simons Reviewd-by tag.
Please update the commit message as per your and Simons
conversation, i.e. that the return value is now a tristate,
0 for not found and -1 for 'malformed' and that you checked
all callers that they will do the right thing.

