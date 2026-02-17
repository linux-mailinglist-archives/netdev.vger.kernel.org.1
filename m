Return-Path: <netdev+bounces-259087-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA8bMf6TlGl3FgIAu9opvQ
	(envelope-from <netdev+bounces-259087-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:14:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C98514DF45
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E730300D6AE
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D47136E468;
	Tue, 17 Feb 2026 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XwDVtnPf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K1Y40plc"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6692236E463
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344891; cv=none; b=MTylq9p3IATHC7UI3/SkljxeR44KfTioxUYzHDYjGN/q3PIl7HDPWHJ/nxY+mnUD9awShpK7Lm2HcCXbzMgIQYkjz87FqcQbwPO0ZjgT++HHH/d3+sdZAp+YIOiqa46C5hZAv3t/8bvyZRIWSqWGWXh0qprkNKCDMjpMSWncFxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344891; c=relaxed/simple;
	bh=HvNYTV2c9xYk371jY6cPOKDiXaEbwINPOLQvA0HmGGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7TGlRjEMm5UUxRMjJqIZb3ddGQNU5MHV9HlXM7TUVljhqU4HC2qQeDUmerEXMttH+tGpei4qYnPDxL8RU8NaKmosgFmf7iLmttsJb6+/jxyz550a88dOQ4R8yBCG0s5OzKCTDhPMiuyb5UdJMK0sP2gpBRZvf+KFOfuGxDjvUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XwDVtnPf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K1Y40plc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Feb 2026 17:14:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771344888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Z5/KLApu9SuW+UlcMMwlhFFRtUlI2yVkUsXD4WTlVg=;
	b=XwDVtnPfKgb6LpUeCL0dyVRjFdjnd6fLTr69wwWz3bU3XaadgsrSvCChnyAhOUyOBgfGJA
	z4i4PJgaofWByRX8N+uY6R16jnmUTf/0EWiX2XJWz59KdloBz4Y9F02k8jAzz337i7bTID
	BCLznb9rgzD9WfysCjOwXpt09b3AuIjFjmBtj4UyHPXacwfJSXjcRW4PdlpYtZmiDIPVcF
	1EkaO4UfXM5Oj+7PyEnQfSJ2wmAi1bCvSqYtTgD+h41aBGbSuaN24ZaEnJn5jDYUlx6CY+
	DJysjBQLLKGwIQNVQQGrbznSVOffjNcVi29GGMT0RvXJAceHaaD5JWIA4I2EZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771344888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Z5/KLApu9SuW+UlcMMwlhFFRtUlI2yVkUsXD4WTlVg=;
	b=K1Y40plcTJlRO8bFtTTIt1pJJSYXHX56TWQ8oTnNqPe/cAiL8eRx9SAclx3tw87yRx121M
	hlhoB3KLz07uBRDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Felix Maurer <fmaurer@redhat.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH RFC net-next 0/2] hsr: Add additional info to send/
 receive skbs
Message-ID: <20260217161447.eZ-80I8x@linutronix.de>
References: <20260204-hsr_ptp-v1-0-b421c69a77da@linutronix.de>
 <aZNBfh81p1zBvbi2@thinkpad>
 <d80e1fbc-04ed-4bb7-81ea-b298c6a0f15a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d80e1fbc-04ed-4bb7-81ea-b298c6a0f15a@lunn.ch>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-259087-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: 4C98514DF45
X-Rspamd-Action: no action

On 2026-02-16 17:25:33 [+0100], Andrew Lunn wrote:
> > Is there a reason not to create and bind one socket directly to each of
> > the underlying slave interfaces, with a socket filter attached to only
> > receive the HSR+PTP packets you want?
> 
> I don't know HSR too well. But what you are suggesting is what is used
> when you have an 802.1 bridge on top of two or more
> interfaces. ptp4linux is configured to open the lower interfaces of
> the bridge and sends/receives frames out the ports as required. I
> _think_ it only works in L2 mode, since the ports don't have IP
> addresses of their own.
> 
> If HSR can be made to work in the same way, you might be able to avoid
> all the invasive changes.

The missing point is that I need occasionally to send packet with system
HSR/ PRP header on a specific slave interface. Otherwise this is what I
had in my initial PoC version (this and dropping PTP packets early in the
HSR stack before they get forwarded).

>     Andrew

Sebastian

