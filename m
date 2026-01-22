Return-Path: <netdev+bounces-252471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Nn5FuBlcmmrjwAAu9opvQ
	(envelope-from <netdev+bounces-252471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:01:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1F96BDC9
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFDCC312FE95
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F202539CB24;
	Thu, 22 Jan 2026 17:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vGOdDs8g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BCxD7W4H"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F10B33C192
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 17:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102699; cv=none; b=d/IMtoy4/q+afDI8P1cnkr7Vb3G6vC6n4hY4Z4E82NGr63KzT8TQOyQcCktL4OA00XNO6e5RCqS+7MJ1rKNEq6yXjXJsqXqkK4scTzwBN9Ju/9CgGdtTpTD9XfBP2eL2oOIOuBTeomXL8So31yN1nfySboZ+wA9+5dlbd0kbxiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102699; c=relaxed/simple;
	bh=oemMxJWUlFpAA2L92FqUU16beahK3YjujAxY33jboq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuTBvNzv+PJz2TDZLbm/ZcpYXI1GjpVvqw9iHTF32r4EgCR4BvhtUTyQbW8vKGvi3jsxvRVoYK8F4gSYPqc/rUI+VZZ0MN/TOTZxFKN6fsGtGAnm0gP86Wjpl5241Ce2T8S+M/NnoyteLwNvttlp/6ro2sPDIakAquBTDUrd3LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vGOdDs8g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BCxD7W4H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Jan 2026 18:24:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769102682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oemMxJWUlFpAA2L92FqUU16beahK3YjujAxY33jboq4=;
	b=vGOdDs8gj2DEzYq8TsHJNQ99lX0RHsSiX+hPNb05SbJ51LqZ165Ao1oljs2ho1I+ieTGEI
	WA2gLYZd6a6L3NYKe3ZclJZVIsCj4OBosjxHChWshY/haHJOFkbqOM1jt6A1CFIQHKs/lY
	0JkZV23lGi/eCk2L1hYh3Wq+vO7rP445cy/V5NCcJZHhbIFX6fD11vv3ZLxTWGSItOJb0V
	8VS+/OzgY+yUILd6tE7BgeqrlhRAQOe34h9QNcSJt9H2NaDpM8uCPEUEcnZeA2+u3vPjv3
	5pEEVDlZAbrKrlPsqat+E4fVWtnyiyLhvPKrKkbNBhHE0ma3MVHJNGVX+RTtow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769102682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oemMxJWUlFpAA2L92FqUU16beahK3YjujAxY33jboq4=;
	b=BCxD7W4HNxR8PaEkwX2GdrE0WUrm0nBNV7e+xoK0MUR/QoD3MxBL4nDo7CNq9SmLcWhJ4z
	D8PtFWNl9CRttaDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net
Subject: Re: [PATCH net-next v2 0/9] hsr: Implement more robust duplicate
 discard algorithm
Message-ID: <20260122172441.IIR1mXs0@linutronix.de>
References: <cover.1769093335.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1769093335.git.fmaurer@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252471-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.960];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: DF1F96BDC9
X-Rspamd-Action: no action

On 2026-01-22 15:56:55 [+0100], Felix Maurer wrote:

I try to get to this.

Sebastian

