Return-Path: <netdev+bounces-292910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPXAGJnhGGogoggAu9opvQ
	(envelope-from <netdev+bounces-292910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 02:45:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FB65FBC04
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 02:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF5F93096B5E
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 00:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D846332EAC;
	Fri, 29 May 2026 00:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WY0zIYZY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCD934D901;
	Fri, 29 May 2026 00:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780015510; cv=none; b=eItfL8G54oS1K9qzZjtgYamkLtK6wOqRTIbaGjLU62p7XwjYfX6DBTIUGpmL5KDEPoXwq+Rx9wAWs5V+HebKu+/TTu7qRW9Hq+uVtXGAPE9AtRf+mnCiPCvBpWREKvRG/oqGQxUxIGe2c+aKKmokH4sWkXaM3JNJXLPd1x//Cr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780015510; c=relaxed/simple;
	bh=UQK7ypBdd3TPMYsKnQsYFN0ZoOGAMIEyD+YaDgM9u+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=un6t4jY39IlzjdO8hhfjgbuAo5+9BlBpcAL0AhC5Y8MzFhTEQENQxdJrgGy/ekSHPO4hNPKYfQdJKDojwEmogJVMDLIXPUdXMS8hd4d7nEymK+O1zP96JoxaxIem+3lfLzqy5B+wI78LtHVlnhmBCXTG0Vu+wLioOfjJMdNDcV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WY0zIYZY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EAC1F000E9;
	Fri, 29 May 2026 00:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780015508;
	bh=2U2ikK9fJnVGbpxitWIM7dNBE4Z8GlqpdN0MRGoCnFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WY0zIYZY8Bk3yvYqGPqji5bP8ImX9Rc6KFEtkEM0x26GYqmTbSKvaozFuldjo6ebN
	 lpWURLkkGm2rBShmeTF/GRvSSOrkE0UfUJLQ4Xbvv620E5VKD/lmi7AF0326JwFRg3
	 +x5sew3HRToFMAZ8wcRWNgIobpQghlaIN57ujfcYNJv5NrS9H7/x6UbyGylSHQeh+l
	 j3mvQwL9cfZBQlBQWh8tWvewojrtoX0WIjKkpiYUD5czyHNhI4fNqqlpbS28pXhuph
	 1zErequxfSw8bjIdEFPBWPhKNFy4FSOxKq4VOZCwBk4T7XKO9UMJA1HWsQ1X6x3wAE
	 Bzsd9ctThEMiQ==
Date: Thu, 28 May 2026 17:45:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: bobbyeshleman@gmail.com
Cc: alexanderduyck@fb.com, kernel-team@meta.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, hmohsin@meta.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bobbyeshleman@meta.com
Subject: Re: [PATCH net v2] eth: fbnic: move aui and fec from fbnic_net to
 fbnic_dev
Message-ID: <20260528174507.3ae6fa6b@kernel.org>
In-Reply-To: <20260529003714.317617-1-kuba@kernel.org>
References: <20260526-fbnic-aui-change-v2-1-7c74cd48074f@meta.com>
	<20260529003714.317617-1-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292910-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12]
X-Rspamd-Queue-Id: B4FB65FBC04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 17:37:14 -0700 Jakub Kicinski wrote:
> > @@ -15,18 +14,14 @@ static int
> >  fbnic_mdio_read_pmd(struct fbnic_dev *fbd, int addr, int regnum)
> >  {
> >  	u8 aui = FBNIC_AUI_UNKNOWN;
> > -	struct fbnic_net *fbn;
> >  	int ret = 0;
> >  
> >  	/* We don't need a second PMD, just one can handle both lanes */
> >  	if (addr)
> >  		return 0;
> >  
> > -	if (fbd->netdev) {
> > -		fbn = netdev_priv(fbd->netdev);
> > -		if (fbn->aui < FBNIC_AUI_UNKNOWN)
> > -			aui = fbn->aui;
> > -	}
> > +	if (fbd->aui < FBNIC_AUI_UNKNOWN)
> > +		aui = fbd->aui;  
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does moving aui and fec to
> struct fbnic_dev actually prevent a use-after-free here?
> 
> If fbnic_mdiobus_create() registers the MDIO bus using
> devm_mdiobus_register(), devres-managed resources are cleaned up after the
> driver's remove callback returns.
> 
> If fbnic_remove() frees the fbd structure, the bus remains fully active
> between the time the remove function finishes and the devres cleanup
> unregisters the MDIO bus.
> 
> Can a concurrent sysfs access invoke MDIO read callbacks which pass fbd
> to this function, leading to a dereference of the freed fbd pointer when
> reading fbd->aui?

Sorry for broadening the scope here a little bit but I think we should
fix this (as well). In the same series, but probably separate patch.
Just don't use devm_, it creates about as many bugs as it prevents.

