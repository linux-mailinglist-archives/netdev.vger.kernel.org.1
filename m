Return-Path: <netdev+bounces-260945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iN6MJaf6nmm+YAQAu9opvQ
	(envelope-from <netdev+bounces-260945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:35:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEFC198263
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 545ED3078FB0
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FFE3B9600;
	Wed, 25 Feb 2026 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="YejnM16x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DFE39281E
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026470; cv=none; b=UMAHVxpZBN9SDqFmY092SNlAVB4m0l9xZkSetRxe4xuNk/GL6a/Sso7U2Slds/TlLSXz9F8OISf4CaGkSuIG9cIO10ZDfrgIIH6/cY4IkeA5vgbbht82wyYqIT70is4KFI37z+kTie1JlM+aHS/s1Ax/X/Vr65nMwMGnmHQC6Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026470; c=relaxed/simple;
	bh=PABzC/qYg8Go3kt1GXod1fs3aKuZpPfkbvp4LZZhDPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwuN1ujq24dVZYv1vozXcviPlE675kr++mJM2P16Hl/XGC7JBcT5Om+B8ii4MbAf60IIDKnXmuvAKEmxD6XjnLoG1ps0NnepLeafaa9D9ZLjYZwPbgr63f/RmcmIEuGwXyba2VTju4vfKdTXVJXXJ21ZArA4VizN+GYnGpft0mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=YejnM16x; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-480706554beso79342345e9.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 05:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772026468; x=1772631268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWhrdo13vFR8MpiWqGIUlMw11zaKiApxbVw47NJoYB0=;
        b=YejnM16xnGU2GKt/KJgJ2dVqhRyS7HDZAizyT2sZHwOUi400ShfwOlv70+hLTHTb0D
         HODTMfMp7yb4lK3hbV0cxnIyW2Z+uBOYiZZn7o3kOGp8HJBt2BLEeKrxuNIJzHqDJX8J
         4nMjzkXVjmAOVJcRGJyVN9chfknHG/sksb1Z9kf6u61FXousetYPthuYXUtAawYGWSfL
         ykcDh5RbPGNnCZCPWprHlq2UlJAhW7SIxBpbngZ4MbAL/05ch1PY3NmP2/ua4aPoxMOf
         qeTWXqDNL61U5db9qiWg6649HeJqmJmuLi74w86ZeZj2lvXokMBvLJdk2NyD91wTW+N3
         aVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772026468; x=1772631268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GWhrdo13vFR8MpiWqGIUlMw11zaKiApxbVw47NJoYB0=;
        b=ubdQivA5Pp0rzJHE3fkPCWYA4IM3TvZTUqpvXMSl/Kocp5rnPLGLhoGwrDSlvTXsCs
         /eNi1a6l/9ya/Lz3Ri4NkcE9Xy3rB2Iq0G8fhlBm9ugIB1y9m4JGsi+IMnThGcHkLnx/
         QWDrxRlo4ACD2Qtl4k5+zhP5o36k0Qro8i3iZkpilVP221o4rOTXtuiSTH8tXOn4QzoT
         TyNu/CUkjcnWup86xBkgXJOs3Ywqug0XMkIwA4RK/Un/g9PCNrcaJK9cTNhdLrItQIs/
         evk8+E4uU6o7yC6t5QvDFtzPsqISy+sF+vHtEm4dWClNbyyW3YtICfW+IxF1Kg5yq00Y
         tYcg==
X-Gm-Message-State: AOJu0Yzae5Sp0DQlZkNok2FTClgYItrEeDngTRqRylWPlM5mCEBPocBV
	kXiAZ/WpvgZMiGouGtBtZiW0hZYzvIz4D8iDWXrYssMoDf8c7mpnYEB1oItrVaAU8xGsGU83jdM
	QsV1+
X-Gm-Gg: ATEYQzxovdIY/vU8TtsMpaQuE+XcHl0G5mb5O6d14UZ8UKaERsABLZ6YGPPtMVrDjeJ
	UBFkOwWBXKfqzwgeoiM/Lbm6Axqqjyd0K7xHurwhMryTXPjhvKPFHdKnMHZuS3HZOtik1kZh5O7
	hyG82akaSmofBVoM4+FwoY+3VSwVqJiltUT1okzgvNAg6DcueXx3EOi7cmSXPnbpIKr+hBw9/iW
	NTB0M3yckwxK/L9L93VMv6Z7TLUzI/umlA/0jq0qfDDoIcdQueL+DE6kDqEZq34bvnrfLeAv4Zt
	ugdBIjBkP/YApFn2N+FcYwzQiyxcmZ5mIiYC7TrSpnh9eZKmk2Ltg6QVrMF+pWcXb84ZPN0Renb
	cJDJDbFbWKqd0OnQ4Tua8aN4AfNywK06/k3UtRkDqB0OHRbLBvz+X85+k+jb0wLAp4CMMkpvhNf
	glXOdIYgqd4a8ycw==
X-Received: by 2002:a05:600c:45c5:b0:483:afbb:a077 with SMTP id 5b1f17b1804b1-483c216a9f6mr9402805e9.1.1772026467742;
        Wed, 25 Feb 2026 05:34:27 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd732eb1sm71670605e9.12.2026.02.25.05.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:34:27 -0800 (PST)
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
Subject: [PATCH net-next v2 03/10] devlink: avoid extra iterations when found devlink is not registered
Date: Wed, 25 Feb 2026 14:34:15 +0100
Message-ID: <20260225133422.290965-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260225133422.290965-1-jiri@resnulli.us>
References: <20260225133422.290965-1-jiri@resnulli.us>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[resnulli.us];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260945-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.974];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 4DEFC198263
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Since the one found is not registered, very unlikely another one with
the same bus_name/dev_name is going to be found. Stop right away and
prepare common "found" path for the follow-up patch.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/netlink.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 3f73ced2d879..a517d42c7b96 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -194,16 +194,20 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
 		if (strcmp(devlink->bus_name, busname) == 0 &&
-		    strcmp(devlink->dev_name, devname) == 0) {
-			devl_dev_lock(devlink, dev_lock);
-			if (devl_is_registered(devlink))
-				return devlink;
-			devl_dev_unlock(devlink, dev_lock);
-		}
+		    strcmp(devlink->dev_name, devname) == 0)
+			goto found;
 		devlink_put(devlink);
 	}
 
 	return ERR_PTR(-ENODEV);
+
+found:
+	devl_dev_lock(devlink, dev_lock);
+	if (devl_is_registered(devlink))
+		return devlink;
+	devl_dev_unlock(devlink, dev_lock);
+	devlink_put(devlink);
+	return ERR_PTR(-ENODEV);
 }
 
 static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
-- 
2.51.1


