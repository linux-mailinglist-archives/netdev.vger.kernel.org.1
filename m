Return-Path: <netdev+bounces-50085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F80C7F48E2
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10711C20380
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 14:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D344E1CD;
	Wed, 22 Nov 2023 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zaxr0pzT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349C54E1BD
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 14:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE49C433C7;
	Wed, 22 Nov 2023 14:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700663055;
	bh=QR/QJMDCyq8rWET7o6GqViSZGdRpjyD4snuqAa56378=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zaxr0pzT+zCy4robC67I+PopY+R6/GmYxd6bXK2+T1b6kKPO8KbtuoQ0DCYfT15dF
	 E+S8hj5NS0JKUgz24HzfBL3tKpq5X2YrR2MJmqvxykXvSRJQjFNWsMsiIghgZJt1RV
	 uhMbGNWgI4KTa8UBmJEH58HpSzxsZ+DoU4yNqksXOjtQuS8GjShGrTdPgpUkdqr9Ty
	 4JzDQZ7sbZqX6cHxaxBKnWo0YHfR4eANjSWIR9SGMRFSkFFTuTwY/TT78vyRU7nbfO
	 44XxzcUN8vbd3LeKQzL5EC/AsKYYfqbl3HO6u3aOjZhgvw7hiS3GB4xYJwJZg8z59O
	 RfKz3GarhomTA==
Message-ID: <575df36a-d3fd-4776-b8df-8d5b2a8aa36b@kernel.org>
Date: Wed, 22 Nov 2023 15:24:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 06/13] net: page_pool: add nlspec for basic
 access to page pools
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 almasrymina@google.com, ilias.apalodimas@linaro.org, dsahern@gmail.com,
 dtatulea@nvidia.com, willemb@google.com
References: <20231122034420.1158898-1-kuba@kernel.org>
 <20231122034420.1158898-7-kuba@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231122034420.1158898-7-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/22/23 04:44, Jakub Kicinski wrote:
> Add a Netlink spec in YAML for getting very basic information
> about page pools.
> 
> Signed-off-by: Jakub Kicinski<kuba@kernel.org>
> ---
>   Documentation/netlink/specs/netdev.yaml | 46 +++++++++++++++++++++++++
>   1 file changed, 46 insertions(+)

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

