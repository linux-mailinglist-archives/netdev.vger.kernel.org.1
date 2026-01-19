Return-Path: <netdev+bounces-251146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 281C7D3AD37
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E675302651C
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D630F37BE63;
	Mon, 19 Jan 2026 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="R/bjSLnK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A5A1E531
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768834266; cv=none; b=YTAyZhaulqn47Kj68/+0Srtrfkqp80JdIrj1nCPj+gx9PYtsxbpxSTGhlymt3Qu/aog63nWvtuSC+zTp2qYkEOwrVcH6Ox9ATN4q2OMbGu90obQFqyZ0VX4QHOIe75HrUa0I1Wu00TV+WPH7LvrvMMObXVZjRHmkcbTw8xmFmbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768834266; c=relaxed/simple;
	bh=YzDaTIg/kj64dSWIYot36YBRsO9mNg0Mr6txvnWzDI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3yJBqAwDD774wXnzlUZ2l7oxNcocnBH0XRQm1O40a45gymnLVzQ18yhqmxA2fi683wDTw6vgbDPcPbhGKsklyPfQAxB6wiXjY7vvcnmLyDeLgId9e/8QJf+lR3GaRac+ofh7pcEo2XjPhbfbtPSlm8QVnvckqfXZe29wTT2tRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=R/bjSLnK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nJuu4ULUfV+umhoxx3amYuxkLqbVUhJCj4GIbe/iJKA=; b=R/bjSLnKaunB5G29hAxpF6TDBK
	ThsxuwI+1mJSRw5P1KA7r8h2JhjdWSS6b6VaBxUNYpaihDc6teH1ReKC+dXBapQzcZu1G9226NfFd
	OGBAeR5n8ZOMIUgcZ8TbKyIMqbIE4Q/+MFgRy+Vcaju6R2o03Z6E98kmpAxAyZZ91N8w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vhqao-003Vvf-L4; Mon, 19 Jan 2026 15:50:58 +0100
Date: Mon, 19 Jan 2026 15:50:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sayantan Nandy <sayantann11@gmail.com>
Cc: lorenzo@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	sayantan.nandy@airoha.com, bread.hsu@airoha.com,
	kuldeep.malik@airoha.com, aniket.negi@airoha.com,
	brown.huang@airoha.com
Subject: Re: [PATCH net-next v3] net: airoha_eth: increase max MTU to 9220
 for DSA jumbo frames
Message-ID: <fa6a4cfa-0169-46e3-8c7e-190b69a97e91@lunn.ch>
References: <20260119073658.6216-1-sayantann11@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119073658.6216-1-sayantann11@gmail.com>

On Mon, Jan 19, 2026 at 01:06:58PM +0530, Sayantan Nandy wrote:
> 
> The industry standard jumbo frame MTU is 9216 bytes. When using the DSA
> subsystem, a 4-byte tag is added to each Ethernet frame.
> 
> Increase AIROHA_MAX_MTU to 9220 bytes (9216 + 4) so that users can set a
> standard 9216-byte MTU on DSA ports.
> 
> The underlying hardware supports significantly larger frame sizes
> (approximately 16K). However, the maximum MTU is limited to 9220 bytes
> for now, as this is sufficient to support standard jumbo frames and does
> not incur additional memory allocation overhead.
> 
> 
> Signed-off-by: Sayantan Nandy <sayantann11@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

