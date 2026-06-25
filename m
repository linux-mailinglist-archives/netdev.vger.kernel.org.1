Return-Path: <netdev+bounces-301979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SOP7Fbc6PWp6zggAu9opvQ
	(envelope-from <netdev+bounces-301979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:27:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C6B6C69F9
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:27:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=NQxE8IWq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301979-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301979-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB5EB3070D18
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 14:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F090361668;
	Thu, 25 Jun 2026 14:20:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1657A34CFC7;
	Thu, 25 Jun 2026 14:20:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397220; cv=none; b=WmQqMcBM/4amAAfzgn4+E0TR4S3PF8WnEvJOrBkuFfI4njyOvS+3VW044B5IzzOwAJU1jpXFg/dZPL7J1dIrCJULJ/oVflcsmvo08lOKXlzHTkYIx7xZwEYiQajKMaI1OFLlfVdGsiJKqRShNBq8JvtFoeGSQUg26vzcuAmUvsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397220; c=relaxed/simple;
	bh=NYpgmTNR4/xM3D2xd7xhRv2xvwRB2xQPrSf7HWK0gVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVbbzuMsWBKaVdg0sge9Aawuk5sqLW80CmLKEvS54tBhuDsAKmBFI4ek3z2m85ysS1dunJQJkuApVl6xcFzgGQNJ13JCdcXTK8EyPaecEPOeEfFfrATNLMEswSzhg/gBvzAEfwBOxJKnmvrOTvjObCVOBjs4ZphdF0t+m+KFRrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NQxE8IWq; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lvGPRbXKE/BaYDQ9KX91PEUDNglqp7DnjlN7P3BPN2g=; b=NQxE8IWqFuTtjXZxjBCYSYKE4Z
	LctK1N10bxrphUpmFxye21882PQofNcmD7T0JlPHSGsfo2mzg9cKsQ+5Cx73D9ZaP+j1YQ1oYX5WF
	yKJxlSIHShXNllBta7N5adQJEOU1u/fKNujzZsps+Nkl08Xjcn6xq/wmzsKDTN9Vvfv8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wckw5-009FWE-PM; Thu, 25 Jun 2026 16:20:09 +0200
Date: Thu, 25 Jun 2026 16:20:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
	richardcochran@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v1 1/1] ocp: Add I2C control support for Adva TimeCard
Message-ID: <e44ea342-67cb-4809-9ca2-9e551e433a8a@lunn.ch>
References: <20260625133802.11741-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625133802.11741-1-maimon.sagi@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301979-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:maimon.sagi@gmail.com,m:jonathan.lemon@gmail.com,m:vadim.fedorenko@linux.dev,m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:maimonsagi@gmail.com,m:jonathanlemon@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 97C6B6C69F9

On Thu, Jun 25, 2026 at 04:38:02PM +0300, Sagi Maimon wrote:
> - Load i2c-dev module to expose /dev/i2c-N character devices
> - Add sysfs-based I2C bus control for Adva TimeCard model

A list like this suggests the patch should actually be two patches.
Also, the commit message should answer the question "Why?". I can see
what you have done by reading the patch. But Why have you done it?

> +	request_module("i2c-dev");

linux/drivers$ grep -r i2c-dev | grep request
grep: i2c/i2c-dev.o: binary file matches

No other drive does this. Why is this driver special?

    Andrew

---
pw-bot: cr

