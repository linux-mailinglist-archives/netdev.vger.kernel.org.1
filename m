Return-Path: <netdev+bounces-17972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAFB753E54
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 17:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0579D1C21588
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 15:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31E213AEB;
	Fri, 14 Jul 2023 15:03:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121EDEEA8
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 15:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77450C433C7;
	Fri, 14 Jul 2023 15:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689347016;
	bh=/M6rpxZ4WdePzzrxfvLXx66B0T8N+zk54mUpfPJ55ME=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=pryQQxY8RibjdCnVtdB5bg1xbQPwTPhCcH4TDXNi2pZAMQNRGSyYbZlSORu/QzGRt
	 I/Vl2YFUVLWBhfDZKM+qV3MoueRs0lm+mp+fxYfGclt3Hm3qjDamEQNaa+c3ZtULT+
	 83plr7PBETVHHfePuu9PqqncCpINUh5G1LkNNZcQHu+6GXj37OvMltvzszY+TlYoNY
	 KEU55pCDM+hXliTJO0LojuI0kaUjyhwnzVx/T9kE0qKmWnx7eMPb/CeH6LOlsujws8
	 JOlwr860hn6wbyQSZFzQa1ZLapsVAI/G8Bd0yV3EuBTuTH9GMWmsa5bPhWg2yXriwP
	 JNtYqVXR7F2yA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0637ACE0070; Fri, 14 Jul 2023 08:03:36 -0700 (PDT)
Date: Fri, 14 Jul 2023 08:03:36 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Networking <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the rcu tree
Message-ID: <f8f3ed8c-66c1-4a07-8fe8-f7bb997a7dcf@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230714144330.3c0a4074@canb.auug.org.au>
 <6f655ef5-b236-4683-92b0-da8b19e79eca@paulmck-laptop>
 <CAADnVQLF0BP-_Fjxi1S-0Shus38vAVdNbB2JHsBd6_RudYWF0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLF0BP-_Fjxi1S-0Shus38vAVdNbB2JHsBd6_RudYWF0A@mail.gmail.com>

On Thu, Jul 13, 2023 at 11:04:11PM -0700, Alexei Starovoitov wrote:
> On Thu, Jul 13, 2023 at 9:50 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Jul 14, 2023 at 02:43:30PM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > The following commit is also in net-next tree as a different commit
> > > (but the same patch):
> > >
> > >   a2b38823280d ("rcu: Export rcu_request_urgent_qs_task()")
> > >
> > > This is commit
> > >
> > >   43a89baecfe2 ("rcu: Export rcu_request_urgent_qs_task()")
> > >
> > > in the net-next tree.
> >
> > The net-next tree needs it for BPF, correct?
> 
> yes.
> 
> > So if you guys intend to
> > push it to mainline, I will be happy to drop if from -rcu.
> 
> That's the intent. Please drop it from -rcu.

Very good, it goes on my next rebase later today, Pacific Time.

						Thanx, Paul

