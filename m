Return-Path: <netdev+bounces-14224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5486673FA0E
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 12:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11438281074
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 10:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC76174D6;
	Tue, 27 Jun 2023 10:20:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04F717727
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 10:20:07 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D572109;
	Tue, 27 Jun 2023 03:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QpIG8zIiPiSqoF8aX8idnXur9dqkJW4/QKoTrZH8cD8=; b=AvSWYAQNpQ/maAcKP7sl2uAWaM
	r8VUkC/gUpf8gqV4fszhxttZkOR2LWKnEc87QNlx02OHUeHuUts/aXwTibIk39V5MnW2AcRRxkFw/
	A5XYNmTvrwPSkdZqKNBuRoxZrePTBbZaP9Y1fHc3WOYafzBheEm/pdMdp/JftCUyKwlTmQLUhkkgO
	E5bE9FwoMVtR525XRJIhz1KEncHrv9TwrCTeIrqVtuiHNK4ELXfXcDrCfNZIsKJCz+H+LwZmJiLNU
	tB3d2WpFl5GpcyT6+4gZxPQsriZBPZcc2owzmgLkK5DEA6frQWGkpyGMtkQCmLDXJy7r6s1NWxF9P
	e47EPxlA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qE5nR-004e0Y-1h;
	Tue, 27 Jun 2023 10:19:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A8D5300118;
	Tue, 27 Jun 2023 12:19:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3790924A40809; Tue, 27 Jun 2023 12:19:39 +0200 (CEST)
Date: Tue, 27 Jun 2023 12:19:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lingutla Chandrasekhar <clingutla@codeaurora.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"J. Avila" <elavila@google.com>,
	Vivek Anand <vivekanand754@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux Netfilter Development <netfilter-devel@vger.kernel.org>,
	Netfilter Core Developers <coreteam@netfilter.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Linux Power Management <linux-pm@vger.kernel.org>, x86@kernel.org
Subject: Re: Fwd: High cpu usage caused by kernel process when upgraded to
 linux 5.19.17 or later
Message-ID: <20230627101939.GZ4253@hirez.programming.kicks-ass.net>
References: <01ac399d-f793-49d4-844b-72cd8e0034df@gmail.com>
 <ZJpJkL3dPXxgw6RK@debian.me>
 <20230627073035.GV4253@hirez.programming.kicks-ass.net>
 <99b64dfd-be4a-2248-5c42-8eb9197824e1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99b64dfd-be4a-2248-5c42-8eb9197824e1@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 27, 2023 at 05:15:42PM +0700, Bagas Sanjaya wrote:
> On 6/27/23 14:30, Peter Zijlstra wrote:
> > I can't tell from this. Also, please don't use bugzilla.
> 
> Why not BZ? I'm confused too...

Because we have email; and why would I want to touch a browser for this?

