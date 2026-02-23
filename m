Return-Path: <netdev+bounces-260066-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uImiII9rnGnrGAQAu9opvQ
	(envelope-from <netdev+bounces-260066-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:00:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F32B1785AE
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10A6A317FF67
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9434A267B89;
	Mon, 23 Feb 2026 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="kVHQ73Ua"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235FC26982C
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858566; cv=none; b=g+74ey6F9afnFi1kZpo1qu54TYhTUescpuVZW4l8S55bBdtnrDBLHa/FxRlKUyDsi6jKtlbblIvM9OMdr6v/0uJ2rEwFfJLOqRJoXcJkZxL3f+37HI0z3ukrOzoQr/LJB1Ii1d/tt4+XCV7yGZt0x5Ai8wps9OnCZnsReGe1bc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858566; c=relaxed/simple;
	bh=PABzC/qYg8Go3kt1GXod1fs3aKuZpPfkbvp4LZZhDPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qn/8Iz20sd0BONcSrzUZvO7IpZiq79vy/wMk3pWbvbZ/k27JK5J7WGZuDfFpd2QmzfeUDGMwqcmRmMMKMPg4ytd9gGjO4h93o44ySyNCupLXQ+ozWQYq03LWZHIIZIyVgOeB6pU9e4xMrdFB8hdjzAp4U36AmRCMMWp/slPVE1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=kVHQ73Ua; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4377174e1ebso3389748f8f.3
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 06:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1771858563; x=1772463363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWhrdo13vFR8MpiWqGIUlMw11zaKiApxbVw47NJoYB0=;
        b=kVHQ73UaWTeOzgSuI66AbBQe3amAcZWWBj304kvXZnsbwnrO6PgH/5UFKgFgvnHbAe
         e38bBogb6ODXks1JMOhWXfv90Ul9s6KVqQPT/SV9bfGmULwlusxb/8Zmr5eLsbOZJkki
         qv423lcqQxKuh+eQmAsKYSoKW29RuuZMD/RoqgvepeSwAkdqucY/iuFFYuIctAtE3T4D
         vrV/QcT/hd8dRJetI4kNZMkUVa30ie0QhvqVF3IF8WNZtjJq2je/9dqcWZ+nI3/YuHa8
         InwAQCIvBjD43rdlj/Xd7havLsHQfzp1gbbRN7IBigLyZyn18ImoYogoBROPvfonRSkb
         PxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771858563; x=1772463363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GWhrdo13vFR8MpiWqGIUlMw11zaKiApxbVw47NJoYB0=;
        b=uQzZG5Vf+AKsqOQOUJu72ATqHj5F7+PvzI5QTJUAx2kwFCCNlPzwLkVNMyp4KT7tJO
         GnE3Nl4pOES139txrUl73E7DCDyfRCuHiMwK4CQJkYl+xxHNeRXkPZ1vhlh+k4W7Kpq0
         kgJ1GYu7lHeD++vG2Nh4mX+Pdklrwv1hrp3XOJgXVQo1HcAuAAPbxNlZjhWFGN+bU9fe
         VNBJ+s8H3CkZoOYoDqhpJfRCFW2OohZmHZubfZ0cCAAq2Cc3Q43nVKqCvZdWs0NwPRLF
         PqUdZRkCvU+XCfBMS4SU/jZLv/gL3dnuv9obMFeqTtqm7G02afBELE3L7WB2s1GGNSsA
         lpCA==
X-Gm-Message-State: AOJu0YxXZAiwXS9uZ4jg/WFPstVhUPfzXutKSM8ba1NMw48mzRHqwHru
	pwBh63/7OpPHBlYnta0LEUYb0S0Asl+7Bmu0XA6cwFZJLEy/QsrlDzKwib1ehaFDxuojDgb/SPD
	ZpFeu
X-Gm-Gg: AZuq6aKzkAUtlWYr9nQrEcG/uhyqbxQaqsqzcQ32ckzbAgm5pQiqYnZAiczoEy39rT+
	3tZtQ9WwkCiAbhdBscjDALjs3T3/TLfujQVxgf1eo1QIf7rJ1996SnRzbeaj8D6ADPp7vOpD8gv
	Z35KJ8r2axTvbMMGU6X7wVVgqZACCBOsdhJpSatbCE1YN82mlkOTFskzQ7xcNS97Nu2ci+lAVaL
	vCqyV7ZGOyQwr3VYCXilnsH0imVpKyOTUIAmzs5dsYITl2/HA5jBPagX3k9IHQCFKf5872Gipe4
	BWWTo/VCRx80rz51sjZBOvmAnAZ1yjKmbFAePuRX0/+fT9711ihxcJoPNFtIlS3BaT2AjBnIKBT
	Bw9gEVoZW76bCdmqqG0aTjDbbG8gRIBxj+J+Mz0qgpV4T4ZCULqU9zGmeXPKDvmWmFXRlwApVK5
	cbpgS0UVIddZlXst8fV0l1VLpA
X-Received: by 2002:a05:600c:3b17:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-483a95b15b6mr156901905e9.7.1771858562993;
        Mon, 23 Feb 2026 06:56:02 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3deb8e5sm93595035e9.1.2026.02.23.06.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:56:01 -0800 (PST)
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
Subject: [PATCH net-next 03/10] devlink: avoid extra iterations when found devlink is not registered
Date: Mon, 23 Feb 2026 15:55:50 +0100
Message-ID: <20260223145557.248679-4-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-260066-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F32B1785AE
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


