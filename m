Return-Path: <netdev+bounces-305411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b07JH+vZTGqeqwEAu9opvQ
	(envelope-from <netdev+bounces-305411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 12:50:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E215F71AA00
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 12:50:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=HKafU4um;
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305411-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305411-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8388E306C3ED
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 10:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B123EF663;
	Tue,  7 Jul 2026 10:44:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3923C13F5
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 10:44:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421086; cv=none; b=vBchfmQAIQAr/t4bmymR5JSkqs8Cog9KqxNh6XnLry3cY2Uj3g0J2FpG24U0vYDKb71t95LgAYuJC4eLTVWWwgIg2ubhTXwYNPzuCUW57j1Af8rXExq1OTIPnevDtH/ACc0+YWQkqCZR/2tD5w86gsbi4iyM/shI7oJGCVSYak0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421086; c=relaxed/simple;
	bh=m6Vy8/wHNPY8C0kCEaunFHodod1EiDxclom3bCaHBiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E9ErJldWQZQ/hrM++WIchJKxB+z1WQCbqhLTAoHjC8tOflt0hFUHiuG1rAUGIXzJ1lEMhe5p2KnYm0ju6NraCj/L4XJBuKRNRn70Ir368WpEGczmqolzYz1nji57znV2vMmuUAuV9G0qsoq+gWEGoDVpcfmSI/RIec9wJoVzCgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=HKafU4um; arc=none smtp.client-ip=209.85.219.50
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8eeadbc5e21so28545556d6.3
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 03:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1783421083; x=1784025883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3RkQmMz3202ZTrMgKkMwsZxm+kpwa045YM/cz4B8cic=;
        b=HKafU4umyraQAmiWaczD3X9BvF55k/rlHtK0rfbsRXB8TG2d9NFPCkI5rH18Xh4ucu
         6wevUHejTehnV940QdxQjzxyVHhdMt2JBTxvSolXauHwCZ/aB2kw0PbnyTvKkPkqcLDH
         JrH0u5mMkLztwJWDhCkNjIhNj7WLz0pY2eXQnXDEa5AUIGLJ9Tt46Q4xxBnQ7P87Ic+C
         RBjwgMnqXNm6BsVMU7HF+pkxS2VE+m/p8d2uMq789aiWfaJNK3Es7BWVM/L1CHao9ERD
         i70hQO/WzWZoyeb6L5c70elAsmAc2aH3V9bRE8XqDg9qbXi+fSq/RbeaqCgGfARU8/st
         oTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783421083; x=1784025883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3RkQmMz3202ZTrMgKkMwsZxm+kpwa045YM/cz4B8cic=;
        b=QMLKwGYh8jdKtPcoz1PB5j22ZO9yf+m2bS/Gj5zWx/utlNd11wmxdarELZ/1847C5N
         Zl5oU78rQNJhSmVFYxUg6iqvDDFCUEQ4ZailO7heohaWN0fCvDxjtupdDz3B8pfTGjSt
         gCdS+rGuuiJJRoy24w0VFJc1QBSJmqLxSzXWZnQGMrHYSMouLRSOjVJsgCXGWwN9Hovu
         hC3zD5FYaGNP8MLVKvN0j2DrNVMk3omiXc9k2YD2FXljcgMirdOZj3qT5xscEh/q+9ZO
         1P4r5SDc3mI7PE7zE2KSKoC8SodIpHB9BYtFFmUw7NxCuUcnuPa0+6O96wnsMaz90VHx
         N7wQ==
X-Forwarded-Encrypted: i=1; AHgh+Rofg/1LRgadpIU+49wiJQTCKL7xmjqq1oU3t42xeM4NIyVaqC0ob+0jzunInJ0fQ7jr9OqvhvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUBqFnpGBzhvBrprP82nztqPdMkJahd2U/OsV3nEZH6fVEiz0f
	gCnTWiwF2xpbo/NB9CML8wg63vs3PQrYFoCJmtngq65xSDZ2naBJ1cglb/arsOE47co=
X-Gm-Gg: AfdE7cm70VCiU6xP4cXrJNGXIE4P01XetDx3YNYDK2/B9HRQD7BHoG4wiR6D7e3VBeC
	QDdVyaJCzMu4Rf7h9UlsmBMvPy0lfNfRdWMpNbvoOZjjdxLM6xYE384oNvPa615KZune6b3IaSb
	zvB8WQZu3CjSmgxv4Y9jKG1NKSpbqPr8XsaQdQDfJe2/hOzNJien6QtlShAfvQk3W1DcT8LAwFT
	iwArLsse4F/ZqCDN4OmWvgsNRnelFIKIan4Wst76aZkNUEUBwNV+oLXmZjnRQmaK8QcSsEuT2Ig
	oUK+ZrTO8mADOIjjdGfiZK7l43kAVWrZ3Dpn5UgQrjfq1L+V386Wkmc9js8nR56gV8NTKsr1cVz
	nxRUJTVgeZLRr2eezQH5pUUuLAel/kKvS3p5e3EAgavAX9FdlJuKfoej/f5vWVbW8t69RrLeOCx
	WMMg2PKVAhPcwCtPzr4A==
X-Received: by 2002:a05:6214:1d01:b0:8f3:f17a:a3f with SMTP id 6a1803df08f44-8fcb25aa951mr57732236d6.3.1783421082632;
        Tue, 07 Jul 2026 03:44:42 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8f46e27d53fsm157983436d6.5.2026.07.07.03.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 03:44:42 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: David Lee <david.lee@trailofbits.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net v3] net/packet: avoid fanout hook re-registration after unregister
Date: Tue,  7 Jul 2026 10:44:37 +0000
Message-ID: <20260707104440.833129-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-305411-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:willemdebruijn.kernel@gmail.com,m:david.lee@trailofbits.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dominik.czarnota@trailofbits.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:willemb@google.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[david.lee@trailofbits.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david.lee@trailofbits.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,trailofbits.com:from_mime,trailofbits.com:email,trailofbits.com:mid,trailofbits.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E215F71AA00

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
po->bind_lock. This is distinct from ifindex 0, the normal
unbound/wildcard state: ifindex -1 marks an existing device binding that
was invalidated when the device was unregistered. Restore po->num as
before, but do not re-register the hook if device unregister already
detached the socket.

Fixes: dc99f600698d ("packet: Add fanout support.")
Link: https://lore.kernel.org/netdev/20260701113947.23180-1-david.lee@trailofbits.com/
Assisted-by: Codex:gpt-5
Signed-off-by: David Lee <david.lee@trailofbits.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
Changes in v3:
- Drop Reported-by due to duplicated patch author.
- Add Link to the v1 discussion.
- Clarify that ifindex -1 is an invalidated-binding state.
- Add Reviewed-by tag.

Changes in v2:
- Add Fixes and Reported-by tags.
- Fix the incorrect Signed-off-by tag from v1.

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

