Return-Path: <netdev+bounces-195480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD615AD06E9
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 18:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B60E188EE67
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 16:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B0C19F12A;
	Fri,  6 Jun 2025 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OIRG3RYI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3CE1A275;
	Fri,  6 Jun 2025 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749228397; cv=none; b=OLkkikcakVitJI5InKs+0wQtJq8XGf7M01yrITJXunPuc6toyabBc7aM75FtjbQ+XnimYGe9b3m9w/V9n5NHLBp4D1wOEn8MFtLQXT6jiXwOs0Pfw9gTWdEWY/vj3ST7/i5ofuL6ZEPMBUTVCJXSONPHPUfYyn8NC2cqST5mFUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749228397; c=relaxed/simple;
	bh=yPsp6Sx1FDzN4AZzrpfqrzBife+tukUSYsFcS7U70zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFc2fcL0r+p0RYOfnIyyem8A8dwm0gZTPY+4m8JQ5xlYXuPDk6UKn56VyW2TrHzqrqsMV3MmLqYRYF2yoGiF0PcT1WKzv9iRzSBHvhsh6YEZ+DkvjcVzB3+o1bAIIZDbd2pu+SjaIAS3CGvye2rY1RUwUgksO+lZaY4WJMThewU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OIRG3RYI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zmN3I0iDvIotE+dg6WQxdkwZl+++SIblZ81Mf5UIw08=; b=OIRG3RYIe0kaVKvxPv4ZqSaXWD
	LNcSr1vQa8/lIJBcyZn4Dn5wwxxaYjUX/RZuAJAxO8sJ3C81Thrg4RyXa5jsLHrE84wFuInCcSzyN
	KuUTJmP79BG0kru4YiVq7vYWrZCLlVQ1tH4S6PyvGm+L+VgS2y1CO6L9jkynkoQohbTw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uNaD3-00Euwd-W8; Fri, 06 Jun 2025 18:46:25 +0200
Date: Fri, 6 Jun 2025 18:46:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ch9200: use BIT macro for bitmask constants
Message-ID: <486738a4-c3ea-4af2-ba78-53bf8522ccb1@lunn.ch>
References: <20250606160723.12679-1-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606160723.12679-1-qasdev00@gmail.com>

On Fri, Jun 06, 2025 at 05:07:23PM +0100, Qasim Ijaz wrote:
> Use the BIT() macro for bitmask constants.

What you fail to answer is the question 'Why?'.

This driver is old and stable. It has in fact had no feature
development work done on it since 2015. All the patches since then
have been tree wide sort of changes.

Most would consider your change just pointless churn. It does not fix
anything which is broken. So why make this change?

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#clean-up-patches

Do you have the hardware? If you do, maybe consider porting it to
phylib?

	Andrew

