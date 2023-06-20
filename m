Return-Path: <netdev+bounces-12337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E87197371E4
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 18:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C73281458
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 16:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BA92AB23;
	Tue, 20 Jun 2023 16:38:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA07B2AB20
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 16:38:23 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A676C0;
	Tue, 20 Jun 2023 09:38:21 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qBeMo-0002WT-Fi; Tue, 20 Jun 2023 18:38:06 +0200
Date: Tue, 20 Jun 2023 18:38:06 +0200
From: Florian Westphal <fw@strlen.de>
To: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [lvc-project] [PATCH] netfilter: ebtables: remove unnecessary
 NULL check
Message-ID: <20230620163806.GB3799@breakpoint.cc>
References: <20230620152549.2109063-1-Igor.A.Artemiev@mcst.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620152549.2109063-1-Igor.A.Artemiev@mcst.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Igor Artemiev <Igor.A.Artemiev@mcst.ru> wrote:
> In ebt_do_table() 'private->chainstack' cannot be NULL
> and the 'cs' pointer is dereferenced below, so it does not make
> sense to compare 'private->chainstack' with NULL. 

?  Why do you think that?

> +	cs = private->chainstack[smp_processor_id()];

Looks like NULL deref to me.  Did you test this?

