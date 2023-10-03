Return-Path: <netdev+bounces-37807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A26147B7410
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 00:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 2D6BE281353
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 22:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8AE3E47B;
	Tue,  3 Oct 2023 22:20:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2633E466
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 22:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E06C433C7;
	Tue,  3 Oct 2023 22:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696371632;
	bh=6y7yOpF3hjHEJEXpBlwtl2/qKv3st7gL0H1Sn9YwJ/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d6fGfUSB/RevS+9tgve/tqb2SRL6fKIqm9H46Id+jA16c1ZtbNLoHfdiot7Z0avH/
	 8fUhvxnJo9+tf3WaebkNXxXEfpht3HnVSic6aTWuur491PgIL31+OLJdyU3ykW7D25
	 QG0AZVIJTOuVUsFj0PCtRcmq3EO72FAVL8cMIr8vXfqhdJ/vmpUuhKIgaF3SdZKc9w
	 iAin2Uu9qIiWO96cCFoi+PtxnDy3fIRhVeZ7rt0yG5SVB8cXupZYwAs9jl2ZxlWTAe
	 Y0aWqfNE5mpfVLQgRfClFz338e3TALHiZPEYDmLN13cCTjwcr8+b1YXISEAA4xWs3c
	 /H7ulb9LfNwyw==
Date: Tue, 3 Oct 2023 15:20:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, Tariq Toukan
 <ttoukan.linux@gmail.com>, Valentin Schneider <vschneid@redhat.com>, Maher
 Sanalla <msanalla@nvidia.com>, Ingo Molnar <mingo@kernel.org>, Mel Gorman
 <mgorman@suse.de>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Daniel Bristot de
 Oliveira <bristot@redhat.com>, Pawel Chmielewski
 <pawel.chmielewski@intel.com>, Jacob Keller <jacob.e.keller@intel.com>,
 Yury Norov <ynorov@nvidia.com>
Subject: Re: [PATCH 1/4] net: mellanox: drop mlx5_cpumask_default_spread()
Message-ID: <20231003152030.6615437c@kernel.org>
In-Reply-To: <ZRwbKRnnKY/tDqCF@yury-ThinkPad>
References: <20230925020528.777578-1-yury.norov@gmail.com>
	<20230925020528.777578-2-yury.norov@gmail.com>
	<2fd12c42d3dd60b2e9b56e9f7dd37d5f994fd9ac.camel@redhat.com>
	<ZRwbKRnnKY/tDqCF@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Oct 2023 06:46:17 -0700 Yury Norov wrote:
> Can you elaborate on the conflicts you see? For me it applies cleanly
> on current master, and with some 3-way merging on latest -next...

We're half way thru the release cycle the conflicts can still come in.

There's no dependency for the first patch. The most normal way to
handle this would be to send patch 1 to the networking tree and send
the rest in the subsequent merge window.

