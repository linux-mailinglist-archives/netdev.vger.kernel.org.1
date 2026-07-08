Return-Path: <netdev+bounces-305821-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vU+ICBtVTmpqKwIAu9opvQ
	(envelope-from <netdev+bounces-305821-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 15:48:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A8D726F1F
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 15:48:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=Z4nAj4EH;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305821-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305821-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 279D531269B8
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 13:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A94380FC9;
	Wed,  8 Jul 2026 13:42:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325B43803C6;
	Wed,  8 Jul 2026 13:42:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518121; cv=none; b=e+uKz7K1kL4jhzTc885l9ELHO62MpHBuUMzUjUhgVRWXQzUCS/uGa4fdHypW3pARu87tJY9NGEuQpHMWG10Ymb9fioCAAAQrNxR7ATURZ9SN6wNeMMxnMo8Udcnc28DL8NIc2SIJyz4/3z00bs/dbgDBjBT/zsps9p2QPffhXk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518121; c=relaxed/simple;
	bh=Bm7RObp9s++cBMV9gkbZTmjkcWOyReBVOW6pz3ieI9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GX9PyY7rYOIFKboFBrdrU0qj1EbyChYDmD3lm5eEfJKDpSuwmfToMRYgFtq31iX6XEdEwnr0c/vsVYtS+vriLqPzHhsa9TeHMaAIk2gAB6VxFqmLhQMuxLm/UP3C9RMgRe1UI4vIvsrcOvgl3BWXdVlE2pv3jP8MPcQY4n4nMoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4nAj4EH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2C48C2BCF5;
	Wed,  8 Jul 2026 13:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783518120;
	bh=Bm7RObp9s++cBMV9gkbZTmjkcWOyReBVOW6pz3ieI9I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Z4nAj4EHwFWipzPWBGfUODXCzMvclcqA5zEg4UL6KMhyPiCq177S8frkzkTGtj+/0
	 eVxRgPovQ6F6URO87oF5K5fnoxzG4HqFeBj1lk9yTukurj3fyeNrKYruF0hPxQTXB2
	 MoKsBrOoCmy1/jRU8mpew5f+fuYWkj5dlw4AR0Xwv0qcnIrrRqY7h6lfUF9bpRtBaT
	 VSSRvrcxlDg/KvVl4tttRC/Aw8wN6XoRmnt8aeJ64KyeLrPaqyqRIzAUF675vYJkVT
	 nZ4CkpAiuDQVIc0BN7B8L+c8arOFu7pmCz5dEuUbTSMYa3OQ8cCoMZewB6XwMoFEsa
	 JA1JhofaMfC1Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C445FC43602;
	Wed,  8 Jul 2026 13:42:00 +0000 (UTC)
From: Mattia Meleleo via B4 Relay <devnull+mattia.meleleo.coralogix.com@kernel.org>
Date: Wed, 08 Jul 2026 15:40:56 +0200
Subject: [PATCH bpf v2 1/2] bpf, sockmap: Account for receive queue in
 FIONREAD without a verdict program
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-fionread-no-verdict-v2-1-29dd293621c7@coralogix.com>
References: <20260708-fionread-no-verdict-v2-0-29dd293621c7@coralogix.com>
In-Reply-To: <20260708-fionread-no-verdict-v2-0-29dd293621c7@coralogix.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Mattia Meleleo <mattia.meleleo@coralogix.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783518119; l=1935;
 i=mattia.meleleo@coralogix.com; s=20260707; h=from:subject:message-id;
 bh=+7W+UywcmQEf+EMNYloJybeZfGEOpWtaZ50KeeVhEPM=;
 b=rJB40xzHsfzfq0DEE+iaFOQymdme8+o6xox98Q11IEKechOz/K1/KHm8zeoZ2APnI/TVR2O9w
 fsSRAZyQig+DF1kGPzTppidER3cP+Y58qa1D5Tb5IDxoN47xojab04N
X-Developer-Key: i=mattia.meleleo@coralogix.com; a=ed25519;
 pk=cs1zLoe3YDm4bJ7bfbPaZH0lHnd871JyJLiSh2eEzLs=
X-Endpoint-Received: by B4 Relay for mattia.meleleo@coralogix.com/20260707
 with auth_id=857
X-Original-From: Mattia Meleleo <mattia.meleleo@coralogix.com>
Reply-To: mattia.meleleo@coralogix.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-305821-lists,netdev=lfdr.de,mattia.meleleo.coralogix.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:memxor@gmail.com,m:emil@etsalapatis.com,m:mattia.meleleo@coralogix.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,cloudflare.com,linux.dev,etsalapatis.com,coralogix.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[mattia.meleleo@coralogix.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 50A8D726F1F

From: Mattia Meleleo <mattia.meleleo@coralogix.com>

tcp_bpf_ioctl() answers SIOCINQ from psock->msg_tot_len, which only
counts bytes in ingress_msg. Without a stream/skb verdict program
nothing is diverted there: data stays in sk_receive_queue, so FIONREAD
returns 0 even though read() returns data.

Add tcp_inq() to the reported value when the psock has no verdict
program. The two queues are disjoint, so bytes redirected into
ingress_msg from other sockets stay correctly accounted through
msg_tot_len.

Fixes: 929e30f93125 ("bpf, sockmap: Fix FIONREAD for sockmap")
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Mattia Meleleo <mattia.meleleo@coralogix.com>
---
 net/ipv4/tcp_bpf.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index cc0bd73f3..8e905b50d 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -334,6 +334,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 
 static int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
 {
+	struct sk_psock *psock;
 	bool slow;
 
 	if (cmd != SIOCINQ)
@@ -344,7 +345,21 @@ static int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
 		return -EINVAL;
 
 	slow = lock_sock_fast(sk);
-	*karg = sk_psock_msg_inq(sk);
+	psock = sk_psock_get(sk);
+	if (unlikely(!psock)) {
+		unlock_sock_fast(sk, slow);
+		return tcp_ioctl(sk, cmd, karg);
+	}
+	*karg = sk_psock_get_msg_len_nolock(psock);
+	/* Without a verdict program, ingress data is never diverted to
+	 * ingress_msg: it stays in sk_receive_queue and is read through
+	 * the fallback to tcp_recvmsg(), so account for it like
+	 * tcp_ioctl() does.
+	 */
+	if (!READ_ONCE(psock->progs.stream_verdict) &&
+	    !READ_ONCE(psock->progs.skb_verdict))
+		*karg += tcp_inq(sk);
+	sk_psock_put(sk, psock);
 	unlock_sock_fast(sk, slow);
 
 	return 0;

-- 
Git-155)



