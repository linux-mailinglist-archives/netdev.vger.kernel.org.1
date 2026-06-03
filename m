Return-Path: <netdev+bounces-294514-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dvlNEXeNH2p1nAAAu9opvQ
	(envelope-from <netdev+bounces-294514-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 04:12:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EF36339B3
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 04:12:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nIhK7AxS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294514-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294514-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2347D300E331
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 02:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D423D810B;
	Wed,  3 Jun 2026 02:11:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051971DDC3F;
	Wed,  3 Jun 2026 02:11:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780452708; cv=none; b=s7bBnYdOLF25+AprjIXCIoJR3J/2hxI4sxg0IV7eHMjnqv/VIgltlnleN8rf3ahyoH9Q6ePfrHm+4U4NYySOoOK/0rjLIT63VUM2pHsyE7CgnACgNa1fdc/sHhdMhkeTtv64Btfxk1U5v4ZVkUalrSq/BxdM2QG8Myc5WDWn+/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780452708; c=relaxed/simple;
	bh=voVZx1GIudpGX0AGo7GPtPWorlvJMKRTYdDmaZd2AhM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LKlCypnXqZ7ewb9AUN4zyMrTRDbuRq9ILiPBrqEl4EG4QAzVgx41QhtTqn6woQ73o+mc/ME8W9+EW6LMvLQ2IBQm8JwhXDIcJpWRbTTiR1QzZuGJ4agVofnLLj6pNGzb5XYsFrk3GVeabK8p/WvZcRj0jDSzPm0+SESoaHTVV+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIhK7AxS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B4B1F00893;
	Wed,  3 Jun 2026 02:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780452707;
	bh=2ZnF787JgdPjtfwtyHh+h25jAvQi0FoshaX+J1u/6x8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nIhK7AxSMbDx0ECI2DO6OECw+1ErY0dTDMXIVzqNxbMGR8TpVrYwfl66eaEuanttd
	 03ViQVILVlM+lyWIomgHYczR/FQXqQLkEGlbWCk5nHJ6x0JDcRd3EGmqlVthpoDHTD
	 E+cu6+eS2vDjRx4LIpJccCI8zCJKcXJe7/99SY/4jaNhHgnwRspcgEgZl1OVqrTmwG
	 MzkYkZrme3DUtFTfz6bD4S9qcUM/dSMIx/tStmXC2OhhkT8b5P8MiKr/Htnf7g7sN8
	 5oH0NAH/52qrABOfM9t41EBX+x1y6oVg255DFUiZgfrTLss2ghiPbCqO00ukTEs+/R
	 tKo273gB0a8Ig==
Date: Tue, 2 Jun 2026 19:11:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Cc: davem@davemloft.net, edumazet@google.com, ernestas.k@iconn-networks.com,
 horms@kernel.org, kees@kernel.org, kuniyu@google.com, leitao@debian.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v2] llc: Fix race between sock_orphan() and timer
 callback in llc_sk_free()
Message-ID: <20260602191145.3deea6db@kernel.org>
In-Reply-To: <20260603013007.1171695-1-xujiakai24@mails.ucas.ac.cn>
References: <20260602133002.3ed70fc3@kernel.org>
	<20260603013007.1171695-1-xujiakai24@mails.ucas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294514-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xujiakai24@mails.ucas.ac.cn,m:davem@davemloft.net,m:edumazet@google.com,m:ernestas.k@iconn-networks.com,m:horms@kernel.org,m:kees@kernel.org,m:kuniyu@google.com,m:leitao@debian.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 31EF36339B3

On Wed,  3 Jun 2026 01:30:07 +0000 Jiakai Xu wrote:
> > Sashiko points out that there's more issues if the timer runs after
> > llc_ui_release(). Can you reliably reproduce this? Have you checked
> > that this change is sufficient? Sashiko says that llc->dev may
> > disappear even tho we don't clear that pointer in _release().  
> 
> This crash was discovered by fuzzing. Unfortunately, the fuzzer did 
> not generate a reproducer program, so I am unable to reproduce it. 
> Our analysis has been based entirely on the crash report.
> 
> I'm not an expert in this area, so the quality of my patches may be 
> low. I really appreciate your patience and the time you've taken to 
> review this. Would this V3 approach (moving both sock_orphan() and 
> netdev_put() into llc_sk_free() after the timer stop) be the correct 
> way to proceed?

Not sure, feels like we're trying to fix symptoms instead of addressing
the real root cause.

