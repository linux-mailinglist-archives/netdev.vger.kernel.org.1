Return-Path: <netdev+bounces-24212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F79D76F3F1
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 22:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE6B2807AC
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 20:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3685C263B1;
	Thu,  3 Aug 2023 20:17:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E82B1F185
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 20:17:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B523C433C7;
	Thu,  3 Aug 2023 20:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691093857;
	bh=hlTj8FWRP+KeRJXeZVASlq4tZOs+3Sg5LkjuhZmjEus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X+V3mnjg9poQaRgLspkDIpPUtSDANk8xOsdike2zUz40tJsj/cNBi9s2y5xKnsDj8
	 QW5OxmdJL5UdhNNHQZoy+LCCGwYkTPsG2x5EFVF64qZgRi83BiEj6B3BBVHGUl6AZX
	 wGARIlvj/L6CIHVqjaCwg7YXIt7w27+YTgptOEWrysiZPRdXgtej4UqHZ8B5HXdpMB
	 1Gob8LAGO+ydXPfpivHJR5uE8R/aVyuJmbRO96vxXvaRGQgwEEFw2be1IvyjBhVoKI
	 U2Pc6LnrXW6cifer60tcAVyYhEfSpsvSoSNaZYW4nw5G7NdRpeJw3teEH64z/Kqp3S
	 jDWMKRylQW4iQ==
Date: Thu, 3 Aug 2023 22:17:31 +0200
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] tcp_metrics: hash table allocation cleanup
Message-ID: <ZMwLWw7DiMNeDeoO@kernel.org>
References: <20230803135417.2716879-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803135417.2716879-1-edumazet@google.com>

On Thu, Aug 03, 2023 at 01:54:16PM +0000, Eric Dumazet wrote:
> After commit 098a697b497e ("tcp_metrics: Use a single hash table
> for all network namespaces.") we can avoid calling tcp_net_metrics_init()
> for each new netns.
> 
> Instead, rename tcp_net_metrics_init() to tcp_metrics_hash_alloc(),
> and move it to __init section.
> 
> Also move tcpmhash_entries to __initdata section.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


