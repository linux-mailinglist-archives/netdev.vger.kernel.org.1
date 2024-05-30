Return-Path: <netdev+bounces-99273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9ED8D4431
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 05:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FD0BB24809
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 03:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAAA139579;
	Thu, 30 May 2024 03:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+McAG2P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE52139566
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 03:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717039945; cv=none; b=BiLT8yHVD7vm7Zya0PLkrX/789OwoBCsCPh52d7l/2pLPzNfRByCxiTq5PW0BB2d3ko7wBGPStJZXTdoodIEBo5qLAz7hxDXNzrH5KaQ81H/7lNDwwrW5XfPnQVH/zRE4Q7WffhZLBquSYOCqlFKSLQQ3aHs2wSQyfTL+fx55Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717039945; c=relaxed/simple;
	bh=QdjBA/cGJKxHSqdrkpKs+wmuBb/1Tv41LF2zB1jMHc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3p6tZ0yyj3d7hlwoGeQKYmDyvIxSThsBXsn4Z7op6yMpooCiNCOXma1h9wejXy2vSdy4QjkPnmkyHiV13EjNAZ+RGA7yqyuI+DRBMUdgkK456Xygf47aHXES5JZMp6zoiogK2KSS8BiTlzPELwqJcnNdA3a02Xyl2voQPgZ1Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+McAG2P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A1AC116B1;
	Thu, 30 May 2024 03:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717039944;
	bh=QdjBA/cGJKxHSqdrkpKs+wmuBb/1Tv41LF2zB1jMHc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y+McAG2PTD0WQnWE89Zy4JvwRY/OYNjFQbYBIG3VyetJDXEAX/dQsD/b6kBKKVron
	 Ws7jYLLLKUr8qpKdRornTPS0Ypp3nZNHLVZyZUX+beDnet5fCYJjL4rLlVTzH0+os3
	 aIQZc6+oqT9KW1cWDOzuDUMT6gskaNSoVPG7tPslAiIqAdLm8xqqNdbow59kpC+Uye
	 s0Nec4PDBePe5JyN6LSuN5S7Mw6vHkE+E1v970Vaa3ph4pztCHb0zmHb3xwD1F5nat
	 iWxBvqzRVqfJZudxW9If5yXRC6/g1xiKhF7NcRBMrAHTCUCSdBxyXu/pDakapxoKlS
	 vRwGxkPVqVmWQ==
Date: Wed, 29 May 2024 20:32:23 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 11/15] net/mlx5e: SHAMPO, Add no-split ethtool
 counters for header/data split
Message-ID: <ZlfzR_UV9CcCjR99@x130.lan>
References: <20240528142807.903965-1-tariqt@nvidia.com>
 <20240528142807.903965-12-tariqt@nvidia.com>
 <20240529182208.401b1ecf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240529182208.401b1ecf@kernel.org>

On 29 May 18:22, Jakub Kicinski wrote:
>On Tue, 28 May 2024 17:28:03 +0300 Tariq Toukan wrote:
>> +   * - `rx[i]_hds_nosplit_packets`
>> +     - Number of packets that were not split in modes that do header/data split
>> +       [#accel]_.
>> +     - Informative
>> +
>> +   * - `rx[i]_hds_nosplit_bytes`
>> +     - Number of bytes that were not split in modes that do header/data split
>> +       [#accel]_.
>> +     - Informative
>
>This is too vague. The ethtool HDS feature is for TCP only.
>What does this count? Non-TCP packets basically?
>

But this is not the ethtool HDS, this is the mlx5 HW GRO hds.
On the sane note, are we planning to have different control knobs/stats for
tcp/udp/ip HDS? ConnectX supports both TCP and UDP on the same queue, 
the driver has no control on which protocol gets HDS and which doesn't.

>Given this is a HW-GRO series, are HDS packets == HW-GRO eligible
>packets?
>

No, UDP will also get header data split or other TCP packets that don't
belong to any aggregation context in the HW.


