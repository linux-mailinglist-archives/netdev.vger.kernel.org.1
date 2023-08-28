Return-Path: <netdev+bounces-31107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB47678B7EC
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 21:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9562D280EB0
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 19:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE0B13FFF;
	Mon, 28 Aug 2023 19:14:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4287D29AB
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 19:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B71C433C7;
	Mon, 28 Aug 2023 19:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693250076;
	bh=2NTZTvnMlL+IAzhEdSEC+MihfBPJt2Hq6WGmu/EcsCw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LmFYHZSid0kPQkk4tHp1uN9yeFoJNnnY0NK+PFwI8PujYYnwf4Pe5f4civw2leoVd
	 uhFjh00QXRqfb+23LOunnXXAQ70Hy8pJO3x2e47M4IHuhcMBdCLm+dmWrc0KKwnfaN
	 klC3Uyj6rGYkJj7eQsDquIazZe7Ga0qYnOh2G9FuZMMJzz3WdYx/L684wq0j1Y+8hI
	 MKbZKvtEYo8cEGhrwOjleIy6SJb6B/znv241teL7eKYQA1jbi5ZNm6VWn9+E3RXq9Q
	 YGhwxIUs1VkJug7aI8rJiJra6fwOdYopZU8a5L6BFKfEVSse7LLoUoYD31z1ow7Ohh
	 42zRDDoJg23yQ==
Date: Mon, 28 Aug 2023 12:14:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@idosch.org>
Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, David Ahern
 <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Shuah Khan
 <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net v3 3/3] selftests: fib_tests: Add multipath list
 receive tests
Message-ID: <20230828121435.3b76c138@kernel.org>
In-Reply-To: <ZOy8JOjw9W4g8fYa@shredder>
References: <20230828113221.20123-1-sriram.yagnaraman@est.tech>
	<20230828113221.20123-4-sriram.yagnaraman@est.tech>
	<ZOy8JOjw9W4g8fYa@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Aug 2023 18:24:20 +0300 Ido Schimmel wrote:
> Jakub / Paolo, this change conflicts with changes in net-next and I
> assume that the next PR that you are going to send is from net-next.
> What is your preference in this case? Wait for the PR to be accepted and
> for master to be merged into net?

The trees will be merged before the PR, in the next 24h.
As soon as they are you can resend for net-next.

