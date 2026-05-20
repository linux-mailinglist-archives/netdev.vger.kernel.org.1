Return-Path: <netdev+bounces-290025-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDRuDHj0DWoF5AUAu9opvQ
	(envelope-from <netdev+bounces-290025-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 19:50:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF97594B88
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 19:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C6B5A316B2FF
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716F83D75DA;
	Wed, 20 May 2026 17:23:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC1A364E89
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297825; cv=none; b=dLg3ObbNbhR80O2SP0VIgkCFVgl/2WSLAiqZF1/dJ4D1KYwEtEM2szG1B4HLLjt22Q5H2/msBzlzm2sgkxA+BHyeX24ZbwwMSLB4/xBmnwEMPCBAKFAm0UlrglokB0EVliGgL90LqNWUl6+TA+GXTrAfi4/JTpy5rBF9caDrT9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297825; c=relaxed/simple;
	bh=dEn/DZjJ6ZkDMxdIMlTcRhfqUFij0sqTMuUmS72Qvf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2wgmqt9C6u5VzvIjr7i2q8At0wcyicnD0qWo7vKKoJ+xGQsWgRx7QigClYLOUhKQQmgqWJAzFJUfRJlpE8PQrpR/ul8aBRp2zHfZ1PBtRV7VAzB6ei743+XKPdu2o9a+Ry90nQGiWYJoLsGiKP8oXh1zJ0l8++yEJ3KAS4C4tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-43d73422431so3615332f8f.2
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 10:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779297822; x=1779902622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f/5B2KT7zWN9FEt5jFJ3UZmNoriTd7Q2p02B+ALz3Mw=;
        b=fwGx2J1vdNuZ/jChILS2KwLA0ITYuT95MXQ/1HQljYqY0mZ9byfcJybMOjXEBr5xcX
         JrVDR00ZfE22waiEv+OQTJTcMzD2y4feRF1j0QU80pqbnCENH7+5zLc+30k/DrViTDh/
         uKEKeJFp/pZdn1aE8GNb019x+plPfotgSINHZJpW/nygZrvcxH8K5NIXWemzwxY12ihK
         f+lBOBtfV54epoTlbXMoeDLE80yIsgZGmwdFpcdmAW0ylIQwO8empfU3egca1jygqo0x
         EUoqTBAmkZKIdtPY9jG+62AzoSvclMEeTP35dgSM/OmrbE39i5f13QKiWpwlpeiIlksh
         yG4A==
X-Gm-Message-State: AOJu0Yx9zapo+M5u0J3K+nlJHcngayGVDYLPoec0FQPrDa1JMr0MlNk7
	1Tvd9xfCTdYAA8BfHEiKOZSvbfFYm6RxKzGnreXbhBOfdmMHyZMU59DEK8emgYCG
X-Gm-Gg: Acq92OGV0g9KaUXxOBuQ8iGBDV0Tt3UhxMoEIVVTZ6+UWCkdjsyfDgcyy8X2KFRe3LW
	AMkNjkwC1S+k/0N/EdUtoG5Is13wOq1mac8OkdZd4UxyFvYSn2EtUrQQxqzJury/sUfL5Dhx3Dh
	qdxtyxtsLW7XfAk8ryQChBKBCHd97GVebFL+bKCcSiTwwtlnwZWV7cUsvlRv0aYt/blrjIvF05/
	sOjR2uuhAPBOILjg4uLDvL5sglS9Jm8lENWdI+8geEE8+5spOpwnPFkJm+he4VRwTTb/xBdJCxY
	hqxKuhfMxEo+LMpbNC/9EgBOTKcwkG/j7pq3PLdVgNLT0XhxHVFae6inyHLd73CEkMfyKlpan31
	SZBU4Uenx+KB8eydNm42ew8SAYfenkGjjUb7wIafzQj5M0GLpj/90rqCVIfXXN1p8hXKtYIWsZW
	jP/T3HJnN/ZwcLkDxER5SOVIJ453b8U9V/GR7ilmO5KetMW48Wd11PT65FPKK2DSG7KXqyaKPjD
	DqlokPq
X-Received: by 2002:a05:6000:2503:b0:43d:d037:d59c with SMTP id ffacd0b85a97d-45e5c5ca060mr41914479f8f.16.1779297822258;
        Wed, 20 May 2026 10:23:42 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0fecsm51125580f8f.26.2026.05.20.10.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 10:23:40 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kees Cook <kees@kernel.org>,
	Adrian Moreno <amorenoz@redhat.com>,
	Jiri Benc <jbenc@redhat.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Matteo Perin <matteo.perin@canonical.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net v2 2/4] net: netlink: don't set nsid on local notifications
