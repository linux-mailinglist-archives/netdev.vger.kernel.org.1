Return-Path: <netdev+bounces-305485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bCv1Ms4JTWoAuAEAu9opvQ
	(envelope-from <netdev+bounces-305485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 16:14:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0353871C6C9
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 16:14:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=IlkKE9iq;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305485-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305485-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C260D30AD635
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 14:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937CE4252DD;
	Tue,  7 Jul 2026 13:59:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5880742378A
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 13:59:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432787; cv=none; b=PpTKrBuvT2wAI2U9xPgYqEIOmmw9c6f84sXiWiAYRiGBAkik3X/H5Gephy5w9NP42avomd4dAkZRnsbdhxQO4R2OfqQI0s2LoGw79y50Tg5zEJu9qO0euOPoi0iOGXxKy1a8+VFy6KatTcu/QbdMK70X4DoVv/LriDwWI7tNsaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432787; c=relaxed/simple;
	bh=fKe70vqmsSB7Sbpqp5Pwa9y18Qh7KEsEmm0Uen+uTFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7UKrBQQ2bGKcxd1ooIyBHpT9KtrEPw7vLiGex3VE29Ai490MhzpX3ClAtiRcX9RaryKsJBks3OM2sCNARsJBoHvMjO/Rxlq0M4w/w+vMjVQtOvdrTAV5BXHnNaOLCyZP3lNBgzMluv1QwdXHF6y0voBBw2hG7wohpvH6o5HCjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlkKE9iq; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493c564ed4dso5083845e9.3
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 06:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783432784; x=1784037584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f9VRQMdG5mh4GbPjofS2MPnVG7awxExT5N1bUTExBEM=;
        b=IlkKE9iqwsuZXYS8lwMuAA2NBeFz2yUY59OTqskSF2pqnbkhPdzcHoYJ3h3Tal1HHS
         hzzu3+U3kReQezqHyt5YZZsWgu18+3bWm8bsq26glfgQm53iCsGwCd2ngv2ayoyrCIpd
         4BU+vHMiEKZghAlWSQWVq8ewE1H0temMj6ct8Mg/gTGdFAfhWs7KRZNABCtA2xXmXd7Z
         6wJJk1KlG+pDb4qB7NrXYtcfeqzBpNStinpctPi2j/MSTDTG3sCx9J+7LnO5UpihLXtM
         kmPdZsqF9sBra8yN5Ft+Q6hno8suycbQ2DFDfml/U5BxRSslOYfTuA5H91aH5fXf25U5
         nZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783432784; x=1784037584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f9VRQMdG5mh4GbPjofS2MPnVG7awxExT5N1bUTExBEM=;
        b=NrmhIYZhh1alCCeuR19Om3Coi7NgSy5A5cXqADHlSFLobGvr8Daq/Y80kGmmWFyrgX
         BRwiw2mJTkqSYFYtY+WPOwVNDfe+iHvaVG/fj9Kumqfd1/SZhh9e1CTAttXM4E4s4SBH
         XVDLmFjbvLSsaZCZNrLWe0+jUZ2xOUFJgHOFdQKBwBKMpc6kwc2AbvJVOzFj/uG/PoGv
         qko4GOoADlvll46+o1pLl7GOlydnxerIe48WKruqDMpm8QUUXx+f+ufQJa+YC/Dp2IGq
         Dae+UsaxKYl5dr2Sxvki28Sg/6WELJ9c6W49qlcLAMAovnvZcVGLP9OF/jHXUBSVdcY0
         jpqw==
X-Gm-Message-State: AOJu0Yxo6NOirX6+KTi5M862UAWOoLnzYb1pSPM7vxxi9uxLq0mDhbj2
	tUsvdKhRffapg55P2wUNKGZrzroAvQWBKwq/szoirAuZhzYdEvK/2kfgqIUVch0q
X-Gm-Gg: AfdE7ckn7u+BNqsZmvvtIrCcEu9HYwY9rqj7SQP4ttpP4KiKp0+x18nHS3NanbEel2O
	FE7PliYEVX1bWEQryJyGJ4q7LOQ3rxMhJd59WEX0xpetS+70c78bld1805Rd2dOfP8oqvVHHpBx
	ik8OabDEhs2133kdjZT7LXX6GAvvVRy++JjDw8e/d+5B9nf2MCOdehpgXhgy3Ew5ooj1s2IcOcj
	nmk7MHpzFPSHzouTJVo2fLMHdE+5wzjtj3hKkckQYXhdo7+e9mUlv3r0giMFC5+G1c/UlpRqKzp
	tW3zfneeATdaa+LBTv0SGb2kxwVX9HtJ5Wo2ClhSYq4vj/0Jp8fy8ZhGAYk9i7D1pF4tqihtIu9
	8hHkfc0dyDSEnLOB29bbG3QvbTd4Q2CjQH4H0jiSlq5zvREhgfxdogB+5p+0g8+fN6HR6adeJh/
	Rpma70FbzCD+pwVqRFUDzyjHrZd/ysaXaevLzVJV6cbMRCwVFq6LBPFPOgqUu3mRudoANmTzRMY
	sU8V8JbW0ngNJSJdtxUVj5IAIOie2FPqmLcT0trc5yg5hj3jJM=
X-Received: by 2002:a05:600c:1907:b0:493:bd67:315 with SMTP id 5b1f17b1804b1-493d0f4284fmr111439575e9.5.1783432783600;
        Tue, 07 Jul 2026 06:59:43 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-189-165-250.77.189.pool.telefonica.de. [77.189.165.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f40d50sm67409615e9.5.2026.07.07.06.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 06:59:43 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Felix Maurer <fmaurer@redhat.com>,
	Luka Gejak <luka.gejak@linux.dev>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH net-next v3 3/4] net: hsr: allow PRP RedBox (interlink) creation
Date: Tue,  7 Jul 2026 15:59:36 +0200
Message-ID: <20260707135937.18-4-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707135937.18-1-xiexinet@gmail.com>
References: <20260707135937.18-1-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,linutronix.de,linux.dev,suse.de,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-305485-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:bigeasy@linutronix.de,m:fmaurer@redhat.com,m:luka.gejak@linux.dev,m:fmancera@suse.de,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xiexinet@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[xiexinet@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiexinet@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0353871C6C9

With the PRP interlink datapath, duplicate discard and supervision support
in place, a PRP device can act as a RedBox. Remove the rtnetlink rejection
of "type hsr ... interlink <dev> proto 1"; the feature is implemented
unconditionally by the preceding patches.

Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 net/hsr/hsr_netlink.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index 8099f2069a7..88940e8014b 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -121,14 +121,8 @@ static int hsr_newlink(struct net_device *dev,
 		}
 	}
 
-	if (proto == HSR_PROTOCOL_PRP) {
+	if (proto == HSR_PROTOCOL_PRP)
 		proto_version = PRP_V1;
-		if (interlink) {
-			NL_SET_ERR_MSG_MOD(extack,
-					   "Interlink only works with HSR");
-			return -EINVAL;
-		}
-	}
 
 	return hsr_dev_finalize(dev, link, interlink, multicast_spec,
 				proto_version, extack);
-- 
2.53.0


