Return-Path: <netdev+bounces-258750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPYrJLoEkWkTegEAu9opvQ
	(envelope-from <netdev+bounces-258750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 00:26:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC7B13DC3F
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 00:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E920301368F
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 23:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6056827BF7D;
	Sat, 14 Feb 2026 23:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p4F08vC3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uICWyFb3"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4079414F70;
	Sat, 14 Feb 2026 23:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771111607; cv=none; b=RdDSYa+MXClDu8Y8EQBBUUoN7GA8wCwX3qWbefXrnUkx9owjw/5sl9Zzm9C8TAefmpkX4vnBis9y7HQXeDSybMcnTkkHia1kljyooLovDrkYmzEnXLSHBhQ7MQX7cPcLJOCpggvQN9yeviH3Pi4Kbk6w+K2ifqmqruQ+yIkzgKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771111607; c=relaxed/simple;
	bh=ENEwz6LdmKpREpK8bhdMo739PNLmgWrRKaleXuhgM9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGgmmgh2BJe3GOuk/J7VHMkO2jpcu6Cii3sKGgbFAl6hpdD/+ov3j67aJgoQtUvtuCvIHjhUNG6ZuLXSxAsh3b+e/a5FxdYDUaEM7qzT34E+6Pc8Y2sCd8+ZL36w5KSJS9qSBL4wnFQOgFOyKb4as4UVX+XLuCRwkkhF728+wcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p4F08vC3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uICWyFb3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 15 Feb 2026 00:26:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771111604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ENEwz6LdmKpREpK8bhdMo739PNLmgWrRKaleXuhgM9E=;
	b=p4F08vC3S9ncfwCsy+GC+uvHmCPqndlBDnPCI1cCe7xrldv/S6qptCWcB8z21LE+XakRlE
	kVAJ7N2LDStDBzyLj2KH4iEYR5v4lHrjqlsv5EvL/H07h4BOR0/5IYyvNYq6loCjQMjAbs
	MTcdWXzf3gHIDqfXu7dlhbP71RMPMZilSuSR7STlS2lAVUQvzPunCVh1rNXsjXrIHbm/g0
	GZEKwFhVDwtGt4xZsEM8XSyJ1lxnEfh6K0ZEvuBIBO5Ky/USMLYFWz9WBVynhHM2l2oTw0
	5D3+FEpL/lElTCDHnqgblFkUABnvbT9/2aF8K+QMvjpgShNWHn5JAtfhHNi3LQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771111604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ENEwz6LdmKpREpK8bhdMo739PNLmgWrRKaleXuhgM9E=;
	b=uICWyFb3Mg9VCEgcxdsOdktkOgtEGy3Ipqgg2Xgr5xVnr1LlnzMCJWJLOA1YowSBrvVt/e
	bbdDt2tkdK9JuUDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	"Gomes, Vinicius" <vinicius.gomes@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx timestamp
 directly from interrupt for i210
Message-ID: <20260214232642.6j_2036G@linutronix.de>
References: <willemdebruijn.kernel.bbdefedfb87e@gmail.com>
 <20260209090621.GiZqTiMJ@linutronix.de>
 <8e762437-69f9-40d7-bb75-3a45bef1d5d6@linux.dev>
 <20260209114836.GPU-vnnh@linutronix.de>
 <78e2af2c-40e6-43f1-9471-42f350e69389@linux.dev>
 <willemdebruijn.kernel.2e6213a98660b@gmail.com>
 <20260210121207.9kLHroS0@linutronix.de>
 <willemdebruijn.kernel.cceee43f5b9b@gmail.com>
 <87qzqr5vos.fsf@jax.kurt.home>
 <willemdebruijn.kernel.2759f838d176e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.2759f838d176e@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258750-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linutronix.de,linux.dev,google.com,kernel.org,redhat.com,davemloft.net,intel.com,molgen.mpg.de,vger.kernel.org,gmail.com,lunn.ch,lists.osuosl.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:mid,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CEC7B13DC3F
X-Rspamd-Action: no action

On 2026-02-11 11:29:43 [-0500], Willem de Bruijn wrote:
> I think we should look at the locking. It is not clear to me that
> sk_callback_lock needs to be held here at all.

It can go away, posted https://lore.kernel.org/all/20260214232456.A37oV4KQ@linutronix.de/

Sebastian

