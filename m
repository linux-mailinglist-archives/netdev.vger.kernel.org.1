Return-Path: <netdev+bounces-298786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KyErLItlLGqsQQQAu9opvQ
	(envelope-from <netdev+bounces-298786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 22:01:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 417C667C3AB
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 22:01:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=H14Rv8QI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298786-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298786-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ACCE03012B17
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 20:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4030D3AE1B1;
	Fri, 12 Jun 2026 20:01:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467A43ADBAD;
	Fri, 12 Jun 2026 20:01:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781294472; cv=none; b=THfJTVxlExHVZwcBJ9oBHsJGV2qNb7uYpuHaPuXnyDxa8CXJo9ixAcuAN+H7eLJCNA31an7IAhJGq1k6oUNKWw9awV7ONO+LOCVJPDqCmXUIhkAx87nADrZcczlT+MffAY5HwsosPhqmwgemrmxaU08iFg6efcdmZ+/jHqVaF0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781294472; c=relaxed/simple;
	bh=agMd+urAvIyKRjQYU+TIhH8AHBmKyGvaoohLJsoxiyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ju2Nku0QOPONDfklUqGYSzaH7bwXRpqLeE/Ox/jSqx990BQc49o6bGflvb/2VqpoY1cMOPgP+/+ZtSyBd30uAoBR1n1G50MqIcYDT+wyCNQlrzgBKxXgXGgbQuuyfbf+HA5jsC4D0qerQL3l0jWaCft2xutDX9sUUvllO+9DtXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H14Rv8QI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76031F000E9;
	Fri, 12 Jun 2026 20:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781294469;
	bh=6cNLNgKkcl8y9XOjsHZbmwTHwlAMKwujnNeJuX5MyOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H14Rv8QIWLqMP5DKAKGLXtlhlq3IhYgWWJ6DqMIRiuBuURhTpCog/S9xltrF1bRv7
	 l4Kec9HrjhQHQpafmFP65nTJnZgD5g0fkkxmPgXvxLRp7Oon4CobbdefGMepHu/DWr
	 WuO/0iRij4UTgHdWeZhIeWh+Oi4T6+zINU8JzBc74X8nfSyNVPH34nS1ZNkHM7rPOA
	 gAAFEW14575TMb5lZWOXngy2vHBwGa1OSvR3OYGYY7w1Vq8JCobMte7yuCvOi9KzYg
	 EJOeDpKKT+scHphKNlQc8ZQs+xroSlIvgPAlvze0zsyNeP8i6SLw7HVfaWWbVPd78W
	 /DKIR6ILAjPuA==
Date: Fri, 12 Jun 2026 21:01:02 +0100
From: Simon Horman <horms@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, danishanwar@ti.com,
	rogerq@kernel.org, pmohan@couthit.com, afd@ti.com,
	basharath@couthit.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	pratheesh@ti.com, j-rameshbabu@ti.com, vigneshr@ti.com,
	praneeth@ti.com, srk@ti.com, rogerq@ti.com, m-malladi@ti.com,
	krishna@couthit.com, mohan@couthit.com
Subject: Re: [PATCH net-next 0/3] Introduce HSR/PRP HW offload support for
 PRU-ICSSM Ethernet driver
Message-ID: <20260612200102.GN671640@horms.kernel.org>
References: <20260611123636.376577-1-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611123636.376577-1-parvathi@couthit.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-298786-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_RECIPIENTS(0.00)[m:parvathi@couthit.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:danishanwar@ti.com,m:rogerq@kernel.org,m:pmohan@couthit.com,m:afd@ti.com,m:basharath@couthit.com,m:arnd@arndb.de,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:pratheesh@ti.com,m:j-rameshbabu@ti.com,m:vigneshr@ti.com,m:praneeth@ti.com,m:srk@ti.com,m:rogerq@ti.com,m:m-malladi@ti.com,m:krishna@couthit.com,m:mohan@couthit.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 417C667C3AB

On Thu, Jun 11, 2026 at 06:03:25PM +0530, Parvathi Pudi wrote:
> Hi,
> 
> This series introduces HSR and PRP protocol HW offload support for
> ICSSM-Prueth driver.  HW offload support for HSR/PRP is implemented using
> dedicated HSR/PRP firmware running on 2 PRU cores(PRU-ICSS) as a "DAN"
> available in AM57xx, AM437x and AM335x.

Hi Parvathi,

There is AI-generated review of this patch-set available on
https://sashiko.dev

I would appreciate it if you could look over that with a view
to addressing any issues that directly affect this patch-set.