Date: Wed, 20 May 2026 19:22:36 +0200
Message-ID: <20260520172317.175168-3-i.maximets@ovn.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520172317.175168-1-i.maximets@ovn.org>
References: <20260520172317.175168-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290025-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[ovn.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,6wind.com,vger.kernel.org,canonical.com,ovn.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ovn.org:mid,ovn.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,canonical.com:email]
X-Rspamd-Queue-Id: CAF97594B88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In most cases, notifications on sockets with NETLINK_LISTEN_ALL_NSID
do not contain NSID in their ancillary data in case the event is local
to the listener.

However, when a self-referential NSID is allocated for a namespace,
every local notification starts sending this ID to the user space.

This is problematic, because the listener cannot tell if those
notifications are local or not anymore without making extra requests
to figure out if the provided NSID is local or not.  The listener
can also not figure out the local NSID beforehand as it can be
allocated at any point in time by other processes, changing the
structure of the future notifications for everyone.

The value is practically not useful, since it's the namespace's own
ID that the application has to obtain from other sources in order to
figure out if it's the same or not.  So, for the application it's
just an extra busy work with no benefits.  Moreover, applications
that do not know about this quirk may be mishandling notifications
with NSID set as notifications from remote namespaces.  This is the
case for ovs-vswitchd and the iproute2's 'ip monitor' that stops
printing 'current' and starts printing the nsid number mid-session.

Lack of clear documentation for this behavior is also not helping.

A search though open-source projects doesn't reveal any projects
that use NETNSA_NSID_NOT_ASSIGNED and rely on metadata to contain
self-referential NSIDs (expected, since the value is not useful).
Quite the opposite, as already mentioned, there are few applications
that rely on NSID to not be present in local events.

Since the value is not useful and actively harmful in some cases,
let's not report it for local events, making the notifications more
consistent.

Also adding some blank lines for readability.

Fixes: 59324cf35aba ("netlink: allow to listen "all" netns")
Reported-by: Matteo Perin <matteo.perin@canonical.com>
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/netlink/af_netlink.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 0742e97f256e4..7269e23b578d6 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1482,10 +1482,14 @@ static void do_one_broadcast(struct sock *sk,
 		p->skb2 = NULL;
 		goto out;
 	}
+
 	NETLINK_CB(p->skb2).nsid_is_set = false;
-	NETLINK_CB(p->skb2).nsid = peernet2id(sock_net(sk), p->net);
-	if (NETLINK_CB(p->skb2).nsid != NETNSA_NSID_NOT_ASSIGNED)
-		NETLINK_CB(p->skb2).nsid_is_set = true;
+	if (!net_eq(sock_net(sk), p->net)) {
+		NETLINK_CB(p->skb2).nsid = peernet2id(sock_net(sk), p->net);
+		if (NETLINK_CB(p->skb2).nsid != NETNSA_NSID_NOT_ASSIGNED)
+			NETLINK_CB(p->skb2).nsid_is_set = true;
+	}
+
 	val = netlink_broadcast_deliver(sk, p->skb2);
 	if (val < 0) {
 		netlink_overrun(sk);
-- 
2.53.0


