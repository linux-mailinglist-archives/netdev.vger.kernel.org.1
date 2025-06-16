Return-Path: <netdev+bounces-198025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67283ADAD7B
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 12:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735543ABB5D
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 10:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C397E298270;
	Mon, 16 Jun 2025 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTQ7eFvY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2F127FD7C
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750070012; cv=none; b=ld0aCvvxariPzk/axIjusRjVHj7vX0rNiNtxlew/OasyWFCJBkdjDhpR1Ws7GK/EQOzmWTOn2Z4oNL0r7WJp7B8ajeucHqXUfu33clRLVSwwwpV1jLCzNBIO9a7snm7UJ8+Ygc73eqwMi3bQUU7brLkflX+1AgUaIvVOrcJ1lW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750070012; c=relaxed/simple;
	bh=3ebRY26H1XYhLWH6tzAmlkRLTE0gf74bhstF6wlp81g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iydCZ0k6LefC8sd6KjAVlCUEdrraVogpD1JTNpfTzIJqRfsaZfEhGuHQQL3zbGbGRL7VivxxqRbPoyXSr5EC3aWhUgkJs4DN4ycYntmWnTbctIJfNZ+DCCrbE2r3ZNUja7p5Wrc9auhAmiJZGbZ684VikrZzmFxsrDS4JIvLAZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTQ7eFvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D77C4CEEF;
	Mon, 16 Jun 2025 10:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750070012;
	bh=3ebRY26H1XYhLWH6tzAmlkRLTE0gf74bhstF6wlp81g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HTQ7eFvYlai6Fm7Plh3CUF5fdZQH42OhfVLxDXVvk4LYOABsm1o5J5efydBcdWkma
	 T0oQSqelEUILokmDUZOFyywp+a7DPOH7BDNXrrU1SoIVTM6U9OA5dBKWruSW7DO+cm
	 pe3yppISTO+1JgxB8ESDPQ2hQHVY5RPDGBLmlRirqY5EtcK4VVVXY5yufqg+V6YiD8
	 8WfI9PBLa2DlTy0sJudiE2b2B/K5tfbAqovqsLoIEyLfI5QXVcFZ7NYqHzAWB885KU
	 E1ayNCmavwIzwZM80yi3GYVBY6wZh04ZnM0gMsZGR95wdCbo2UHms3tTqEAtGXW0+u
	 jI3PRM/eaFxFQ==
Date: Mon, 16 Jun 2025 13:33:27 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
	hkallweit1@gmail.com, davem@davemloft.net, pabeni@redhat.com,
	kuba@kernel.org, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [net-next PATCH 0/6] Add support for 25G, 50G, and 100G to fbnic
Message-ID: <20250616103327.GC750234@unreal>
References: <174956639588.2686723.10994827055234129182.stgit@ahduyck-xeon-server.home.arpa>
 <20250612094234.GA436744@unreal>
 <daa8bb61-5b6c-49ab-8961-dc17ef2829bf@lunn.ch>
 <20250612173145.GB436744@unreal>
 <52be06d0-ad45-4e8c-9893-628ba8cebccb@lunn.ch>
 <20250613160024.GC436744@unreal>
 <aEyprg21XsgmJoOR@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEyprg21XsgmJoOR@shell.armlinux.org.uk>

On Fri, Jun 13, 2025 at 11:43:58PM +0100, Russell King (Oracle) wrote:
> On Fri, Jun 13, 2025 at 07:00:24PM +0300, Leon Romanovsky wrote:
> > Excellent, like you said, no one needs this code except fbnic, which is
> > exactly as was agreed - no core in/out API changes special for fbnic.
> 
> Rather than getting all religious about this, I'd prefer to ask a
> different question.
> 
> Is it useful to add 50GBASER, LAUI and 100GBASEP PHY interface modes,
> and would anyone else use them? That's the real question here, and
> *not* whomever is submitting the patches or who is the first user.

Right now, the answer is no. There are no available devices in the
market which implement it.

Thanks

