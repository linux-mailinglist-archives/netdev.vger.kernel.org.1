Return-Path: <netdev+bounces-290120-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CjZNJk0Dmqt8AUAu9opvQ
	(envelope-from <netdev+bounces-290120-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:24:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C8C59BF1C
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A22A930A70A4
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 21:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4229D37BE87;
	Wed, 20 May 2026 21:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMNuBev1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342D6371876;
	Wed, 20 May 2026 21:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313904; cv=none; b=dfCuAD+4+2AaeywVK2RpD3XY4NMo6RvPOWbdiKpQtn+CIE0wkwSU376JvZ+08WqSiOVHjPqRPXRu8jH+1hQoBHro5qNvYijgcJ/8ThNfaMaa1utS+lx+sx5Y36E1r0k+P8FIa7SB8SqZUf6DS1ldtv1JH0Ano+K34y/vZK0vyWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313904; c=relaxed/simple;
	bh=nS5BVihxpj6781lviI/v55QMa3QO4i0k204S89iHWFA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o5ZDkhoptFXtLBJNwSeBai33GLdjuZQaO5eM0alJ6lREu2I5EzlAc1zCnyCmD/DZOLeAX1UNOuFQYtEspvuajxSFlX44G2ME3vMEnqJv8h+FLQytBL4btd2On3iSrSrH9upWYRRVSKJTZkjLm1K91fqRbXSzT+L7zfUQnz21EZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMNuBev1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BE81F00A3E;
	Wed, 20 May 2026 21:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779313902;
	bh=uCF1tzGKoWOJC9uQJj0/iDUWAHPq0etDVJxvB1UpGlc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PMNuBev1F8s2PXR3FSwvPOx9oF8KaT2U9drxYu78OTP70kYjGlv6vrhVMsVfcG8sc
	 6e/sd6yzt20jrH2M3NW5QoLQlgrzz1aaPzWXJ8V1eFSf0bXhOuap1z5fetIM5CN7Kb
	 D6U/XDM+jPDVq1c9NTmm5f8n/zWqzEBcxyq3DDNlzFwv1GyRrtJwH+jcUtfig6ydNv
	 5mXsRjWcCyFCv5jtG+6+X5v4Nrp7qt1EU8Lkh0pygDjd2DthOjsVlu+HxmNWzpedth
	 7sIk5yGgpkuIveDn8GFSg1OfRNeVq4YK21wTG3X2vytPbv0HHok8I7CCGBD+O1in+3
	 ZHPu6SJ0kzBfQ==
Date: Wed, 20 May 2026 14:51:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Frank <Frank.Sae@motor-comm.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next v4 3/3] net: phy: motorcomm: Add YT8522 100M RMII PHY
 support
Message-ID: <20260520145141.26f2930a@kernel.org>
In-Reply-To: <20260520101310.128969-4-minda.chen@starfivetech.com>
References: <20260520101310.128969-1-minda.chen@starfivetech.com>
	<20260520101310.128969-4-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[motor-comm.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-290120-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D8C8C59BF1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 18:13:10 +0800 Minda Chen wrote:
> Add YT8522 100M RMII ethernet PHY base driver support, including
> PHY ID and base config init function.

drivers/net/phy/motorcomm.c:1871:6: error: call to undeclared function 'of_property_read_bool'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
 1871 |         if (of_property_read_bool(node, "motorcomm,auto-sleep-disabled")) {
      |             ^
../drivers/net/phy/motorcomm.c:1871:6: note: did you mean 'fwnode_property_read_bool'?
../include/linux/property.h:59:6: note: 'fwnode_property_read_bool' declared here
   59 | bool fwnode_property_read_bool(const struct fwnode_handle *fwnode,
      |      ^
1 error generated.

