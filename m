Return-Path: <netdev+bounces-55347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E27CF80A7E3
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 16:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810131F21061
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 15:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84A532C93;
	Fri,  8 Dec 2023 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNIGP3FJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE35531591;
	Fri,  8 Dec 2023 15:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01231C433C8;
	Fri,  8 Dec 2023 15:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702050677;
	bh=lCFS20uIkMonxP7+wD+yWLnbB/EHld3DDNhf7b6S+Og=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=LNIGP3FJRDZalkqbSp1IgFF1cXQrHZdPgxug8pxKC2P453NphDzxOHLdbyYlxOyfq
	 B3l55T1Muvxe3gLsfxY8lkNA0qsfQspSV4xknSzYJ/HH0gk/fJVBxCscy27MIkqtLg
	 y8aD8PcSIOtbj02ylhSc9Pxvlpy606cW09+Xy+fsg/vsZbv2OpqF8YIs3UIPUYWtw/
	 P3raJN0VHbtaXO7Uysbjp7lhRFELqNvbXjYGryoVM9ecgKdbPeMVCKVAVyS+awGZdB
	 hO6AD3PoOT+sNDbVltuyj+nc15rnPZhI7BjDw+3o1VBl/8RLgzPqWO2FYDVX3z0btE
	 FRyEF2WAxDulQ==
Message-ID: <06f0cae8-03ab-474a-b8dd-40329339a4cc@kernel.org>
Date: Fri, 8 Dec 2023 08:51:16 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v6 3/7] RDMA/rxe: Register IP mcast address
Content-Language: en-US
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Bob Pearson <rpearsonhpe@gmail.com>,
 jgg@nvidia.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 rain.1986.08.12@gmail.com
References: <20231207192907.10113-1-rpearsonhpe@gmail.com>
 <20231207192907.10113-4-rpearsonhpe@gmail.com>
 <488bcc6a-2198-4fbc-a12d-329a378d6ea2@linux.dev>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <488bcc6a-2198-4fbc-a12d-329a378d6ea2@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/8/23 6:52 AM, Zhu Yanjun wrote:
> Hi, David Ahern
> 
> About the functions ip_mc_join_group, ipv6_sock_mc_drop,
> ipv6_sock_mc_drop and ip_mc_leave_group,
> 
> Can you share your advice about them?

see my previous comment on this patch.


