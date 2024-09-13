Return-Path: <netdev+bounces-128179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2239978658
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 19:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26E09B20A8A
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB419762DF;
	Fri, 13 Sep 2024 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QeCjm9zW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D35457CBB;
	Fri, 13 Sep 2024 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726246974; cv=none; b=PMXOj5RN1/IuNjZ7BYpQRzCi5L6yp9Vfzhz76vWoBr9DSAsWOcCUvekg6Mu1hCOw62ae8JPITIHsO7jxPI5r+YMfdFPkZpHU5UA1BAMAK06AHZDDN0+1F2vCIEzkuXXQ+2UgdQ1FG4xk6eyfooXObZ8YZRFf18yP6ULcY9f2HWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726246974; c=relaxed/simple;
	bh=9hCxTYk9yAqwSOku5ekhshPSb4kkYyvIP5skQlEd55A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/xX8OWjxOKwVxX3zY9lmUc/LK69ehkth1G1P21XrumYt+86RXVzd2toL9oi/dvxjyOreBVX3VxOyiRnhF/RwQnYFAMNIhTYhE4R95w3fml/PpEaPlFOGtOedr4Ne6EJFle+k8De1SQGBw+lV9IJ+RzvFKr38EOvbrILjmEwtXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QeCjm9zW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7zMlLZOcK1RQ4wrk+dCE2XdWF0J3wBrSzW6w7G6AQZQ=; b=QeCjm9zWACqkkRpr1lXanKKSOc
	P6bv7x4mMn6S2gtOxJlV8g1iuP0oKVWvBp5f4UQsTZhssOxFybaWUaIQuMx6Y5a2rEfh1N0hUN7A9
	kdPeZxcTuSjbAtpTNmxL5z2ow3DscexehQfDARGAIWC9XpdxXRHN5ufh38czZXKwtCVs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sp9gy-007PQX-PD; Fri, 13 Sep 2024 19:02:44 +0200
Date: Fri, 13 Sep 2024 19:02:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com, hua.sun@motor-comm.com
Subject: Re: [RFC] net:yt6801: Add Motorcomm yt6801 PCIe driver
Message-ID: <9506d808-85b9-4f37-baee-76f3dee56182@lunn.ch>
References: <20240913124113.9174-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913124113.9174-1-Frank.Sae@motor-comm.com>

On Fri, Sep 13, 2024 at 09:00:04PM +0800, Frank Sae wrote:
> This patch is to add the ethernet device driver for the PCIe interface of
> Motorcomm YT6801 Gigabit Ethernet.

One 11,927 line patch?

Please look at how other Ethernet drivers are submitted. Please break
this up. You should also look at the comments other drivers get when
submitted. A quick look through suggests there is plenty of broken
stuff in here which has been commented on before. You should not be
repeating the errors of others.

FYI: All your PHY handling code needs throwing away and use phylink or
phylib.

	Andrew

