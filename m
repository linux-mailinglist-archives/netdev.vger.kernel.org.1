Return-Path: <netdev+bounces-295098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sEhGNzw5IWp0BQEAu9opvQ
	(envelope-from <netdev+bounces-295098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:37:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA9E63E0A7
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:37:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=A5NPQlqq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295098-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295098-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A84BD3012E84
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 08:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E076639B482;
	Thu,  4 Jun 2026 08:30:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1D0352C28;
	Thu,  4 Jun 2026 08:30:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780561821; cv=none; b=toCZ89kd6SpE+WmT95m5XFRyH9LaNDo42JXc3mHcMIPm6xpJbsnTmSRvnnwxK+0M/L8C2vh0asoJ6RzM3+dkTE0LZtzNbW6zgxtZVgtrsPKr64vgHL4QFwKEFKTjA/EKb75REa3gEDJMHxrJsL9OBdzEedrc9cXJR0QZ/TCY7OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780561821; c=relaxed/simple;
	bh=EqUsJb5dmF8hJKkcZTRQyLGmvdg26mTAQ0mITdbTufg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PsfIyFKtMnQuN0pWrlhI3rRiM7o+MV0q5k3fzP33/ncPp4l7usJdzXR5jv6+Aj/dthxax7i+5r2tf1jRWkfa8JU6oI3dojWZB6cWoNOVL7sA/HFnMsognp5YDDBGT2lv4q4GVa2DWrcv6w+Eto4Gh9JOkOAPSu1zf4nsvs56X3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5NPQlqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69E91C2BCC6;
	Thu,  4 Jun 2026 08:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780561821;
	bh=EqUsJb5dmF8hJKkcZTRQyLGmvdg26mTAQ0mITdbTufg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=A5NPQlqqmtUoH8md30A7A3t4PqZPHYIliMi+XLiWx2E4Bhf7nttWDZxf477AY6Fyd
	 3IoJjK44SyhMeovFyRIioxvo1Ip264aHndt9mzDhP7xglI7p/p93PchHUaEFxmD7ph
	 dZx1p3mnYgvNzJVo88Pz0kzp5jGnyHibR2fL2p1sfr79tq7cH228nZ8B+zIox3/V+l
	 h3Os/wKbvplEIBj9O/l0kNdJjZxEehnaLbSg/csdmJ2iDPMtKMey/ND/YrP9989MTY
	 7auY64yK00CmYXWOQbUTaWqj9r+XFnQQB+Rw2o3C2j2fyd2M1UgbCV17woyR3rZNk8
	 3nABI9ZQ4gVmw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55411CD6E4A;
	Thu,  4 Jun 2026 08:30:21 +0000 (UTC)
From: Cedric Jehasse via B4 Relay <devnull+cedric.jehasse.luminex.be@kernel.org>
Date: Thu, 04 Jun 2026 10:30:14 +0200
Subject: [PATCH net-next 1/2] net: dsa: add support for dcb pcp app
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-net-next-mv88e6xxx-pcp-prio-v1-1-f9d10fe6cdc8@luminex.be>
References: <20260604-net-next-mv88e6xxx-pcp-prio-v1-0-f9d10fe6cdc8@luminex.be>
In-Reply-To: <20260604-net-next-mv88e6xxx-pcp-prio-v1-0-f9d10fe6cdc8@luminex.be>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luke Howard <lukeh@padl.com>, Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Cedric Jehasse <cedric.jehasse@luminex.be>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780561819; l=7081;
 i=cedric.jehasse@luminex.be; s=20260213; h=from:subject:message-id;
 bh=vAbt2oUZwh/Xl1VBsXEixbjizxp0CkUnxtZsJliOylM=;
 b=fRYhAMUUjGItSLgK1KBvFXTrF64mRPvaT/fHSgkT2XMW6s1snlpMsIo7J1q7Ion/DSLUt+pBH
 k2FIxzWGT9iASVhBQiI+cGU5+BGe5UlCvFmDY1GE0VdFzizo2cyskR+
X-Developer-Key: i=cedric.jehasse@luminex.be; a=ed25519;
 pk=DL2RaHc2bc7tTDTMJdugm42BtJk4Ip+7V41Gkj+Avjk=
X-Endpoint-Received: by B4 Relay for cedric.jehasse@luminex.be/20260213
 with auth_id=638
X-Original-From: Cedric Jehasse <cedric.jehasse@luminex.be>
Reply-To: cedric.jehasse@luminex.be
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295098-lists,netdev=lfdr.de,cedric.jehasse.luminex.be];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lukeh@padl.com,m:cedric.jehasse@gmail.com,m:cedric.jehasse@luminex.be,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,padl.com,gmail.com,luminex.be];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[cedric.jehasse@luminex.be];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2FA9E63E0A7

