Return-Path: <netdev+bounces-258362-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHMoAGP4jGk1wQAAu9opvQ
	(envelope-from <netdev+bounces-258362-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 22:45:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E243127DA7
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 22:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACA7D302353F
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 21:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AF6361662;
	Wed, 11 Feb 2026 21:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqy0CijP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C031FF1AE;
	Wed, 11 Feb 2026 21:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770846278; cv=none; b=F+z69aXGXEn3AHX109c9Lxe0xn8kK3UWZlxxfGVF03e/Q6lTxDZj4XlHIYQ76tF15fcf+mUAE78tsox8HX7aVmNbh7XiiUCtPNaV1K+iFKDBWAhjOiJNc/u0bs3ojAuMNRoB6FdTIfFAGXhxUSjm3AUKW/zb/CU3aVBOMTjsVsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770846278; c=relaxed/simple;
	bh=JMqKerywpg1i4AsO2BcZY243d6hFyXTrcC68qtQaPsc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/TsFwiUojvO3rn/c82uFHZkbrN/RK734Els16WI14SUEWrY70FfRe5IdXlBzYVzXiSgwlPw2Nav+JXzDIwCQjzoxIdDqXKeH+LeV45ny9jai2fwJ0QW+noDkWRWdS9Ot2i8DTHFIgN2XoYLdVCT4bn5uk1JlbvKXKvgfme+c0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqy0CijP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB18FC19421;
	Wed, 11 Feb 2026 21:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770846277;
	bh=JMqKerywpg1i4AsO2BcZY243d6hFyXTrcC68qtQaPsc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rqy0CijPHsw3y/Ope8+judGHByxaXC8M8eCsqUvyAwVaY8G8hcKL8i7lxABnmsgyW
	 rzP6NxnvrtFWXxnfPxrH4/rI1SV0cHbwI8mvyHIwcfGWp8jifwWU/1O6cnO1KaHe4a
	 WdoHCvXj+CK1aN9hiQUiQLgbcBNAPmzjkoT5Kv0rvAyOgyEpwuJQsZUSopsnlrXhWq
	 xTm9XL9IzVeieAgUwO6946WgaXTzcwSvghm1LcQXiOEWsUM9HtsdO5ggko5wzgSWGh
	 BkPIjH+vyRWSI4p9BeEwZyn/IdShqVw4aNO8ROUt71yyfwEInStAMYB5acYN1ixx39
	 wEBbCcn9FgA4A==
Date: Wed, 11 Feb 2026 13:44:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Kurt Kanzenbach <kurt@linutronix.de>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Willem de Bruijn <willemb@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, "Loktionov, Aleksandr"
 <aleksandr.loktionov@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>,
 "Gomes, Vinicius" <vinicius.gomes@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx
 timestamp directly from interrupt for i210
Message-ID: <20260211134436.1e623034@kernel.org>
In-Reply-To: <12520aac-c69a-41a0-9710-497392bc18f6@intel.com>
References: <20260205164341.pJvni8kA@linutronix.de>
	<76acd5cc-eb6f-4c56-a5e6-f6413736afbb@linux.dev>
	<willemdebruijn.kernel.459b2672b1e7@gmail.com>
	<601f0c4b-52d8-4b60-96bf-f2d65f8073d8@linux.dev>
	<willemdebruijn.kernel.bbdefedfb87e@gmail.com>
	<20260209090621.GiZqTiMJ@linutronix.de>
	<8e762437-69f9-40d7-bb75-3a45bef1d5d6@linux.dev>
	<20260209114836.GPU-vnnh@linutronix.de>
	<78e2af2c-40e6-43f1-9471-42f350e69389@linux.dev>
	<willemdebruijn.kernel.2e6213a98660b@gmail.com>
	<20260210121207.9kLHroS0@linutronix.de>
	<willemdebruijn.kernel.cceee43f5b9b@gmail.com>
	<87qzqr5vos.fsf@jax.kurt.home>
	<12520aac-c69a-41a0-9710-497392bc18f6@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258362-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,gmail.com,linux.dev,google.com,redhat.com,davemloft.net,intel.com,molgen.mpg.de,vger.kernel.org,lunn.ch,lists.osuosl.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E243127DA7
X-Rspamd-Action: no action

On Wed, 11 Feb 2026 11:29:03 -0800 Jacob Keller wrote:
> > Moving the timestamping in IRQ looked like a good solution, because the
> > device already signals that the Tx timestamp is available now. No need
> > to schedule any worker/work at all. So, it'd be very nice if
> > skb_tstamp_tx() could be called from IRQ context. BTW other drivers like
> > igc call this function in IRQ context as well.
> 
> Right. Reporting the timestamp from the interrupt is the simplest and 
> lowest latency method. I know Miroslav had some situations and devices 
> where it apparently caused more problems than it helped, though I don't 
> believe anyone else has reproduced those?

There's a BH workqueue now, as a replacement for tasklets.
Presumably smallest fix would be to switch to that?

