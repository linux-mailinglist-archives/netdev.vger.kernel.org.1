Return-Path: <netdev+bounces-260819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Eq0ItC9nmnYXAQAu9opvQ
	(envelope-from <netdev+bounces-260819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:16:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD321194C0A
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1437B302802D
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211D73806D8;
	Wed, 25 Feb 2026 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aIJ3NCHy"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F566327BF3;
	Wed, 25 Feb 2026 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772010950; cv=none; b=eINFTEofjWXfLoNiEgjmD/Rs0WL9yRiJrKBv1MGn/7O+9pcAspXs28opU93DYPY7DFCgyaZOj15rUoAH3hKfWLBFlY113LteCE0DmnVm0x6BxbfVkLIdmiPrtK61LnRFzdmbz0G2YDj3MYqKS3xqjV8gKeIwRfOy5f4fi43JusA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772010950; c=relaxed/simple;
	bh=MA1Ecp6qNdTIWIHqsRnR9gWXtW2IAe3WLoXNtA2gOU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXOCXlvyE1ttNMjVC56HvVmAARKJId+e0xXmZS+Kh54LMJrUiinraUh70ap+3xlYmlt4NlENgfUUYpz+w8HtnJZMI71HPcDOmuUMJI0kL8Xkc3v0J0JlkYCiavQSMaF5aff6g2Bi1Dzb0wkUDiSHylT5yO5tZJteqmnNdmjb/b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=aIJ3NCHy; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UbuiIKVkAPOuDTirizvhEGsPkRAbXAkPZHZsKwKoZLU=; b=aIJ3NCHygeUg6MZOKP/iBOl7iu
	9i+Ci3ElTX+LeXN9sY95/h++iBi44uhy8vn2rNRKK5OPO77MN9UdeICypHQXIzf37vJ7L8IYGLodd
	sXfh0dh0tPDIftToHXZQWnmlt76aoZkTQ4ulcpdmdPGnj6Z5L/JSl/cWYtV8pllSUFE1XVwpt+seN
	nr2/0Td0+yYsFDfjc3u4k/ArlLHSB750YCe1+ZDAP3g190IVocEPVAYBtHsOverwG6woLFTL41V3a
	hAIU6WfJX4CdnRx7DIekdzF1w9MHdH/CtR2vBMVN1idMMcugjwGDxiAsW6TbXLDUFfhU7s+Gho1OF
	MssfE1bA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33474)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vvAza-000000006Iw-1lB8;
	Wed, 25 Feb 2026 09:15:38 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vvAzY-000000000pS-2juC;
	Wed, 25 Feb 2026 09:15:36 +0000
Date: Wed, 25 Feb 2026 09:15:36 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/7] net: sparx5: clean up probe/remove init and
 deinit paths
Message-ID: <aZ69uEQHdhASe5dj@shell.armlinux.org.uk>
References: <20260225-sparx5-init-deinit-v1-0-97036580b9f0@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260225-sparx5-init-deinit-v1-0-97036580b9f0@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260819-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,gmail.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.696];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shell.armlinux.org.uk:mid,microchip.com:email,armlinux.org.uk:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD321194C0A
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 10:05:23AM +0100, Daniel Machon wrote:
> This series refactors the sparx5 init and deinit code out of
> sparx5_start() and into probe(), adding proper per-subsystem cleanup
> labels and deinit functions.
> 
> Currently, the sparx5 driver initializes most subsystems inside
> sparx5_start(), which is called from probe(). This includes registering
> netdevs, starting worker threads for stats and MAC table polling,
> requesting PTP IRQs, and initializing VCAP. The function has grown to
> handle many unrelated subsystems, and has no granular error handling —
> it either succeeds entirely or returns an error, leaving cleanup to a
> single catch-all label in probe().
> 
> The remove() path has a similar problem: teardown is not structured as
> the reverse of initialization, and several subsystems lack proper deinit
> functions. For example, the stats workqueue has no corresponding
> cleanup, and the mact workqueue is destroyed without first cancelling
> its delayed work.
> 
> Refactor this by moving each init function out of sparx5_start() and
> into probe(), with a corresponding goto-based cleanup label. Add deinit
> functions for subsystems that allocate resources, to properly cancel
> work and destroy workqueues. Ensure that cleanup order in both error
> paths and remove() follows the reverse of initialization order. What
> remains in sparx5_start() is only hardware register setup and FDMA/XTR
> initialization that does not require cleanup.
> 
> Before this series, most init functions live inside sparx5_start() with
> no individual cleanup:
> 
>   probe():
>     sparx5_start():              <- no granular error handling
>       sparx5_mact_init()
>       sparx_stats_init()           <- starts worker, no cleanup
>       mact_queue setup             <- no cancel on teardown
>       sparx5_register_netdevs()
>       sparx5_register_notifier_blocks()
>       sparx5_vcap_init()
>     sparx5_ptp_init()
> 
>     probe() error path:
>       cleanup_ports:
>         sparx5_cleanup_ports()
>         destroy_workqueue(mact_queue)
> 
> After this series, probe() initializes subsystems in order with
> matching cleanup labels, and remove() tears down in reverse:
> 
> probe():
>     sparx5_ptp_init()
>     sparx5_vcap_init()
>     sparx5_mact_init()
>     sparx5_stats_init()
>     sparx5_register_netdevs()
>     sparx5_register_notifier_blocks()
>     sparx5_start()
> 
>   remove():
>     sparx5_unregister_notifier_blocks()
>     sparx5_unregister_netdevs()
>     sparx5_stats_deinit()
>     sparx5_mact_deinit()
>     sparx5_vcap_deinit()
>     sparx5_ptp_deinit()
>     sparx5_destroy_netdevs()
> 
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

Note that there is the general principle that drivers should not
"publish" themselves (aka register their netdevs and/or ptp) until
they have initialised enough so the facility that has been published
is functional.

That, in general, means that there should be very little initialisation
after the calls to register the netdevs and ptp.

It's fine if something gets published and then a later publication of
another interface fails, causing the first publication to be withdrawn,
that is pretty much unavoidable, but in such scenarios, one would want
to do as much of the initialisation that may fail before any
publication of any user interfaces.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

