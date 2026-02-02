Return-Path: <netdev+bounces-255833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKxSKbGDgGnE8wIAu9opvQ
	(envelope-from <netdev+bounces-255833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 12:00:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0376BCB609
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 12:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 190B03048E38
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 10:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F07A359705;
	Mon,  2 Feb 2026 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2Mz9560"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B7427E054
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770029546; cv=none; b=FyRyN2LuXqlduvpANT2K68Klab2/XxK+agQZEJKvzUtV7GcSt5J59myPiLRMMC3xysHp6qK0WM5/8zJ8tnDM/n73ZIsetPp8Nn25262jJAWv0DSMHX92AWil0ACM3OQSSJRUvZ8DVj9bz7EoB6UdsFqM16hl4lUghrHDKnuCkOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770029546; c=relaxed/simple;
	bh=97NTHCzS0n/BvSuhN/zRb+tihckRuAsp5uZI/F4urVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHLbXR/3jh6lnSUu5sOhs8lwK7bTGEwEK9oPAiWgjiGAoHS9/uYSHXqqSMMgsDHtzNHWEg/ZsV1s4Py+ELhxis5O1R2BomKtcyuoIdMOc2lC4Bry5BCaumgGxVfWzjV0n6BoCgupvGIZb3XfyDskhNt/QBFkqRphtUlqOYwTMC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2Mz9560; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-430f38c7d4eso227855f8f.3
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 02:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770029542; x=1770634342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xWxOf97wKvZxzeWBylvqiEYlaEUCwOSQAbV2NhNj1mU=;
        b=P2Mz9560WfsQ7VGmLrY32VLTSkqJ6rABFaLQSaM5NBH7PzcY8GSaSfyRCTpNjtbeE9
         vCu1WEbda9MbvLWr/Yf+2bbcqxtB0Ke5SfvXSjiKI7lNkglYIHPUmo+YXWZ+Oiae/bud
         RlS5TAuNR34kWbTAnQgOxZFiL8fLnpONVU2kGSrYOp0UMzQm5Ke/GkvSdV6NOkcEgU42
         ksF+MrZN9rwQWWmh7xZySiyw31UiAgv7Bzh7U/zK/UM9LJMJPabRrgbkKSqunxKYwr/0
         18++OTj/+509hE0YiFBxwLyGIceYDjyhsCvcDJJD9kOy4WHGi/tJo3lup/PWoFOVEO2B
         vXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770029542; x=1770634342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWxOf97wKvZxzeWBylvqiEYlaEUCwOSQAbV2NhNj1mU=;
        b=kdlaczyMAd0k/2Q6wtgN/9V7LMWv+GIJZoeuymzthkOE6VsT0liOvvuIrbQ2H3riz/
         VefA2Z6s46fevvnvMipmJf+E/lKK3uaaS5gIjjLCKX2YiXkOoHXrj/XX5HZ234bk6fE+
         6t+zNuAz/qVcitN+/fWm6odQacYosK0l9ffKs4uSkTbrIjFaX8vJ4rWiajBqRwqfF9Bg
         mPk1xPnpYDCZUB7TbzENbiqIshg34LYautsCWHlbA822XhfCSYmyEp14kTl0l6k2i9fD
         SVFcKwqy5/aQzn7T5nNPAc7Ej9nnqPSbJB5qFYBAHpb4sU0vrQMU+/vgk7E997Qzo4kd
         n2yA==
X-Gm-Message-State: AOJu0YyZk1GZiY/gc02x23aRTaUkRkwedB6zz9QaYK+BHySYxxvYGZ1A
	QzHZhhAgxy9f2/CYad7mhFHXlqsJ0u2XEq5I0160FoplAhyjvI2Nr+Kf
X-Gm-Gg: AZuq6aKNTJmfmbech5xadkUZ/pZDJB56IBl3Q660A8EjxZXbcEJboNisW4ul1rlWoUl
	Cnm3D32Qyu/XVrS/Ibf5KOved0NY2cIBNawa8bkoi4GT9Tz5hm+pHbZssfJpDC2Zba4Yr5ujHI1
	cVC1TFoeBIPyZbbS9sP8pASkqA/byxeke+C1q1TVVNvhxnlE19zApF/KFI9pssnQZfB3n0TPo/M
	UL2sdVXp4lbFfigZ/b934MTJxufM7VwqEIZ9/V07AL3MwKj22gLyWhxPEA+/JhJy3Qg8YG2XnA4
	YrCygMLtWug5lfcg+ygJcIZIoTvPLFCK54obUru+nk+qPchn5JFDTHt5PYw8sfT2y9lKw6tWjwx
	Q3W4N8vgWUjJr3Is4gNWm/ZbTM297bLoc0DAI404CWWCX8y5mk8yLBWe8kwVqL7fhOu+1B7Ieta
	XHBuw=
X-Received: by 2002:a05:6000:1a86:b0:432:84f8:98c3 with SMTP id ffacd0b85a97d-435f3a6f79amr9245887f8f.2.1770029541997;
        Mon, 02 Feb 2026 02:52:21 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:74c4:3a65:f9a9:6c29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10ee040sm42798976f8f.11.2026.02.02.02.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 02:52:21 -0800 (PST)
Date: Mon, 2 Feb 2026 12:52:18 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: sync dsa_mall_policer_tc_entry
 with FLOW_ACTION_POLICE
Message-ID: <20260202105218.sx5k6ksy5ycpfyxf@skbuf>
References: <20260131045821.3451873-1-mmyangfl@gmail.com>
 <20260131045821.3451873-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="b4xng4watr55epxh"
Content-Disposition: inline
In-Reply-To: <20260131045821.3451873-1-mmyangfl@gmail.com>
 <20260131045821.3451873-1-mmyangfl@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-diff];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255833-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 0376BCB609
