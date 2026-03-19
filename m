Return-Path: <netdev+bounces-269245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGlJF/xNu2lMigIAu9opvQ
	(envelope-from <netdev+bounces-269245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:14:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECCC2C44A4
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 052AB302617F
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BC5253B73;
	Thu, 19 Mar 2026 01:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="Lx3YB24O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aF6HogpE"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D21C1C84A6
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 01:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773882872; cv=none; b=PQf+i+7j/xEzfkYXMhbsrRbdBdawfzUQVzzN40pzxRs++Z2eDJ4kT81C1+zQicNSNS5RMSxJmLpfhvuPNs7HlGGd+RV6kTH9soFd+KcYWtwbtynsbS5tdPW17kGYEmPZRYfq4QWX5EH11VkLZFlNwQxWvGZyjgs9kOT+gTB7cJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773882872; c=relaxed/simple;
	bh=FmgF3KT5+S1dEa60jTGZTWgFooQijuiHCGB5vm2MzLY=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=KWAdMrcYJ/bWxPLtuplwajNKdDt/61nBpgM1bX88NVawpg14k7UojcPYb2cd19YwqEwj/jb/jcFqcTYhapW0C7BkHmLOijV5ydWNZN1O4nylWxwVeK8MAWuqVqWpF0rn4RA6L/5ji4ynhqcFh0qDsUAcRI9+mZZsHF6lWL2EIJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=Lx3YB24O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aF6HogpE; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id DC675EC0191;
	Wed, 18 Mar 2026 21:14:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 18 Mar 2026 21:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1773882868; x=1773969268; bh=q7WwXwDbJ7TKzKCQ5X+a5
	zubBjEY3AIsJ4ZM+FVwao4=; b=Lx3YB24Os/hz+t4YUSgFEjhSAyfCsujZfGdYM
	rEG/uVISDQp5TDYcRJJegN4XRSQpazchtxX3SMfwrJbRXz2bguMJzul+Mudq3ody
	HPsnVWDxfAG3WybXwSGletEDWB+Uj1A88hmX6Rj4adeBe/wzKytDxxIxaBJp+2xD
	oC/gkb2L7CygVaqW+MJYgZ0OUQMUdgk+RkzzfUM+XsRiV4rWFb9Y1dFig58/O7ZA
	i7M2bRJ3kFABHrXXz72LjSa+7jYgZfeITOxMBbllqcEj9/wC3uQ6hgBbMocYdEF9
	TrCcuSrMwEEZ/oevG2gVIorr3D9LVFeWS1TYkDmHtIUb27mKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773882868; x=1773969268; bh=q7WwXwDbJ7TKzKCQ5X+a5zubBjEY3AIsJ4Z
	M+FVwao4=; b=aF6HogpEUddwhBorU79O9s/3jxZoEP0XXOwj67InMvQqtwBaqYk
	cdo5pnvuXr07CPfBKuLfO0tpywPSxsEQxRa9jwv9VUM0/94z5Y02h47yFg1pek7R
	3BB47fz1niFFNylp5vpApQGXnMcg6LefEfHuXAAdkANgAUNFLI/CBoeAJtdn/T2W
	OLviYooVvMut56SN1dNhYQ1qACM8uACrf8n2NGG5cSS+rZqduFShgEA9PcxEhA/p
	dYfgWIkHcS75oNI43/vQZZSA7SsTeo+8dJ1qF1q8p/ZfdAz4VsMIH8j4fjX6evdd
	QxWUE1A4wgJDyFSQ5JXLLVQ+kN7M1uoPZ3A==
X-ME-Sender: <xms:9E27afuKNtEXGzSQ2Ru6LFwQ_xZ0cxhCwdKgRS3zVFqATIEa-hztlg>
    <xme:9E27aTCPLhH7ItbRH--VWLFGF6rl_9oT3HQVS_VhhVRED-wn4Q40IDbLwtVo1p3-W
    KC1xv2pwzgiltVVklubWTL8s44st4cxdvuyigCOSVwbDqwv0w5gBOc>
X-ME-Received: <xmr:9E27aWbs1UwOdCqO6svyTJ9M-8DZm3dD5saHtjbVdTb8XQv9-amecivcM0GIH4-1ffbiBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdehieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepieefvdelfeeljeevtefhfeeiudeuiedvfeeiveelffduvdevfedtheffffetfeff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhvse
    hjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlohhuihhsrdhstggrlhgsvghrthesieifihhnugdrtghomh
    dprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    rghnugihsehgrhgvhihhohhushgvrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehjrghnughrvgifodhnvghtuggvvheslhhunhhnrdgt
    hhdprhgtphhtthhopehfsghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopehprggsvg
    hnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghmmhhinhhgvghrsehvhigrthhtrgdrtg
    homh
X-ME-Proxy: <xmx:9E27aeUADlnqwYnDVBeT9U4vBWvdO4fqDVIZDCKtK4ue7lifg9dpmw>
    <xmx:9E27aVNPYGrTFXAgawyEx04mwxhZoEWM-c2gG-0iBK5D54CDfAf8RA>
    <xmx:9E27aYYObP7wCXsGTCiv_TPHgvn1QTrEaD65McCLcuopnoloW5T9QQ>
    <xmx:9E27aU-PncnqdlBQDXMWzUZ71PskSaqzzX1iY0kKby2WZ0NvF4pCAQ>
    <xmx:9E27aRDs7ptQQ0w0cr3DsfcZFvYSFu2UmvbMvwA234tmRxL_UlcoEXqY>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 21:14:27 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id BC5459FC7E; Wed, 18 Mar 2026 18:14:26 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id BB3D89FB65;
	Wed, 18 Mar 2026 18:14:26 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Louis Scalbert <louis.scalbert@6wind.com>
cc: netdev@vger.kernel.org, jandrew+netdev@lunn.ch, edumazet@google.com,
    kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com,
    andy@greyhouse.net, shemminger@vyatta.com
Subject: Re: [PATCH net 1/2] bonding: 3ad: fix carrier when no valid slaves
In-reply-to: <20260316131838.3257889-2-louis.scalbert@6wind.com>
References: <20260316131838.3257889-1-louis.scalbert@6wind.com>
 <20260316131838.3257889-2-louis.scalbert@6wind.com>
Comments: In-reply-to Louis Scalbert <louis.scalbert@6wind.com>
   message dated "Mon, 16 Mar 2026 14:18:37 +0100."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1943613.1773882866.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Mar 2026 18:14:26 -0700
Message-ID: <1943614.1773882866@famine>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269245-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,jvosburgh.net:dkim,jvosburgh.net:email,6wind.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 5ECCC2C44A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Louis Scalbert <louis.scalbert@6wind.com> wrote:

>When an 802.3ad (LACP) bonding interface has no slaves in the
>collecting/distributing state, the bonding master may still report
>carrier as up. In this situation, no slave is actually able to transmit
>or receive traffic.
>
>As a result, upper-layer daemons consider the interface operational
>while traffic is effectively blackholed.
>
>Fix this by asserting carrier only when at least 'min_links' slaves are
>in the collecting/distributing state (or collecting only if the
>coupled_control default behavior is disabled).
>
>Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
>Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
>---
> drivers/net/bonding/bond_3ad.c | 22 ++++++++++++++++++++--
> 1 file changed, 20 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3a=
d.c
>index af7f74cfdc08..7d7661972c5e 100644
>--- a/drivers/net/bonding/bond_3ad.c
>+++ b/drivers/net/bonding/bond_3ad.c
>@@ -745,6 +745,22 @@ static void __set_agg_ports_ready(struct aggregator =
*aggregator, int val)
> 	}
> }
> =

