Return-Path: <netdev+bounces-263901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJBtFYhZqGlxtgAAu9opvQ
	(envelope-from <netdev+bounces-263901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:10:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3730E203DA1
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E53A30C2D13
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 16:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C463F351C1F;
	Wed,  4 Mar 2026 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="HKgeK19B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B379234FF5A
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640033; cv=none; b=ryJgg9mnZ5Qw9R/KP0bcMr1uV+nu/afcGNrjaliKRGXOFjZ+VGYNINn3ri/Fmany/n692M0qncS/ska2g7LUToSw9CR3A5EquwbrOSptm1Kjv0otoAyC5+v5fRKoyT/rIwVO1mLuvkYSLK55JUtg8+P2NBMyNZXFh97TGsRf7cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640033; c=relaxed/simple;
	bh=Vtm80qE6FuR56bwzyqwTxutZyqLSGPZTe2b3PkwM178=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cj9PZTb5sQQQPU/FCAnKu19Bw/+QrKdLZiXVZ3MJ1TYpGHh5L674Kl5jRVUgg03sd/u5jry1L4DBUi3egGtud4EmPsXJbqJIrC/PHfODJfUun+RK0xNvEoQHzKlOXWba0FQnpxu/O6wlUi6NeA31bEZuVMRF6Bc7EiJv03pzuYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=HKgeK19B; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-483a2338616so44247275e9.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 08:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772640030; x=1773244830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEWuug6YBMXUGRBONZQ2DbkIBf5q1GxD8BXyAd3vMMw=;
        b=HKgeK19BNnN/xfBdG3TeGtmGL4/I6csuNySXiK2cvgGVrlXff2jFACmEtRqt1l/BkT
         QS8uWnklsDMoiQGl9zO7SZwouW09GKKmMpK346Hlh5FEVTSNPBKXJ6jfQX15eXo1TdRF
         qlVD3h9UmKOPLDS//iY+ytByE8MGw49FZJ0V0I0NzZ1BCn2jCs591b0RE/Xpp3PoKF8s
         azTOhDeI7RpNIvy6vt/0kOKU8R7hgiFVSrd+0v6JuY2LYxG0CGCXMVcyGIdRmjW52VlM
         4zNYfYKPVl2jeoGMmQvDQRvR4toe5Z0JohC8zilCe0XoTEYzmcCm5+YF44VzPCPnLl7f
         dLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772640030; x=1773244830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HEWuug6YBMXUGRBONZQ2DbkIBf5q1GxD8BXyAd3vMMw=;
        b=WuuZWYVmlnHxHzccEadm6I/Lhyog1xdKZb3c0F/zqkp4BomoYw9mqTcRx4wRdLMaIk
         9dV1NclSKCoT00I5TJo68XQKhDpwgaNg1UQYMOAO3nDmPrkOTpI2Zf8+NMBF5U2VYuCd
         nw69xgnXD+zi2WnE0JpFuhVjZRo1VRTKcaGhcHROnWzfRV7ciqsCtpXp6PBKM25iV1B2
         2CqPVhzoMXKLA389RKasZb4U0CWcBePIr2Sgl1nH/ms/8fexQylJjroQkeEOgRVynevk
         E10aDiNsqww8PAtHCLD+NuZiCjN5FATXWe0uIQZDT+QQoYDx584ESX3p8zoX107PJZ2t
         0epQ==
X-Gm-Message-State: AOJu0YzRzaV7gPM5Ai+Wd5GqjKP8b8KrsbOSkfyjOlub8uccUTlsLifq
	S5rpP2RagFC30u4fGczIKqLMBnOzI9bZNV09WqHNJMD0ouzFtItfZWjeB0IXUyw3Z8xShD21HW3
	kn3809uA=
X-Gm-Gg: ATEYQzwwzjKem0SBfxwLrWCYrgL85t/jlJUNqnKflfQb1zodDMZpm3kO1i3iiAj6ur2
	NKVfgc1+sm8JoyxX/YOc47t9TWNQfiqE91dTR+rZhMC29ZUeicnjMFW1IsM7nteLlu91YFu0zkQ
	DqYDBcUB69lExSmn3YQP53ZMze4ciwgTfg4PxdMYQfsF4oXV1xKHL3el0HrxrOHKE9BVfeHvEcj
	J6iy1YsldZxmhyAgurBGZtcYBWCPswbEWqysMrqm1uOrgmScVukuWDzuGiZG2wdnUJRo4BmADWT
	PooU8w0eqouEseGFGvvyWPjChec9x9X+BBfN9Fu4P+EXV6UqK45zQSNH/fYVCR7UR91mR5opdMN
	Pzeuhl0dz5QzZWiyxNCpAju9dcSYZOpicdswBM57QK/Igs9nW6TddQjVOgAwMmozly1nRSPoj/+
	RqILqZAGFZjKQ4KzVxEFy5C9n8VJWyBqrdg0m7g+P7owZEBg==
X-Received: by 2002:a05:600c:1c21:b0:483:71f7:2794 with SMTP id 5b1f17b1804b1-48519866866mr45713755e9.15.1772640030032;
        Wed, 04 Mar 2026 08:00:30 -0800 (PST)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485187ced3bsm56749265e9.8.2026.03.04.08.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:00:29 -0800 (PST)
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
Subject: [PATCH net-next v3 03/13] devlink: avoid extra iterations when found devlink is not registered
Date: Wed,  4 Mar 2026 17:00:12 +0100
Message-ID: <20260304160022.6114-4-jiri@resnulli.us>
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
X-Rspamd-Queue-Id: 3730E203DA1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[resnulli.us];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263901-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
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
index 56817b85a3f9..7b205f677b7a 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -194,16 +194,20 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
 		if (strcmp(devlink_bus_name(devlink), busname) == 0 &&
-		    strcmp(devlink_dev_name(devlink), devname) == 0) {
-			devl_dev_lock(devlink, dev_lock);
-			if (devl_is_registered(devlink))
-				return devlink;
-			devl_dev_unlock(devlink, dev_lock);
-		}
+		    strcmp(devlink_dev_name(devlink), devname) == 0)
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


