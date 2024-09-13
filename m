Return-Path: <netdev+bounces-128167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D6397858D
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 18:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9991C222DD
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 16:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BB46BFA3;
	Fri, 13 Sep 2024 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nu+zkOGP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wtbJP5g4"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F4261FEA;
	Fri, 13 Sep 2024 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726244092; cv=none; b=F3fq2516eS8KZn6kxK6vJxI+XvRHYZvq+rR+498uAWVdP0n3IILB8f0328t8fstFPH76p65oZhPq6YMJCNI7+5TwMAGo/shKa9yIwAgbvtrrWC+0YGNMC9f7QGYKdPGkhTcGsD27RTehND6Bu7+X3h1Rsh1rOg1Z086KWqEsyCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726244092; c=relaxed/simple;
	bh=GaQg+fwrZFri0Wi73Qs1StGP0rbN/Z50JZa5VLeb5kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLupY6MaPpP4c80fsAuCW3HOpIpyTQ8W232YDbmgDoJjWsDrQ2cacN840Y5N5zhlT7nuWVQvttg+I1Ja0J3jVG+e3L3UjBi7KeB/ucxEhOoIeQCDunJYRsjlc1bA10UStuZUjhAirlQFWkKpZg7EbtF3gq8y25TShf047oydnkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nu+zkOGP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wtbJP5g4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Sep 2024 18:14:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726244088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GaQg+fwrZFri0Wi73Qs1StGP0rbN/Z50JZa5VLeb5kI=;
	b=nu+zkOGPe3xR5bt11oXeZOycgOnEec3ksAZCem3ZbUKLrJazUZfjLk2umKdSIO49EN68Lw
	aueF83UXidFBycjET1+mQ5w66OkHvTubQv4WLG7AfTjaKNQ84U3rWmt4cQs4FYoVVCaXoA
	1XL91A1G2phkKDC/XKTjIHLxamotGr0wZRsxASbeEtRPXz25UBOK268XxUGz1KIBA6XGow
	nQ/WRUSddhmFHkbc/ud1dLCsqBNurR9HoIIMEGuRqC6+VDf2aGsuC+5Lk68jrw6dziB9bu
	y8DAJnttadjXLuxpGm1ADBTJ8pWXynqhgX1v0NVVGkuLy4fPrez85XQUoLwq5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726244088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GaQg+fwrZFri0Wi73Qs1StGP0rbN/Z50JZa5VLeb5kI=;
	b=wtbJP5g41vUGuzd7rSTUGc6XKAwIfnsOtljKVIyzw7TmCMHg6BSFRRuBdgMzh65/v5gg9X
	99xdwlQ1rIgIcmBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: Handle threadirqs in __napi_schedule_irqoff
Message-ID: <20240913161446.NYZEvAi1@linutronix.de>
References: <20240913150954.2287196-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240913150954.2287196-1-sean.anderson@linux.dev>

On 2024-09-13 11:09:54 [-0400], Sean Anderson wrote:
> The threadirqs kernel parameter can be used to force threaded IRQs even
> on non-PREEMPT_RT kernels. Use force_irqthreads to determine if we can
> skip disabling local interrupts. This defaults to false on regular
> kernels, and is always true on PREEMPT_RT kernels.

Is this fixing a behaviour or is this from the clean up/ make it pretty
category?
The forced-threaded interrupts run with disabled interrupts on !RT so
this change should not fix anything.

> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Sebastian

