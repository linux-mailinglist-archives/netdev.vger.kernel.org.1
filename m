Return-Path: <netdev+bounces-288445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOedA2SAB2qQ5gIAu9opvQ
	(envelope-from <netdev+bounces-288445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:21:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E5A557618
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A95730492B9
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDB739BFE7;
	Fri, 15 May 2026 20:19:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC03D3624C4
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 20:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778876391; cv=none; b=QyHEmlw+576go8kZuwNbosDAGf4ksqZpqJckWPyAwFaI7OxwkYDmZthU7m8YxgMJkfP6/VtPF4ll5pRR8Gvo/uLMeAnRRGQP89x5+78O+2scSQVZbrlwh6Kgs5CaOoKI9Rhtr5lVidc3oq28UhJ39ssHL7GP4vTSUIAR050U9tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778876391; c=relaxed/simple;
	bh=11PvwTnrSqhRrKXUG1flLgVCfsSwFEgQM3usa6azJag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMzz/5XdTDLT2ShR8ZeyMKF/M3dxIzPiE5OxnX0QcJuiXijedtexFtK2CbQzSJGCEZg4yrP7kvjqMI7ZmWV5TFVxdMmI8Wbtl5G255ANCd6w4ImDw64XC0bpc5nVCxq+7hHHOy6zovqe4briqkVy3bPHZqcja1iiGnjmRV4SJyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-48e82c23840so1432405e9.3
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 13:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778876388; x=1779481188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hPaN1T7r/zmxUDUF/SdVhtgWCcFs71hNuD9xdwSmNs0=;
        b=JKCSQRqkBqXcT9DK0Ac15KiqiCFk+5GSzWm2MF5qXhwkMgmbJ90RAjfZZTyOcRRbJQ
         YMsI+Hox+PcxiIre+7gHdrw7/8UjNWqioUFkYxzrD1XM6GsedUUKnNg9RlpjSdUNuiQd
         1FRGFkkl8kWP3XIawdDDw4ewwunubSh08VZ3iVkpJy/GZ5fZmcjVAZ7kgTsCXIlGZUFe
         YxOfQTufIatz2uKvwKLVns+GSgeyjVFcu6H/EhCf0ywgIegMKsFWNipVEiZmAODDHFUQ
         cqaZ5/XBnIM6xWz4tSzXLgsuI+2xB9l7UENE/uWp0Bvj8BoXmPs5wLpulnee8o8ia6Jh
         qnFQ==
X-Gm-Message-State: AOJu0YyVyO+hOJm+J0lIVVe64oprsK6YW3zf9iUd2Wm7scymN2703ZXh
	1Nx6Nt7JraMlmuok7W1RpiNcldl+2rzfprpAoRKfphJG/NVXm8zyC8DVf2pDE8C4
X-Gm-Gg: Acq92OE+QLuEPyCo0NXXn79R/k8c+zX8g95wLzxRzHou183L7gVnjnc7wvGu6n/ZPLS
	vLK8hHsSLTwUzjErfhINyIKQG8kzisnR1s80vtI6ZxQosMk+gBGTqya63UbvdDKpL5xg0uT/NFD
	VS5Q8XSGVAcgMq1MX5mKpdNJrCxYPFpjNGSh/8Vw29/iD/ztpdzT+R6g+sPKvSufBTg+/uq7rgA
	6y5y54m+6KaNfccEksMGK+APrT7SJvuoaqYABF4em6hhjLejloErR4Q6DDP9BNUfAM10KtGuRu6
	g4KqSG34ljKMT7NpzxqGquatpGU71TW4NU/9d90IPUkLekMIhDxk+p57+qh1Npj8YS6e2d05Uci
	WwstRq/lFEHyYmTxyDGQsOxrLQVG3w8ml3bU5lBviQVcC0vOQ5s94NMS7Kjo2WxICUw4KAG37Q8
	BkvJbrLPyQjB81iNf9FqepZd5O3B+NGMQtpT2pr54XHFSi8B7ld/wQOXUrsrs=
X-Received: by 2002:a05:600c:a406:b0:489:1aed:1658 with SMTP id 5b1f17b1804b1-48fe632a9f4mr65203915e9.23.1778876388129;
        Fri, 15 May 2026 13:19:48 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feab2896bsm22924605e9.4.2026.05.15.13.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 13:19:47 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Adrian Moreno <amorenoz@redhat.com>,
	Jiri Benc <jbenc@redhat.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Matteo Perin <matteo.perin@canonical.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net 3/5] net: netlink: don't set nsid on local notifications
