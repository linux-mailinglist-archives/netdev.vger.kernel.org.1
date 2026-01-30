Return-Path: <netdev+bounces-255079-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAJfHvx3fGmWNAIAu9opvQ
	(envelope-from <netdev+bounces-255079-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 10:21:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BB3B8D4D
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 10:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC4EC3013EC1
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 09:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664D0352946;
	Fri, 30 Jan 2026 09:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IYqOoMP9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bTc6HI6s"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BD2329C74;
	Fri, 30 Jan 2026 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769764857; cv=none; b=cJNJV3n4FlghYezMakPgIvIwGxNGjjvEx7Rz8AnGgBLACNfx+kHzX0mJrARIMmDREZ4ZiQbaSaXT4Xg/Sr+yyZpWCS9281lmkldbA9PyOU+QQGjGvyBnFUhkyx6kxlmJ7k4Ibi6O6J0CUtShm42fBGCAW7opPQuxq+YSnOxRfEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769764857; c=relaxed/simple;
	bh=+Ji/JDzmGzLjJdjHGDhsRLxxQQN7YO4Cx+dhNGurg1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qNTcSUhCG3cJywsuxDC8riMLvFL5EQ0TuCzJbJiQvrZlRQc2/QHsbHijb8hq46+Q02u59xtndk3mABk3fNhee+C1e4Z/40QceVTLJUK71ZMg7UaNdqah72PVNMePwcaL7zCeQWKI4mWkExT/JSmS8J+GzwbQDvN/cl7XStZqR+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IYqOoMP9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bTc6HI6s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769764854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TkHPyjgxMiFLjBd/qTLYzxHDhkV+NMOimWy/RgwAQQE=;
	b=IYqOoMP9cwdkVFqTlKdj1HG4+Kcrh6YCg4+aCc3H3ZXtJMlLF0P2JEnVrvMhaXkIbCeCK3
	GvouyG2kg9ZFmyeUkrpIL+KZdD8TEz7OB9FYL4/xz9i3qt8y0iovOT3vKR4GgfeoHvtnrf
	JrhrjnAo9X+NmOOBpWmVwRHeTlppv2DNixL1q+LW74G+VTYGD3jqyAdd8x5PLLxxwuUcsH
	VzrcJTcle1zkJ2isw1BKM6tFrB2g5T0CmniMBqSGvgXusD383QJ889mAEulnWxw38qFVjx
	NX6pDpE4QJ/F44gZDIDnpDPDp6+5LNroN1HZBGnFEIVqHaxatFNf1neParwQdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769764854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TkHPyjgxMiFLjBd/qTLYzxHDhkV+NMOimWy/RgwAQQE=;
	b=bTc6HI6sbzehHtCK7GRIVgY+RFo63rkBmmo0zYx7z+MKoqcrUXTl2kO+CvOu/qLng9Cair
	1ph4UmjaoKutRrBw==
To: Breno Leitao <leitao@debian.org>, pmladek@suse.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, pmladek@suse.com, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt
 <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
 gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net,
 mpdesouza@suse.com, kernel-team@meta.com
Subject: Re: [PATCH net-next v5 1/4] printk: Add execution context (task
 name/CPU) to printk_info
In-Reply-To: <aXxy7usBz1-TTkVB@gmail.com>
References: <20260128-nbcon-v5-0-93b4ddbc181a@debian.org>
 <20260128-nbcon-v5-1-93b4ddbc181a@debian.org>
 <87ikcllrxz.fsf@jogness.linutronix.de> <aXxy7usBz1-TTkVB@gmail.com>
Date: Fri, 30 Jan 2026 10:26:53 +0106
Message-ID: <87h5s31moa.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255079-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,suse.com,linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.ogness@linutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,linutronix.de:email,linutronix.de:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3BB3B8D4D
X-Rspamd-Action: no action

On 2026-01-30, Breno Leitao <leitao@debian.org> wrote:
>> > Suggested-by: John Ogness <john.ogness@linutronix.de>
>> > Signed-off-by: Breno Leitao <leitao@debian.org>
>> > Signed-off-by: Petr Mladek <pmladek@suse.com>
>> 
>> Reviewed-by: John Ogness <john.ogness@linutronix.de>
>
> Thank you for the review. To confirm, it is acceptable to queue this for
> the next netdev version, isn't it?

From me, yes. I would be happy to see it in netdev-next and be included
in the next merge window.

John

