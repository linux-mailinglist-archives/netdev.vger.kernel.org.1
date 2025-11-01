Return-Path: <netdev+bounces-234878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03510C287FF
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 22:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655953BB3F4
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 21:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9AB2727FE;
	Sat,  1 Nov 2025 21:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="j71DDsZ/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A443244677;
	Sat,  1 Nov 2025 21:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762032050; cv=none; b=AT8JCrqJeWhW1rA4Be4m6OQSjTDuBnFSrwpNbaYa6HdSHa1i61FTbQxA8MZk6bLYooj+7oqTartl0h6ZrW4TUhlXtEb4AzvnzX/n9ZqOdj4VuKP7mv8nHMx6T8xTuF642F6TRZD0Y6UQ5VcesMkzuBJEoRI2HDist4cOMdqeh6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762032050; c=relaxed/simple;
	bh=x93ugru9bvXAQkZntAATxaGJnMDH3h6hst4REgEf21I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWj+d4hInLAcgzsYCkN64zyiRRa9P/c+4GGca+XQRWon5vkqDp9NDv7nDZT1wQYFZV/oz8qYj94ydCTEh7m6DyfAG4VmRq+ECqv7jNyNNjBjLz9UerJTdES/oJ/zf6vCsVzdPGNd6eQpHibl7mEgy3JBG3dfmRPEnb05GpEbyX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=j71DDsZ/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wSZIw/mmKpcqy9rrzv1+xiAFYxy212t/4U4L01X1tps=; b=j71DDsZ/PmqWMbgMaeT41lxvJp
	YGM9IvfCniAL4kmp23wDF0+wAWgYBim15xmN8dIznq+KpF+ZIbxt4laA3GouUgw51Q/+c1mp4Zhay
	HfaTanGYvb4ZU6ELZJYhRWVEUciCzMWSiuMIlKSx/XRj6jaX/vL40TNvo/mYQ/EZTklg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vFJ1Z-00CgDl-19; Sat, 01 Nov 2025 22:20:37 +0100
Date: Sat, 1 Nov 2025 22:20:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: David Yang <mmyangfl@gmail.com>, Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net: dsa: yt921x: Fix spelling mistake "stucked"
 -> "stuck"
Message-ID: <e101febe-0f69-47b4-9905-098da8aa7f84@lunn.ch>
References: <20251101183446.32134-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101183446.32134-1-colin.i.king@gmail.com>

On Sat, Nov 01, 2025 at 06:34:46PM +0000, Colin Ian King wrote:
> There is a spelling mistake in a dev_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

