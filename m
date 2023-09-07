Return-Path: <netdev+bounces-32441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 199FE797947
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 19:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9261C20BB4
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 17:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34A2134DD;
	Thu,  7 Sep 2023 17:09:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E6813AC0
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 17:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62B6C433AB;
	Thu,  7 Sep 2023 17:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694106573;
	bh=sDlwvUjTGCoXbRBzHl54v5TrXLHp5jTS3+4M5/2djHg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fp7FkNHcbJr2lZK3+58D03pf1aMVjzvsy9up5Ocy0GZRoO9w/xt7FeAVcQXBX3AG8
	 uwGZsB5bNOE39B0AhxAqkc2t/JQ2xdxt2413oaH7L+JPUYkREa/Yb43+mOpAzC63FF
	 6UN8WyqZRVB4UCNIFWhIkFEuHDtQ00eUzgVOx6sguBhQAWk1t4BCABQYtt4gZtxWJp
	 Zjk3XGGQFC9MRRNhaBwXyB7tDPjul98AQJJrVmYYXbO0XUgcWEbyTx/pSwf+oV6Cts
	 Kx3CdgXWKyeohhISQF4suuV+e41PPyTmXmwzElz83SolSIEz3k1Aj1gI6cJAwHIET/
	 z5wnW/oz79j5A==
Date: Thu, 7 Sep 2023 10:09:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, Soheil
 Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>,
 Yuchung Cheng <ycheng@google.com>
Subject: Re: [RFC net-next 4/4] tcp: defer regular ACK while processing
 socket backlog
Message-ID: <20230907100932.58daf8e5@kernel.org>
In-Reply-To: <20230906201046.463236-5-edumazet@google.com>
References: <20230906201046.463236-1-edumazet@google.com>
	<20230906201046.463236-5-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Sep 2023 20:10:46 +0000 Eric Dumazet wrote:
> This idea came after a particular workload requested
> the quickack attribute set on routes, and a performance
> drop was noticed for large bulk transfers.

Is it okay if I asked why quickack?
Is it related to delay-based CC?

