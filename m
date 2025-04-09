Return-Path: <netdev+bounces-180964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E28A4A834A4
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 01:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 499077AD308
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 23:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABCC21ABD7;
	Wed,  9 Apr 2025 23:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMHIfp9N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8653211472
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 23:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744241859; cv=none; b=Twm4okspW+Lq6fpOzQFxz2JJqtNBPbgUunppgHrsZu/TObiGM/XnAD34qoNFT1LvIqfs7V27Dtw2dD1OUZOaZucOLsjJULiRMauzpOzavIbyNqj/QJCEgAQXAprC68oLjQ2fgG39SeYmwr7ixwwWZW4+YBnxHDX1j0HfTv2j+uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744241859; c=relaxed/simple;
	bh=fn3kK6il9AD7bbyhGbo7s4pLFMPkWIgx39JLPgek8Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLoEA+6cEQVijgi0GkmBxtMEwwUKln2DTIM9zYBvgoH4CJgdSUfZWeyGURbB7PLuaP8Wr1I4W5FW0fgSqqtrqMQ+T5zhElMxbidx5JS5khja6x+J32048ky4N6WxNm+p9vkzGGg22ARWOKVk4ki5X8a7mVaxa4QCuuudzCWMqPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMHIfp9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157BBC4CEE2;
	Wed,  9 Apr 2025 23:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744241858;
	bh=fn3kK6il9AD7bbyhGbo7s4pLFMPkWIgx39JLPgek8Gw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lMHIfp9N9b4AU82PF84cXzGFVf0BQn2dXv8FXhAnXKy5a0Qohkexq7ua9cJJQaN+R
	 qkpnhLZs0cT37kuiyh07Zyti4dkbvQKSDPTkJsWKEd+l6W8ygLXbKqxtbL7r3PubfA
	 sACc7DcndTkjnFvyb/5fy6HFSRx0JKB/ZyBTwWbhSmNvkt+PZn1L3+7IBgDXLkTbL/
	 4I0SZhBwBo1iJpDVtNvI7oU2cfj4UmsmypODzhPCwZ6IC/OtGvGi2R0+Z7ST9UJQyr
	 R2QYvEEf60muOa7hVqZ54LGG33k7QQ3aA+kyVuyAQmhNDu0tG2yCCRRbsPUqplPi2N
	 VIoMKhSHZQLSg==
Date: Wed, 9 Apr 2025 16:37:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, Davide Caratti
 <dcaratti@redhat.com>
Subject: Re: [PATCH net-next v2] net: airoha: Add matchall filter offload
 support
Message-ID: <20250409163737.2b6c13e3@kernel.org>
In-Reply-To: <20250409-airoha-hw-rx-ratelimit-v2-1-694e4fda5c91@kernel.org>
References: <20250409-airoha-hw-rx-ratelimit-v2-1-694e4fda5c91@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 09 Apr 2025 01:15:32 +0200 Lorenzo Bianconi wrote:
> +	airoha_fe_wr(eth, REG_PPE_DFT_CPORT0(0),
> +		     FIELD_PREP(DFT_CPORT_MASK(7), FE_PSE_PORT_CDM1) |
> +		     FIELD_PREP(DFT_CPORT_MASK(6), FE_PSE_PORT_CDM1) |
> +		     FIELD_PREP(DFT_CPORT_MASK(5), FE_PSE_PORT_CDM1) |
> +		     FIELD_PREP(DFT_CPORT_MASK(4), FE_PSE_PORT_CDM1) |
> +		     FIELD_PREP(DFT_CPORT_MASK(4), FE_PSE_PORT_CDM1) |

Coccicheck spotted that the previous line is duplicated..

> +		     FIELD_PREP(DFT_CPORT_MASK(3), FE_PSE_PORT_CDM1) |
> +		     FIELD_PREP(DFT_CPORT_MASK(2), FE_PSE_PORT_CDM1) |
> +		     FIELD_PREP(DFT_CPORT_MASK(1), FE_PSE_PORT_CDM1) |
> +		     FIELD_PREP(DFT_CPORT_MASK(0), FE_PSE_PORT_CDM1));
> +	airoha_fe_wr(eth, REG_PPE_DFT_CPORT0(1),
> +		     FIELD_PREP(DFT_CPORT_MASK(7), FE_PSE_PORT_CDM2) |
> +		     FIELD_PREP(DFT_CPORT_MASK(6), FE_PSE_PORT_CDM2) |
> +		     FIELD_PREP(DFT_CPORT_MASK(5), FE_PSE_PORT_CDM2) |
> +		     FIELD_PREP(DFT_CPORT_MASK(4), FE_PSE_PORT_CDM2) |
> +		     FIELD_PREP(DFT_CPORT_MASK(4), FE_PSE_PORT_CDM2) |

.. and here.

> +		     FIELD_PREP(DFT_CPORT_MASK(3), FE_PSE_PORT_CDM2) |
> +		     FIELD_PREP(DFT_CPORT_MASK(2), FE_PSE_PORT_CDM2) |
> +		     FIELD_PREP(DFT_CPORT_MASK(1), FE_PSE_PORT_CDM2) |
> +		     FIELD_PREP(DFT_CPORT_MASK(0), FE_PSE_PORT_CDM2));
-- 
pw-bot: cr

