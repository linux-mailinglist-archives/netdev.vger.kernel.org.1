Return-Path: <netdev+bounces-217604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B7DB393C4
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 08:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03BCE3644FB
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 06:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C955207A26;
	Thu, 28 Aug 2025 06:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RjNArcxE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X51vUQi8"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD121CAB3
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 06:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756362538; cv=none; b=WWEP/UKEEyVvrBLAK7m3rWO0liFZxyZH0zSmBR+tO4wFWLUlqdNbIeKcswJp9e7M9DCXXWUUETPrEcr3nbi3InCAPsfPrRhAmDlWyZ6sckNxb6lSn8nwAfmqJFOoOW35gjYlz5JhKsNVnqnc1BWSmjQN4N0Q68fBnLB9+dtBjV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756362538; c=relaxed/simple;
	bh=DwTlqxX6tIgbZvw+kgjUnRWq1zFPBxjF7k+EvG4okzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfttKW7V1nfPiTWq9kjZ9jGcGjg9GdAsLml9PPzO2av7hRoNqLUxc+Y7i6q4QV4OOubB5TLU99nC2ZNTBWt6ICsYSuigJaLogUDF+COcszP6wfOsMTnkndlosU59Q2Ffrr2FxM08S0yFl8EtreP9wWxpjaQKKCWjA7LIY0ii2XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RjNArcxE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X51vUQi8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 28 Aug 2025 08:28:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756362533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwTlqxX6tIgbZvw+kgjUnRWq1zFPBxjF7k+EvG4okzQ=;
	b=RjNArcxEU3UozRbTkJVVLbmVYwi383ybNbscHnPVd7LVDYd3PB8WThkGGFGVaVYRhM369y
	x4T9RufwU9qb7FGDvzq9ki2Hqcq8w6cM42oyUi3owd8/sdeMpPphngfO5ULNHsYEfJRnre
	LreXJyHWTuBxfn8cXx9mzir1t4K7iQT2WvR1muf2kDz1lB4AMW2YyKD0VvBhvIr3Hw6aM4
	VBvjdRXq43k0v7bbtHCOoucmFNXk4g6M8OHDLboq0/dQzdphndo8S9KpPqJYORUNuDW6nw
	5swBanicSvh5h/LJcR9SiY8jShwGFvfKH8JMsNBnHKPjPGrlpWnlySg8DRGH4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756362533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwTlqxX6tIgbZvw+kgjUnRWq1zFPBxjF7k+EvG4okzQ=;
	b=X51vUQi8KLWCV5IzhGkbeW7j1KY3WLCZxObUveZipQd6XK3ckl6Hbqw4lsUMi1lP0DYX7S
	+e0H/ttyzeN0V4Dw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot+72db9ee39db57c3fecc5@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 net] net_sched: gen_estimator: fix est_timer() vs
 CONFIG_PREEMPT_RT=y
Message-ID: <20250828062852.7LnXu1qK@linutronix.de>
References: <20250827162352.3960779-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250827162352.3960779-1-edumazet@google.com>

On 2025-08-27 16:23:52 [+0000], Eric Dumazet wrote:
> syzbot reported a WARNING in est_timer() [1]
>=20
> Problem here is that with CONFIG_PREEMPT_RT=3Dy, timer callbacks
> can be preempted.
>=20
> Adopt preempt_disable_nested()/preempt_enable_nested() to fix this.
=E2=80=A6
> Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")
> Reported-by: syzbot+72db9ee39db57c3fecc5@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/68adf6fa.a70a0220.3cafd4.0000.GAE@=
google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

