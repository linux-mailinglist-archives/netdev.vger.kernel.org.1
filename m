Return-Path: <netdev+bounces-125523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8815F96D81D
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FFCA1F22BC8
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 12:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AFE19AA56;
	Thu,  5 Sep 2024 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tYY+yuMK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bylXMyBv"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E931993B2
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 12:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538631; cv=none; b=hOMMJco6Yuby5UiwIC78zFFiBgQ/5rnX53d2RM7ziDlEHmHeSeWtYRI/QUb2MyqwYY2ABpI2mJGGp1X8PwOlOLMfKK6jvo0+iSSdT4sinXCD1UVm1BCfiHyh3NObZSuyBjO8gGGYlBPaTDZZy99YnMzgMmya98yGRGQW6OQCEg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538631; c=relaxed/simple;
	bh=Nl7tep75+weiAejeyQ5o4VBkqcSSwdr0e/Frg0wdF7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOS5HrMY4q5TtRJKlQU0R0fCpWwkxpg2OI4x620O21v7U+iro/i/L+MVTCNMWNkKY0G/y/XZWU609r8rTODs2EDfTSrQ9FhHwQCRwjuuD2WUgC3ipwOTGIps5P1Pb/KqZyIccZ7Cuo0EEOxz9k/fx+0WQLh7NfPZeS2AnNOBaXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tYY+yuMK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bylXMyBv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 5 Sep 2024 14:17:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725538622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rlhnKLN6zGasGmEiGZMG745V9CKOHbVdTW2uyj8j/Pc=;
	b=tYY+yuMK9NjCin6w7C9F22jIj2id+02jMJ6i25y8YlOe9Vk22c9T/nDILuJWr+xk9gA+DU
	9kqJ5Y6iaVG9crhfNmpDxcKtjJnSrcM2d1T1m9/QPhMC6obQa05ARrqwKsMwsfeGqjobln
	fhMr0SuYWCWouaVI1QxyGDaU3AOjmc56HTsfJpXc3DDKdmrrnMEht4GzN1cDaiUW3+lfhb
	iThg0p3oqsZQ9bTaW/Pa8xs7yLT0P0tskHYcgsGpknXE64ZLChOGbqOFWT2EQaA+fLPMvq
	oWxQJhojiByYnh8j67mlw2m3cC3geB7bmKMFJlqvOO2dJuo9X9BPvJQ15F7ZqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725538622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rlhnKLN6zGasGmEiGZMG745V9CKOHbVdTW2uyj8j/Pc=;
	b=bylXMyBvVnqLRljs8RzJZXMz5DXokeM8G5RsOfIWR0UVbfAh0kSjg1Th300XrOk1ls4IQN
	c3hvPsSxNShlFXAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] net: hsr: remove seqnr_lock
Message-ID: <20240905121701.mSxilT-9@linutronix.de>
References: <20240904133725.1073963-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240904133725.1073963-1-edumazet@google.com>

On 2024-09-04 13:37:25 [+0000], Eric Dumazet wrote:
> syzbot found a new splat [1].
> 
> Instead of adding yet another spin_lock_bh(&hsr->seqnr_lock) /
> spin_unlock_bh(&hsr->seqnr_lock) pair, remove seqnr_lock
> and use atomic_t for hsr->sequence_nr and hsr->sup_sequence_nr.
> 
> This also avoid a race in hsr_fill_info().

You obtain to sequence nr without locking so two CPUs could submit skbs
at the same time. Wouldn't this allow the race I described in commit
   06afd2c31d338 ("hsr: Synchronize sending frames to have always incremented outgoing seq nr.")

to happen again? Then one skb would be dropped while sending because it
has lower sequence nr but in fact it was not yet sent.

Sebastian

