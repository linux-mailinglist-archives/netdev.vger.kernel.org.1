Return-Path: <netdev+bounces-303617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SNgvKg/9RGp14goAu9opvQ
	(envelope-from <netdev+bounces-303617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 13:42:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2526ECEA7
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 13:42:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=LYeqonHq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303617-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303617-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AB5730422D9
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 11:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CAC428837;
	Wed,  1 Jul 2026 11:39:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD2247F2F9
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 11:39:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905993; cv=none; b=VEZP3z80agW78LRpW/OE+8amkMCMlKle6ry727lpW6MGar3N6bbZfzO6Z8KO0h/fhYUQfm/hNOsXrypCeJhGGaTa0kV0zElZaDMG8OLNV1IumS5r5X32OBDEkCT4A3Fhq4w8BAkfNFY22Q3io+TI2jiMQbiJ47oKTv4N7M0ejeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905993; c=relaxed/simple;
	bh=o+B7KcNekZ1AwDCltTOPQsgK7LkxNwVl69lCMBqoSoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bPIzq7Tj6QOaUWfSA9fua/UUsfGiUC5ahkB7SlCqqQNmkjXvu2xAIJ2Nfg5W74Zr9fMTNcG9lt8y/aSBsYSMduZvV/zxfeynnkHSNeGode5Gx881Ef1dphCvLSgrsxa2tZvt3wLvZQiW4PRwYdGFSxF3WzUPJdGzjpkOPMwreWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=LYeqonHq; arc=none smtp.client-ip=209.85.219.41
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8efbafa1bacso3547836d6.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 04:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1782905991; x=1783510791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hzsIVnhhCz3tNgTE+Zs3wzI2ISF/+u7rMUgG7jp4kuk=;
        b=LYeqonHqVsvd2YiosMP8rFOXOWsKB555YBlgN69HNivT7QrHgexmLX/1DjU8x3+Vee
         bRrRMLdNohsxBj4hcUnI9dfB7OCCfZS6dqkYY/7kZRS078VUo6/Ys4vT7/bFauDlIrY8
         zIiv81Gf/0Is4tCKWyMZSyjqTwh9Qw05dRIQqlVHRcGppOsD6G15/xJNtPhyFif511oq
         v7XnbKUVohgA02Okc8XjaF0vNpNrUfgU7MwmYe6MYsq0Fl4Fh/oiiPbn6WrdI0nZhG+h
         bLLXkOe3nv3GyRdn0Dugy9OP48mRTO0Ge1b+jCKYw8AdBXJbuk8OjYqEn24BORvK9Fuo
         0tFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782905991; x=1783510791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzsIVnhhCz3tNgTE+Zs3wzI2ISF/+u7rMUgG7jp4kuk=;
        b=BH1Hpu+kJ7fZ6uzpnHdM/lPvdw+PJ3ljYb5FBEHTiHI2nu1TWQcexbDTKf3iZ8E/C7
         MXPJRZIcFU8shYwfCxeeYiJ56aSYs+YVRKLWm/JVvBmzxUc85f2SKTWx8PTyMdU1/Q9h
         v6dVuQhxIB74gD4OFlJjgr2Dl48Iy28ZUh7gLEI/j9ammuBABhTJteWeqt7bWaUG3EaC
         RJtfUxDVWqPMr/ilCe4mpjaEBJ9xSxbDwUQGqRzYmJghU+O7crvCwmprLs0AboprAmfz
         rko0rMUXsvWfInEfTjr9WZ9w1lWWC8Kb7yj7JQISgg8Qeb87z5wR7LaIakQRHTgg97KD
         h15g==
X-Forwarded-Encrypted: i=1; AHgh+RpakuJXzb8Yk97wcg0rqZklD2Xuyz/yQLDN9QOrUg4ohHzEVFrpLbxn8mA6v2PnjuR9Rnvaryw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwebljFlqzy3azfA71BiRjZAedYXMwUuzeu/DlqoQunjACIqvr4
	is0857wPM/w4EdZqvsU5ZtSe6FBFkmPpkKstVlCRFQHsr3jMz355XpT4Lkm8bdpjbm8=
X-Gm-Gg: AfdE7clB46+X+OEfcVPilwyOf08LPybvDfs18q8Vh3PoXGgLM+pvthZwVh3nEjKnr+Q
	dPc5aYulykgWCCU0bBItHy6HhMN1wUAHVLUqDPqtU755N0fCAkbVDp8duvoOph/9l/XDENxbj/O
	3Ib6vRNsukNAjxJgN3lBpGsstwhxvZFhYiD2Gft3au4V++pJQgrDX3Ad8/bS8A3HFiooSq1vUTq
	tRDdw71waZ2tfrY/CzZc3520xuzvEMZKoahcN76hTAlqbykrHhGgxzhFoXnFOMb2d6X9jMGYRbV
	zzBoCuD5bL6CralgUelbTNhlb8PJDGuY8iHC7TgCTY9glQ+3HsFbCb3CtgWPKuJ8XgUjEZlGk9i
	yiUVGNCImrOmGX5p6WGneIX+vGhtjFqba7HE1n9By3CxbCqHZiLfSy6mZKdsvSBKDX2Uyd+ZtHg
	6Obmrroo8NEH975d96zw==
X-Received: by 2002:a05:6214:601c:b0:8ef:892d:381 with SMTP id 6a1803df08f44-8f3c9cb2198mr13267446d6.52.1782905990921;
        Wed, 01 Jul 2026 04:39:50 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8f3612d3c32sm19157396d6.32.2026.07.01.04.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 04:39:50 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: david.lee@trailofbits.com,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net/packet: avoid fanout hook re-registration after unregister
Date: Wed,  1 Jul 2026 11:39:47 +0000
Message-ID: <20260701113947.23180-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303617-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david.lee@trailofbits.com,m:willemdebruijn.kernel@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dominik.czarnota@trailofbits.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[trailofbits.com,gmail.com];
	FORGED_SENDER(0.00)[david.lee@trailofbits.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david.lee@trailofbits.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C2526ECEA7

packet_set_ring() temporarily detaches a socket from packet delivery while
reconfiguring its ring. It records the previous running state, clears
po->num, unregisters the protocol hook when needed, drops po->bind_lock,
and later restores po->num and re-registers the hook from the saved
was_running value.

That unlocked window can race with NETDEV_UNREGISTER. The notifier can
observe the socket as not running, skip __unregister_prot_hook(), and
invalidate the per-socket binding by setting po->ifindex to -1 and clearing
po->prot_hook.dev. A one-member fanout group can still retain its shared
fanout hook device pointer. When packet_set_ring() resumes, re-registering
solely from the stale was_running state can re-add the fanout hook after
the device has been unregistered.

Treat po->ifindex == -1 as an invalidated binding after reacquiring
po->bind_lock. Restore po->num as before, but do not re-register the hook
if device unregister already detached the socket.

Signed-off-by: Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>
Assisted-by: Codex:gpt-5
---
Bug found and triaged by David Lee from Trail of Bits.

Trail of Bits has a PoC that achieves local privilege escalation using this
bug on a custom kernel config with CONFIG_LIST_HARDENED disabled, which can
be shared further if needed.

 net/packet/af_packet.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 8e6f3a734ba0..000000000000 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -4561,7 +4561,11 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 
 	spin_lock(&po->bind_lock);
 	WRITE_ONCE(po->num, num);
-	if (was_running)
+	/*
+	 * NETDEV_UNREGISTER may have invalidated the binding while bind_lock
+	 * was dropped above.  Do not re-add a fanout hook to a dead device.
+	 */
+	if (was_running && READ_ONCE(po->ifindex) != -1)
 		register_prot_hook(sk);
 
 	spin_unlock(&po->bind_lock);
-- 
2.43.0

