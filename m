Return-Path: <netdev+bounces-263898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCRNFHVZqGlxtgAAu9opvQ
	(envelope-from <netdev+bounces-263898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:10:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B42203D63
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8EC4E3052B9E
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 16:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E001C34D91F;
	Wed,  4 Mar 2026 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xpNtugTn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528D4EACE
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640030; cv=none; b=JjRaS9C7g5s/FgJKMtYzMN5EemAm+labVN7dCKfA9eIVC5kQoqwGEpFqZFZ83NlS8h3AXhSp3bTs+d6vsldH+xT1Bw9JnMEncTYZ9TTqTRAVfyiJIJgIeAxp0labHLXGX0CNEaNye9cwXd2Pim12Eqjq2VAbW8GDgoXZE972M4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640030; c=relaxed/simple;
	bh=Uit1Ti7AU3XxeFhawNvwoDfVMeh6nJo+iBe3Dbimg88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjLal5mBjJbP8WZgz/L+sYTmRnpJjR03kR7DcBI/8hBHIhZguPj9Frh0VdAklwqvJcuj64LCyoqHkVp2rAI/Vl6o3HqyB3BC+rbp1Z1ClGJxjV72o2zAdm7trzOu1dc3N9HpQamAS5iTrGVN4fehXr8jgr5Fxxsbixa6Rw7/A1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xpNtugTn; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439c5cce2c6so1095621f8f.3
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 08:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772640027; x=1773244827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9KLhKGx9RzUBsWoWUkwA/+vgETenzM1WQ8j317w0fU=;
        b=xpNtugTn5UkhZ0Lnj1qvpN3/EWbSA+Q7NtWSKHhiGKB85+u05ycJt2AN9tUrhAORh7
         hW+ribiQId7X1OKVlILOHPPh4w/TmVWNbsisyRB6ffJ34Vzazuplk05LwzGI7PNAcl5U
         a+zA90aBV1Dozsn2xQ19lB4SEP4M+3LvWhRAskqdlKCT2/49kNdf0633Cpkg/jpF7ntD
         SArn97nrknD8YfUqpQzAEJI/sgPJuRxXcFyCg3EPGuM0NLApF2sp1c/MBKdGMse3WcGY
         E/WNZK7o9QAXHrQMSZeTupaT9WPkuOs4CHpV8+2NziKLbUHnurL7UZwLXH1a6c2g1kH6
         9Cbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772640027; x=1773244827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d9KLhKGx9RzUBsWoWUkwA/+vgETenzM1WQ8j317w0fU=;
        b=G6NcxfZbD7KbOKXHf40Bc6hYSfyFBMDD9TFuIhFfieN40MJhepQ6LRk2i0dvjIG1tr
         CtTyJ+v1kAuFkoDqbJDjjMiDU4WosrvWxFILPXwgsQOXLQuJ0mWoVgsKyn2nmiN996Rb
         wp5mi5xg3NrcstcSaRsg1nMzYbgCN0eTIVyq58/tsKwjFz06/Ms0ofLIrd5s6vuN4mh9
         +SjtbfJchNHvDmv/UDZvjnxbcShZbehShgpVB0e2m85xvOPeVe2z2EnHeb1SFnxLktdp
         8+r3qzCSefPM5k0IbmQZr/SY3/wACIce93EQRY/ex7HqAsh7uPypUoSiNuXd4GJXqFge
         q4Ag==
X-Gm-Message-State: AOJu0YwQ0sX85h+lm+dH5Haojh6O3gk3avWuImOy7w4RQm/zjKvKH8RO
	6G5gNdxRURxWfVt9RPVfk7PO7aohy9aTinpCdaQpWr+V6G//GGFq/ZFEZBHp8YsWY80nC8H8YSY
	il0SkPcU=
X-Gm-Gg: ATEYQzys8VTKOYerS5yKcPKGFOf9/3tfbQcAi4NyRVSJipqW8pPKk9bDSdgLuxbh37g
	1KwCN9kA+px03Rof580fRxvCmueqWara+Zdh3pad3vwSKqabP8LcECakYzJet33TRL96tRpP9tb
	tEYcSC7EQAtS7XJvN6XZI72phFzEhlSaspyZe4EiNBgnBzTufycmXHt0bypnNCQsz95TCQdeZ15
	VgRWdZ9vZLrFOH8RMQZgbMVLmhj/jdb6trEEUln4kl7+00acZ9yTr/u29zNLc5o+QHUytcjkecL
	AhR3B4KAkdiKPereGz9uGNv2hLgTEIxRaspIolGc+DoA0b6+UmEHzwkD8zHbjG1IjsPOQL3bWje
	EKkvb/1++oSzlA0w/ZrhdFgprs4yIVESJpoOQtpIWsG0+Zr4ZO/4D41HMD/AwMQNgpjd9Yq4sIq
	sbIYZLa3dGegJeHJXcoT36ujbIQydaEig7g0Kb/gzJRRa9+GBFvma8lEgJ
X-Received: by 2002:a05:6000:4006:b0:439:c279:32e9 with SMTP id ffacd0b85a97d-439c7fe3d7cmr4503831f8f.39.1772640026687;
        Wed, 04 Mar 2026 08:00:26 -0800 (PST)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b485a0b6sm27629409f8f.39.2026.03.04.08.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:00:25 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	przemyslaw.kitszel@intel.com,
	mschmidt@redhat.com,
	andrew+netdev@lunn.ch,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	chuck.lever@oracle.com,
	matttbe@kernel.org,
	cjubran@nvidia.com,
	daniel.zahka@gmail.com,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH net-next v3 01/13] devlink: expose devlink instance index over netlink