>+static int __agg_valid_ports(struct aggregator *agg)
>+{
>+	struct port *port;
>+	int valid =3D 0;
>+
>+	for (port =3D agg->lag_ports; port;
>+	     port =3D port->next_port_in_aggregator) {
>+		if (port->actor_oper_port_state & LACP_STATE_COLLECTING &&
>+		    (!port->slave->bond->params.coupled_control ||
>+		     port->actor_oper_port_state & LACP_STATE_DISTRIBUTING))
>+			valid++;
>+	}
>+
>+	return valid;
>+}

	Did you consider instead rolling the COLLECTING / DISTRIBUTING
test into __agg_active_ports?  It appears at first glance that the users
of __agg_active_ports would do the right thing with the "able to
communicate" logic.

	As an example, logically the aggregator selection logic should
count "usable" ports, not simply ports that are enabled and may or may
not be usable.

	-J

>+
> static int __agg_active_ports(struct aggregator *agg)
> {
> 	struct port *port;
>@@ -2120,6 +2136,7 @@ static void ad_enable_collecting_distributing(struc=
t port *port,
> 			  port->actor_port_number,
> 			  port->aggregator->aggregator_identifier);
> 		__enable_port(port);
>+		bond_3ad_set_carrier(port->slave->bond);
> 		/* Slave array needs update */
> 		*update_slave_arr =3D true;
> 		/* Should notify peers if possible */
>@@ -2141,6 +2158,7 @@ static void ad_disable_collecting_distributing(stru=
ct port *port,
> 			  port->actor_port_number,
> 			  port->aggregator->aggregator_identifier);
> 		__disable_port(port);
>+		bond_3ad_set_carrier(port->slave->bond);
> 		/* Slave array needs an update */
> 		*update_slave_arr =3D true;
> 	}
>@@ -2819,8 +2837,8 @@ int bond_3ad_set_carrier(struct bonding *bond)
> 	}
> 	active =3D __get_active_agg(&(SLAVE_AD_INFO(first_slave)->aggregator));
> 	if (active) {
>-		/* are enough slaves available to consider link up? */
>-		if (__agg_active_ports(active) < bond->params.min_links) {
>+		/* are enough slaves in collecting (and distributing) state to conside=
r link up? */
>+		if (__agg_valid_ports(active) < bond->params.min_links) {
> 			if (netif_carrier_ok(bond->dev)) {
> 				netif_carrier_off(bond->dev);
> 				goto out;
>-- =

>2.39.2
>

---
	-Jay Vosburgh, jv@jvosburgh.net

