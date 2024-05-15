Return-Path: <netdev+bounces-96478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FE38C613B
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 09:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C7CEB222D5
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 07:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABB842072;
	Wed, 15 May 2024 07:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pywic27G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2zLTLqej"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269F741C6D;
	Wed, 15 May 2024 07:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757294; cv=none; b=bTqKGZoRpaWfDHtIBghfUevDGRjqpHwHNlWcKFWkVol9quW8uJzY1TSyZHlhhkGCfYTWBp/oGCiYS/gAUg017nZtqAuCFAUIRVreKCx+FNDZSlHoVAwrFI7QA+mpWtAfZXbQq2N2LR5+gJHBlx6qlXmb+pZRYEfW0YUhDgDK/sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757294; c=relaxed/simple;
	bh=fSBL+I7mlttw6laOfhj4mqwmELbbr3O5aHueDsMdMS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GF6qtX6MbvgWP+litRDv+K+TmmHVimRi+4t8UC+jH+U6Um2VoLb3AFTpCRW4QJZXtL+0Kbz9CG8+neB1iLSG9XZ/2YLpP7igtWSvbxanXkt655j6zRJRb+VbuRWIXOTjdzp6mR0QGS0Q+5Ak9wZEP+C7R+tHr3ry0IXuaTat+hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pywic27G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2zLTLqej; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 May 2024 09:14:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715757289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OjxbuDWr0zOcw90ZsB0EVCRcP/VSMs6LQbSERYEb5HM=;
	b=Pywic27G6qu/Lw3kltaLmpHlBJ8NSDpUkGLrQpH7xRcd3YGPculNrQE8UARStG1Fbp4YOk
	AqvgJcnM8H0efgQEl1bIJXyMPnoSKa/MB5yVj5uR/4Fr9c7pbh65aa8Fd7Wc9ExvMfJ7k9
	f5WvWMTqCCriiQwqugz1oaOUL7vbk17vSJVl6REFne7o6O6c4Rg37frg0yyX8gQs9ssUmG
	GriN41mjcNW+kz400ugIm6gxHfYxZpouNevrPKUgBJe8KsjHvpfCHPvLi5sS3gENjCSDh4
	XOpKd7Bvq8SeWukkxJ7hGRGANAHGgQ4u7GWww/lQjHaZq+mYB4WRtF6REj1BiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715757289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OjxbuDWr0zOcw90ZsB0EVCRcP/VSMs6LQbSERYEb5HM=;
	b=2zLTLqejJl0Ua9Ga9kjSrJSd2+cmRRiET9BtcLwZPEgkSF6WMtC2NL6nFsMyD+/fMvpHFz
	aCS2g4nSnd29RpCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Lukasz Majewski <lukma@denx.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Simon Horman <horms@kernel.org>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Arvid Brodin <Arvid.Brodin@xdin.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Casper Andersson <casper.casan@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: hsr: Setup and delete proxy prune timer only when
 RedBox is enabled
Message-ID: <20240515071448.Vf_t99dI@linutronix.de>
References: <20240514091306.229444-1-lukma@denx.de>
 <20240515064139.-B-_Hf0_@linutronix.de>
 <20240515090904.477c6b5f@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240515090904.477c6b5f@wsk>

On 2024-05-15 09:09:04 [+0200], Lukasz Majewski wrote:
> Hi Sebastian,
Hi Lukasz,

> My concern is only with resource allocation - when RedBox is not
> enabled the resources for this particular, not used timer are allocated
> anyway.

timer_setup() does not allocate any resources. The initialisation is
pure static assignment. The timer subsystem does not look at this timer
until mod_timer() is invoked (or something similar).

> If this can be omitted - then we can drop the patch.
> 
> Best regards,
> 
> Lukasz Majewski

Sebastian

