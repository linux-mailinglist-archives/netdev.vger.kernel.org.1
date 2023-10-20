Return-Path: <netdev+bounces-43055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 262EC7D1329
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 17:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED853B213AD
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 15:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFED1E517;
	Fri, 20 Oct 2023 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZK2wqGMg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB0B1E515
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 15:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A166EC433C9;
	Fri, 20 Oct 2023 15:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697817160;
	bh=RQbAD0w6npd/FFPPPsOmLmBAxljIFEFg4+88J7KQD74=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZK2wqGMgpq9AYh5ih48qeGf7JCJQjX9jJa15JKgcrmGobaokWzX0MrfKAVmiKkR3u
	 nF9/YKkWfFx7iMxW3aArxMcWC1pFlJv3t/zkdxEd8PIRpjHpPmWeyBAr3nCbBYiBKN
	 Dj2jt8R9N09k3pyEti6mKoCS2hvenl09N83fIbmlZJAvFfiAoMhVKLuavcYdBHq4GR
	 bZMNxYHH+gT72u315aOAaJlF/3ahjGYmrFXPs7QXy018M73GwgiMPZU8xH/6PqY9lo
	 RgOrTxaNUrsYijldQF6lA7DYKsJLSwy5hUC4NBnlCtmICUSKzGimXAXx7ulTn9Daw8
	 WFcUjVEtD+U+w==
Message-ID: <a702a703-badd-cfa7-6963-54830a0570ea@kernel.org>
Date: Fri, 20 Oct 2023 09:52:39 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 2/5] ipv6: remove "proto" argument from
 udp_tunnel6_dst_lookup()
Content-Language: en-US
To: Beniamino Galvani <b.galvani@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Guillaume Nault <gnault@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20231020115529.3344878-1-b.galvani@gmail.com>
 <20231020115529.3344878-3-b.galvani@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231020115529.3344878-3-b.galvani@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/23 5:55 AM, Beniamino Galvani wrote:
> The function is now UDP-specific, the protocol is always IPPROTO_UDP.
> 
> This is similar to what already done for IPv4 in commit 78f3655adcb5
> ("ipv4: remove "proto" argument from udp_tunnel_dst_lookup()").
> 
> Suggested-by: Guillaume Nault <gnault@redhat.com>
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  drivers/net/bareudp.c     | 5 ++---
>  include/net/udp_tunnel.h  | 2 +-
>  net/ipv6/ip6_udp_tunnel.c | 4 +---
>  3 files changed, 4 insertions(+), 7 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



