Return-Path: <netdev+bounces-161917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BE7A24A04
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 16:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBEE93A2F6C
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 15:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21791C3BEA;
	Sat,  1 Feb 2025 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mEXBvEK0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3BD1C2324
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738424652; cv=none; b=Yz5BbM64DLcS+QbSADu18Re8Uf0xJYJFtGZWIs6fudYaSo9666935lmrdSIU1tqYIj3cVxCo4QqWViP9PfutPj2e3LahwY4Y1s/TdzcBqTtNIkkTJ44O6JZozqlYLY7i5z4yMoPRFD+DrKrqwZKsP6CWCu4SoCP+yP1EmdByF40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738424652; c=relaxed/simple;
	bh=c2xLXJ5zcIwJuWDTTbAfrDJHio4B3DRoIQstks9P/kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0N4qN34XbRdw+FXrsVjnoPwaht0yQwyIIT2Sm1xksvD2EOXgInt0rmrqtZ+1VVZXwJedJ9RUbFhz79dcq+nSWc6r8nxgiPh6VNOuO5hVZaYSvayfVJBixVqn0mTHIWrXh/sNqYKy9tKQKS8qdQwL0LXFny22FuPUL/Jcsf0r2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mEXBvEK0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xhhAp5dhFtA3p8LwOlAsNLWQZ52z1ZnB0oSyExi6nrk=; b=mEXBvEK0OZ9GZf5gFiSYCP+Jaa
	JCW2WSkX5fF9aJ+Pxe9hy4jR8aihxC8Ri4N25VlNHNelcUJaztHqczkyuxuxf3KJdbLvfJClQe8Gl
	ttuZLjuo/Ij2iN3oxlFjZEz7iRoHVWhpw3pNi1BAHTl4BxKw4sf2CxFhKOu66G4JhLnA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1teFf0-00A0JF-23; Sat, 01 Feb 2025 16:43:54 +0100
Date: Sat, 1 Feb 2025 16:43:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	nbd@nbd.name, sean.wang@mediatek.com, ansuelsmth@gmail.com,
	upstream@airoha.com
Subject: Re: Move airoha in a dedicated folder
Message-ID: <d441b4f0-fd21-4e6a-8883-d9c2c1f0c1ef@lunn.ch>
References: <Z54XRR9DE7MIc0Sk@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z54XRR9DE7MIc0Sk@lore-desk>

On Sat, Feb 01, 2025 at 01:44:53PM +0100, Lorenzo Bianconi wrote:
> Hi all,
> 
> Since more features are on the way for airoha_eth driver (support for flowtable
> hw offloading, 10g phy support, ..), I was wondering if it is neater to move
> the driver in a dedicated folder (e.g. drivers/net/ethernet/airoha or
> drivers/net/ethernet/mediatek/airoha) or if you prefer to keep current
> approach. Thanks.

Hi Lorenzo

Moving it into a subdirectoruy of mediatek is fine. Maybe also
consider moving mtk_eth and mtk_wed into subdirectories.

	Andrew

