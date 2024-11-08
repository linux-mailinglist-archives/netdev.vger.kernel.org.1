Return-Path: <netdev+bounces-143284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1893E9C1CF5
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 13:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CE761F24704
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 12:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4A11E8830;
	Fri,  8 Nov 2024 12:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vvqwxkye";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wXLeRF8E"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CF61E7C2E;
	Fri,  8 Nov 2024 12:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731068914; cv=none; b=Mwyy/Oe5cl44ezYtNpgsA1hyOLPiwMIwVcNqyqB1ClSSm1ieSrbx8Zqf1Hl4qB2LsllaHxvzcNpj56aqj4plZabSPoWfLz/uFegVz/5DicKTSQs10jDb5cKm0+3BJ0efvmBBC6qn/mbxZ8g0FMdS0OKiMUptpe/14Tnp9s/gXBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731068914; c=relaxed/simple;
	bh=LMKq9rkoIyFUohSyOhYK7G5byytQGxxY6fPL4Wtg9fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLE08k6ltRe7zyGxdIOLzcB3PmK/AZvcI+yCOHl0Y8rrOsZ41SK915mabBLWqYNXODm3CcBeQwJHOs18YGTluQvs9qP3DpQICnbypJdSR3D2g4Q+IyZoZvIhU038vI4HaNthpWfUPu+djpqnqLSlFiuA1ipAH4ONBORzgvySx9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vvqwxkye; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wXLeRF8E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 8 Nov 2024 13:28:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731068911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LMKq9rkoIyFUohSyOhYK7G5byytQGxxY6fPL4Wtg9fc=;
	b=vvqwxkyeETXOKX8tiQbGG+Jamzv6OxZx29ZXDDfKOspUYXrrNPmz1V9akEQbkDxvjjhete
	y7YoONWe6qSITvVLQT2YHpJnIDq0B3BP/HM3WuOsKXbGt5Q3HWSauLBV1oodOtxyIdmRKv
	SshSCD1xzV4Da9sml0NyxmQLZZtVAWcgbZbPnRgCwStaajHraqrujW4e2IkmEi2O8PvxuK
	S63aG3v5+IbqF5P8/cR4MN93eMLH+Gi5RdWGAqKi41NLTumvvg6S4xJQ0RUCyO8I0R92Lw
	MZACFP8NXJkDkBRrcq/cOmXxfqyCoM3LApbWfful2bBDHFaJNLiREPs9DB/t0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731068911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LMKq9rkoIyFUohSyOhYK7G5byytQGxxY6fPL4Wtg9fc=;
	b=wXLeRF8EToVc+MUy+lWHA4Hotrwr2ftAsmy/WbW1Am/ZdzwTBJ+ggNsAQJErKk8ZAtWugu
	H4ItCQVzXu+XBFCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Wander Lairson Costa <wander@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, tglx@linutronix.de,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH v2 1/4] Revert "igb: Disable threaded IRQ for
 igb_msix_other"
Message-ID: <20241108122829.Dsax0PwL@linutronix.de>
References: <20241106111427.7272-1-wander@redhat.com>
 <1b0ecd28-8a59-4f06-b03e-45821143454d@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b0ecd28-8a59-4f06-b03e-45821143454d@intel.com>

On 2024-11-08 13:20:28 [+0100], Przemek Kitszel wrote:
> I don't like to slow things down, but it would be great to have a Link:
> to the report, and the (minified) splat attached.

I don't have a splat, I just reviewed the original patch. Please do
delay this.

Sebastian

