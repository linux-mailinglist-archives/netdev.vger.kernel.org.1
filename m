Return-Path: <netdev+bounces-262396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SP/cCJA7pGlnawUAu9opvQ
	(envelope-from <netdev+bounces-262396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 14:13:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7397F1CFCFD
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 14:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA41F300D45C
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 13:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CFF32548C;
	Sun,  1 Mar 2026 13:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="l7AFNGy4";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Id1qQbJP"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAE031DD97
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772370829; cv=none; b=HxqSJ78EC+FFNiKJ4/VM6mU5vPtoA1X4WG/K5HWi7bRww9KXD40mkOG01EoSTDuj+laIfjPoGKCZ7dHV/ZQ6iqtASWJUOGPrNkY634W4PZfLxy/79Xa5aO0aSokHlzyBuXfufPfxveaiaEBXEngwY5Rr3c+HygrY9TsALAoRYj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772370829; c=relaxed/simple;
	bh=onrirJo6ydCcYll7DRFQH980eTfE0dFqfteq+y/Q7Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqpTirs9NJAM/dlpclW+LPPv0JQlwXDMmcIMZxbZ2yxNCi4eGKvhP+vmBY6InVdqWJPmQ4G3W/IP7tkmvXwFFBbHISJYmazEZO1tGCPH2sgGFr7HrW08CJEejL5cjaA/SxKLFDpbvKaeNMnHylapPvEdAIUrOi625ibXqsrhGDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=l7AFNGy4; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Id1qQbJP; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
DKIM-Signature: a=rsa-sha256; b=l7AFNGy4IEwW2WASA8umQzD/AlXwX3SIi/6TyLTXSarUsQnOWFipKhfRmVzPEuaDcPgYMo7IeY9sH31uuQlb+GXgt+d1mZhRpFbG1LMdBOZCaif3VfN2dB0U1RRj4TdTaG0v1Gh5umNkZ/x9DQ1OdoTL/yGS6P6wtO2m2UisYXZDRXUV3enOEINBPzaRxEEwpcfjiKiM4429vCGO0fZWbo+taJPlAuRjJn1tvkBXKRzZozwZ21LrZct9/ScG7HewxxDjfXCLnTYAe7mdpDfQa9PEYK7uQUxZb2c2xfemvOvLaN8UeYpslkQAgVGrL6x3dY1Zn0x+m4kc1laM65qtVg==; s=purelymail3; d=tinyisr.com; v=1; bh=onrirJo6ydCcYll7DRFQH980eTfE0dFqfteq+y/Q7Ns=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=Id1qQbJPHXTlOtEWJ+dn8S1Zy28x+59rtr2toB26nOoRPJoN90v3oTnRf3WwvLqokULlZ98D3Q6jTgMjLFCW2E9FBkDut2c/kgQL9f292SwsL2uyKdDxZlWeB3eVO/2WYAEKpv+57iS4dCs+99Q17seek2U/5CTzLchdqmJkfAt1d9Y/DqesfhdCheJq5ok3tij1qTXGPNL0qSrI6iBE/ytWGpooeGOVsaxdFYRsXMRkY6TUeWuMI876o8355NL6SQzRc/Fcxsw33jgo4LD2J9jD3Ow2xDAjf1MbFww+97aS3kwRlEjbLLTzfw+doFXI/m1mBILz1Vl5iV0yfY8F/Q==; s=purelymail3; d=purelymail.com; v=1; bh=onrirJo6ydCcYll7DRFQH980eTfE0dFqfteq+y/Q7Ns=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1817600932;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 01 Mar 2026 13:13:34 +0000 (UTC)
Date: Sun, 1 Mar 2026 15:13:28 +0200
From: Joris =?utf-8?B?VmFpxaF2aWxh?= <joey@tinyisr.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [RFC 0/2 net-next] net: dsa: MT7628 embedded switch initial
 support
Message-ID: <aaQ15ZLlZRvlqZ3H@archlinux>
References: <20260228185242.800836-1-joey@tinyisr.com>
 <20260228234031.bimzpo4mmu6t5rty@skbuf>
 <aaQqdwNsuwzRb7Xu@makrotopia.org>
 <20260301123619.skschp4ioxnevh3u@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260301123619.skschp4ioxnevh3u@skbuf>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tinyisr.com,reject];
	R_DKIM_ALLOW(-0.20)[tinyisr.com:s=purelymail3,purelymail.com:s=purelymail3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262396-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tinyisr.com:+,purelymail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,purelymail.com:dkim]
X-Rspamd-Queue-Id: 7397F1CFCFD
X-Rspamd-Action: no action

Hi Vladimir,
Thank you for the feedback.

On Sun, Mar 01, 2026 at 02:36:19PM +0200, Vladimir Oltean wrote:
> I see a slight discrepancy between what the documentation claims the
> hardware does, and what the driver claims it does. The documentation
> seems to say that setting this bit is what allows the vlan->untag bits
> to take effect.

The comment was referencing an accidentally deleted line that enables
double tagging:

	/* set up switch for double tagging to simulate vlan unawareness */
	regmap_set_bits(esw->regmap, MT7628_ESW_REG_SGC2,
			FIELD_PREP(MT7628_ESW_SGC2_DOUBLE_TAG_EN,
			MT7628_ESW_PORTS_NOCPU));

I only re-tested untagged traffic before sending this in. Apologies for
that. I will expand my testing procedures to prevent this from happening
again.

> A VLAN-unaware port means that when an ingress packet comes with 802.1Q
> TPID 0x8100 and VID X from the wire, this VLAN header will be ignored by
> the switch, and the PVID of the port will be pushed as an outer tag, for
> any value of X, regardless of whether it is in the VLAN table or not.
> Does it do that?

That is what is intended to happen and it does do that if the
DOUBLE_TAG_EN is properly set. Will be fixed in later revisions.

