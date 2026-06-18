Return-Path: <netdev+bounces-300482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3sidGOkVNGpXOAYAu9opvQ
	(envelope-from <netdev+bounces-300482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 17:59:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F3A6A1680
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 17:59:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=QKJjVw9+;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=xIMrlJlz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300482-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300482-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80E583091C57
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 15:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004F32F8EBB;
	Thu, 18 Jun 2026 15:53:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C802F7EE1;
	Thu, 18 Jun 2026 15:53:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781798021; cv=none; b=aK8zxQv1Uymw+V//XNV4zsqariEOCtyN1CE5B/bNvixb1v/9EAr5H2K0zOR7LP0oohsICbbgn0bU321HtiLcQH2hxRWkMmgkEn67H2zW89ZjX43KSGuwt+T8PdRzojqyjlvshwDwSHvvRPHYk1YgjvQS08JPuZsktBCfbsYRhHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781798021; c=relaxed/simple;
	bh=K06X5qoPB0dVAL1KY8FBHUBKxms6yGG9dyP4VAwbsEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXcIO0yVan/QELqYeKfbbkjTJ7taMKT5iesnuMnIUOWvGbkE8JTm4I6NkY6LNdspc9MCRFTeZ76ZoRyuZWGqgoCZeULeDoyFkbbweoyv1f/b3IWZtcY8XYWU6AI/Wtoz+eS0OJ/XSFOwC8FI7YW427JTKBPJYesU+WBdha4faXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QKJjVw9+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xIMrlJlz; arc=none smtp.client-ip=193.142.43.55
Date: Thu, 18 Jun 2026 17:53:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781798018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K06X5qoPB0dVAL1KY8FBHUBKxms6yGG9dyP4VAwbsEg=;
	b=QKJjVw9+mKgmRWrHuK0bD/Os+/SBmClT1JMVcPCROxSob2P0/5oSWg23k1STl51tf3uXKb
	33mzGi5ucGxMrsGbD9DfS89UHLTMUL6q98UucIiOaBefqNQ6qqlYIDMPAx+0rhiq2jcnIN
	Yf1yZMLYPg0OhWuQKiw1Hicwm3Y5kK23B3U/fEihT2206uo1OqAWEXdZlvv360Bv0oX5Ve
	5T4l2iCHKskPVxiS0BCR3r8kQuxTxW8zzyYB/t6m7ZqHw0qp4bf6QWbBYwpTsriOC+okQ+
	Dx/QsSrJXi5XcSlpzGGr2Dsvbm4eUy/6U4eKVCSjanWsnvQglur36urn3OJpfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781798018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K06X5qoPB0dVAL1KY8FBHUBKxms6yGG9dyP4VAwbsEg=;
	b=xIMrlJlzoxwBjhQ1zAwCTcj5/T412EX4e5qWknnsxLUjXAVx4KlxyzBDtgTl2BIf8K2PwL
	8dWJEnsyymevwTAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Zhou, Yun" <yun.zhou@windriver.com>
Cc: marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: mvneta: re-enable percpu interrupt on resume
Message-ID: <20260618155337._cxJpvd0@linutronix.de>
References: <20260618104351.3456161-1-yun.zhou@windriver.com>
 <20260618125128.h5g-StPH@linutronix.de>
 <06d0158e-bf4c-4ad1-8ad3-c8176003ab11@windriver.com>
 <20260618150440.cLDwgyDM@linutronix.de>
 <3a4ba3da-47ee-4da7-b0da-af500ff1a369@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3a4ba3da-47ee-4da7-b0da-af500ff1a369@windriver.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300482-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:yun.zhou@windriver.com,m:marcin.s.wojtas@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marcinswojtas@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4F3A6A1680

On 2026-06-18 23:45:51 [+0800], Zhou, Yun wrote:
> > Having a NAPI instance with IRQ per queue and those configured and
> > spread among CPUs should cause less trouble and is what others do.
> > In fact is the only net driver using per-CPU interrupts.
> >=20
> It is a SoC limitation. Armada XP's MPIC provides a single shared
> interrupt for the ethernet controller with per-CPU masking for
> interrupt steering =E2=80=94 there are no per-queue MSI vectors. The perc=
pu
> IRQ model was the only way to distribute interrupt handling across
> CPUs given this hardware constraint.

Is this a hardware constraint or more a software design choice? From the
other comment it read like it could be changed.
There is nothing wrong to provide 4 interrupts for a device from the
device-tree and then allocate and request all four. This requires that
SMP affinity is supported properly in order to spread it across CPU. You
would also be able to reduce the amount of queues/ interrupts via
ethtool if you would like to isolate a CPU for NOHZ reasons.

Sebastian

