Return-Path: <netdev+bounces-190539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDC9AB76FD
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 22:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7077F3B0FCD
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 20:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CA22951CF;
	Wed, 14 May 2025 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJF5g6P9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D07921A931;
	Wed, 14 May 2025 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747254264; cv=none; b=oqzi9ie2Bc9p3iQkYzXUZQ/IZNL/4rX9EixW5UboVRAqnNIdXjAkM+DoFcKGNNUuN15m8WuSOl4nk0i6M9CazfHQgVyb/cbdPoGNAcgvp5ekfsRZczTsM7D5RJx7C473iHjjEe0CFgclCd+9eqAK5rg+JzskoUod5PuhYOmnGfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747254264; c=relaxed/simple;
	bh=msa1LqxW5AvR3sfRZ839tg6nnH96HOc0aqjlK01yMcM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zu4gzdlsSIxdnOW3WV1uPL7vuJ/tfTwyOT6Lr2ehzdTawaote+rkYPVGc6HMhJKcA+JczzNsLQozKVkP7m2iDWpH+uFcj3gNeJFAMxjyAss2KUvo38SKjBxzEoynHbg+ooIGM5e7HK2IBG5gNYIeYBAKWeo153DcIwypAmYJRcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJF5g6P9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A53C4CEE3;
	Wed, 14 May 2025 20:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747254263;
	bh=msa1LqxW5AvR3sfRZ839tg6nnH96HOc0aqjlK01yMcM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZJF5g6P9yJCI7jB02ZX0NhfmoSzcG0gNK05ljaOI0LlO/uGeJ1mbClJ05OFKr+5xA
	 9pUoAKwvTaRI4Kupimn6mSa4M/TgjtTYqpyGCfgXffh/8A/wQLPATcII3CLZYyoCEc
	 BfblblSuERDnWR8yGFFINL7V6yxP4Wn4gvdNnil/ZSBFnRZT9eAwWZbQQtb58SJN9r
	 +PByM5jTopoPbS1qIFZjdNp/ZByTMHbVnztKKId+3BGKXyl3jT+WjYDcwgfvd8ZAUW
	 EI70M11UiiSQ0WfzpGG515QnyAU5g19iZ/oJ1UxErENEWFByMckrHb5uhi3G8+Izy+
	 QBwiFly4uifWg==
Date: Wed, 14 May 2025 13:24:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Neal Cardwell
 <ncardwell@google.com>, Simon Horman <horms@kernel.org>, Rick Jones
 <jonesrick@google.com>, Wei Wang <weiwan@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 11/11] tcp: increase tcp_rmem[2] to 32 MB
Message-ID: <20250514132422.2eefdbf1@kernel.org>
In-Reply-To: <20250513193919.1089692-12-edumazet@google.com>
References: <20250513193919.1089692-1-edumazet@google.com>
	<20250513193919.1089692-12-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 May 2025 19:39:19 +0000 Eric Dumazet wrote:
> Last change to tcp_rmem[2] happened in 2012, in commit b49960a05e32
> ("tcp: change tcp_adv_win_scale and tcp_rmem[2]")
> 
> TCP performance on WAN is mostly limited by tcp_rmem[2] for receivers.
> 
> After this series improvements, it is time to increase the default.

I think this breaks the BPF syncookie test, Kuniyuki any idea why?

https://github.com/kernel-patches/bpf/actions/runs/15016644781/job/42196471693

