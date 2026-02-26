Return-Path: <netdev+bounces-261567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOAGJ2qpoGlGlgQAu9opvQ
	(envelope-from <netdev+bounces-261567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:13:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E89231AEEE6
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 21:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D95B13019FF4
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF08D426EC1;
	Thu, 26 Feb 2026 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dqjLefHA"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F99542B736;
	Thu, 26 Feb 2026 20:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772136806; cv=none; b=BeKafSaGFMXnTMdaVBNaUh+8SRm04YdM6GzWhQVfdeiF37eGlPkR1ouGwmbVAAeg0zvcnPXzmMJbkZDSAsnohM1MK5g66hbqYZEXna6DgYetVxoRPj58NW+aZM1KtYh7W9vi/3VkgtP0Z/E1xuya17qCF5d+hBLdIYO0YXYFNxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772136806; c=relaxed/simple;
	bh=f+FH5u6NePnJWpkXpdMf0rFuk3vM+W+gFD63G5LmYC0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HypIBQ5zsAS2jnBifT7FkMsYJ0NYk9pPzyPAyoadbY9Htrr8nBNQ+s5ILFE+TNX7Vg6ylnYTJ2hVWtSrEY89aB/tDMM6yn7s9SZiBY/yiSfzdko8GDPVhPHboQL01YBPV8UfRnHy5VJLrzSqcenk+589w3okJlvWJNrkR5df+Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dqjLefHA; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772136805; x=1803672805;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=f+FH5u6NePnJWpkXpdMf0rFuk3vM+W+gFD63G5LmYC0=;
  b=dqjLefHA0oOMQ1BfEcaMoXi6iPyWIAYmqFUnaWZeheQYBy6KDI1vCXmi
   kWWeU2WtSCfsqlgI9ms5AiZJoISM8q3ATrqGZSFplMsiu17xO1YdCcLlH
   EAx4/blR+fj+J8QxVz6dBLnNeV0L4lP27SQTjC5ce3iWn0a+FZHn0H5eB
   T8e8JIJNz82wUYlPp88nAy7HgwpPEyl2cacefIg3OaOXSceypklhM+ZLj
   yDzO237GjyGphFyh+hTJf0v7dIkM5zTkDPYxXcMYQlrPPxnYihLDA4BLg
   xQ2bApGovNCDEGZ2pTYSNP+5++PCSoxAtCnNHvdtJ+tTRWitwXy5KXvmV
   g==;
X-CSE-ConnectionGUID: /3wlzlSWTeqatQ0/5yW24Q==
X-CSE-MsgGUID: u1+A7DOrQWul7wPPEnGxgA==
X-IronPort-AV: E=Sophos;i="6.21,312,1763449200"; 
   d="scan'208";a="54359471"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Feb 2026 13:13:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 26 Feb 2026 13:12:37 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 26 Feb 2026 13:12:35 -0700
Date: Thu, 26 Feb 2026 21:12:35 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Richard
 Cochran" <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 0/7] net: sparx5: clean up probe/remove init and
 deinit paths
Message-ID: <20260226201235.vbnnp3skx3tv3obb@DEN-DL-M70577.microsemi.net>
References: <20260225-sparx5-init-deinit-v1-0-97036580b9f0@microchip.com>
 <aZ69uEQHdhASe5dj@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZ69uEQHdhASe5dj@shell.armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261567-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,gmail.com,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-0.982];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:email,microchip.com:dkim,armlinux.org.uk:url,DEN-DL-M70577.microsemi.net:mid]
X-Rspamd-Queue-Id: E89231AEEE6
X-Rspamd-Action: no action

Hi Russell,

> > This series refactors the sparx5 init and deinit code out of
> > sparx5_start() and into probe(), adding proper per-subsystem cleanup
> > labels and deinit functions.
> >
> > Currently, the sparx5 driver initializes most subsystems inside
> > sparx5_start(), which is called from probe(). This includes registering
> > netdevs, starting worker threads for stats and MAC table polling,
> > requesting PTP IRQs, and initializing VCAP. The function has grown to
> > handle many unrelated subsystems, and has no granular error handling —
> > it either succeeds entirely or returns an error, leaving cleanup to a
> > single catch-all label in probe().
> >
> > The remove() path has a similar problem: teardown is not structured as
> > the reverse of initialization, and several subsystems lack proper deinit
> > functions. For example, the stats workqueue has no corresponding
> > cleanup, and the mact workqueue is destroyed without first cancelling
> > its delayed work.
> >
> > Refactor this by moving each init function out of sparx5_start() and
> > into probe(), with a corresponding goto-based cleanup label. Add deinit
> > functions for subsystems that allocate resources, to properly cancel
> > work and destroy workqueues. Ensure that cleanup order in both error
> > paths and remove() follows the reverse of initialization order. What
> > remains in sparx5_start() is only hardware register setup and FDMA/XTR
> > initialization that does not require cleanup.
> >
> > Before this series, most init functions live inside sparx5_start() with
> > no individual cleanup:
> >
> >   probe():
> >     sparx5_start():              <- no granular error handling
> >       sparx5_mact_init()
> >       sparx_stats_init()           <- starts worker, no cleanup
> >       mact_queue setup             <- no cancel on teardown
> >       sparx5_register_netdevs()
> >       sparx5_register_notifier_blocks()
> >       sparx5_vcap_init()
> >     sparx5_ptp_init()
> >
> >     probe() error path:
> >       cleanup_ports:
> >         sparx5_cleanup_ports()
> >         destroy_workqueue(mact_queue)
> >
> > After this series, probe() initializes subsystems in order with
> > matching cleanup labels, and remove() tears down in reverse:
> >
> > probe():
> >     sparx5_ptp_init()
> >     sparx5_vcap_init()
> >     sparx5_mact_init()
> >     sparx5_stats_init()
> >     sparx5_register_netdevs()
> >     sparx5_register_notifier_blocks()
> >     sparx5_start()
> >
> >   remove():
> >     sparx5_unregister_notifier_blocks()
> >     sparx5_unregister_netdevs()
> >     sparx5_stats_deinit()
> >     sparx5_mact_deinit()
> >     sparx5_vcap_deinit()
> >     sparx5_ptp_deinit()
> >     sparx5_destroy_netdevs()
> >
> > Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> 
> Note that there is the general principle that drivers should not
> "publish" themselves (aka register their netdevs and/or ptp) until
> they have initialised enough so the facility that has been published
> is functional.
> 
> That, in general, means that there should be very little initialisation
> after the calls to register the netdevs and ptp.
> 
> It's fine if something gets published and then a later publication of
> another interface fails, causing the first publication to be withdrawn,
> that is pretty much unavoidable, but in such scenarios, one would want
> to do as much of the initialisation that may fail before any
> publication of any user interfaces.
> 
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


Thanks for pointing this out.

Before this series, quite a bit of initialization was already done after
publication. But as a consequence of moving netdev registration out of
sparx5_start() (patch #2), some initialization that previously happened before
publication now happens after — which is the wrong direction.

I will do some reordering to fix this in v2.

Thanks!

