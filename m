Return-Path: <netdev+bounces-305972-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 95WQOw+pTmqHRgIAu9opvQ
	(envelope-from <netdev+bounces-305972-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 21:46:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8271B729F85
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 21:46:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305972-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305972-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 005B7301ABB4
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 19:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D50C3A1A5D;
	Wed,  8 Jul 2026 19:46:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ECDF4F1;
	Wed,  8 Jul 2026 19:46:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783539980; cv=none; b=CUCQh9V4ewNP+sLTFUo00HGnhO8fcH7BWDEFWs1KkdudghWvLqaCeli2IhsE3tae6UubzbWjnc17Cu95oCpiNJkypZe71H/ZCwkhF07IRaoDc2U64IYPj99/FNo4AstT3WyKzCEr2Bc0DGLjHSXLp9C90G2eHUgWtl3PEnrSbsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783539980; c=relaxed/simple;
	bh=KXzvMMXAalFxrhgHFbpXE+QWseDaqEypD1jOwd1J6/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vxn7aUO1MG6oiKx7RhnPXoJUBRgltIbzlaS82RFoskcbeh1RmZmXVB3cajkzcF3xdE6X2mYW4J3AZdggeHZYd3yjHWkEIL8qxqCFWa5p03p+SWQM7ChVk4K3EPq/5uTCzQWFZ8G6jPhFPIK5FHWnOis6voQyAGb2fNwYi0aSquM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1whYDe-000000000js-2aC0;
	Wed, 08 Jul 2026 19:46:07 +0000
Date: Wed, 8 Jul 2026 21:45:48 +0200
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 2/3] net: dsa: mxl862xx: add SMDIO clause-22
 register access
Message-ID: <ak6o7Ovekjb_evPs@makrotopia.org>
References: <ak0KJ6gUk2l_IwoI@makrotopia.org>
 <96c362d3-59d2-43c4-b2aa-c12dfeb6fcca@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96c362d3-59d2-43c4-b2aa-c12dfeb6fcca@lunn.ch>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305972-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,makrotopia.org:mid,makrotopia.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8271B729F85

On Wed, Jul 08, 2026 at 07:22:49PM +0200, Andrew Lunn wrote:
> On Tue, Jul 07, 2026 at 04:16:07PM +0200, Daniel Golle wrote:
> > Add mxl862xx_smdio_read() and mxl862xx_smdio_write() for clause-22
> > SMDIO register access. MCUboot rescue mode only exposes clause-22
> > registers; the existing clause-45 MMD interface is unavailable during
> > firmware transfer. The MDIO bus lock is held per-transaction (not
> > across polls) so that SB PDI polling during flash erase does not
> > starve other MDIO users.
> 
> What other MDIO users are there? It sounds like once the switch is in
> rescue mode, switch management is dead. So how can there be users?

The MDIO bus lock refers to the host bus which is used to connect
the switch management interface. The same bus can also be used to
connect other unrelated PHYs (eg. to provide a WAN or management
interface independent of the switch).
Especially because this "other" interface can be used to connect
to the host via SSH and perform the firmware update on the switch
holding the MDIO bus lock may impact PHY polling and impair the
link used to conduct the update.
At least that was my thought when implementing this.

