Return-Path: <netdev+bounces-253062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cfR6DcuYdGlJ7wAAu9opvQ
	(envelope-from <netdev+bounces-253062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 11:02:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D95E7D2BF
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 11:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 818A130097C7
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 10:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108B613C8E8;
	Sat, 24 Jan 2026 10:02:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29724883F
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 10:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769248967; cv=none; b=h2EMMS3IbU+4uH1yTMWWN1FVk7wbt8AWRB5j5i+ZvcvR6tlWxKOkSvI2uDSk0s3ckiHa8uqNcd5zRGsBNQgh6u8sj6Shv9DJgx2voxzPO7j7ISnVXB5azTT3KLn1GaJol8ZlNvKG4XMab0d7gM9pYLjYZkHUTvBPmMkrLCgDW3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769248967; c=relaxed/simple;
	bh=+XYuLIPLTY1YIAItBegpjPZa1EncYk2HL/BRvKPDJBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8iXfrB3mtEZEZIoBBFmz22exGC5AnpHI+h4pYzuM2JRctoACIWmcM/zUH+4dHMs8w4gxqgGBUtdwysNUhdfH7PZAkXr0NV+gTayYYc8hgy9F3m8ygwscVHeP6tYCSs7/+17QBaI2aGrdwazC5rXfVYmm/hXObDeVT6BGTBkFU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vjaTR-0007iS-TF; Sat, 24 Jan 2026 11:02:33 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vjaTR-002EpK-1A;
	Sat, 24 Jan 2026 11:02:32 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vjaTQ-00CpcX-1l;
	Sat, 24 Jan 2026 11:02:32 +0100
Date: Sat, 24 Jan 2026 11:02:32 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: David Yang <mmyangfl@gmail.com>,
	Oleksij Rempel <linux@rempel-privat.de>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: dsa: yt921x: Add DCB/priority
 support
Message-ID: <aXSYuOjo5EL4MeeU@pengutronix.de>
References: <20260122194233.2777550-1-mmyangfl@gmail.com>
 <20260122194233.2777550-3-mmyangfl@gmail.com>
 <20260123234759.bj2gik3oobluyjs4@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260123234759.bj2gik3oobluyjs4@skbuf>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253062-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,rempel-privat.de,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	DMARC_NA(0.00)[pengutronix.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:url,pengutronix.de:mid]
X-Rspamd-Queue-Id: 6D95E7D2BF
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 01:47:59AM +0200, Vladimir Oltean wrote:
> > +static int
> > +yt921x_dsa_port_del_dscp_prio(struct dsa_switch *ds, int port, u8 dscp, u8 prio)
> > +{
> > +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> > +	int res;
> > +
> > +	mutex_lock(&priv->reg_lock);
> > +	res = yt921x_reg_write(priv, YT921X_IPM_DSCPn(dscp),
> > +			       ipm_ctrl(IEEE8021Q_TT_BK));
> 
> Question regarding semantics, also for Oleksij: deleting the DSCP app
> table entry should cause that DSCP value to be mapped to bulk, as in
> your interpretation (or best effort for KSZ), or according to the next
> selector in line, as per trust order (for example port default priority,
> which may not be bulk)?

It maps to bulk.

My interpretation of this hardware is that it uses a direct lookup table
without a "valid/invalid" bit per entry. Once DSCP is enabled in the
trust order, the switch performs the lookup for every packet; it cannot
transparently skip a specific DSCP value to fall back to the next
selector.

Therefore, "deleting" an entry practically remaps it to the default
(Bulk/Best Effort) priority. This matches the logic we use in the KSZ
driver.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

