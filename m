Return-Path: <netdev+bounces-38019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AEC7B8651
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 19:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E163F28163C
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 17:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF611CAA3;
	Wed,  4 Oct 2023 17:19:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFEC18B1C
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 17:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8EEC433C9;
	Wed,  4 Oct 2023 17:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696439984;
	bh=gAEn4eId1x0ecJC5aSVKxPnIT1WkxCZer2buCoCNdH8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UqXPKV9aw3sQ2ReXHrJZtAn10tcSHUsRGhUwG7zyuBx/2+iTVaM4Fr2SYz04NvYK8
	 Swd3oKvd6VYBi5FS0qu/+Eq0cXWkTpq4v1ODhGwMB6QDdrTlQuE4zk1Gg/Aatu7Ayf
	 rmFrOzKgh3PPacx/KUrymD+2V7uP8lyxfWr1aiW7Zr84cMfAEE2RMphVKjNMdSOFWS
	 jqASNYltO1zLHO/250Hg9AwPB9YoDIOTi9CK+T+v5fZvolyZ82NC5XXkPXm//IxKew
	 XD0wuwBRELjcLOaZAkMGIZH76bTcemVf5Ld/Tkq96T9eKTc+Zf+uskXcP6s8G8PcMe
	 ORq9tq8wH2DFQ==
Date: Wed, 4 Oct 2023 10:19:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yury Norov <yury.norov@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>
Cc: Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, Tariq Toukan
 <ttoukan.linux@gmail.com>, Valentin Schneider <vschneid@redhat.com>, Maher
 Sanalla <msanalla@nvidia.com>, Ingo Molnar <mingo@kernel.org>, Mel Gorman
 <mgorman@suse.de>, Leon Romanovsky <leon@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Peter Zijlstra
 <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>, Pawel Chmielewski
 <pawel.chmielewski@intel.com>, Jacob Keller <jacob.e.keller@intel.com>,
 Yury Norov <ynorov@nvidia.com>
Subject: Re: [PATCH 1/4] net: mellanox: drop mlx5_cpumask_default_spread()
Message-ID: <20231004101942.11feab87@kernel.org>
In-Reply-To: <ZRzAcJInEJtYuOKi@yury-ThinkPad>
References: <20230925020528.777578-1-yury.norov@gmail.com>
	<20230925020528.777578-2-yury.norov@gmail.com>
	<2fd12c42d3dd60b2e9b56e9f7dd37d5f994fd9ac.camel@redhat.com>
	<ZRwbKRnnKY/tDqCF@yury-ThinkPad>
	<20231003152030.6615437c@kernel.org>
	<ZRzAcJInEJtYuOKi@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Oct 2023 18:31:28 -0700 Yury Norov wrote:
> > We're half way thru the release cycle the conflicts can still come in.
> > 
> > There's no dependency for the first patch. The most normal way to
> > handle this would be to send patch 1 to the networking tree and send
> > the rest in the subsequent merge window.  
> 
> Ah, I understand now. I didn't plan to move it in current merge
> window. In fact, I'll be more comfortable to keep it in -next for
> longer and merge it in v6.7.
> 
> But it's up to you. If you think it's better, I can resend 1st patch
> separately.

Let's see if Saeed can help us.

Saeed, could you pick up patch 1 from this series for the mlx5 tree?

