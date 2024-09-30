Return-Path: <netdev+bounces-130286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524F0989ED3
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 11:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB309281A3D
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 09:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA6218CBEF;
	Mon, 30 Sep 2024 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dgh05ztB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yE7ab8np"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFAA18BBB5;
	Mon, 30 Sep 2024 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727690136; cv=none; b=fXOcTbdkTBCC7oAyNkSvPURGu9yC83AVLhoaWBQUG4+f4BeG3wZZNMiVbTzB/EEXUROCRqYGRgLvQ2CPZx2iYRUP9olcGNyjLZqb58L+bsdhHKSkNJMpquAorDBb4yP7ktMXQ7K/TPqf1785tSLlaAs/4Q/MclF7F2qcnTouPr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727690136; c=relaxed/simple;
	bh=4nStY/Ei0jHnUHbqhHQx5TDZKxq7rceTapg5ogLOSDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRe5rdIeYNHad3vVjriSIg4Q3D/1L6LnGp+SemCI4vds+112c8OLvI9UNCqMplMFVPlgaSNgbgiv3Kewoi6N58yiUwLKg1U48mUL4L4pYaETNjGoXlWZgAum0U4GCYVQAyXuVLrHlaWPszUu7PxwfXWJ5+E1htRG2hXlUj05VQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dgh05ztB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yE7ab8np; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 30 Sep 2024 11:55:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727690133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eCm+ZGSs89fZBPc0QAi3Lh3twMatMrAkztrGwOGxCEE=;
	b=dgh05ztBxcugr0HeUdPzw1q+hP7lkPcJc7GvDwiuVxI2o4gxK5BT3VhF1d9t6eFaFWgO+3
	PL1pJHVbz8UVwPrDncdliPnLgtCElo0i3t6wqzn/SKil805zSAliK+O0MXApvEuB4V2s4U
	4iR/SrC9PevpB1x52xZo2qG5FnhMGZ+PynvXtF1LjvcBeT73WKItmAJte0N0mKUpbW5peD
	aaOzm+yJ1y1OUU3iYalhBN8u44COOTHyniAwktqo7Iy+FYoVU2WpkL9mPOpITbLUlbQUw3
	CCFcjwfDxSptJrPWWdbXyoRtA94eR0uMeZA83Kg4HFjtzonJwZiAoh8d0WLYQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727690133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eCm+ZGSs89fZBPc0QAi3Lh3twMatMrAkztrGwOGxCEE=;
	b=yE7ab8npTdKvQcS0DKxkFwZvGNM4mIYO2iPC/6Uw0Z7R/+XpHnkr3FkgXyntEpEIoZk/Si
	Q12ZGWIB/fuGY1Bw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: Handle threadirqs in __napi_schedule_irqoff
Message-ID: <20240930095531.b_GDXzNb@linutronix.de>
References: <20240913150954.2287196-1-sean.anderson@linux.dev>
 <20240913161446.NYZEvAi1@linutronix.de>
 <0735aa31-3fc0-4767-9372-23509df751df@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0735aa31-3fc0-4767-9372-23509df751df@linux.dev>

On 2024-09-13 12:19:05 [-0400], Sean Anderson wrote:
> It's in response to [1].
> 
> [1] https://lore.kernel.org/netdev/20240912084322.148d7fb2@kernel.org/

thanks

> > The forced-threaded interrupts run with disabled interrupts on !RT so
> > this change should not fix anything.
> 
> OK, so maybe this isn't necessary at all?

Based on your reasoning so far, yes, not needed.

> --Sean

Sebastian

