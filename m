Return-Path: <netdev+bounces-130720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4205198B4EA
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 08:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF442B23AA4
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 06:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144F21990D7;
	Tue,  1 Oct 2024 06:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ty5VVpuB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U/3H1QsN"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4F063D;
	Tue,  1 Oct 2024 06:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727765561; cv=none; b=nLzRpiQnj9pcqcy26oYDQ6keWIg28zptcaQU9AVvDtYarAZmSd06T6FUCOAvC8z2RzW5veUkL0l0ATOG13Sh7vefN5uSZ+eTUntdruoyusbFfziD9+kHWjaiuL19PP7Fux/IpWnvF1mU3IIHGGRqpKfBrpBNsCI9R0MhNDMsSAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727765561; c=relaxed/simple;
	bh=Ah2Eb/fQPhPHoG6yxtGmV1GmMXxGOMtQgibGTHc6gXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pj3I2JA0QUUMkGTjs50URnnVP9GVvpWfSq3XjM5YO1FmjGa5H/lfza8jDRa69N0eG/OHTwuW9ZKf/NIkF/lj4xJxCoiwhjnfMBv/Ayia3c3tysc1R4VFwcXWX+XNUHmXnQB3Rui18t7mCIVOsK+K3ctL2G1DNVAVKSnmiodIj4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ty5VVpuB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U/3H1QsN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 1 Oct 2024 08:52:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727765557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mV+B6cZhN3L3FUa1yf53suZCT9wy5aqHL2vlaFhfBPg=;
	b=Ty5VVpuB1RPEZXpvBVgQQJUwE/Ln3pfcFcP65/N49x+4veKqs3Nkfylsej6JeuDc9/DNpD
	vdbpN2XULV+BJAAbozuKZF6H0PpmlZm0uPh5hPUmKHardRBkYmAChiFmwR7vNLoWslepG+
	i3Vt/nB3SB+utwjsfN7bRqYih2nHMK9n18cxwL8MEQT9xrvM+OkeuRq/a96xQMNNS2vyCJ
	Kl9vivEnfaauLSC0+sXX2lyyvPDcsICJhNusj13TaPuap39SWrW8pACLYBluCUD4DUU+84
	pLzQPre8oxoX3xb/isMRas+WM6gTa09sdr67gW6/2aOyBycezMdeyl4LKGQVZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727765557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mV+B6cZhN3L3FUa1yf53suZCT9wy5aqHL2vlaFhfBPg=;
	b=U/3H1QsN8lq4vWXTOTQSNgNh0k4kLo4iVtDAY0nDmjw5h03UdqLGiwPVKZLt0NGwzr6hGA
	RtfIzlxFf+6lT8BA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Brett Creeley <bcreeley@amd.com>
Subject: Re: [PATCH net] doc: net: napi: Update documentation for
 napi_schedule_irqoff
Message-ID: <20241001065235.Ka2p3AtB@linutronix.de>
References: <20240930153955.971657-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240930153955.971657-1-sean.anderson@linux.dev>

On 2024-09-30 11:39:54 [-0400], Sean Anderson wrote:
> Since commit 8380c81d5c4f ("net: Treat __napi_schedule_irqoff() as
> __napi_schedule() on PREEMPT_RT"), napi_schedule_irqoff will do the
> right thing if IRQs are threaded. Therefore, there is no need to use
> IRQF_NO_THREAD.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks for docs update.

Sebastian

