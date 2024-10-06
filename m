Return-Path: <netdev+bounces-132550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A0F99219A
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 23:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68FB0B20B28
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 21:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FECD18A6D9;
	Sun,  6 Oct 2024 21:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IFUyxjrX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BC816F265;
	Sun,  6 Oct 2024 21:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728249427; cv=none; b=FzRU979PTrPhB/qXt8EZ/iYleCmmiFcA5cIWwcqcHtZyYC6craH5Nm99LjFOs/cwgz9VIhwYKJoCNPgs+5G7GgDTCmGuORj4msZkPbWies9LnB5NLE8EJazu6Msdt8zvALJWa/k0HduB/Ks7aV9ZcvTAviPkTgNDa2KBF54q1c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728249427; c=relaxed/simple;
	bh=fMOpqR7WUIJ02+NgqLdDKUlOA2GA9Gp/bfx3B2PHMx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sH3jzOhfevLG3KgZcg3398m5vLhJS6tZpIJqth/YNC9m3TYDqU87/q+0KJA2iAbtKqgxbGWTdHnv+UBZPon3y29FUeGtmbRMf/IfhoKsdfgt4eaxFeIkz0p0mwmqRlUIDqGrJwhEJf/HnH643HffvBaWhGpWBwhmBPhfiwVSdC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IFUyxjrX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Rwa8VqrUB6oeytZ1jBbHHR84eZsNX2C7kR6+kG7pKag=; b=IFUyxjrXRycxN9apx68Ug/nFDE
	H7Int5jUGBO7mqQxrw+Gp29FhyBKYzit6HanMEfbgAV28uzSo5HLd1ZQXZBILJd9fr5qtghNPFWif
	nT0ZJqKuTh8g0tzbYxWs9PKhZiRGggSODKHMdmKvguQCAiy50M7T5a6Et15jjp8EfRQ8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sxYcY-009CwI-Ns; Sun, 06 Oct 2024 23:16:54 +0200
Date: Sun, 6 Oct 2024 23:16:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Safonov <insafonov@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: fix register_netdev description
Message-ID: <844f8c95-634c-4153-bfab-d6a032677854@lunn.ch>
References: <20241006175718.17889-3-insafonov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006175718.17889-3-insafonov@gmail.com>

On Sun, Oct 06, 2024 at 08:57:20PM +0300, Ivan Safonov wrote:
> register_netdev() does not expands the device name.

Please could you explain what makes you think it will not expand the
device name.

	Andrew

