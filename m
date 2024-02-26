Return-Path: <netdev+bounces-74908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE40867417
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 12:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CE961C27759
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 11:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19DE5A7B5;
	Mon, 26 Feb 2024 11:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xgrpF85O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ROsfE2Cf"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5495A792
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948767; cv=none; b=UclMvazIudjyYmwFeo1GMjQxK7BgInVb6b3lwEX0Q3fYNftEkjA03djWn32zPqm80hLHwXHFJgvrPbN655rG592BQZzGS7ljkdVna+pr/I2y/JGskQnukVQe3sTVoGMd2mU2RwF161Y7EYREVGYPlEFglKC48Qo6AOaCk+anxw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948767; c=relaxed/simple;
	bh=tgH3PrWlS4v5W2HgdnQPhXMwJOPRARa3rjWxgwjcsFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foHL6Aed1Vd6pFVwe4hJEsaqon3Ww1qPvBG/FLhw10iXxtzWq8J8yxD3B3dw2avrY4TAyTnqkQR2SizXT3utGj9Xfj/edN4vsbF3YWrVC/C0Ygvpk5FWX0/g2Mx51MIovHRcokqhtTRtIRuKxf/mnzo5JWBy3/ZHdyllzEodRUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xgrpF85O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ROsfE2Cf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 12:59:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708948764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NgFK5jWzx6DmWx8ZqtnGBdRZPOE4Pah2OmJH2CdXGaI=;
	b=xgrpF85OEvtndIcCC15iWe/ReYbovMJAFfZlxxqFv4mFH8OyzzdfCJBcWeW+ycy7T8f9eo
	Bq7OX1+AYcitxXyY4WHNSpQ5QgnjsOxPxETcNjY9BKHGIUONpNih6M8TIRHXD2gaGqw+mw
	6wWWmkB2KTT/d4Wpa0lTI7/bAG9pzFWZ38D1e3wbO0ExvThe1mKqywQDK/jrrCiRi2nG+u
	CCxh6KC/BBYSjIsjVmKXD2oqR50j9vbPvr1v5IZ8kupoUM3zc5WuK9eMPGdcKST7RWFYX9
	HhrYVmgdENe4W/yo6ANIG7NHPPPrBKDXJEQa8Bu5X3udHG8AzMsMa2VikNcrAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708948764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NgFK5jWzx6DmWx8ZqtnGBdRZPOE4Pah2OmJH2CdXGaI=;
	b=ROsfE2CfZXJ4ct/WQfkM79CU7iwJndqOdOIN+Y0zt8xRRgs0ZH9WHIVt3mKfuZiUcvl84i
	rXEv9b13mYbu/QBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH v2 net-next 3/3] net: Use backlog-NAPI to clean up the
 defer_list.
Message-ID: <20240226115922.3ghr5wuD@linutronix.de>
References: <20240221172032.78737-1-bigeasy@linutronix.de>
 <20240221172032.78737-4-bigeasy@linutronix.de>
 <20240223180257.5d828020@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240223180257.5d828020@kernel.org>

On 2024-02-23 18:02:57 [-0800], Jakub Kicinski wrote:
> On Wed, 21 Feb 2024 18:00:13 +0100 Sebastian Andrzej Siewior wrote:
> > +	if (use_backlog_threads()) {
> > +		rps_lock_irqsave(sd, &flags);
> > +
> > +		if (!__test_and_set_bit(NAPI_STATE_SCHED, &sd->backlog.state))
> > +			napi_schedule_rps(sd);
> 
> Why are you calling napi_schedule_rps() here?
> Just do __napi_schedule_irqoff(&sd->backlog);
Looking at it, __napi_schedule_irqoff() is enough here given that we are
already in the use_backlog_threads() case.

> Then you can move the special case inside napi_schedule_rps()
> into the if (sd != mysd) block.

Okay.

> > +		rps_unlock_irq_restore(sd, &flags);
> 
> Also not sure if the lock helpers should still be called RPS since they
> also protect state on non-RPS configs now.

They protect the list in input_pkt_queue and the NAPI state. It is just
in the !RPS case it is always CPU-local and the lock is avoided (while
interrupts are still disabled/ enabled).

What about
	input_queue_lock_irq_save()
	input_queue_lock_irq_disable()
	input_queue_lock_irq_restore()
	input_queue_lock_irq_enable()
? 

Sebastian