From: Cedric Jehasse <cedric.jehasse@luminex.be>

Set/get of dscp-prio map is already supported by dsa.
This adds support for set/get of pcp-prio map in a similar way.

Signed-off-by: Cedric Jehasse <cedric.jehasse@luminex.be>
---
 include/net/dsa.h |  10 +++++
 net/dsa/user.c    | 126 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 129 insertions(+), 7 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 8b6d34e8a6f0..05428c555ccd 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -447,6 +447,11 @@ struct dsa_switch {
 	 */
 	u32			dscp_prio_mapping_is_global:1;
 
+	/* Drivers that have global PCP mapping settings must set this to
+	 * true to automatically apply the settings to all ports.
+	 */
+	u32			pcp_prio_mapping_is_global:1;
+
 	/* Listener for switch fabric events */
 	struct notifier_block	nb;
 
@@ -970,6 +975,11 @@ struct dsa_switch_ops {
 				      u8 prio);
 	int	(*port_del_dscp_prio)(struct dsa_switch *ds, int port, u8 dscp,
 				      u8 prio);
+	int	(*port_get_pcp_prio)(struct dsa_switch *ds, int port, u8 pcp);
+	int	(*port_add_pcp_prio)(struct dsa_switch *ds, int port, u8 pcp,
+				     u8 prio);
+	int	(*port_del_pcp_prio)(struct dsa_switch *ds, int port, u8 pcp,
+				     u8 prio);
 	int	(*port_set_apptrust)(struct dsa_switch *ds, int port,
 				     const u8 *sel, int nsel);
 	int	(*port_get_apptrust)(struct dsa_switch *ds, int port, u8 *sel,
diff --git a/net/dsa/user.c b/net/dsa/user.c
index c4bd6fe90b45..aa6d030968b9 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -2238,11 +2238,11 @@ dsa_user_dcbnl_set_default_prio(struct net_device *dev, struct dcb_app *app)
 	return 0;
 }
 
-/* Update the DSCP prio entries on all user ports of the switch in case
- * the switch supports global DSCP prio instead of per port DSCP prios.
+/* Update the APP entries on all user ports of the switch in case
+ * the switch supports global prio settings instead of per port prios.
  */
-static int dsa_user_dcbnl_ieee_global_dscp_setdel(struct net_device *dev,
-						  struct dcb_app *app, bool del)
+static int dsa_user_dcbnl_ieee_global_setdel(struct net_device *dev,
+					     struct dcb_app *app, bool del)
 {
 	int (*setdel)(struct net_device *dev, struct dcb_app *app);
 	struct dsa_port *dp = dsa_user_to_port(dev);
@@ -2284,7 +2284,7 @@ static int dsa_user_dcbnl_ieee_global_dscp_setdel(struct net_device *dev,
 
 		restore_err = setdel(user, app);
 		if (restore_err)
-			netdev_err(user, "Failed to restore DSCP prio entry configuration\n");
+			netdev_err(user, "Failed to restore APP entry configuration\n");
 	}
 
 	return err;
@@ -2324,7 +2324,7 @@ dsa_user_dcbnl_add_dscp_prio(struct net_device *dev, struct dcb_app *app)
 	if (!ds->dscp_prio_mapping_is_global)
 		return 0;
 
-	err = dsa_user_dcbnl_ieee_global_dscp_setdel(dev, app, false);
+	err = dsa_user_dcbnl_ieee_global_setdel(dev, app, false);
 	if (err) {
 		if (ds->ops->port_del_dscp_prio)
 			ds->ops->port_del_dscp_prio(ds, port, dscp, new_prio);
@@ -2335,6 +2335,54 @@ dsa_user_dcbnl_add_dscp_prio(struct net_device *dev, struct dcb_app *app)
 	return 0;
 }
 
+static int __maybe_unused
+dsa_user_dcbnl_add_pcp_prio(struct net_device *dev, struct dcb_app *app)
+{
+	struct dsa_port *dp = dsa_user_to_port(dev);
+	struct dsa_switch *ds = dp->ds;
+	unsigned long mask, new_prio;
+	int err, port = dp->index;
+	u8 pcp = app->protocol;
+
+	if (!ds->ops->port_add_pcp_prio)
+		return -EOPNOTSUPP;
+
+	if (app->priority >= IEEE_8021QAZ_MAX_TCS)
+		return -EINVAL;
+
+	if (pcp >= 16) {
+		netdev_err(dev, "PCP APP entry with protocol value %u is invalid\n",
+			   pcp);
+		return -EINVAL;
+	}
+
+	err = dcb_ieee_setapp(dev, app);
+	if (err)
+		return err;
+
+	mask = dcb_ieee_getapp_mask(dev, app);
+	new_prio = __fls(mask);
+
+	err = ds->ops->port_add_pcp_prio(ds, port, pcp, new_prio);
+	if (err) {
+		dcb_ieee_delapp(dev, app);
+		return err;
+	}
+
+	if (!ds->pcp_prio_mapping_is_global)
+		return 0;
+
+	err = dsa_user_dcbnl_ieee_global_setdel(dev, app, false);
+	if (err) {
+		if (ds->ops->port_del_pcp_prio)
+			ds->ops->port_del_pcp_prio(ds, port, pcp, new_prio);
+		dcb_ieee_delapp(dev, app);
+		return err;
+	}
+
+	return 0;
+}
+
 static int __maybe_unused dsa_user_dcbnl_ieee_setapp(struct net_device *dev,
 						     struct dcb_app *app)
 {
@@ -2349,6 +2397,8 @@ static int __maybe_unused dsa_user_dcbnl_ieee_setapp(struct net_device *dev,
 		break;
 	case IEEE_8021QAZ_APP_SEL_DSCP:
 		return dsa_user_dcbnl_add_dscp_prio(dev, app);
+	case DCB_APP_SEL_PCP:
+		return dsa_user_dcbnl_add_pcp_prio(dev, app);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -2405,7 +2455,7 @@ dsa_user_dcbnl_del_dscp_prio(struct net_device *dev, struct dcb_app *app)
 	if (!ds->dscp_prio_mapping_is_global)
 		return 0;
 
-	err = dsa_user_dcbnl_ieee_global_dscp_setdel(dev, app, true);
+	err = dsa_user_dcbnl_ieee_global_setdel(dev, app, true);
 	if (err) {
 		if (ds->ops->port_add_dscp_prio)
 			ds->ops->port_add_dscp_prio(ds, port, dscp,
@@ -2417,6 +2467,42 @@ dsa_user_dcbnl_del_dscp_prio(struct net_device *dev, struct dcb_app *app)
 	return 0;
 }
 
+static int __maybe_unused
+dsa_user_dcbnl_del_pcp_prio(struct net_device *dev, struct dcb_app *app)
+{
+	struct dsa_port *dp = dsa_user_to_port(dev);
+	struct dsa_switch *ds = dp->ds;
+	int err, port = dp->index;
+	u8 pcp = app->protocol;
+
+	if (!ds->ops->port_del_pcp_prio)
+		return -EOPNOTSUPP;
+
+	err = dcb_ieee_delapp(dev, app);
+	if (err)
+		return err;
+
+	err = ds->ops->port_del_pcp_prio(ds, port, pcp, app->priority);
+	if (err) {
+		dcb_ieee_setapp(dev, app);
+		return err;
+	}
+
+	if (!ds->pcp_prio_mapping_is_global)
+		return 0;
+
+	err = dsa_user_dcbnl_ieee_global_setdel(dev, app, true);
+	if (err) {
+		if (ds->ops->port_add_pcp_prio)
+			ds->ops->port_add_pcp_prio(ds, port, pcp,
+						   app->priority);
+		dcb_ieee_setapp(dev, app);
+		return err;
+	}
+
+	return 0;
+}
+
 static int __maybe_unused dsa_user_dcbnl_ieee_delapp(struct net_device *dev,
 						     struct dcb_app *app)
 {
@@ -2431,6 +2517,8 @@ static int __maybe_unused dsa_user_dcbnl_ieee_delapp(struct net_device *dev,
 		break;
 	case IEEE_8021QAZ_APP_SEL_DSCP:
 		return dsa_user_dcbnl_del_dscp_prio(dev, app);
+	case DCB_APP_SEL_PCP:
+		return dsa_user_dcbnl_del_pcp_prio(dev, app);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -2486,6 +2574,30 @@ static int dsa_user_dcbnl_init(struct net_device *dev)
 		}
 	}
 
+	if (ds->ops->port_get_pcp_prio) {
+		int protocol;
+
+		for (protocol = 0; protocol < 16; protocol++) {
+			struct dcb_app app = {
+				.selector = DCB_APP_SEL_PCP,
+				.protocol = protocol,
+			};
+			int prio;
+
+			prio = ds->ops->port_get_pcp_prio(ds, port, protocol);
+			if (prio == -EOPNOTSUPP)
+				continue;
+			if (prio < 0)
+				return prio;
+
+			app.priority = prio;
+
+			err = dcb_ieee_setapp(dev, &app);
+			if (err)
+				return err;
+		}
+	}
+
 	return 0;
 }
 

-- 
2.43.0



