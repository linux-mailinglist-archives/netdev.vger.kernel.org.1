Return-Path: <netdev+bounces-230990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FD3BF318F
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 21:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A224403E77
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 19:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED1C2D3EF6;
	Mon, 20 Oct 2025 19:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nbKY7v9H"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2581EDA3C;
	Mon, 20 Oct 2025 19:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760986893; cv=none; b=YQRaZg4EghIqOTcoQCH1kOkWuSFDsyNvEhyehohxxgztSWatDanyb2jPnV9nbe1Pp4Lrzz6DqNkKKn3X+jUg3qXrEvsrZW6xvSHyszegojSP/ETp6BtMyCMznHTD3QtNzY+oJ+AYFKV9bvWG2/o/30u8kbr6N8+7sFeGBBG9yTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760986893; c=relaxed/simple;
	bh=ftVDefP4cohm/FLTktty0efMRIsouSqAH9Av5C2bYRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyfU80gsqagBkN4XVhESXp0xtnolCleT7INfuYjwZdt92vq7wz0xPw6JmPI3vlAFYcxdwUmEkfrM0Wzg9tybFveJ7r2QjOlyuqjgAVM5vAf48gnLzBMVNgieK9I+aYPFNTkEHKWjuSHQv+keueOVxYvnJeb4zNDzBKX7DdYrsoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nbKY7v9H; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jr6KJvEptSKLSTwW4QOgvKHB6kOy5jEvJzUWQwrQraY=; b=nbKY7v9HT5L6Z4QXZLsm0FwwNM
	7O6cf4Ho7LRGsCck8osNsqhq6O+f6C5eXAJz9ZU27dVn28CO+Gd/dJ3wnc84YUPVAk0utLborbX3j
	RpMz1gMnHmCdhmbGQpd1AvXLKEu/e/QuBjYNCTJNrYEVst7mYn2vFbh0ZdUaZuhSZdrQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vAv85-00BY92-P8; Mon, 20 Oct 2025 21:01:13 +0200
Date: Mon, 20 Oct 2025 21:01:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: zuoqian <zuoqian113@gmail.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] net: macb: enable IPv6 support for TSO
Message-ID: <657cf1e4-a27a-4d9d-9931-494ce26ef325@lunn.ch>
References: <20251020095509.2204-1-zuoqian113@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020095509.2204-1-zuoqian113@gmail.com>

On Mon, Oct 20, 2025 at 09:55:08AM +0000, zuoqian wrote:
> New Cadence GEM hardware support TSO for both ipv4 and IPv6 protocols,

What about the 'Old' Cadence GEM hardware? I'm assuming you mean
something by New here. So it would be good to make a comment something
like that IPv4 and IPv6 TSO was added at the same time. So if IPv4 TSO
is supported, IPv6 TSO should also be supported, so there is no danger
of regressions with older GEM hardware.

> Signed-off-by: zuoqian <zuoqian113@gmail.com>

This means you are agreeing to:

https://docs.kernel.org/process/submitting-patches.html#developer-s-certificate-of-origin-1-1

However, we say "using a known identity", since this is a legal
statement. I don't think zuoqian qualifies. Please you a full name
here.

    Andrew

---
pw-bot: cr

