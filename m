Return-Path: <netdev+bounces-260063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKOkBltrnGnrGAQAu9opvQ
	(envelope-from <netdev+bounces-260063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:59:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ED9178588
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21F9D305AC95
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AE8261B9E;
	Mon, 23 Feb 2026 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="2SijwTgU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DC145BE3
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858564; cv=none; b=N0bHivvKIsuBQ3sfSErNSsoAi05OZhbB1iXBX7uvksfJqSN9vGBpVgqEnpfuQrLvPQ29AxbqrfTkn6FDIDOofgTZxmJu0O6RLST2YVn9umfaYoz6GWH9mY8Pfkpvp0y+ZflxTdobKKH5XB5RamIKV6qmZ73BrnaSRQ/4JSerlVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858564; c=relaxed/simple;
	bh=Uit1Ti7AU3XxeFhawNvwoDfVMeh6nJo+iBe3Dbimg88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AsUr3w446muj0JbEnBBTwexoijCYNTglasBpKcxcKlpzHiAmJO0QNG8DG/TAIJbTeugEXO/Jp2pPNv99x84wi9yOtbZfhpKR8UpTB+dW1kTb4QI289R6rMFe7t4eTnAoy6toTGYqL+UXYdMxLfBUTbgSmgzCpsmiFp5uivrQJE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=2SijwTgU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so55351485e9.2
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 06:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1771858560; x=1772463360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9KLhKGx9RzUBsWoWUkwA/+vgETenzM1WQ8j317w0fU=;
        b=2SijwTgU7Kya0ofDEED/9Xh6CM2Gy1tkyV0kdAkJJferqWO278nrVZ9Y5MDxIow4hY
         iCa6mvqTbf7czfpVqk3JoJox5u5APBENUaod70JbNl7JX9weBCYhLJ6Sx5WeA07lT1zs
         zRhP/mmQwRAsEfmjMpCyZpQQEQNW6BFDmv6iXtEDm6PkiQxudAqGzN596Gug0hRNlJ7/
         6h3RH2MpawpHW3Ux0Yumj2n3ktRReiYQSV3mlrz8xMoDJneFJIzJrUu5b0j3IUs9skDM
         dGgBarT87FYhqbeZq5W91ZNwl28UM1lzfNy5YivFu1clMi9gIsJziHOjCDbvNF5tg/YH
         zRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771858560; x=1772463360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d9KLhKGx9RzUBsWoWUkwA/+vgETenzM1WQ8j317w0fU=;
        b=axdqljlBX+DyZOeO5paxDYJJxWGcM64u+9GrZhom3TOLCWZ9NcMsaS4k52MrBjOiNL
         2DBC/sI6NoYY/p7l9ZOFIbXeuC1hVO1RqaQxK6QjoijjYUU9PLMSvXfXVm/TmSaLROpn
         v4A+gIzHOIX3/xQvfOdlu/fJfscsdH2WKZLYT57Ki88PjoqcQ7pWJM7R51tPdUvGFRXH
         i7LVXEPUzt41g9YM5LC4gdmF/RuV/sH2IupOQh5uV5mBTiLtHFzxx+6Ks8OiAnDUQ+d7
         S9zuAuuOpmuvm3PEq4QVSAxe0T35Cdq3SwiEfGvOWV0QP091CveF8+0nHOHDDag4LtjG
         RZfg==
X-Gm-Message-State: AOJu0YzsrRAUAQ0e7M/Ik0+BvZticgLeSfjt6qX64sQcUZu8C/girgi7
	OIBdjJpPNh5aocmjUZ6rP29iyzgdUlYjdgOPpAwV8mHaNR4Pnfd9hplc8L9emUThPRtzFexox0X
	qujvJ
X-Gm-Gg: AZuq6aLwoH+E2WE0uVngwaH5ISBhKr0wNATpny9A4RDr/Rk/9f3G4RqsyGwhIFHq6Wr
	DLHkGi/AAinQwKAxCJb6qeCvqjQjKc7hdalnIemXUc60Bcd49m7U3lGSb9OccSbyFHgCdvScAvK
	XkKxuxKcMIvOK1+jmgfOakkyAQK5EPi/Yba2JyYHGmLVRFZiKJOlPmvT2G5SmmWE2xvQDgw7SB1
	noY5wHmXD32hHnaSDeBogqQA3waJWNHigHL1SlDxRpsNcROX3UBZEK25Lav7P/XCcKlwZcJO2ZX
	vnHFP2aB6ocPexW5L97ETZPY34Zsz7eRDNRaTcDqTO7M22RnYYL5Z5R4ZA0GNUiAohCYvdcTHoU
	O3WdM8tilmgFRKw/ywhpOwth0LAFB/mqZvAf0gas0SMZO/kgDgjBeCr13XO0P2sEemqzunRdfJ8
	SuUP2ESUV0k9iW8w==
X-Received: by 2002:a05:600c:c167:b0:480:3a72:524a with SMTP id 5b1f17b1804b1-483a95e9643mr119569985e9.19.1771858559736;
        Mon, 23 Feb 2026 06:55:59 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a4e869a3sm167488895e9.1.2026.02.23.06.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:55:59 -0800 (PST)
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
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next 01/10] devlink: expose devlink instance index over netlink
Date: Mon, 23 Feb 2026 15:55:48 +0100
Message-ID: <20260223145557.248679-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260223145557.248679-1-jiri@resnulli.us>
References: <20260223145557.248679-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260063-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 76ED9178588
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


