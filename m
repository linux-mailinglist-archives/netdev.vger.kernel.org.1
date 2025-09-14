Return-Path: <netdev+bounces-222864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ED5B56B68
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 20:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120B71767B9
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 18:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CE4286D76;
	Sun, 14 Sep 2025 18:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qCDfEqdC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E3E1DE8A4;
	Sun, 14 Sep 2025 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757876167; cv=none; b=dsTpr3nQHK/+owmfMAIcs8GbeeZTur3cIcXSjhYQ7qFuT/vf0IXYk/3ywP05ivhNpskYP++HxJACo4EyTlscFiuampymI4J9KUfgTQbc+RoMHboAbpZRNrGw2wLAeKXxLmo6AhiQN/VBV/o5LyY5f/VhMMlFtK16IsAANXlJbk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757876167; c=relaxed/simple;
	bh=owSCmTywugDQT5TmSEcAhrDCWd18bU9phloIb4CEgt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hz3eYVPU9Sra1kXR+zb6kI8qOPtUvU4Y6uw3IInB0e504hy/gHHbYQ9FYFaPA1vzmYs4CtDdo0Lr5/dtiY1xrJ7G64DOPffzoaFvXwIWyufIcQlfebTDl56McLWZ+0OpaL7K5FOHAFC4puI6RcRFPHsKXPFjlOUlB6Gkgg4lTH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qCDfEqdC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XLxHUmBnsIL7oqRRVA9M1wQh0Xlcvzf20qSXcEazRTI=; b=qCDfEqdCebqShsXWd9Kx86iupW
	MIT4c5zj1K90xUZfvRioN/LPt+PEmf8MbctDv8Isvns/MHU6KWGfAIEMeEgk6m2LP67QGMdMJgr4F
	S7AaeM0XlzoABzJgWGX0FsvqKMxkRzEBG4eJXtbSg5et9a/f+3twErBuDt1rY3nllRXo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uxrtF-008MXn-VN; Sun, 14 Sep 2025 20:55:57 +0200
Date: Sun, 14 Sep 2025 20:55:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: dlink: fix whitespace around function
 call
Message-ID: <b1a52aab-9b8a-44f3-ad2b-dbaa0e56abd7@lunn.ch>
References: <20250914182653.3152-2-yyyynoom@gmail.com>
 <20250914182653.3152-3-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914182653.3152-3-yyyynoom@gmail.com>

On Mon, Sep 15, 2025 at 03:26:53AM +0900, Yeounsu Moon wrote:
> Remove unnecessary whitespace between function names and the opening
> parenthesis to follow kernel coding style.
> 
> No functional change intended.
> 
> Tested-on: D-Link DGE-550T Rev-A3
> Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

