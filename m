Return-Path: <netdev+bounces-155923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4315CA045AA
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC98A18814B5
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93EC188733;
	Tue,  7 Jan 2025 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+WxJmgw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F592594AB
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736266361; cv=none; b=cx5VYHsOlf+LFjxHMsitJ/OnnNJf2bD2CF+e1LtrC9qzJxv4D6g/WiQwfloEbl4GYxFYRW9SnHWKbuQgiOIrvSoAlB5BRHYJnoz3j2I6V9RtAUUHDIrgxFs9loyp3wF0xfj6fkkj0se+u8uNplLoC56m29607qVhUe8jny5BI54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736266361; c=relaxed/simple;
	bh=gXvU2HX9jQ010npZSD5X7PJGot6Snk3tRmhjEMmrxKo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YqwUTkh4dyZ2a+VcL1OfTMqyXVGHmn5iKUDqHdTVEjm7v8AevcFeDD1FVHrlDx6b+V1K0aeax35iZvWYAKgJCTRujFTXC6WYP1f5fEHONOj8LPz3fLRUL5RkbM71+e4BHx+nA/DlGDLJa1NqEzewAAMODBVXC7kBjgcy9IjYiVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+WxJmgw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD26CC4CED6;
	Tue,  7 Jan 2025 16:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736266361;
	bh=gXvU2HX9jQ010npZSD5X7PJGot6Snk3tRmhjEMmrxKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K+WxJmgw9+vyipIGTUiCCukxgo4HD66bvpz4CMpV7evweCmKvWWB3GxSDSSqlvMeY
	 5qOnh3R6vvvGCpbO34rg0vzfY67nIrC/rDfZWbFm18h1Rb3/3KjjG8dL2PKI5gLcqm
	 hvstvMgZw/f/R5jr1XzQaX/BhFXKjMcp17G/vFNsJP7v3WmY4SiQGLfSgNlNgWYD9H
	 91NyPs/qypaiH3MEnlkH1vP5nG+WReeRE8UAF+2hA1G5TgKzbeRcLZZplZwXt2ufP1
	 zRd2QZGWzFF5UsGYdRAmKnDy9E5Aw+6h0CNowXJkxpGiQ+s9l3KMmQ1WK4r5Eqh7Qk
	 0U7JqiWg5oJ1g==
Date: Tue, 7 Jan 2025 08:12:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: <Woojung.Huh@microchip.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <Thangaraj.S@microchip.com>,
 <Rengarajan.S@microchip.com>
Subject: Re: [PATCH net 2/8] MAINTAINERS: mark Microchip LAN78xx as Orphan
Message-ID: <20250107081239.32c91792@kernel.org>
In-Reply-To: <SN6PR11MB29266D59098EEEB22ED3BE86E7112@SN6PR11MB2926.namprd11.prod.outlook.com>
References: <20250106165404.1832481-1-kuba@kernel.org>
	<20250106165404.1832481-3-kuba@kernel.org>
	<BL0PR11MB29136D1F91BBC69E985BFBD6E7112@BL0PR11MB2913.namprd11.prod.outlook.com>
	<20250107070802.1326e74a@kernel.org>
	<SN6PR11MB29266D59098EEEB22ED3BE86E7112@SN6PR11MB2926.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Jan 2025 15:10:21 +0000 Woojung.Huh@microchip.com wrote:
> Hi Jakub,
> 
> > On Tue, 7 Jan 2025 14:14:56 +0000 Woojung.Huh@microchip.com wrote:  
> > > Surely, they should involve more on patches and earn credits, but
> > > Thangaraj Samynathan <Thangaraj.S@microchip.com> and
> > > Rengarajan S <Rengarajan.S@microchip.com> are going to take care LAN78xx
> > > from Microchip.  
> > 
> > I can add them, I need to respin the series, anyway.  
> 
> That's great! Thanks!

Could you share the full name of Rengarajan S ?

