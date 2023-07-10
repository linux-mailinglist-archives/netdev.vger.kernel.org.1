Return-Path: <netdev+bounces-16510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D3874DA8A
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 17:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B7E21C20A7B
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 15:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5762512B8A;
	Mon, 10 Jul 2023 15:50:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2D312B87
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 15:50:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB981C433C9;
	Mon, 10 Jul 2023 15:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689004230;
	bh=ujUND67ysedfOJcnpq0izCtjDzDV1Go55+afJoHmEzg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PDuthxJZis4IrtB0OZr1lgi9c6fhan+1dxoIiOFPXVmmoNmJzRgzzpqpwOi7Wuyis
	 ZmOWtDRBdLONBahbvZ/nc7q1ZiMTt71yHzj5EONkd03wlG1+TCRdFecU41tHCOG8yI
	 JJo9Bdx0Tgg3qWm3SQFYssbUo6zDZJyXOIluEcu9rjNoezuPvLRIa9MHV9iRJqxJP5
	 9+CJuE1stgv2zItirDHPfHvHYAaIevutuwL2QJQCzcv5F6WGpJ/L8r6lIEupifKHJY
	 kuLN3dpEztjy3QrLobCkDr8b97dH2T4XxyL2pRJ48lAMO+ve6qRV5eS/IFdrqYHj1K
	 bbQcxMSREpirw==
Message-ID: <2291aa12-3081-5e65-dc64-bf3d4349dfea@kernel.org>
Date: Mon, 10 Jul 2023 09:50:28 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 1/1] net: gro: fix misuse of CB in udp socket lookup
Content-Language: en-US
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, willemdebruijn.kernel@gmail.com, tom@herbertland.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com
References: <20230707121650.GA17677@debian> <20230707122627.GA17845@debian>
 <1340947f-2f66-e93d-9dab-055e40e1f9f9@kernel.org>
 <20230710145817.GB22009@debian>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230710145817.GB22009@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/23 8:58 AM, Richard Gobert wrote:
>> put your cover letter details in here; no need for a cover letter for a
>> single patch.
> 
> I believe some details are irrelevant to the bugfix itself,
> I prefer to avoid overloading the commit message...
> Do you think there is a specific part of the cover letter that
> should be added to the commit message?
> 
>> there are existing iif and sdif lookup functions. I believe this gro
>> path needs a different version, but it should have a comment of when it
>> can be used vs the existing ones. Also, it is small enough to be an
>> inline like the existing ones. e.g., see inet_sdif
> 
> I was under the impression the coding style of Linux does not
> encourage placing the inline keyword.
> In which cases do you think I should add it?

See the existing *_sdif helpers in include/net/ip.h,
include/linux/ipv6.h and include/net/tcp.h.

