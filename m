Return-Path: <netdev+bounces-234873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0ABC285D9
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 19:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A3DE4E1CD9
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 18:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520652FD665;
	Sat,  1 Nov 2025 18:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2921O6Ar"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF912FD1D0;
	Sat,  1 Nov 2025 18:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762023524; cv=none; b=AiYC+hFc9kG0onkjl1oQVp7Xd7u8OSnVzSgEsoiqYo3PWUMpokWsgQG49Qu55xXCEjMKryTw/w8gM164/o90Af6iz2zBI3xSJFgQLh1SwEUar8XTTnkoo9hMFxmvkFK1AINgX4STdX0EvHVJSJw9tmQi2xQVGmImpJXsW3SXlY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762023524; c=relaxed/simple;
	bh=7LoAPepD4eFaaUqZEIMxR8uSjySCCaR8EcLjDwAwFFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ArmOFM1I9676miOo0nJu2QW96aWxno/ne+XYKvYV+nxT+olNOcNLOd030ovKwl63OTwBxWMYkA3NOBoqu7ZOOHLNxE/tH9KjR3WkmG6K2LlIdLzulRGKTUEpBHMIS8gTo/0YfpT15dYb5kroDlPQXp8fyOpqpJ9F+ybAy8JtiqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2921O6Ar; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=P8HmXM67TmlRyT3RaMYldgJ94lqKSzK8QgtFkpR1p/8=; b=2921O6Ar+EXel+oStPCeppjFPI
	AZKrvYYNfGjs7+yVEAhYHOw6dDdABBs811giP5m/l5ZJ4TeELxxJqUg7WIXw8MhTlUKOojSXb9QP8
	mf2X7uagZtbgqB/o1f8ePwDpDnrjx18Fo80+FBo6cueTc6yu+ZKo/Nuc3j9wHQGKn8qLfdxw9oXKn
	Vd4GWVQY1lQEaJ05gYty3AznyeJ8qf2Lz/AS0YsCKg3VunPgn9R2Y8qvBy1KyBCFG9JMtlrypeNK4
	7gSRGzX/PpsVv//3MxCRsTSX/znrLr8OHbWUisOCwhA9gdaFb8h+XxwA1fjtAqwSl7heDmxC14HWL
	uWSwFcCw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFGoB-000000081ew-1lXp;
	Sat, 01 Nov 2025 18:58:39 +0000
Message-ID: <c3ee9b5d-62f4-4c7f-b6a4-9e0dd8290edc@infradead.org>
Date: Sat, 1 Nov 2025 11:58:37 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/8] xfrm docs update
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20251101094744.46932-1-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251101094744.46932-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/1/25 2:47 AM, Bagas Sanjaya wrote:
> Hi,
> 
> Here are xfrm documentation patches. Patches [1-6/8] are formatting polishing;
> [7/8] groups the docs and [8/8] adds MAINTAINERS entries for them.
> 
> Enjoy!
> 
> Changes since v1 [1]:
> 
>   - Also polish xfrm_sync section headings (Randy)
>   - Apply review trailers (Randy)

Changes all look good. However, there is still one header that ends
with ':'. Not sure it is worth fixing.

XFRM Syscall
  /proc/sys/net/core/xfrm_* Variables:

> [1]: https://lore.kernel.org/lkml/20251029082615.39518-1-bagasdotme@gmail.com/
> 
> Bagas Sanjaya (8):
>   Documentation: xfrm_device: Wrap iproute2 snippets in literal code
>     block
>   Documentation: xfrm_device: Use numbered list for offloading steps
>   Documentation: xfrm_device: Separate hardware offload sublists
>   Documentation: xfrm_sync: Properly reindent list text
>   Documentation: xfrm_sync: Trim excess section heading characters
>   Documentation: xfrm_sync: Number the fifth section
>   net: Move XFRM documentation into its own subdirectory
>   MAINTAINERS: Add entry for XFRM documentation
> 
>  Documentation/networking/index.rst            |  5 +-
>  Documentation/networking/xfrm/index.rst       | 13 +++
>  .../networking/{ => xfrm}/xfrm_device.rst     | 20 ++--
>  .../networking/{ => xfrm}/xfrm_proc.rst       |  0
>  .../networking/{ => xfrm}/xfrm_sync.rst       | 97 ++++++++++---------
>  .../networking/{ => xfrm}/xfrm_sysctl.rst     |  0
>  MAINTAINERS                                   |  1 +
>  7 files changed, 77 insertions(+), 59 deletions(-)
>  create mode 100644 Documentation/networking/xfrm/index.rst
>  rename Documentation/networking/{ => xfrm}/xfrm_device.rst (95%)
>  rename Documentation/networking/{ => xfrm}/xfrm_proc.rst (100%)
>  rename Documentation/networking/{ => xfrm}/xfrm_sync.rst (64%)
>  rename Documentation/networking/{ => xfrm}/xfrm_sysctl.rst (100%)
> 
> 
> base-commit: 01cc760632b875c4ad0d8fec0b0c01896b8a36d4

-- 
~Randy


