Return-Path: <netdev+bounces-21955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6A5765743
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 17:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 687191C21679
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 15:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0096B17757;
	Thu, 27 Jul 2023 15:18:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55C610794
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 15:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B7CC433C8;
	Thu, 27 Jul 2023 15:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690471116;
	bh=fenBB2koth1e4ENrWoam6lBTZg1giD0geQV42gDcvfY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sKz/UbI0/kqKM/s8TYPiHz9StYpJ9ZKlFPJMQdHHcbp411c4JLD6ebN2YN0xrJEpq
	 2EOUC69sh+Fv7Cwt1sXf7dCK8mjlLDeomCugo+xLBdrGtbX7O/U9gTWmhTBFCY609V
	 HBpir8YYT2o9+jrlbyAzedi4unblB5gosVQjxfO2Bhp7r/+Rlo2csTZNkzWWEe8Tc3
	 r04uOEJwDBwleCNctaPakZcY47SVazUJQEai+ScISTilCHqGiM00ey1BMF3esuB33b
	 VV5NxQjeyv83ySJvM5AgOGHj12Nv6lblMe565qq/TzQ8TnuPPvKf4oSOOPbcKXJv9D
	 ohyE3whgXgcEw==
Message-ID: <39c14f96-3787-2781-145c-37837e13e782@kernel.org>
Date: Thu, 27 Jul 2023 09:18:35 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] net: remove comment in ndisc_router_discovery
Content-Language: en-US
To: Patrick Rohr <prohr@google.com>, "David S . Miller" <davem@davemloft.net>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>
References: <c3f90818-3991-4b76-6f3a-9e9aed976dea@kernel.org>
 <20230726184742.342825-1-prohr@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230726184742.342825-1-prohr@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/26/23 12:47 PM, Patrick Rohr wrote:
> Removes superfluous (and misplaced) comment from ndisc_router_discovery.
> 
> Signed-off-by: Patrick Rohr <prohr@google.com>
> ---
>  net/ipv6/ndisc.c | 4 ----
>  1 file changed, 4 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



