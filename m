Return-Path: <netdev+bounces-94356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C868BF447
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 03:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C111F238FE
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 01:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A9F846B;
	Wed,  8 May 2024 01:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejM8njBn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C538F5D
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 01:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715133489; cv=none; b=ZhUxjlwU10z0NKBQvcuG4qrVwahPXR/qVQl7gEoES6mQ7WnIskuVaiWzAfrLdntbo9D/j7FA2r8MpL3yXZIT6hxm64HmmUvnVdF/WSAhKKD+U7ler0EKMQMeAgLo/Yi6OkKdkswqMyNlLyrPW/W3JV5l9ruE6H6Wt5RkTuriAvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715133489; c=relaxed/simple;
	bh=AwOrdjNpKBUxDaG6VzaMatxoAfFKK+SCQzpC5QdRKiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W10T4YsAOt1saB3x3TSbP1nyK8YlTslyZUQTPeg16wF4A9hHIKrWvMCDtnEtNyKeSvvhHzaNaBtdJVR8iJlp6oWdLiJ+MU5SGrGg/+Wn7ObvC/728WVUFrf2GpQshhpcmffX/Kx6OOxLO7TcdzAYOlpVf8/NhvV9w7yvl3O0Pgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejM8njBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C37C2BBFC;
	Wed,  8 May 2024 01:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715133488;
	bh=AwOrdjNpKBUxDaG6VzaMatxoAfFKK+SCQzpC5QdRKiA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ejM8njBnJG4XryBFSpcdwSasXMceiCLXgLMBYGPaioJ68P+r3aVEFSHcOD/IH4Pbm
	 flcDTcW9PnI3viAa8j1Mu9oGw3wjKFVTVQVi5XZRKichmeCL9fysE7xi6jpbSAegMW
	 Sxlv55U4iA4lveF6Erizf7+89RERzczPg2K26GrqQNZsYjbUZRicKO89ThHYvIlsZk
	 P9+TlEVC39EwrdE+/Q/VhxOmQZka57W+rB7AGhf34BewXM1aEJqZ6wxcm6DCt0lqdr
	 hJ6YnN5vYYmaFl9zC2JWqlFyBIw+bIOxcMgSuWGquj/p/C/tyogQZoGyrNZuCGbXBt
	 SVNLFyYoH/f1g==
Message-ID: <438c1e8f-b29f-4ab7-866a-fc5688e918f3@kernel.org>
Date: Tue, 7 May 2024 19:58:06 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Driver and H/W APIs Workshop at netdevconf
Content-Language: en-US
To: Mina Almasry <almasrymina@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 Andrew Gospodarek <andrew.gospodarek@broadcom.com>,
 "michael.chan@broadcom.com" <michael.chan@broadcom.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Jiri Pirko <jiri@nvidia.com>, Alexander Duyck <alexander.duyck@gmail.com>,
 Willem de Bruijn <willemb@google.com>,
 Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
 Shailend Chand <shailend@google.com>
References: <c4ae5f08-11f2-48f7-9c2a-496173f3373e@kernel.org>
 <20240506180632.2bfdc996@kernel.org>
 <CAHS8izPu9nJu-ogEZ9pJw8RzH7sxsMT9pC25widSoEQVK_d9qw@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CAHS8izPu9nJu-ogEZ9pJw8RzH7sxsMT9pC25widSoEQVK_d9qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/7/24 12:17 PM, Mina Almasry wrote:
> On Mon, May 6, 2024 at 6:06 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Mon, 6 May 2024 13:59:31 -0600 David Ahern wrote:
>>> Suggested topics based on recent netdev threads include
>>> - devlink - extensions, shortcomings, ...
>>> - extension to memory pools
>>> - new APIs for managing queues
>>> - challenges of netdev / IB co-existence (e.g., driven by AI workloads)
>>> - fwctl - a proposal for direct firmware access
>>
>> Memory pools and queue API are more of stack features.
>> Please leave them out of your fwctl session.
>>
>> Aren't people who are actually working on those things submitting
>> talks or hosting better scoped discussions? It appears you haven't
>> CCed any of them..
>>
> 
> Me/Willem/Pavel/David/Shailend (I know, list is long xD), submitted a
> Devem TCP + Io_uring joint talk. We don't know if we'll get accepted.
> So far we plan to cover netmem + memory pools out of that list. We
> didn't plan to cover queue-API yet because we didn't have it accepted
> at talk submission time, but we just got it accepted so I was gonna
> reach out anyway to see if folks would be OK to have it in our talk.
> 
> Any objection to having queue-API discussed as part of our talk? Or
> add some of us to yours? I'm fine with whatever. Just thought it fits
> well as part of this Devmem TCP + io_uring talk.
> 

The queue API is a suggested topic given its newness. The current 4 ndos
and "ndo_queue_mem_size" were created based on gve. Are they sufficient
for other hardware vendors? Are extensions needed? Other use cases?
Discussions items if needed; maybe what exists is fine. Either way if
someone wanted to discuss, the scope for the workshop would be driver
APIs and down (driver code only).

Your use case is a driver capability upward.

To me a clear boundary.

