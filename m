Return-Path: <netdev+bounces-20085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6796475D8DC
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 04:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660051C21880
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 02:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0217663C1;
	Sat, 22 Jul 2023 02:00:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3916613D
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 02:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC0FC433C8;
	Sat, 22 Jul 2023 02:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689991228;
	bh=9uaeXtxe4unZzbrIeFOhj1LzJcUKV2mGuq4o1uAw0cw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tq57IEXA3V3bPLE7IqAXsNIDw83qnvuWC/7JiN0TVr4/b51rQQXE8zAeitvFDSBG6
	 Cx2l/wkn0p0gSGmT6A7Dth6uEnE5NnZ1QwQO+Jw3hLEn/iQZ2YyyNhV9v5XiyJCYrz
	 hXiHhl/i7HNaP0+Rlg/3MErG76d519LXsm5i9XagsrJQ4MmVtHZKcf4UodsVYpB4y0
	 FN+RndIytcKzG8eLGVujmEF5jJAII6top9L+0Af+tl1aEd8aGbcOZK1NBgbfUR7eF5
	 4viMHwvsq9qdTPYDh4v/Zris+2EEFfotxsYSPWzRwvV4VEWJOvTLM4JTFXFZOc9NNI
	 4UxpciaFuhKIg==
Date: Fri, 21 Jul 2023 19:00:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCHv8 0/6] net/tls: fixes for NVMe-over-TLS
Message-ID: <20230721190026.25d2f0a5@kernel.org>
In-Reply-To: <20230721143523.56906-1-hare@suse.de>
References: <20230721143523.56906-1-hare@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jul 2023 16:35:17 +0200 Hannes Reinecke wrote:
> here are some small fixes to get NVMe-over-TLS up and running.
> The first set are just minor modifications to have MSG_EOR handled
> for TLS, but the second set implements the ->read_sock() callback for tls_sw
> which I guess could do with some reviews.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Sagi, I _think_ a stable branch with this should be doable,
would you like one, or no rush?

