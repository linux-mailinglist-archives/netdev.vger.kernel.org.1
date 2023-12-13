Return-Path: <netdev+bounces-56769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09232810C9B
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 09:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33BD1F2109C
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 08:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0FC1DDDC;
	Wed, 13 Dec 2023 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBh+34a7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDDB1D6A7
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 08:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BDCC433C9;
	Wed, 13 Dec 2023 08:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702456868;
	bh=TzsNahavSs5CL13mW5Gfl3HN2i5Ne/dmCQs9tLOGKAU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VBh+34a7rXW/XNuc7VaChOUghKSKFI3Jyt2dvCqIvqc0jcvEaJ8ZHkJ2qihCcv3a4
	 ib3dbprOqK1tR2TxcBRHJm3DSb7it6eb1qLPqcuEDyrYgIUZ/1ZjbxdYh/KNZ/2p2S
	 HaTFBq59OgR8pnOuo8FQsA7pWSfLGnCQAZQUM+gn8vMXj7CatNXIOlT9EYESvMqcQy
	 xkTP5ezDrdb/45EkVOYZoVRuY3bXtAz1wU1JZVWrVCO/b/vAO6JFkIGcMLnUqR7Hoq
	 P9LJC+dP6m6OL9JmEfiAWAwAMxI3KqtBbLPEfP/AyJx71Dq8JVqI+Meuxp0VigqbkU
	 cRXUrRaSfEP5g==
Message-ID: <a1503e30-5b0c-43d5-8e18-e71f8511b27b@kernel.org>
Date: Wed, 13 Dec 2023 09:41:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] page_pool: fix typos and punctuation
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20231213043650.12672-1-rdunlap@infradead.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231213043650.12672-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/12/2023 05.36, Randy Dunlap wrote:
> Correct spelling (s/and/any) and a run-on sentence.
> Spell out "multi".
> 
> Signed-off-by: Randy Dunlap<rdunlap@infradead.org>
> Cc: Jesper Dangaard Brouer<hawk@kernel.org>
> Cc: Ilias Apalodimas<ilias.apalodimas@linaro.org>
> Cc: "David S. Miller"<davem@davemloft.net>
> Cc: Eric Dumazet<edumazet@google.com>
> Cc: Jakub Kicinski<kuba@kernel.org>
> Cc: Paolo Abeni<pabeni@redhat.com>
> ---
>   include/net/page_pool/helpers.h |   12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

