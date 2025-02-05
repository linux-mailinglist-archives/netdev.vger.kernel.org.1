Return-Path: <netdev+bounces-163172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EE3A297DD
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 268AC7A3E63
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 17:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92991FF60B;
	Wed,  5 Feb 2025 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiwCSjny"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857A01FC0E6
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777476; cv=none; b=BZ37daaL1U2axWb1fBpVLg3v8bnruEPScHgrbFBZcc1s9YyrZosTYVE3BnPfPDp3YqiAfbZe9FmAus+6bUcdkOhuyK/pZS3eEk5TrmJ7Bp/+LOlyRBmwj8qya4VapcrFl7Lx1hIeJ/g9PAgr+m7i1Jv3J5wxfO3zGe6olgwIsF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777476; c=relaxed/simple;
	bh=AJlFXAp9wetxr5kXWWMcm3XEwnpXQubgj5onMg+4dVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S75WGFIaUvDVqj/uRivYAXw6D9Zj4taknZgKkkhyFQ7lqzvWr9PhVqA+70p9WuYbrElE/jEXRbUGantrtzl7IdLR7N5oXM7p4Y9r9rP/Gj4DI+Cx6jbCvKU6WOnC7IRmIMzmd0d5OE9GBEGvJAes4Q2pcJoQpPKLgH4i6Yw8CAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiwCSjny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A1FC4CED1;
	Wed,  5 Feb 2025 17:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738777476;
	bh=AJlFXAp9wetxr5kXWWMcm3XEwnpXQubgj5onMg+4dVQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RiwCSjny2rRnzHMCxuaZkTtbGPvO/z4z93rIEllf2bKBYQIVUf8I2rXyr712YD8VO
	 TKCBC/Qbsp1DO54y0KA+pItk0EbVG9L+Bxz4Nvm7QIrCa6Edg4Z+tQ0Or+vZO9OJmx
	 3W3vPlG+UrLi7AS1Jwoc2YuFgIBd4U7emUmSlPW/O0iVU+kwA9UANgdYDYMtulvvko
	 qR5FUmCjy+LzPLphBzcakffk+EOOlNCtli+WkV7x24+xMdf34rMbAWbtvt0jT+RL3u
	 PAwlVL/oPC7eDUzMP8h0JoR0LbzhQ0Eg40IUtpyCJP6rnqdJpuf2+K/MAu+3eQRvOA
	 Y0IUds1x5ZVYg==
Message-ID: <aa3f85be-a7d9-4f41-9fe3-d7d711697079@kernel.org>
Date: Wed, 5 Feb 2025 10:44:34 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 00/10] io_uring zero copy rx
Content-Language: en-US
To: David Wei <dw@davidwei.uk>, netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Pedro Tammela <pctammela@mojatatu.com>
References: <20250204215622.695511-1-dw@davidwei.uk>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250204215622.695511-1-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 2:56 PM, David Wei wrote:
> We share netdev core infra with devmem TCP. The main difference is that
> io_uring is used for the uAPI and the lifetime of all objects are bound
> to an io_uring instance. Data is 'read' using a new io_uring request
> type. When done, data is returned via a new shared refill queue. A zero
> copy page pool refills a hw rx queue from this refill queue directly. Of
> course, the lifetime of these data buffers are managed by io_uring
> rather than the networking stack, with different refcounting rules.

just to make sure I understand, working with GPU memory as well as host
memory is not a goal of this patch set?

