Return-Path: <netdev+bounces-258471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGCPCDcAjmm0+AAAu9opvQ
	(envelope-from <netdev+bounces-258471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 17:30:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CA412F72D
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 17:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5486304501C
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 16:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08ED1353ED8;
	Thu, 12 Feb 2026 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p/ptBcHj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S9aeuaEK"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E5134F462;
	Thu, 12 Feb 2026 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770913739; cv=none; b=duvBybiFZFxx31Zx3vv6pU8LIErmv5uJEFgqVgyBJAzTysXwVQL3dQ9TAA1Xr2O9XGeP5IsrBELcL7dCF5wtw6ea7vNWf+R6BGoQkELRaGpZpg/Y6PtSVkgDk5sLe68aFtUyiCW6+Ak7M5ft+qdtgHqcmwRpPnUtYUD39wzsHQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770913739; c=relaxed/simple;
	bh=TRHZXcV2nDdeLMlTQ3urObUjcIUvRlNNfh8C7w6ZmWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjBiTXutjag7i+WcEMS4q8vBEitw0a0W7ppxmgwWJ24UKtQp05WxWxiioxDpulMCSkRDnXS0JLB732GqDw7Nn0VXKdU3RgI6COg9K5+5eSyZo5L1K9reLiwIHqujJnDtcq5OMCChqLjRMdqsHD0TqN19P6kcaj47dK/b2TJiLPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p/ptBcHj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S9aeuaEK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 12 Feb 2026 17:28:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770913737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TRHZXcV2nDdeLMlTQ3urObUjcIUvRlNNfh8C7w6ZmWw=;
	b=p/ptBcHjrc9RG4J9Cw1PYdMMkkWrumGBX+6YmfQ79wXkjPLO57C9tf0kNJAr2L74Nps90j
	+29v+InfesxgTH/JdwOO1DfrnXxDlPFqDe1rP5CU+zmhJFst6UTOAly39MZNzXz1bokFSe
	G2AZQTtszcZzjt7kY9133l9UPd/9ArtFnyNtvnBMlXf06ouqWNq51AiUaPRkgx35Ni0Ue1
	bSPHQO0YOsa4857DIrL81tQuRQy8fZGnLr6zYn8gOhME/o2gV1JfhOaKjr11wHeyme/eIe
	+rFjSyg+iP1zpdpqJEuL1eJ7zIuVg4c2b0atL+jzpcOW4ZHzKNwNzqRyGLqeog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770913737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TRHZXcV2nDdeLMlTQ3urObUjcIUvRlNNfh8C7w6ZmWw=;
	b=S9aeuaEKL1lC/YpOEcGHrJEc3I6QnFlB8A10YpQbEE2IGu9V5lucP8wOVqVJaDfRN2orsm
	GHB/OXRda8IC53Dg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
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
Message-ID: <20260212162855.Dgc3fZ29@linutronix.de>
References: <willemdebruijn.kernel.bbdefedfb87e@gmail.com>
 <20260209090621.GiZqTiMJ@linutronix.de>
 <8e762437-69f9-40d7-bb75-3a45bef1d5d6@linux.dev>
 <20260209114836.GPU-vnnh@linutronix.de>
 <78e2af2c-40e6-43f1-9471-42f350e69389@linux.dev>
 <willemdebruijn.kernel.2e6213a98660b@gmail.com>
 <20260210121207.9kLHroS0@linutronix.de>
 <willemdebruijn.kernel.cceee43f5b9b@gmail.com>
 <87qzqr5vos.fsf@jax.kurt.home>
 <20260211105444.1e370abd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260211105444.1e370abd@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258471-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,gmail.com,linux.dev,google.com,redhat.com,davemloft.net,intel.com,molgen.mpg.de,vger.kernel.org,lunn.ch,lists.osuosl.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8CA412F72D
X-Rspamd-Action: no action

On 2026-02-11 10:54:44 [-0800], Jakub Kicinski wrote:
> Are you concerned about the latency of delivering the TS to the user
> space app / socket? Or purely reading the TS out of the HW fifo to make
> space for another packet to be timestamped?

The problem with the global workqueue is the latency. If the system is
idle it works as-is but if it gets busy the workqueue can be
significantly delayed. You can't give this workqueue a higher priority
because the workqueue is anonymous and changes.
The next best thing here is the aux_worker because everything here is
executed always under the same process/ PID so you can apply a priority
and ensure that is handled before other "less important" tasks.

However. There is actually no need for the workqueue so you could do it
directly (which is what some other driver do). But then I stumbled upon
the locking issue=E2=80=A6

Sebastian

