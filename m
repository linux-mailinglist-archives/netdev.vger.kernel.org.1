Return-Path: <netdev+bounces-43057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB84D7D1346
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 17:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC38D1C20D1C
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 15:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC091E51D;
	Fri, 20 Oct 2023 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQIPUoz9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C771DA5F
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 15:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B51C433C7;
	Fri, 20 Oct 2023 15:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697817405;
	bh=R6WXWf2U9PhFFtx/uOATxce8vfrGvQFpSyZOtJdAxr4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DQIPUoz9meDLqmycvoJTtR/MPQql0wfDQMYwdhxDEIVbMW5nooQJq7Us7Q2QyKtKW
	 KGZNRc5kIzK/o3HI3q+fCs5yt9mU/xD5P8xvR1/3ahXr5vxg0zgo1qsPusAEusnlAr
	 nq5MGRYaENATQdetc27rzl1WSuati/CWsuFUG03eeFIQ1fHrmc0He0jT36K4uDvaHC
	 UEFGloKW/psOFx6rxAz12I6oI4jQfwhSMKnGe2X9RoMgNfvY+EhACunzqjY4/wznOc
	 2TGDv0zfJFw5G8NR1dx+vCUE/RYNKRG3WPynbcgQzFRntz74e6UshhRzdvuxzEat74
	 g8lO04fxzYtnw==
Message-ID: <e4291747-cb1f-ce81-cc86-83bb6790e1af@kernel.org>
Date: Fri, 20 Oct 2023 09:56:44 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 4/5] geneve: use generic function for tunnel IPv6
 route lookup
Content-Language: en-US
To: Beniamino Galvani <b.galvani@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Guillaume Nault <gnault@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20231020115529.3344878-1-b.galvani@gmail.com>
 <20231020115529.3344878-5-b.galvani@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231020115529.3344878-5-b.galvani@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/23 5:55 AM, Beniamino Galvani wrote:
> The route lookup can be done now via generic function
> udp_tunnel6_dst_lookup() to replace the custom implementation in
> geneve_get_v6_dst().
> 
> This is similar to what already done for IPv4 in commit daa2ba7ed1d1
> ("geneve: use generic function for tunnel IPv4 route lookup").
> 
> Suggested-by: Guillaume Nault <gnault@redhat.com>
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  drivers/net/geneve.c | 96 ++++++++++++++------------------------------
>  1 file changed, 31 insertions(+), 65 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



