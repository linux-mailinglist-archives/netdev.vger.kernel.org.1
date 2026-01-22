Return-Path: <netdev+bounces-252211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH3fEOeucWlmLQAAu9opvQ
	(envelope-from <netdev+bounces-252211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 06:00:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9142661DBC
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 06:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7F0B729587
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8406E466B51;
	Thu, 22 Jan 2026 04:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aw8Hs/5l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E00466B5D
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 04:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769057847; cv=none; b=l6aczSOYnwKAs7MW2BiCgqK5Dm3r1X7/DjkbumOPvdtEB9pzcPOYpJ8StosRWL/SUX8HLCHPB3owmeE7fjX14ijMQdumleGhQtqFO23hpGDLJyQj3wYF3Ska3CQ4hGbEt32pWi5Wfm/UmigWkqxg4kXXsWoSyo5PcLOuLURqf4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769057847; c=relaxed/simple;
	bh=OuouQweB9Ott4p+c3mZNsKGvW6OQlkrz/dVO0j3NwFQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ArY63Q/CvAMthjrRCV6ItLblkwUvxwtWDBJZjkVQBYftqRhaLffZArJHqi+7//vD9ezDC/Cc4xTvjEV30mTqfuo+FaXLCso8kC73yAYN+F7GU1kz/ugmIRXCkjdt4eo5+DadW38/GdZEPkSD/N67fNl+7wbCVhnxfKIVjueqDAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Aw8Hs/5l; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8824d5b11easo15160196d6.3
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 20:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769057845; x=1769662645; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wE3l00sLNYhtiPCp34moNDGYpuQZ/X4QrZhCx8IVgHM=;
        b=Aw8Hs/5lhNA4IrQS9OGzQbkcsNGOSI6d7I6zp5RR6CjKEFesZEFG5mImCwLj/NoT9H
         4TfhibqyGS76+CGkoSCcjMXP8OHSYhIW60SJF4JnqRGHNjmi2impGwavQPmtrJSm8eby
         xaom0WQmq+AtpZpsMsG7giQgILp2jkCKQM8OccrkbCM72pEt1jDdKUchjdfH63PFdnAB
         dCIxq3UXC9j9Ea0YhQm7/TLMuKljKgiT1cHrzmZHc6n00PQpWKcDRCi7PJC5ogCGf3jJ
         AmzhM5Jdl0z2IG0QIj3HQSYz5KRdsK/gycXCgbLMKeYzDPwcpFP6yKkUWfz/RiFG+FxH
         +Icw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769057845; x=1769662645;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wE3l00sLNYhtiPCp34moNDGYpuQZ/X4QrZhCx8IVgHM=;
        b=G8c7Mt8E9HfrLqsMqcBELzrUJ8aDz7UNr4QUxh8Xmmlc0QL3nx4odtcAbedHBH9kZ0
         qVoNx5FpZtbx/TUGTbPtLD4XvgCwvQtEYAPQJ9aTlXlwCNBCC/PVMj7LoEj2ayuXJiAc
         0J0Th19M85puhXZP+Ss3m4Id1866ht/hwsfTPMlQxh2JWYFNkoyaNii/ds1Et2w1B1oQ
         4ttaScwxpqfLsWxXuHkHsGFQkq8mTxqN/878pC+YkP36vuGMu1dnuJQdksLckobnxSzR
         dPWtg0CzkIVoCoBzIKHJvDLLK2AwdbRKnJiwM1jnCercd5ED3zjn5EMphbbUeOwNQo6p
         0uMA==
X-Forwarded-Encrypted: i=1; AJvYcCW3WN9PqODdgx+/ZgY5XOYcXMmw1tjy4o7iYmbK6F+QVmXguV19b1yTJPYvn2UrxNZfpNULgT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjD4Rd7ABhHs81QFMUg9BLF5w8JHM2TQMAAawUOLb2u0wLsmXT
	FAiE1nYm31Dxn8SAS2eHlAc7QNs2EHkhV/u0uZbTlaPsqED7APWU3wy4AkD+CQ0b2bpuUo4PHFB
	lyvtHw3wqnr1POw==
X-Received: from qvab26.prod.google.com ([2002:a05:6214:611a:b0:894:4d8d:3a1a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:495:b0:880:5883:4d23 with SMTP id 6a1803df08f44-8942e2c8ca5mr300106146d6.16.1769057844733;
 Wed, 21 Jan 2026 20:57:24 -0800 (PST)
Date: Thu, 22 Jan 2026 04:57:17 +0000
In-Reply-To: <20260122045720.1221017-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260122045720.1221017-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122045720.1221017-3-edumazet@google.com>
Subject: [PATCH net-next 2/4] gro: change the BUG_ON() in gro_pull_from_frag0()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252211-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 9142661DBC
X-Rspamd-Action: no action

Replace the BUG_ON() which never fired with a DEBUG_NET_WARN_ON_ONCE()

$ scripts/bloat-o-meter -t vmlinux.1 vmlinux.2
add/remove: 2/2 grow/shrink: 1/1 up/down: 370/-254 (116)
Function                                     old     new   delta
gro_try_pull_from_frag0                        -     196    +196
napi_gro_frags                               771     929    +158
__pfx_gro_try_pull_from_frag0                  -      16     +16
__pfx_gro_pull_from_frag0                     16       -     -16
dev_gro_receive                             1514    1464     -50
gro_pull_from_frag0                          188       -    -188
Total: Before=22565899, After=22566015, chg +0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/gro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/gro.c b/net/core/gro.c
index 76f9c3712422109ad00f15f6804abf6a8b00db43..ad326c7cdc0a1f31c416ffe60cc492d3fcd7b050 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -415,7 +415,7 @@ static void gro_pull_from_frag0(struct sk_buff *skb, int grow)
 {
 	struct skb_shared_info *pinfo = skb_shinfo(skb);
 
-	BUG_ON(skb->end - skb->tail < grow);
+	DEBUG_NET_WARN_ON_ONCE(skb->end - skb->tail < grow);
 
 	memcpy(skb_tail_pointer(skb), NAPI_GRO_CB(skb)->frag0, grow);
 
-- 
2.52.0.457.g6b5491de43-goog


