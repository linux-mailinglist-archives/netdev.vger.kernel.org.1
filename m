Return-Path: <netdev+bounces-298328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wFA0HjIVK2px2QMAu9opvQ
	(envelope-from <netdev+bounces-298328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:06:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08603674F13
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:06:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=W6GDHGz7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298328-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298328-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C33A3069782
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951BF386C22;
	Thu, 11 Jun 2026 20:03:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6143161BF
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 20:03:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208239; cv=none; b=RsSqlB+EtVeIdnf5Uzf+hsrsRYkUFeCCa/tLC5nNCswF30CJc5LdXN/A6eMP0PfznvzA5o84uL4qDnB03CNgTSsjPgrvbrddgOBccgCeFuH5algjYc0/tUKBL1Bsy/4GFRDnbEOHYK1opjZ8vLar8WX/sV0FvovC/SvK+bMZavw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208239; c=relaxed/simple;
	bh=V+djr4i9aW3LMbBOQmPjC9scV0XsPtrh8rupNsvbNaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZFGcgzG8AIRCdWzfqGAFQBy/Hh9Yf4z/4MSjTa+gsQbrSx/nejt75bJXS9BDtXhY5rrum9eSp7mJ/ek6ANnPxiSp9nBwJkqi755eTGiidFgalJwO33nuz/sZ02c3CKBB/82g2Tg8tr2R4XY34inpi2TBFBC6FpoqniSBejACNsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6GDHGz7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923611F000E9;
	Thu, 11 Jun 2026 20:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781208238;
	bh=8brqqtrIs3mW4sawlcnNy/td9fs1hXNgYVw9O3koCRE=;
	h=From:To:Cc:Subject:Date;
	b=W6GDHGz75FT1xlx/2DINWaB+BbnVIHlnLocjFWGs7d+9VlUloJ/le3GH0z4AfoBg2
	 kDnhCjlW2YfKKreDx+FVLXBC4nSswcJ/185wYlLoyWGm0d1O0IFM9LSYiFEfyLokQb
	 HsJi8/wF0cpNuRjSPDSpFzqrhs18e5AsA3iLgZdaWe3WD//I1PsmKSgMw/yTVHSrK/
	 tQ1/vXcikAX4R9uzsaMU/6nfQqtFFm4S6EJnXcT7YZ60IzArmTGszQ7Ejd6rSGI6pV
	 BZXkqVJ/+hLCi2vxCFPQhqLCKtb2K5xlQGCbL3LM6s3TXGHk3qWW4UZZbQGEgbwLQF
	 DvtBrfnrITpmQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	gal@nvidia.com,
	jacob.e.keller@intel.com,
	sdf@fomichev.me,
	kory.maincent@bootlin.com
Subject: [PATCH net-next] ethtool: tsconfig: always take rtnl_lock
Date: Thu, 11 Jun 2026 13:03:55 -0700
Message-ID: <20260611200355.2020663-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298328-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuba@kernel.org,m:andrew@lunn.ch,m:gal@nvidia.com,m:jacob.e.keller@intel.com,m:sdf@fomichev.me,m:kory.maincent@bootlin.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:email,bootlin.com:email,fomichev.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 08603674F13

mlx5 throws ASSERT_RTNL() warnings on timestamp config, because
it tries to update features. mlx5e_hwtstamp_set() calls
netdev_update_features().

I missed this while grepping the drivers because tsconfig goes
through ndo_hwtstamp_set/get, not ethtool ops, even tho the new
uAPI is in ethtool Netlink. We could add a dedicated opt out bit
for mlx5, but NDOs were not supposed to be part of the ethtool locking
conversion in the first place.

The mlx5 features update is related to the "compressed CQE" format
which lacks timestamp, apparently. See commit c0194e2d0ef0 ("net/mlx5e:
Disable rxhash when CQE compress is enabled").

Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to get/set hwtstamp config")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: gal@nvidia.com
CC: jacob.e.keller@intel.com
CC: sdf@fomichev.me
CC: kory.maincent@bootlin.com
---
 net/ethtool/common.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index e3052972f953..2b3847f00801 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -113,6 +113,13 @@ ethtool_nl_msg_needs_rtnl(const struct net_device *dev, u8 cmd)
 		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_SPAUSEPARAM;
 	case ETHTOOL_MSG_RSS_SET:
 		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_RSS;
+	case ETHTOOL_MSG_TSCONFIG_GET:
+	case ETHTOOL_MSG_TSCONFIG_SET:
+		/* tsconfig calls ndos (ndo_hwtstamp_set/get), not ethtool ops.
+		 * Also, there is no corresponding ethtool ioctl, therefore
+		 * these cases are Netlink-only.
+		 */
+		return true;
 	}
 	return false;
 }
-- 
2.54.0


