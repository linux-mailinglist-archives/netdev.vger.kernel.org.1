Return-Path: <netdev+bounces-227368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B7BBAD2DB
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 16:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD663C18E7
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 14:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC31E1BBBE5;
	Tue, 30 Sep 2025 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BoF9A4Lb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RqD/P53H"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A24A1A0BE0;
	Tue, 30 Sep 2025 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759242667; cv=none; b=cqEKYIQYFVvTe9DZKgkcaUfS8y0goMvGql4Wvm6wr9ooZvd7LErHIODNpJXPOz4xvo7yRUeGMZeNlhNg89L1gemGF3fXYROrdN3INDpuAWJ4Xn9X5YHWbcezZ9Vkw95j3D0ZhJf5Z5AYAhdqZQzncZBtYPeXDlGlR8jKfEUvZdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759242667; c=relaxed/simple;
	bh=lJ41failz6s5ibyAqRor3HhQSOH1yaAZt9EsNN8NjJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvNRfMpoEQPFJLQ21CuBEhyH5IhTDzKXPzrPJKjhj7AB0Kond2YYys/D+0kWEPaYnvQ1XxOajSAnh15p1AM5QtIQsl2nDt2T07zwV78EbXAELDZX1Gd6SRlwheh3Y+9BCZV1ZB/UB/eKGf13vAxL1k5+lbujUqPgPzLgp/auhc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BoF9A4Lb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RqD/P53H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Sep 2025 16:30:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759242661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lJ41failz6s5ibyAqRor3HhQSOH1yaAZt9EsNN8NjJ8=;
	b=BoF9A4LbTD8DbuqzHMymn6Z0OFkUG4hgMjwnsc+CWSOZFh8CW2TypKcD6nS8vFO6zVCZrY
	I2xxcUBSnL5+++UruwBqLldWsSg6a0vuHXpsT+m/XRTwowQoiaw4z1W/CO9v8q1grclHt1
	MUeAI7G0VfmcnEd2DwMh9+PAlw3Fqj6FMd/WLQ38dnNjP0TnVisQSZ0+NSd1hMtIodU81g
	283y/Pw5pTeksIbepX3GfFxAfvTFfTODAXLMCQ1SnsrtIAsE+9ncEp5w73jhuh6F79YFuJ
	wQ1jvIeiH5/OAFHIv3NVEKk2IEQ3OGAYvcPZO15tADVY8o6Jred3kvHQ2RiiLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759242661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lJ41failz6s5ibyAqRor3HhQSOH1yaAZt9EsNN8NjJ8=;
	b=RqD/P53HXgLXPnIxXIDMMc9LcDoO0CnQqb8xUCl1SIgq1re5GZZNMTonrU7YQXjDKssDF0
	2W6zgpx7eeJ9V6AQ==
From: Sebastian Siewior <bigeasy@linutronix.de>
To: John Ogness <john.ogness@linutronix.de>
Cc: Calvin Owens <calvin@wbinvd.org>, Breno Leitao <leitao@debian.org>,
	Petr Mladek <pmladek@suse.com>, Mike Galbraith <efault@gmx.de>,
	Simon Horman <horms@kernel.org>, kuba@kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>, paulmck@kernel.org,
	LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	boqun.feng@gmail.com, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
Message-ID: <20250930143059.OA_NFC9S@linutronix.de>
References: <tx2ry3uwlgqenvz4fsy2hugdiq36jrtshwyo4a2jpxufeypesi@uceeo7ykvd6w>
 <5b509b1370d42fd0cc109fc8914272be6dcfcd54.camel@gmx.de>
 <tgp5ddd2xdcvmkrhsyf2r6iav5a6ksvxk66xdw6ghur5g5ggee@cuz2o53younx>
 <84a539f4kf.fsf@jogness.linutronix.de>
 <trqtt6vhf6gp7euwljvbbmvf76m4nrgcoi3wu3hb5higzsfyaa@udmgv5lwahn4>
 <847by65wfj.fsf@jogness.linutronix.de>
 <aMGVa5kGLQBvTRB9@pathway.suse.cz>
 <oc46gdpmmlly5o44obvmoatfqo5bhpgv7pabpvb6sjuqioymcg@gjsma3ghoz35>
 <aNvh2Cd2i9MVA1d3@mozart.vkv.me>
 <84frc4j9yx.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <84frc4j9yx.fsf@jogness.linutronix.de>

On 2025-09-30 16:29:02 [+0206], John Ogness wrote:
> @bigeasy: You have some experience cleaning up this class of
> problems. Any suggestions?

I though that we have netconsole disabled on RT. As far as I remember it
disables interrupts and expects that the NAPI callback (as in interrupts)
will not fire not will there be any packets sent. So this is not going
to work.
It needs to be checked what kind of synchronisation is expected of
netconsole by disabling interrupts and providing this by other means.

> John Ogness

Sebastian

