Return-Path: <netdev+bounces-252819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHJfBGdbc2l3vAAAu9opvQ
	(envelope-from <netdev+bounces-252819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:28:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F60274FCB
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16C1E301A70E
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5967D30F959;
	Fri, 23 Jan 2026 11:28:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A53630E0F8
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769167708; cv=none; b=VqZtoR1G3VH7SF7XGJ8yvOEWOXMnWLVnZpR22TKgb9EF0wC6Xt/JRSTqj7Unusoz9Bm28EVKQBJngICJX1JASRk6ATTDkGs6e8XVTNzVct3GMYYRIxPgM7vWbEb/NZM+o/g7DRjnKO8lj4mAIR78Fr8vy1R0AweULxI4jX2RriI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769167708; c=relaxed/simple;
	bh=FTfzdvpE37StflINhMfOPnWam4Xp+bqcOqussm0o85E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sza0kDMwxqRf7UXLnFQ+Y7CsM+N+QbcNo2YdZzAN14jvbU6vzMW2Kp3hz1FNunlsF0oS78ZtSnYxftOSKT82cf4hqXMI7Kzc3R1qlreBF0l00EHXialJYO3GIAEmcKv8zhBHqqjIXcC3nNLDvWzuOZ/kiA3b0dUzgYnGroL65lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vjFKr-0007fq-Es; Fri, 23 Jan 2026 12:28:17 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vjFKo-0025BR-2X;
	Fri, 23 Jan 2026 12:28:14 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vjFKn-00Auhu-3A;
	Fri, 23 Jan 2026 12:28:13 +0100
Date: Fri, 23 Jan 2026 12:28:13 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, alok.a.tiwari@oracle.com,
	andrew+netdev@lunn.ch, andrew@lunn.ch, chuck.lever@oracle.com,
	davem@davemloft.net, donald.hunter@gmail.com, edumazet@google.com,
	gal@nvidia.com, horms@kernel.org, idosch@nvidia.com,
	jacob.e.keller@intel.com, kernel-team@meta.com,
	kory.maincent@bootlin.com, kuba@kernel.org, lee@trager.us,
	pabeni@redhat.com, vadim.fedorenko@linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH net-next 0/3] net: ethtool: Track TX pause storm
Message-ID: <aXNbTVF5KNz1yV-1@pengutronix.de>
References: <20260122192158.428882-1-mohsin.bashr@gmail.com>
 <aXNAjOjkCqOESf5y@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXNAjOjkCqOESf5y@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-252819-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,fb.com,oracle.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,redhat.com,linux.dev,pengutronix.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F60274FCB
X-Rspamd-Action: no action

Here is a TL;DR summary of my questions regarding the pause storm logic
:)

- Does the 500ms hardware timer reset on "flapping" pause signals? If so,
  a stuttering storm might still crash the link partner (tx watchdog
  timeout).

- The auto-recovery (service task) enforces a fixed policy. Can we make
  this configurable? I used devlink health (.recover) to let userspace
  decide between auto-reset or manual intervention.

- Should we standardize an "RX Watchdog" mechanism in the core instead of
  or in addition to driver-specific stats?

- If main case where we will run in to tx pause storm is OS crash, what
  instance will be able to read this stats? Are they preserved on reboot
  or kexec?

On Fri, Jan 23, 2026 at 10:34:04AM +0100, Oleksij Rempel wrote:
> Hi Mohsin, hi Jakub!
> 
> On Thu, Jan 22, 2026 at 11:21:55AM -0800, Mohsin Bashir wrote:
> > With TX pause enabled, if a device cannot deliver received frames to
> > the stack (e.g., during a system hang), it may generate excessive pause
> > frames causing a pause storm. This series updates the uAPI to track TX
> > pause storm events as part of the pause stats (p1), adds pause storm
> > protection support for fbnic (p2), and leverages p1 to provide
> > observability into these events for fbnic (p3).
> > 
> > Mohsin Bashir (3):
> >   net: ethtool: Track pause storm events
> >   eth: fbnic: Add protection against pause storm
> >   eth: fbnic: Fetch TX pause storm stats
> > 
>  
> Very interesting series! Before the Christmas break, I started looking into a
> similar issue on different hardware (LAN78xx USB Ethernet), which has counters
> but no automatic pause storm mitigation in silicon. For reference, here is the
> RFC patch set I'm working on:
> https://lore.kernel.org/all/20260123090741.1566469-1-o.rempel@pengutronix.de/
> 
> In my implementation, I added the detection logic to the driver but exposed it
> via the devlink health interface.
> 
> I have a few questions regarding the definitions and the architectural approach
> here.
> 
> -  Definition of "Pause Storm"
> 
> It seems fbnic defines a storm as a continuous assertion of the pause signal
> (duration-based). The code defines FBNIC_RXB_PAUSE_STORM_UNIT_WR with a 10us
> granularity and a 500ms threshold.
> 
> Does this hardware detector handle "flapping" (high rate of distinct pause
> frames) or is it strictly for a stuck-high condition (deadlock/hang)? If the RX
> queue drains slightly and fills up again every 100ms, does the internal timer
> reset? If so, a "stuttering" storm might bypass this protection. Except the
> primary goal of this feature is to prevent the link partner's TX watchdog from
> firing (saving the neighbor from a reset).
> 
> - Policy and Tunability
> 
> The current implementation enforces an auto-recovery policy that is invisible
> to userspace. By resetting the storm protection in fbnic_service_task (runs
> every 1s), you effectively enforce a ~50% duty cycle on a hung system.
> 
> Since this logic decides when to stop flow control and start dropping packets,
> shouldn't these thresholds be configurable?
> 
> I understand that in a complete OS crash, software cannot intervene, and we
> rely entirely on the hardware's 500ms safety breaker. However, for partial
> stalls (livelocks, soft lockups) where the service task might still run, the
> hardcoded "force normal" policy might not be ideal.
> 
> Furthermore, having the ability to disable auto-recovery is critical for
> testing. If we want to develop/validate a driver for the link partner that
> detects incoming pause storms, we need a way to generate a sustained storm from
> this device without the safety breaker constantly resetting it. A "controllable
> reference" is very valuable here.
> 
> In my LAN78xx work, I used the devlink reporter's .recover callback. This lets
> userspace control the policy (devlink health set ... recover
> true/false) - determining whether the driver should auto-reset the MAC/PHY or
> wait for manual intervention. Baking the "force normal" logic into the service
> task removes this control.
> 
> Architecture:
> 
> This feels very similar to the existing ndo_tx_timeout watchdog, but for the RX
> side. We are essentially trying to handle an "RX Timeout" or "RX Stall" where
> the device cannot push packets to the host.
> 
> I assume the 500ms hardware threshold is specifically chosen to be well below
> the standard 5-second ndo_tx_timeout of link partners, preventing a hung node
> from causing watchdog resets on its neighbors. I've observed cases where
> triggering a full ndo_tx_timeout reset on a stalled device leaves the hardware
> in a partially reconfigured "zombie" state, unable to receive anything
> thereafter. 
> 
> Did you consider if we should approach this as a central networking mechanism
> (an "RX Watchdog")?  I am debating this for my own driver:
> 
> - Option A: Export needed metrics/events to userspace (Devlink/Ethtool) and let
>   a userspace agent decide when to reset.
> 
> - Option B: Handle it entirely in the kernel (like this patch), but potentially
>   standardize the "RX Stall" behavior so we don't end up with different
>   heuristics in every driver.
> 
> Best Regards,
> Oleksij
> -- 
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

