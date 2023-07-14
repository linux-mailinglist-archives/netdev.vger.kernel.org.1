Return-Path: <netdev+bounces-17787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA707530B5
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 06:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12D8281FE0
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 04:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C232010F0;
	Fri, 14 Jul 2023 04:50:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78166A59
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 04:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E998CC433C7;
	Fri, 14 Jul 2023 04:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689310249;
	bh=EcQVGwWcJPMYxthhMryajaVCcmz6AHwCcf1NupuDKag=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=PqKLZx74vek/k7fNDzHgHyawsDb7rqGJEP79fRXcwxTZBz68d8p5lzJNzHDVe8wKT
	 Gg7/Fl2pGNt/+zOppdhDpNO6uSRwKUVCxApEKODxem54Ym9KFTQyM7BWBcqW1G+huK
	 TX0C3Q5GEkEq1+zOgnGJv46D7fiUrXQ0uLbBvIj8XYX7PZ8Lne4m+NrgY3Q4kdd7LE
	 sSNIm50wnH8GieelBGg/tC4cAQD03tA6BMxdyWEcdqESmKJ9pdDaXcdvifHrGPh26k
	 AiVdOqiuINwuS2ylsZR8/LcsrQihKmZ7UxwaLMoC33bj7UMjYvcVe4lpxtkYYrtrHa
	 QQPrkgVWH2SaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7C613CE009E; Thu, 13 Jul 2023 21:50:43 -0700 (PDT)
Date: Thu, 13 Jul 2023 21:50:43 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Networking <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the rcu tree
Message-ID: <6f655ef5-b236-4683-92b0-da8b19e79eca@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230714144330.3c0a4074@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714144330.3c0a4074@canb.auug.org.au>

On Fri, Jul 14, 2023 at 02:43:30PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in net-next tree as a different commit
> (but the same patch):
> 
>   a2b38823280d ("rcu: Export rcu_request_urgent_qs_task()")
> 
> This is commit
> 
>   43a89baecfe2 ("rcu: Export rcu_request_urgent_qs_task()")
> 
> in the net-next tree.

The net-next tree needs it for BPF, correct?  So if you guys intend to
push it to mainline, I will be happy to drop if from -rcu.

Either way, please let me know!

							Thanx, Paul

