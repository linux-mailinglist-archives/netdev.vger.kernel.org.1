Return-Path: <netdev+bounces-252974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHZnEMHnc2nhzQAAu9opvQ
	(envelope-from <netdev+bounces-252974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 22:27:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3057AE5D
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 22:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 398D63006101
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 21:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7F1246778;
	Fri, 23 Jan 2026 21:27:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D9C1E487
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 21:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769203645; cv=none; b=ePcuf6lkPT1GqWp8+81AO86VCYn3koHMwzgIZLKF7i4rVB80OiZEEQyeh7NQrGuztbmWBDON4Nxxi0tdrnHCGDpZOAWWRGwbhpktjukw0Q2QNmnjvnMXd2N8sEfooFXJyMuACNH5q9OfcnYjj30jZDHy0yAR9zybYrBR5ugxvRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769203645; c=relaxed/simple;
	bh=6EfQPL4EHcqyjtbufDjUzm0oqyoxP1Ski6ZimmGZhng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCC42SyGUlVatiRVu9WXYfrMKitevCWZyi05r8BKXEpT6XQLzCSMxXtpKR5PpKJylMF+UCTuAJkD0srayC77GABGO7j5gVy7upMGVXlh+LHEopVjMm0otGV7+HqSwhuen4paExs2lpCeCZgq3rfUkpSCiHzsYJGKQlbG4f/5mZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vjOgb-0007Wc-Vo; Fri, 23 Jan 2026 22:27:21 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vjOgZ-0029ml-2w;
	Fri, 23 Jan 2026 22:27:19 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vjOgZ-00B7J1-0G;
	Fri, 23 Jan 2026 22:27:19 +0100
Date: Fri, 23 Jan 2026 22:27:19 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, alok.a.tiwari@oracle.com,
	andrew+netdev@lunn.ch, andrew@lunn.ch, chuck.lever@oracle.com,
	davem@davemloft.net, donald.hunter@gmail.com, edumazet@google.com,
	gal@nvidia.com, horms@kernel.org, idosch@nvidia.com,
	jacob.e.keller@intel.com, kernel-team@meta.com,
	kory.maincent@bootlin.com, kuba@kernel.org, lee@trager.us,
	pabeni@redhat.com, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next 1/3] net: ethtool: Track pause storm events
Message-ID: <aXPntx9wiUqbKGRN@pengutronix.de>
References: <20260122192158.428882-1-mohsin.bashr@gmail.com>
 <20260122192158.428882-2-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260122192158.428882-2-mohsin.bashr@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,fb.com,oracle.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,redhat.com,linux.dev];
	TAGGED_FROM(0.00)[bounces-252974-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.994];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CF3057AE5D
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 11:21:56AM -0800, Mohsin Bashir wrote:
> With TX pause enabled, if a device is unable to pass packets up to the
> stack (e.g., CPU is hanged), the device can cause pause storm. Given
> that devices can have native support to protect the neighbor from such
> flooding, such events need some tracking. This support is to track TX
> pause storm events for better observability.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> ---
>  Documentation/netlink/specs/ethtool.yaml       | 13 +++++++++++++
>  include/linux/ethtool.h                        |  2 ++
>  include/uapi/linux/ethtool_netlink_generated.h |  1 +
>  net/ethtool/pause.c                            |  4 +++-
>  4 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index 0a2d2343f79a..4707063af3b4 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -879,6 +879,19 @@ attribute-sets:
>        -
>          name: rx-frames
>          type: u64
> +      -
> +        name: tx-pause-storm-events
> +        type: u64
> +        doc: >-
> +            TX pause storm event count. Increments each time device
> +            detects that its pause assertion condition has been true
> +            for too long for normal operation. As a result, the device
> +            has temporarily disabled its own Pause TX function to
> +            protect the network from itself.
> +            This counter should never increment under normal overload
> +            conditions; it indicates catastrophic failure like an OS
> +            crash. The rate of incrementing is implementation specific.

Hm, we already have the tx pause frame counters. So, the anomaly is
visible to the user anyway (even if it isn't explicitly labeled as an
anomaly).

What is not visible to the user is when HW or SW disables flow control.
Maybe that is what the counter should represent and be named? Would
tx-pause-auto-disabled-events make sense?

The reason I do not like tx-pause-storm-events is that the meaning is
device specific; the user has to read the device manual to know what it
actually means.

tx-pause-auto-disabled-events can be reused in more cases - every time
we try to pause flow control for some reason.
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

