Return-Path: <netdev+bounces-59761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3608D81C031
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 22:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8DA2837A9
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 21:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0337776DAE;
	Thu, 21 Dec 2023 21:34:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D1976DAC
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 21:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rGQfy-0000uP-0C; Thu, 21 Dec 2023 22:33:54 +0100
Date: Thu, 21 Dec 2023 22:33:53 +0100
From: Florian Westphal <fw@strlen.de>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, netdev@vger.kernel.org, jiri@resnulli.us,
	xiyou.wangcong@gmail.com, stephen@networkplumber.org,
	dsahern@gmail.com, fw@strlen.de, pctammela@mojatatu.com,
	victor@mojatatu.com
Subject: Re: [PATCH net-next 0/2] net/sched: retire tc ipt action
Message-ID: <20231221213353.GA12882@breakpoint.cc>
References: <20231221213105.476630-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221213105.476630-1-jhs@mojatatu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> In keeping up with my status as a hero who removes code: another one bites the
> dust.
> The tc ipt action was intended to run all netfilter/iptables target.
> Unfortunately it has not benefitted over the years from proper updates when
> netfilter changes, and for that reason it has remained rudimentary.
> Pinging a bunch of people that i was aware were using this indicates that
> removing it wont affect them.
> Retire it to reduce maintenance efforts.
> So Long, ipt, and Thanks for all the Fish.

Thanks Jamal for following up on this!

Acked-by: Florian Westphal <fw@strlen.de>

