Return-Path: <netdev+bounces-260068-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNkGOK5rnGnrGAQAu9opvQ
	(envelope-from <netdev+bounces-260068-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:01:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5F31785DD
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 459D630FEE7B
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224E8263F34;
	Mon, 23 Feb 2026 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="C75i9MoD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCFB25DD1E
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858570; cv=none; b=Gl82N2V/MslaI59X1tznXvyCbwIOrDVxs/UW+vCQmqHgucZyg16qaT/Dn2WJb+DCooVYOxTFpUCEptj55BtlQd99B1BycwcBJs0y39OQIY1BMz5jp4zZjlitar/UdtY2RcmnOOFNLUGrP6NOjTe1IaMHHDHXVmuX38lzh4U9RUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858570; c=relaxed/simple;
	bh=p6oayIVm7ByjhEoojO0fCsQFWrixjjZqNMs8oCX3cP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTnzQIND07hpBXdJf1DESkyHdsr83AmCP3jQGcRxP+mXhGgSBiGpOPjf8Iwb0BozVO7wSvjtfV9qJ2cMMm5iDo2/RCJw3vHoldZTJ/ssND4TMxMuKYp7X5vEAkVg/NBvie+fPmay8yiEtPuH+RSHySC+i9dVbH2o0FU6miHxhvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=C75i9MoD; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43590777e22so2694545f8f.3
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 06:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1771858567; x=1772463367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBu9rmyeuieU7Xwg/HqKMSkvq4IL+Apc0aC/bV1doPw=;
        b=C75i9MoD8i9ewMQCrAFSfXYpaPvuklH6hrEstKkZMMD0iuBXsOoaWHovnrsXh6tLKe
         NpVxGTIDlMC/JB1yxLoKZ1YwSWhx427QmHsYYqk8pyZf0cP7FAArqZo+EdBn2M2fow2M
         /LEPXQ4ll9NRtuxJy5+bAZ8P2JkabdEnjLt0uJSSXHGqLjrhYgqLrIB49YsGYD8mBV9l
         e9y+NcbNjO1AhWMK88omb8yHutBmHmYmPOon5ALy7Dl8/9PI+/nw1exB+GP1qQ7W/tl9
         j4mlTJYEcbcr2JJjxWKGGEsu/uY6TTbCSNS6GsYurpxwVl5qsXxPB8muSQgSRKUlKnwc
         FFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771858567; x=1772463367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nBu9rmyeuieU7Xwg/HqKMSkvq4IL+Apc0aC/bV1doPw=;
        b=Zlru29HQIzZqL8aQWKbhi1bD6bA9oxCOVtL/JdRwEwUwGiJIgqVzoQ8NUB7YQqFoTs
         HAPYCpttdSk5O9nxeDyMiMKCJw6rpGBMYrdnyGdsMsteHugQRNz9DdwXe89TtpIPVUbQ
         7YJuZ+hTOui0cFBEOJWvBuZMtgkOXoZpW6+2b3DaY98OEN/RLP6Jv1unobphxzDjo4IS
         yf2PrjrRRZRVkskwgnpOjNoGIrD/ttBRdEMK86Tphz2V0SYi5CC5Nfzz4v4PS3gwldy4
         fuy3ky7vAfg+ljToq2XYGT/b6W6+EdP1dnk9TGakNNwM2jdtQC6VHxi6lbqLvbfDrB2e
         OMcA==
X-Gm-Message-State: AOJu0YyKzE8fbzwQgO4UG8ipOiWaoKpnVNxjxEB2LaGpf1Jx7qxHya2n
	ki4VJ5RvNh+jGco6OAPxoW3+mr3sbV14UO9JXziCuqNebJ1z9h+QY+By2QS7GNgT9cupXRNEa6K
	cF15l
X-Gm-Gg: ATEYQzyoECP2nX1n1ljOq+mPh/eg89F1R9r9ASlLIjcgS31hC6lc+2hPks1EEB64njE
	Ec0IEqXue7tHtMjAtMh51qGjf+egZDzww4ZIBzlMp9VNb53cxWuMOQJYWC/uoPBgVuPnlgtqCsx
	kKhHLECeJUJ4Khf8IO8RYZYNWLq5i64JC+FGmT5J9AhR20kA/xNKMy8qG/nqiNPxgr1JRw/A5J5
	Dcm1Bv6R5SjY0FAWu0ALxk5Yw7ux8ZNmgFGBSNRFRgGMM5J3ZMAEWK9j594Uc4/Xyx9zL8ThSyc
	iqWw6dYaz6KrNV6dsGroUo+z7LVo+iBG7aKX5s9Z/wwkoTflf/TOxVthhamJJ/8OBmiMgE1u9Dp
	ZMDCqHpdx4trXiFIDrncxF8s7qHc81byXyaFRe16MfT5x1WZRrdxaioj9NUkP4PL1sFg8F/bM5Z
	b0tbO5rxmvSZQXyA==
X-Received: by 2002:a5d:64e5:0:b0:437:675d:7620 with SMTP id ffacd0b85a97d-4396f17b264mr15741874f8f.35.1771858566868;
        Mon, 23 Feb 2026 06:56:06 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bfa001sm20995741f8f.2.2026.02.23.06.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:56:06 -0800 (PST)
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
Subject: [PATCH net-next 06/10] devlink: add devlink_dev_driver_name() helper and use it in trace events
Date: Mon, 23 Feb 2026 15:55:53 +0100
Message-ID: <20260223145557.248679-7-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260068-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,resnulli.us:mid,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 4B5F31785DD
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

In preparation to dev-less devlinks, add devlink_dev_driver_name()
that safely returns the driver name or NULL, and use it in all trace
events. The trace __string() macro handles NULL via __string_src(),
recording "(null)".

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/net/devlink.h          |  1 +
 include/trace/events/devlink.h | 12 ++++++------
 net/devlink/core.c             |  7 +++++++
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 0afb0958b910..45dec7067a8e 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1613,6 +1613,7 @@ struct devlink *priv_to_devlink(void *priv);
 struct device *devlink_to_dev(const struct devlink *devlink);
 const char *devlink_bus_name(const struct devlink *devlink);
 const char *devlink_dev_name(const struct devlink *devlink);
+const char *devlink_dev_driver_name(const struct devlink *devlink);
 
 /* Devlink instance explicit locking */
 void devl_lock(struct devlink *devlink);
diff --git a/include/trace/events/devlink.h b/include/trace/events/devlink.h
index 32304ce9ad15..4f8edf77dfbe 100644
--- a/include/trace/events/devlink.h
+++ b/include/trace/events/devlink.h
@@ -23,7 +23,7 @@ TRACE_EVENT(devlink_hwmsg,
 	TP_STRUCT__entry(
 		__string(bus_name, devlink_bus_name(devlink))
 		__string(dev_name, devlink_dev_name(devlink))
-		__string(driver_name, devlink_to_dev(devlink)->driver->name)
+		__string(driver_name, devlink_dev_driver_name(devlink))
 		__field(bool, incoming)
 		__field(unsigned long, type)
 		__dynamic_array(u8, buf, len)
@@ -57,7 +57,7 @@ TRACE_EVENT(devlink_hwerr,
 	TP_STRUCT__entry(
 		__string(bus_name, devlink_bus_name(devlink))
 		__string(dev_name, devlink_dev_name(devlink))
-		__string(driver_name, devlink_to_dev(devlink)->driver->name)
+		__string(driver_name, devlink_dev_driver_name(devlink))
 		__field(int, err)
 		__string(msg, msg)
 		),
@@ -87,7 +87,7 @@ TRACE_EVENT(devlink_health_report,
 	TP_STRUCT__entry(
 		__string(bus_name, devlink_bus_name(devlink))
 		__string(dev_name, devlink_dev_name(devlink))
-		__string(driver_name, devlink_to_dev(devlink)->driver->name)
+		__string(driver_name, devlink_dev_driver_name(devlink))
 		__string(reporter_name, reporter_name)
 		__string(msg, msg)
 	),
@@ -118,7 +118,7 @@ TRACE_EVENT(devlink_health_recover_aborted,
 	TP_STRUCT__entry(
 		__string(bus_name, devlink_bus_name(devlink))
 		__string(dev_name, devlink_dev_name(devlink))
-		__string(driver_name, devlink_to_dev(devlink)->driver->name)
+		__string(driver_name, devlink_dev_driver_name(devlink))
 		__string(reporter_name, reporter_name)
 		__field(bool, health_state)
 		__field(u64, time_since_last_recover)
@@ -152,7 +152,7 @@ TRACE_EVENT(devlink_health_reporter_state_update,
 	TP_STRUCT__entry(
 		__string(bus_name, devlink_bus_name(devlink))
 		__string(dev_name, devlink_dev_name(devlink))
-		__string(driver_name, devlink_to_dev(devlink)->driver->name)
+		__string(driver_name, devlink_dev_driver_name(devlink))
 		__string(reporter_name, reporter_name)
 		__field(u8, new_state)
 	),
@@ -183,7 +183,7 @@ TRACE_EVENT(devlink_trap_report,
 	TP_STRUCT__entry(
 		__string(bus_name, devlink_bus_name(devlink))
 		__string(dev_name, devlink_dev_name(devlink))
-		__string(driver_name, devlink_to_dev(devlink)->driver->name)
+		__string(driver_name, devlink_dev_driver_name(devlink))
 		__string(trap_name, metadata->trap_name)
 		__string(trap_group_name, metadata->trap_group_name)
 		__array(char, input_dev_name, IFNAMSIZ)
diff --git a/net/devlink/core.c b/net/devlink/core.c
index 2dd6d45bec18..85e83a3b082a 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -260,6 +260,13 @@ const char *devlink_dev_name(const struct devlink *devlink)
 }
 EXPORT_SYMBOL_GPL(devlink_dev_name);
 
+const char *devlink_dev_driver_name(const struct devlink *devlink)
+{
+	struct device *dev = devlink->dev;
+
+	return dev ? dev->driver->name : NULL;
+}
+
 struct net *devlink_net(const struct devlink *devlink)
 {
 	return read_pnet(&devlink->_net);
-- 
2.51.1