X-Rspamd-Action: no action


--b4xng4watr55epxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 31, 2026 at 12:58:16PM +0800, David Yang wrote:
> diff --git a/net/dsa/user.c b/net/dsa/user.c
> index f59d66f0975d..2a209b83c701 100644
> --- a/net/dsa/user.c
> +++ b/net/dsa/user.c
> @@ -1497,8 +1497,19 @@ dsa_user_add_cls_matchall_police(struct net_device *dev,
>  	mall_tc_entry->cookie = cls->cookie;
>  	mall_tc_entry->type = DSA_PORT_MALL_POLICER;
>  	policer = &mall_tc_entry->policer;
> +	/* until they export the type of act->police in flow_offload.h ... */

There is no "us" and "them", it's a single git tree. Just submit a patch
to whomever ./scripts/get_maintainer.pl says to.

Have you tried something like the patch attached (just compile-tested)?

--b4xng4watr55epxh
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-dsa-eliminate-local-type-for-tc-policers.patch"

From 7decde3308a690061ec8d874f06b285bde27e4fd Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 2 Feb 2026 12:45:09 +0200
Subject: [PATCH] net: dsa: eliminate local type for tc policers

David Yang is saying that struct flow_action_entry in
include/net/flow_offload.h has gained new fields and DSA's struct
dsa_mall_policer_tc_entry, derived from that, isn't keeping up.
This structure is passed to drivers and they are completely oblivious to
the values of fields they don't see.

This has happened before, and almost always the solution was to make the
DSA layer thinner and use the upstream data structures. Here, the reason
why we didn't do that is because struct flow_action_entry :: police is
an anonymous structure.

That is easily enough fixable, just name those fields "struct
flow_action_police" and reference them from DSA.

Make the according transformations to the two users (sja1105 and felix):
"rate_bytes_per_sec" -> "rate_bytes_ps".

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/ocelot/felix.c         |  4 ++--
 drivers/net/dsa/sja1105/sja1105_main.c |  4 ++--
 include/net/dsa.h                      | 10 ++--------
 include/net/flow_offload.h             |  2 +-
 net/dsa/user.c                         |  5 ++---
 5 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 9e5ede932b42..5d34eb82e639 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -2003,11 +2003,11 @@ static int felix_cls_flower_stats(struct dsa_switch *ds, int port,
 }
 
 static int felix_port_policer_add(struct dsa_switch *ds, int port,
-				  struct dsa_mall_policer_tc_entry *policer)
+				  const struct flow_action_police *policer)
 {
 	struct ocelot *ocelot = ds->priv;
 	struct ocelot_policer pol = {
-		.rate = div_u64(policer->rate_bytes_per_sec, 1000) * 8,
+		.rate = div_u64(policer->rate_bytes_ps, 1000) * 8,
 		.burst = policer->burst,
 	};
 
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 2a4a0fe20dae..71a817c07a90 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2841,7 +2841,7 @@ static void sja1105_mirror_del(struct dsa_switch *ds, int port,
 }
 
 static int sja1105_port_policer_add(struct dsa_switch *ds, int port,
-				    struct dsa_mall_policer_tc_entry *policer)
+				    const struct flow_action_police *policer)
 {
 	struct sja1105_l2_policing_entry *policing;
 	struct sja1105_private *priv = ds->priv;
@@ -2852,7 +2852,7 @@ static int sja1105_port_policer_add(struct dsa_switch *ds, int port,
 	 * the value of RATE bytes divided by 64, up to a maximum of SMAX
 	 * bytes.
 	 */
-	policing[port].rate = div_u64(512 * policer->rate_bytes_per_sec,
+	policing[port].rate = div_u64(512 * policer->rate_bytes_ps,
 				      1000000);
 	policing[port].smax = policer->burst;
 
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 1e33242b6d94..6c17446f3dcc 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -218,12 +218,6 @@ struct dsa_mall_mirror_tc_entry {
 	bool ingress;
 };
 
-/* TC port policer entry */
-struct dsa_mall_policer_tc_entry {
-	u32 burst;
-	u64 rate_bytes_per_sec;
-};
-
 /* TC matchall entry */
 struct dsa_mall_tc_entry {
 	struct list_head list;
@@ -231,7 +225,7 @@ struct dsa_mall_tc_entry {
 	enum dsa_port_mall_action_type type;
 	union {
 		struct dsa_mall_mirror_tc_entry mirror;
-		struct dsa_mall_policer_tc_entry policer;
+		struct flow_action_police policer;
 	};
 };
 
@@ -1112,7 +1106,7 @@ struct dsa_switch_ops {
 	void	(*port_mirror_del)(struct dsa_switch *ds, int port,
 				   struct dsa_mall_mirror_tc_entry *mirror);
 	int	(*port_policer_add)(struct dsa_switch *ds, int port,
-				    struct dsa_mall_policer_tc_entry *policer);
+				    const struct flow_action_police *policer);
 	void	(*port_policer_del)(struct dsa_switch *ds, int port);
 	int	(*port_setup_tc)(struct dsa_switch *ds, int port,
 				 enum tc_setup_type type, void *type_data);
diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
index 596ab9791e4d..a2b1b752958a 100644
--- a/include/net/flow_offload.h
+++ b/include/net/flow_offload.h
@@ -275,7 +275,7 @@ struct flow_action_entry {
 			u32			trunc_size;
 			bool			truncate;
 		} sample;
-		struct {				/* FLOW_ACTION_POLICE */
+		struct flow_action_police {		/* FLOW_ACTION_POLICE */
 			u32			burst;
 			u64			rate_bytes_ps;
 			u64			peakrate_bytes_ps;
diff --git a/net/dsa/user.c b/net/dsa/user.c
index f59d66f0975d..df25a8891c01 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1459,8 +1459,8 @@ dsa_user_add_cls_matchall_police(struct net_device *dev,
 	struct netlink_ext_ack *extack = cls->common.extack;
 	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_user_priv *p = netdev_priv(dev);
-	struct dsa_mall_policer_tc_entry *policer;
 	struct dsa_mall_tc_entry *mall_tc_entry;
+	struct flow_action_police *policer;
 	struct dsa_switch *ds = dp->ds;
 	struct flow_action_entry *act;
 	int err;
@@ -1497,8 +1497,7 @@ dsa_user_add_cls_matchall_police(struct net_device *dev,
 	mall_tc_entry->cookie = cls->cookie;
 	mall_tc_entry->type = DSA_PORT_MALL_POLICER;
 	policer = &mall_tc_entry->policer;
-	policer->rate_bytes_per_sec = act->police.rate_bytes_ps;
-	policer->burst = act->police.burst;
+	memcpy(policer, &act->police, sizeof(*policer));
 
 	err = ds->ops->port_policer_add(ds, dp->index, policer);
 	if (err) {
-- 
2.43.0


--b4xng4watr55epxh--