Date: Wed,  4 Mar 2026 17:00:10 +0100
Message-ID: <20260304160022.6114-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260304160022.6114-1-jiri@resnulli.us>
References: <20260304160022.6114-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A0B42203D63
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[resnulli.us];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263898-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,resnulli-us.20230601.gappssmtp.com:dkim,resnulli.us:mid]
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Each devlink instance has an internally assigned index used for xarray
storage. Expose it as a new DEVLINK_ATTR_INDEX uint attribute alongside
the existing bus_name and dev_name handle.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 5 +++++
 include/uapi/linux/devlink.h             | 2 ++
 net/devlink/devl_internal.h              | 2 ++
 net/devlink/port.c                       | 1 +
 4 files changed, 10 insertions(+)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 837112da6738..1bed67a0eefb 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -867,6 +867,10 @@ attribute-sets:
         type: flag
         doc: Request restoring parameter to its default value.
         value: 183
+      -
+        name: index
+        type: uint
+        doc: Unique devlink instance index.
   -
     name: dl-dev-stats
     subset-of: devlink
@@ -1311,6 +1315,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - reload-failed
             - dev-stats
       dump:
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index e7d6b6d13470..1ba3436db4ae 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -642,6 +642,8 @@ enum devlink_attr {
 	DEVLINK_ATTR_PARAM_VALUE_DEFAULT,	/* dynamic */
 	DEVLINK_ATTR_PARAM_RESET_DEFAULT,	/* flag */
 
+	DEVLINK_ATTR_INDEX,			/* uint */
+
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
 	 * net/devlink/netlink_gen.c.
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 1377864383bc..31fa98af418e 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -178,6 +178,8 @@ devlink_nl_put_handle(struct sk_buff *msg, struct devlink *devlink)
 		return -EMSGSIZE;
 	if (nla_put_string(msg, DEVLINK_ATTR_DEV_NAME, dev_name(devlink->dev)))
 		return -EMSGSIZE;
+	if (nla_put_uint(msg, DEVLINK_ATTR_INDEX, devlink->index))
+		return -EMSGSIZE;
 	return 0;
 }
 
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 93d8a25bb920..1ff609571ea4 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -222,6 +222,7 @@ size_t devlink_nl_port_handle_size(struct devlink_port *devlink_port)
 
 	return nla_total_size(strlen(devlink->dev->bus->name) + 1) /* DEVLINK_ATTR_BUS_NAME */
 	     + nla_total_size(strlen(dev_name(devlink->dev)) + 1) /* DEVLINK_ATTR_DEV_NAME */
+	     + nla_total_size(8) /* DEVLINK_ATTR_INDEX */
 	     + nla_total_size(4); /* DEVLINK_ATTR_PORT_INDEX */
 }
 
-- 
2.51.1


