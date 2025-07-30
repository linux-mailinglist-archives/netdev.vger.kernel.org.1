Return-Path: <netdev+bounces-210930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8AEB158C9
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 08:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F7E18A59FE
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 06:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3FF1EEA49;
	Wed, 30 Jul 2025 06:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4zEQBk8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A911BA33;
	Wed, 30 Jul 2025 06:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753855996; cv=none; b=OAJKhKvMAn15GhXGczauo6TCSr9ds/heMg8MkqnIjdroucgnZRHzgDsYe/DYFQCvHyr1QtLEFShahxYP42/wqTSKwc4+1o3kg88rH0ytS4Jd6AGSO+hdnu6MWEza9HnjDIRxp/g9ctqSDoL8KUraWCZBnwNQUPwZqe+E8cJPUCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753855996; c=relaxed/simple;
	bh=4Gu/nZGTPHHnvYxvsYZE+skXTULyHPQaSlicJBI4naE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P30taPhHEABNbLkJR6um3bhUqShCCxhc+0hUc51sYvrSMpmi7yy0xG/qdDtoA2KWROHNbIkQIZxWsF7l88tlq6c3e2jIQvUAAiY/0xPkHsSCqQzPcoRUObq0lTWMmAIe07YKM5lsFI5i6Ci41Es3foKCDON0crXKIi50LD4Mipc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4zEQBk8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5AAC4CEFB;
	Wed, 30 Jul 2025 06:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753855995;
	bh=4Gu/nZGTPHHnvYxvsYZE+skXTULyHPQaSlicJBI4naE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L4zEQBk8OnGts/AjL0C07Jv7c+rBUmVAIaaYjAkRGggz5o5Ump61nIJMw0V2sNdqB
	 j1hU7QByJmNNJ+HbFVNlQFTlwZHokk56usepIYYjF49mHn1oDPG/Y85WWFgj2gDDfT
	 76XVC0nqZv1jxCCyoY4gB1xcMfIa+pP2SPNmsksUSd1iLLCXV89hvsd8b3l3KNWh/Q
	 /DFa6Y7+N7+5Wqb/AwwLmTp/n4eMqodC1QZfaTLTLnJqbGOJ4mKy6ZK073V/T3kB9Y
	 CtIyMbya4+6DCtNZvVQW0I34UCm7+qoAJQhXsJfKGukv9pbKB4mh+PqTam/pAQr4fC
	 lEvyCGUE1xsHg==
Message-ID: <0e85bda4-9ac2-4587-b8bb-550bea1728dc@kernel.org>
Date: Wed, 30 Jul 2025 08:13:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/5] net: rpmsg-eth: Add basic rpmsg skeleton
To: MD Danish Anwar <danishanwar@ti.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Mengyuan Lou
 <mengyuanlou@net-swift.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Fan Gong <gongfan1@huawei.com>,
 Lee Trager <lee@trager.us>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250723080322.3047826-1-danishanwar@ti.com>
 <20250723080322.3047826-3-danishanwar@ti.com>
 <296d6846-6a28-4e53-9e62-3439ac57d9c1@kernel.org>
 <5f4e1f99-ff71-443f-ba34-39396946e5b4@ti.com>
 <cabacd59-7cbf-403a-938f-371026980cc7@kernel.org>
 <66377d5d-b967-451f-99d9-8aea5f8875d3@ti.com>
 <bc30805a-d785-432f-be0f-97cea35abd51@kernel.org>
 <4bb1339a-ead6-4a33-b2bf-c55874bab352@ti.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <4bb1339a-ead6-4a33-b2bf-c55874bab352@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/07/2025 08:01, MD Danish Anwar wrote:
>>
>>> `reserved-memory`. I am not creating a completely new undocumented node.
>>> Instead I am creating a new node under reserved-memory as the shared
>>> memory used by rpmsg-eth driver needs to be reserved first. This memory
>>> is reserved by the ti_k3_r5_remoteproc driver by k3_reserved_mem_init().
>>>
>>> It's just that I am naming this node as "virtual-eth-shm@a0400000" and
>>> then using the same name in driver to get the base_address and size
>>> mentioned in this node.
>>
>> And how your driver will work with:
>>
>> s/virtual-eth-shm@a0400000/whatever@a0400000/
>>
> 
> 
> It won't. The driver imposes a restriction with the node name. The node
> name should always be "virtual-eth-shm"

Drivers cannot impose the restriction. I don't think you understand the
problem. What stops me from renaming the node? Nothing.

You keep explaining this broken code, but sorry, this is a no-go. Shall
I NAK it to make it obvious?


Best regards,
Krzysztof

