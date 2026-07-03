Return-Path: <netdev+bounces-304313-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FBaNAn7+RmpNgQsAu9opvQ
	(envelope-from <netdev+bounces-304313-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:12:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7085D6FD908
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:12:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=AtPY6v6Y;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304313-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304313-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 891843077D8D
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 00:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402131E7C23;
	Fri,  3 Jul 2026 00:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A3138D
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 00:10:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783037423; cv=none; b=jQAIHTbM39En+3aj4y/lY6pFO2pLuFJDJxiMS6lWGd/bZxjvwdBA0dm2rQHPSQSU6gjgPUMdYMayl4GzHzuCdSG1cTxnzdgB+qGrPpEgdEhSAMSBPpVk2R5HaibxkJZR+Dc8XFEfzNxxnBo5W1Kos3Rb/IFvHSmJgm3OvRmHcok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783037423; c=relaxed/simple;
	bh=IYgyf0KqpKjVqq12Gxt0gyZGoIKXjBisxXbbYhjUsPk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nDFlrdjOEaRQZ6cYKvEgUjBE8H3ug9AWTrE/Sjvx7Y0CU8tgEHKv0qK5lv0pZU1fkkVwgoTGaxSL8ChN9py4cwZrwz6BcTNxLb233M6sRM9sY8lER1fouv7h9HvIiyunT3Foswwcrmy32sZWLuqAxKVvk3kb5BQCLAyISh1IjyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AtPY6v6Y; arc=none smtp.client-ip=209.85.216.73
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-380a0925d7bso3349626a91.2
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 17:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783037421; x=1783642221; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ABfcvkc3904kpVhvCIerwaPJWoNtS22NaEck/GhxlgE=;
        b=AtPY6v6YgLs8U8paaCYyI+bvi0xfIX7TeUitqt4EkBKj+Qsrnp59asLoI99fEbm8dY
         1pC72B/Hh3nKLUliMZDPgSzQEFlAdVnf1mS8KU1U0vMh4FU2Gl51KAybRxK/TkNKFQcj
         nUEk4jweag5H+gqE2PMqFR6phr3oub/ZM4nz0NgPRwBlQCLioo0ZM9iUKOlO2tqlp3mE
         wwUTHx0tIw+ChHLn17ago50CJiwJtcguZZ9byBWP0qrKZAXMsK2rRxUNUrosRQHkVkqm
         NVqW1+zTnZjT+EfZ6Aq6Am0YTIZSTRaMBOxZsIs2uTo3IKMwIH1k8c94ec29o9Nc+ZvC
         FxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783037421; x=1783642221;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ABfcvkc3904kpVhvCIerwaPJWoNtS22NaEck/GhxlgE=;
        b=nyron+vwS4AFWGnKDS/uS4EcFDiMnz2pucQNcHFHsTgr3+QJAC6bXt3FDol6m3u7q1
         KbIJMoLN0G4tzHM14BX5owFbega8AeUV0IaH/q/2G1pmPmMuleko0j77cM+kX4iOKC1z
         IwTI51tl/9eX7BQvCCVuDbKonE+NZLjfHaeK0FILyvavB5JhzMk4pLPv4SufOi0GiZeq
         U0ZPDZfKViGsRqkpdPle2ee+FKPPbFlLm2S/hECiRwADm5nh7Vs9iImewK/xb8KfotYB
         m/NcU6Q0lg9IAqHaa/526vof4qSiWBww1P6R2c+UgiCbqgxGG7p2jMH+Fi3yI4A03tCP
         HYiQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp4o/gZwVaj5tYTPGP16swCRADOKJymaZZ6i+BzOapqa29cHlpfoeJ6SfBu4jBSoRY4ofdd3e4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoxvjs1hcrgedlIlIHwf5jrNe51Mg/oqGjeUYPKPReSml34ZCr
	1oSs+4LzO8Pq4eahb9a7kxeL3WCubaGOTMnNvlYW3dsnSCzFqq6CZXYoowzFALx/1AvlFb9qLzv
	ZUkfXfg==
X-Received: from pjqu11.prod.google.com ([2002:a17:90a:ae8b:b0:37d:8595:7a08])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d88:b0:37f:bfd6:8b40
 with SMTP id 98e67ed59e1d1-380aa0952c0mr8456035a91.5.1783037420945; Thu, 02
 Jul 2026 17:10:20 -0700 (PDT)
Date: Fri,  3 Jul 2026 00:09:23 +0000
In-Reply-To: <20260703001009.1572444-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260703001009.1572444-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703001009.1572444-13-kuniyu@google.com>
Subject: [PATCH v2 net-next 12/14] ipvlan: Synchronise ipvlan_init() and
 ipvlan_uninit() for the same lower dev.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304313-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7085D6FD908

ipvlan_uninit() for the last ipvlan device resets the lower device's
rx_handler_data to NULL.

Once RTNL is removed, ipvlan_init() would race with ipvlan_uninit(),
which could leak a newly allocated ipvl_port.

  ipvlan_init()                   ipvlan_uninit()
  |                               |- if (refcount_dec_and_test(old_port))
  ...                                |- ipvlan_port_destroy(old_port)
  |                                     '
  |- refcount_inc_not_zero(old_port) <-- fails
  |- ipvlan_port_create(phy_dev)        .
     |- new_port = kzalloc()            |
     |- phy_dev->rx_handler_data = new_port
                                        |- phy_dev->rx_handler_data = NULL
					...
					`- kfree(old_port);

Let's synchronise the two by holding the lower device's netdev_lock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/ipvlan/ipvlan_main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index b4906a8d24ef..7adad781e9b5 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -177,9 +177,12 @@ static int ipvlan_init(struct net_device *dev)
 	if (!ipvlan->pcpu_stats)
 		return -ENOMEM;
 
+	netdev_lock(phy_dev);
+
 	if (!netif_is_ipvlan_port(phy_dev)) {
 		err = ipvlan_port_create(phy_dev);
 		if (err < 0) {
+			netdev_unlock(phy_dev);
 			free_percpu(ipvlan->pcpu_stats);
 			return err;
 		}
@@ -190,6 +193,8 @@ static int ipvlan_init(struct net_device *dev)
 		refcount_inc(&port->count);
 	}
 
+	netdev_unlock(phy_dev);
+
 	ipvlan->port = port;
 
 	return 0;
@@ -198,9 +203,19 @@ static int ipvlan_init(struct net_device *dev)
 static void ipvlan_uninit(struct net_device *dev)
 {
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
+	netdevice_tracker dev_tracker;
+	struct net_device *phy_dev;
 
 	free_percpu(ipvlan->pcpu_stats);
+
+	phy_dev = ipvlan->phy_dev;
+	netdev_hold(phy_dev, &dev_tracker, GFP_KERNEL);
+	netdev_lock(phy_dev);
+
 	ipvlan_port_put(ipvlan->port);
+
+	netdev_unlock(phy_dev);
+	netdev_put(phy_dev, &dev_tracker);
 }
 
 static int ipvlan_open(struct net_device *dev)
-- 
2.55.0.rc0.799.gd6f94ed593-goog


