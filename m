Return-Path: <netdev+bounces-284702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sI35HSLO+mnMSwMAu9opvQ
	(envelope-from <netdev+bounces-284702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 07:14:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC804D6410
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 07:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3FDFE301A2F2
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 05:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E11A2FC00D;
	Wed,  6 May 2026 05:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hruDdlSH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160BC23E342
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 05:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778044444; cv=none; b=fh0yBXD1Zv+j+EZijTlxdJnQKegbQJB/4SqEIyTOknN0gUbGCardfp4OLM6GgWqtpZVWEeGjDD3dIKLBQIHcG6t+hQMSl4VGj17Q8B1iC3r/hzPhaX/mvUJdrxpOR6MZ38Cp5MEnEtWWuIzEKKu5krORc6UtK2TANj+//SWRXC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778044444; c=relaxed/simple;
	bh=3mPDjpz9UoYLq//zME7f0LLK/FYBp27tbNuZ0h5zQJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pw0o35CsqKk/P2R9av0zeTxPeEe1CMM3BJemkf3FhZEL92nuj0gyd1QKWB6VaQrP7vlvBkousth8yAYUf8A/uo4SDy5rV1e79qFc94MWfOJoJaFjck1hTnsZj2CO34GPGjIgvp6Uo5bQn+R6ZVV2H5If0X4ZiGctCCa81hk09c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hruDdlSH; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-130c653cce4so3316541c88.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 22:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778044441; x=1778649241; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ne6d3NPP/xf4CWREwfa7zTxmf8SmALy0wsZD1GHfx/w=;
        b=hruDdlSHHK/zBbWb8HtnaCSF5yAXUC3YmU7AckgiyHTkCOxCnmkn2PyrFQ9QBYivgw
         zi1zbk6YvxPLBk6gAdW3N6L0eOAhracP+6Yn0ySETPKmeDIo1ZWq+yaiDdtEzJLisQcT
         ijdPMpdUiyh+JtQHiQndtKZFslyd5ey9K34oy5PyKk7NwsEWTb41WHcBLjUJaVPasdGm
         Sl6kV4z4ht4qCPrJlPtml2tXpB0fiVNZ2kYBi0IUBab2hhFIs/qE03RWR1MUTgcAPxRa
         izgb5xzBGnz88M7ZHCIGSgYxrcnB2v8GJhv5kHBWgGzLoIVBNqrpyNKZtxCSWz5NZi/a
         tH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778044441; x=1778649241;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ne6d3NPP/xf4CWREwfa7zTxmf8SmALy0wsZD1GHfx/w=;
        b=EC0/y8AfWYyYmetfBpCv1krjTF09OpJFptnZnpSvdMgTvmBfjjHXQnWzzZUj4mr+8M
         7YFdWtch9PdzIjFDnIGw6D1DiK0iGn6qaQdUiJ7mKG4Rz2OrN8y7PtkmRa4KoKwC2qOM
         Gne3RD1I3hapQOXxmJybVWf0IfJt6JeC86C63eYsCm4Dfbt1V1lPHfwvIqiI3cQzfSTl
         dnGSG+UO51mRJitbs+h/HfG+gxSn4MtkdAVmAxkzh1QmbxdpgtXOHvMVDNqTizjVA105
         exKV13jNFgEPl2EqYyBhnjf0tBonVcw6QHjHqtJntajsWosQt5R1OTFZUhbNqxCMMiWI
         yj2w==
X-Forwarded-Encrypted: i=1; AFNElJ8gWFF+BABboKxUdxoH8XfiaCgFfjEpjsxy67VcjA8+uzTO6GZLsjWfJDcLGpc1fZTj/36y0VI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv69SeNxo0dQ0kvWCyvCLZqg+hkzSKeE+iFnzPMta7HFpq/BOw
	fKeYrIPq/n+X6YdHLIx04i2E9aTug5jcQTg2Rt0O+ggFKDBTzfmeTbTH
X-Gm-Gg: AeBDiesrdUYK+QugxNfs7vqRSw4DNvlEzZVCkJl2kJx/q5YaxeuTZuxvTsN4mk5LKi0
	yDsCOvJqR2wvOh5drPB8MvVUs0zG4oJdMtbdtKrPbk3Nuctp0YxjPyshREGKLPhc5LBR+/UYAud
	ZCsR6BthzwtW5bMxeJXRI3LYF2Aln/lRSTboR1vgnARRiRkRY9OfMRcUrgY8M6lH7A/gWVHb9yJ
	/GwY+EmrN3ZLvYujyIDXxPTQGmgaMQL7VxWDy85a/bva7/cok3fEtfDMIbCY+Oob4sHLAKBhurS
	EbCY4tQdnaypfHstPfFO7+wVGVUhup2uTAFAgGajDDb053kijPSqH4U4CJhrd2rpftdYvvd2Ei/
	W0yKKKtrvyka5oQ7dwp/faIrcNUro+IbF4qdE6Fqt/dY2T/9V1inKQq95Ir9i1ZqV1KWD0uexJ/
	MCL1xfwfpB+COY4EdbTrWzDIEPRin3UKScriT9ghLfkriF6CzcsxlfVRfkLliKyeqe/+OZWCSmE
	COe6MlpZW+2Lk8rQp0jPv8=
X-Received: by 2002:a05:7300:ec11:b0:2e5:5bf4:8869 with SMTP id 5a478bee46e88-2f54c87cd18mr1071089eec.21.1778044441041;
        Tue, 05 May 2026 22:14:01 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56fd8fa8csm1701041eec.21.2026.05.05.22.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 22:14:00 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Wed, 06 May 2026 02:13:45 -0300
Subject: [PATCH net] tipc: avoid sending zero-length stream messages
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260506-tipc-zero-length-stream-stall-v1-1-5d75f202227b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMBCE4Vche3aTUkSjr2I8lGWENbWQthoD4
 d2tepr8c/hWSoiKROdqpYiXJp1CiXpXkYwuDGDtS5M19mBa03LWWXhBnNgjDHnklCPco4zznq0
 0x33dw8qpoWLMETd9//wLBWS6/s/07O6Q/JVp2z7BsX93hgAAAA==
X-Change-ID: 20260505-tipc-zero-length-stream-stall-2c3741de2c93
To: Jon Maloy <jmaloy@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Ying Xue <ying.xue@windriver.com>, 
 Parthasarathy Bhuvaragan <parthasarathy.bhuvaragan@ericsson.com>
Cc: Jon Paul Maloy <jon.maloy@ericsson.com>, netdev@vger.kernel.org, 
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 syzbot+aa7d098bd6fa788fae8e@syzkaller.appspotmail.com, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1829;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=3mPDjpz9UoYLq//zME7f0LLK/FYBp27tbNuZ0h5zQJs=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJm/zolsfyX8tXyhaf4/2exTZgqV4edNkotv/wkqaytYe
 Mq/5k5JRykLgxgXg6yYIsvqpEWWe7oeXK2PW+EBM4eVCWQIAxenAEzklTQjw9RT2lZRq45cOtos
 WXo1zHf3z9ub/y48vXSK3KWZJYs/LJzB8D8wLT1C+7bQ2qvlEgITgnesffT0hvbaBe6KbQHBYX7
 mz7kA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Rspamd-Queue-Id: 7AC804D6410
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284702-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ericsson.com,vger.kernel.org,lists.sourceforge.net,syzkaller.appspotmail.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,aa7d098bd6fa788fae8e];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

