Return-Path: <netdev+bounces-239696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE3BC6B6BC
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 20:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B3088342FB4
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A13029D282;
	Tue, 18 Nov 2025 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0qSvQaHo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94BA1DC1AB;
	Tue, 18 Nov 2025 19:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763493620; cv=none; b=duxD5PTeIt+guZyBrlQ8jd45VKzCTRs2Upf6MKxOARA6UwRmKHrgaxcfkWJbnObmYsn5oM3+mcAhvWHz4Fsgk6FURR4QP+zO/ksXdh+BXZx4q4yBqdD8JUKPw8B1h6DaIOsSLKkMqSociFZt7mVxkTTIKXyBhDNhTWLV2PJaCZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763493620; c=relaxed/simple;
	bh=rmhsiRCPaKlEi8Mvc83hZZfvMm6fTD1gnF0RIpd9gQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3nIQvBOH5mGQz2rD1DAyfNSuf25h5uUYOByjCC6c5SIdSW8mvIRk6+wjHzx1UKUm9tT6wnieLM8m0CZ4MbwvH5+62JKDN+pIGCmqmwdP6PSGQEErq96qRLNVSXDsmkyETzJTrjcPqRJDrttPgNc3zpuor+vYIGOWabKyA3qXtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0qSvQaHo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=R4A7+q1wlSBY6LjIjrcOMg/t1pNb/aK98l81XwQHln8=; b=0qSvQaHovu8f25uOSeEH1motjG
	pOjC2V3VbhrWW7qaHdI53Hget0U1nvC5yyunvOmtFnNPbHJnUH5yatNwftVVIG7J0JnwZypOEKO18
	TW1wMn3rNgAsmvVUVZFL1pQED/8RdOpp+a2oTVYHXak3vPc3eYlGcDOqIj6V//0YS/ew=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vLRFH-00EO9s-QZ; Tue, 18 Nov 2025 20:20:07 +0100
Date: Tue, 18 Nov 2025 20:20:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: lan966x: Fix the initialization of taprio
Message-ID: <11ca041a-3f5b-4342-8d50-a5798827bfa7@lunn.ch>
References: <20251117144309.114489-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117144309.114489-1-horatiu.vultur@microchip.com>

On Mon, Nov 17, 2025 at 03:43:09PM +0100, Horatiu Vultur wrote:
> To initialize the taprio block in lan966x, it is required to configure
> the register REVISIT_DLY. The purpose of this register is to set the
> delay before revisit the next gate and the value of this register depends
> on the system clock. The problem is that the we calculated wrong the value
> of the system clock period in picoseconds. The actual system clock is
> ~165.617754MHZ and this correspond to a period of 6038 pico seconds and
> not 15125 as currently set.

Is the system clock available as a linux clock? Can you do a
clk_get_rate() on it?

	Andrew

