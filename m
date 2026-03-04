Return-Path: <netdev+bounces-263907-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GIAHyhdqGmZtgAAu9opvQ
	(envelope-from <netdev+bounces-263907-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:26:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D646C20434F
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E07CE31E6CA3
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 16:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB02A35E932;
	Wed,  4 Mar 2026 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VYr1MgHL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9774C35DA6B
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640048; cv=none; b=K98fMINg0x9Q27VkdruM+13JIk24Fm+wxxiE+ZQ9qriyAQvQwZbbITnwCuXCAf4/C4hGF68/miTL5dpFNpkgyLSuN20V0ZdlEVJrbJ5u0tbJ93Om/FIglkvJ/Nhe0Pz6tjxqlky/LGzQe4SZueQ08KkqLlivOVRPucMTR0XvEmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640048; c=relaxed/simple;
	bh=fJzhD58yHbnlYGX5HQnBg/2nPap4L8qe/YePr91l0MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZirawKjM5n+guj8XHXq9gtOy+Adv4L1XkdNoyggtZz3OreHKkeduh+vuQ0ozSN78U9zGGubA/WX9iZHvV4517zyPoiorPBoOCheb/+zj6TvbLGDmQi+fY8QPyF7a9tlz5ta7ABup5B82EPsfKG0UuHM2JuDEinWuwGd2MCcCbkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=VYr1MgHL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439a89b6fd0so3977478f8f.2
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 08:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772640045; x=1773244845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjTLWhKo8JnJx7lW+15uLvz3vRStk+3vuWmhHzoD9L0=;
        b=VYr1MgHLXxBk495ZOSZox6rKhRufJalFxAWBo44CdkCH0pQpBs0RmOST9oMY5hK5+G
         Mbr1yEpTP+6R9Jt1z9uQ3MuBg9WbOHmG6m51jx3CFMUnWsB6gPj6rqgCN8wpAdAeSJdv
         U+3obFIw33/doWVKBz2XrF5wX+JQddGt48/Fs8ee9cymRU/irTaQuWVjDKAgSyixyboC
         OKLUk54/jtPaojlpmjbwwUspoJaB2LzcXvRg1sGTYsgJ0MUSRVYtqtO+C+lg096/6PIB
         0vzVM28DUfLsn0iZi36nJ3hMokugZdlxeed8pNY2udkS2NW6f/Gm8zeL2NduE4Sqk0YW
         9Gog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772640045; x=1773244845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OjTLWhKo8JnJx7lW+15uLvz3vRStk+3vuWmhHzoD9L0=;
        b=ZN7i+ZNGen8dqvzxbyRg14EV2Go28i/DeQ9FmUe0Y/BEB+y4S160oKTUx2XFG4Ji2H
         AyVqaNpCW4xkF1dCvTvG9Hv1A1kt+neMDZcH4SknpGRSJ3ecHtmEhTfpS+jdAB7U7+Bq
         8s6vdMaJalj4GsZtYZNjnTDTxVO9ONXjF7BVFOjjmXzJ2r9PhvDeT9LV22sEZHugP9xs
         +eYaH3TrJKHnU/cYq3TY2ShL1MDk3uNdrGbwjU/Up8zLy3MWQQ9tXzw2IpwJqoKvg1BA
         EagNXx/MZ6Rmj+0hx9N0NAvAVS8fHNHBTg+URSYr+oDCtAiqO8aIYJth8ad4B/86F2yd
         pfEg==
X-Gm-Message-State: AOJu0YzZQdW4PVBAdpkW6qXX199UhNEYu8BOJFlFhNhqSk1tIR2PYaP9
	J8cBaIGaqLsXkk+6x1ypbzlmPrfrj3ueAKZqQJBLDmEq3EBCvbqciuL6yzVYHAv5ABGD0fYj0jS
	8QYxUiqo=
X-Gm-Gg: ATEYQzxP9QLP1CpeiUCRnX48DBBdFavIw/qDcmfF5iHwhp/x0+wh+IHT53znGHBy1m/
	gzHnHjAe4r7A+EZVmf3w+bGs4cg3llsa3cNlRwTTjhDMsPWr9GVu12qIbPfNWjM8WmsbfirHeYD
	ZatadJsECTc2q3Wx1rVhIgwYz7ApTP6yWiuh4iC/2WFanjLHEfQ834ugCFQLbbdKyNa4I/xxp3Z
	w8nHCB4rABfxsqTq7cobTkZJ0Luon9pVpW837S4F7WdM7FoNDHDB2Ac8ttHGoK9KFmBHIOi5R+N
	w3ExNoPTXljDGFqkv+Jo5LtwMT6PToNBhDWMprs65l8bbpklIj8cTw0bDC5G0C+Tjv54Ln23BSy
	llQqOES8Ym7bwmNoww3zHxiyEIdNrL6fjyDpCVCW3xt5SoDIQj/l+ikDggMYRI9pcm1X6CeVozK
	+qUfj4my8IPp8nlZ4UZqF+AGLLmGjmNCRN6AKtsBwfVC9dMQ==
X-Received: by 2002:a05:6000:26c2:b0:439:b541:a092 with SMTP id ffacd0b85a97d-439c7f99765mr5336210f8f.8.1772640039114;
        Wed, 04 Mar 2026 08:00:39 -0800 (PST)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439abdf5430sm33042796f8f.5.2026.03.04.08.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:00:38 -0800 (PST)
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
Subject: [PATCH net-next v3 06/13] devlink: support index-based notification filtering
Date: Wed,  4 Mar 2026 17:00:15 +0100
Message-ID: <20260304160022.6114-7-jiri@resnulli.us>
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
X-Rspamd-Queue-Id: D646C20434F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[resnulli.us];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263907-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,resnulli.us:mid,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Extend the notification filter descriptor with devlink_index so
that userspace can filter notifications by devlink instance index
in addition to bus_name/dev_name.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 net/devlink/devl_internal.h |  4 ++++
 net/devlink/netlink.c       | 11 ++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 395832ed4477..f0ebfb936770 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -205,6 +205,8 @@ struct devlink_obj_desc {
 	const char *dev_name;
 	unsigned int port_index;
 	bool port_index_valid;
+	unsigned int devlink_index;
+	bool devlink_index_valid;
 	long data[];
 };
 
@@ -214,6 +216,8 @@ static inline void devlink_nl_obj_desc_init(struct devlink_obj_desc *desc,
 	memset(desc, 0, sizeof(*desc));
 	desc->bus_name = devlink_bus_name(devlink);
 	desc->dev_name = devlink_dev_name(devlink);
+	desc->devlink_index = devlink->index;
+	desc->devlink_index_valid = true;
 }
 
 static inline void devlink_nl_obj_desc_port_set(struct devlink_obj_desc *desc,
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 5db931a0091c..1b00aa1dbcf5 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -73,13 +73,19 @@ int devlink_nl_notify_filter_set_doit(struct sk_buff *skb,
 		flt->dev_name = pos;
 	}
 
+	if (attrs[DEVLINK_ATTR_INDEX]) {
+		flt->devlink_index = nla_get_uint(attrs[DEVLINK_ATTR_INDEX]);
+		flt->devlink_index_valid = true;
+	}
+
 	if (attrs[DEVLINK_ATTR_PORT_INDEX]) {
 		flt->port_index = nla_get_u32(attrs[DEVLINK_ATTR_PORT_INDEX]);
 		flt->port_index_valid = true;
 	}
 
 	/* Don't attach empty filter. */
-	if (!flt->bus_name && !flt->dev_name && !flt->port_index_valid) {
+	if (!flt->bus_name && !flt->dev_name &&
+	    !flt->devlink_index_valid && !flt->port_index_valid) {
 		kfree(flt);
 		flt = NULL;
 	}
@@ -100,6 +106,9 @@ int devlink_nl_notify_filter_set_doit(struct sk_buff *skb,
 static bool devlink_obj_desc_match(const struct devlink_obj_desc *desc,
 				   const struct devlink_obj_desc *flt)
 {
+	if (desc->devlink_index_valid && flt->devlink_index_valid &&
+	    desc->devlink_index != flt->devlink_index)
+		return false;
 	if (desc->bus_name && flt->bus_name &&
 	    strcmp(desc->bus_name, flt->bus_name))
 		return false;
-- 
2.51.1