Date: Fri, 15 May 2026 22:19:22 +0200
Message-ID: <20260515201937.2813983-4-i.maximets@ovn.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515201937.2813983-1-i.maximets@ovn.org>
References: <20260515201937.2813983-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 83E5A557618
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288445-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[ovn.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,6wind.com,vger.kernel.org,canonical.com,ovn.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.953];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ovn.org:email,ovn.org:mid,canonical.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

For notifications with NETLINK_LISTEN_ALL_NSID the expected behavior
is the following:

- if NSID is not reported, then the event is local to the listener.
- if NSID is reported, then the event is remote, i.e., originated in
  the provided namespace that is not the same as the listener's.

Userspace applications like ovs-vswitchd expect this behavior.  And
ip monitor uses this logic for printing out [nsid current] vs [nsid N].

However, when a self-referential NSID is allocated for a namespace,
every local notification starts sending this ID to userspace as part
of NETLINK_LISTEN_ALL_NSID CMSG metadata.

This is problematic, because the listener cannot tell if those
notifications are local or not anymore without making extra requests
to figure out if the provided NSID is local or not.  The listener
can also not figure out the local NSID beforehand as it can be
allocated at any point in time by other processes.

The value is practically not useful, since it's the namespace's own
ID that the application has to obtain from other sources in order to
figure out if it's the same or not.  So, for the application it's
just an extra busy work with no benefits.  Moreover, applications
that do not know about this quirk may be mishandling notifications
with NSID set as notifications from remote namespaces while they
are actually local.  This is the case with ovs-vswitchd.

Having a self-referential NSID mapping is not something that happens
under normal circumstances, but it can be a case in specific
environments.  And it can be more common with certain container
runtimes like LXC/LXD/Incus that unintentionally trigger allocation
of the self-referential NSID via cross-namespace RTM_GETLINK requests.

A search though open-source projects doesn't reveal any projects
that use NETNSA_NSID_NOT_ASSIGNED and rely on metadata to contain
self-referential NSIDs.  Quite the opposite, ovs-vswitchd relies
on the metadata to not be present to separate local and remote
events.  And the 'ip monitor' relies on the metadata to not be present
to show '[nsid current]', though this is more like "print 'current'
if there is nothing to print" situation, but still can be a little
confusing for the user to see an ID for a local event.

Fixes: 59324cf35aba ("netlink: allow to listen "all" netns")
Reported-by: Matteo Perin <matteo.perin@canonical.com>
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/netlink/af_netlink.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 2aeb0680807d6..607ab4e4ac697 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1482,9 +1482,11 @@ static void do_one_broadcast(struct sock *sk,
 		p->skb2 = NULL;
 		goto out;
 	}
-	NETLINK_CB(p->skb2).nsid = peernet2id(sock_net(sk), p->net);
-	if (NETLINK_CB(p->skb2).nsid != NETNSA_NSID_NOT_ASSIGNED)
-		NETLINK_CB(p->skb2).nsid_is_set = true;
+	if (!net_eq(sock_net(sk), p->net)) {
+		NETLINK_CB(p->skb2).nsid = peernet2id(sock_net(sk), p->net);
+		if (NETLINK_CB(p->skb2).nsid != NETNSA_NSID_NOT_ASSIGNED)
+			NETLINK_CB(p->skb2).nsid_is_set = true;
+	}
 	val = netlink_broadcast_deliver(sk, p->skb2);
 	if (val < 0) {
 		netlink_overrun(sk);
-- 
2.53.0


