Return-Path: <netdev+bounces-294324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OTMvGnscH2pJgQAAu9opvQ
	(envelope-from <netdev+bounces-294324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:10:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 752A5630F40
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:10:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ft9AM4eA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294324-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294324-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 640233008CB3
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 18:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4A7320A00;
	Tue,  2 Jun 2026 18:05:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C463231AABC
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 18:05:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780423540; cv=none; b=I0A/lwQOSJ3pQFiGNKuUUgBhbEvqAJwJR1Gd5t/p0JndIxr4FxEZaVWqo3lweVRYpUGnwvs7qA4fhRDkH09SNSmbyH+nA+Fl88y51hwxrSViHpCRYo5U2deW3FmLgoeNIiYW66upVkXSgtFUSil9A3wX1ApTXJSPJHprfG0Dn6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780423540; c=relaxed/simple;
	bh=QrEsNEXSo8bFBbuWK2mPP2576yKP2pf3SFnifh9eXNU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8TfjRJc1HonxpNhXXZc3LCiImMeJxv+45JvFGQh3Ni181LUlnqK2RnZbfbunFD6M4+FNLXB5X4ChMrVF+fd0bI/XaWUpIqHH2VZDtoPTJv53fjqumc3qlir9EYwTuWFlSgU8K3fRJrmPHVm+a9OvvaINvzNE0ULuVWBfqVNYJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ft9AM4eA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5721F00893;
	Tue,  2 Jun 2026 18:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780423537;
	bh=1PEZXVozQH3pkzotyCNi4STpYciHokvYRwneVJu8II8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ft9AM4eA5MIER+LCOdN+x0oLPzacSfAs0zPUQiPOyR0GCWsGEutYYvaJZPAT0l5gI
	 JP8rLMpybmrQncfx5hZN4aKAcOXYmF2DOy8f3shhEn+sB+N0tmNScjyfNOMRxq/ZkK
	 fHFJCmhwmPd5J5mhyMQ1Fz0jttzUI0Z4IRIYetQxblVXLfvpg1D0sjrLPi9st2c9SB
	 3FhrOgxfgU9tpaijQnWn87SezDV5C4pIK2H8wtXZaUYla5OdUlnsiQKFg0UeSwp9js
	 b9um3aito8dGjd5NpuY6KA9fsIofO9RaGQl5qQx9fLnkbuQqKES69WE8eGViFFk1c3
	 1CUmrAqeMYXgA==
Date: Tue, 2 Jun 2026 11:05:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
 daniel@makrotopia.org, mensi@mensi.ch
Subject: Re: [PATCH net-next 1/8] net: mdio: realtek-rtl9300: Convert to
 fwnode API
Message-ID: <20260602110535.13ed4664@kernel.org>
In-Reply-To: <20260602052640.93083-2-markus.stockhausen@gmx.de>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de>
	<20260602052640.93083-2-markus.stockhausen@gmx.de>
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	TAGGED_FROM(0.00)[bounces-294324-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmx.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:markus.stockhausen@gmx.de,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:mensi@mensi.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 752A5630F40

On Tue,  2 Jun 2026 07:26:33 +0200 Markus Stockhausen wrote:
> -		struct device_node *phy_dn __free(device_node) =
> -			of_parse_phandle(to_of_node(port), "phy-handle", 0);
> +		struct fwnode_handle *phy_fwnode __free(fwnode_handle) =
> +			fwnode_find_reference(port, "phy-handle", 0);
>  		/* skip ports without phys */
> -		if (!phy_dn)
> +		if (IS_ERR(phy_fwnode))
>  			continue;
>  
> -		mdio_dn = phy_dn->parent;
> +		struct fwnode_handle *bus_fwnode __free(fwnode_handle) =
> +			fwnode_get_parent(phy_fwnode);
> +		if (!bus_fwnode)
> +			continue;

Variable declarations mid functions are a no-go for netdev.

If you could please move away from using the __free() crap I'd
appreciate. Clearly missed it yesterday when applying these patches

Quoting documentation:

  Using device-managed and cleanup.h constructs
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  Low level cleanup constructs (such as ``__free()``) can be used when building
  APIs and helpers, especially scoped iterators. However, direct use of
  ``__free()`` within networking core and drivers is discouraged.
  Similar guidance applies to declaring variables mid-function.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