TIPC stream send currently enters the transmit loop even when the
user payload length is zero. This can build and transmit a
header-only connection message.

For local TIPC sockets, such messages are delivered synchronously
through the loopback receive path. When this happens while socket
backlog processing is being flushed, reply transmission can re-enter
TIPC receive processing repeatedly and trigger an RCU stall.

Make zero-length sends on connected SOCK_STREAM TIPC sockets a no-op
after the existing connection/congestion wait has succeeded. Leave
implicit connection setup and SOCK_SEQPACKET behavior unchanged.

Fixes: 365ad353c256 ("tipc: reduce risk of user starvation during link congestion")
Cc: stable@vger.kernel.org
Reported-by: syzbot+aa7d098bd6fa788fae8e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000cedbc405ae81531f@google.com/
Closes: https://syzkaller.appspot.com/bug?extid=aa7d098bd6fa788fae8e
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 net/tipc/socket.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 9329919fb07f..3c7838713d74 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -1585,6 +1585,8 @@ static int __tipc_sendstream(struct socket *sock, struct msghdr *m, size_t dlen)
 					 tipc_sk_connected(sk)));
 		if (unlikely(rc))
 			break;
+		if (unlikely(!dlen && sk->sk_type == SOCK_STREAM))
+			break;
 		send = min_t(size_t, dlen - sent, TIPC_MAX_USER_MSG_SIZE);
 		blocks = tsk->snd_backlog;
 		if (tsk->oneway++ >= tsk->nagle_start && maxnagle &&

---
base-commit: 95084f1883a760e0d4290698346759d58e2b944a
change-id: 20260505-tipc-zero-length-stream-stall-2c3741de2c93

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


