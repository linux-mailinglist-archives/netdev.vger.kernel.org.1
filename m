Return-Path: <netdev+bounces-272795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SF3rCu8cyGkShAUAu9opvQ
	(envelope-from <netdev+bounces-272795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:24:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB0334F89C
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EFEB13016B94
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 18:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCE03A7F6F;
	Sat, 28 Mar 2026 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="B0kvgoTO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98073A7F4D
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 18:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774722228; cv=none; b=A/S2yEiRyxjZoDgReF8awhB0lHAiERI+aIEjI3hPmRcZjLi4jv7xEytBDTtll9goSH1+ERc6q5g5o3UNUTE9KjtR8+e9+nLJNx4jOedLF9j8T5z9AJq3WXuPMHwEv9BBkO0vX1RkkJbxTyqAP+Ri0evxibu3LcX/zglTCnnjmGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774722228; c=relaxed/simple;
	bh=/maizwT8ZGLjouDwcq4bTwlangICy3f4G/zLNjuMzbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2QeSJ75OIJiBol7AcW5WI/gGu/LDgaFZNtQ+YNLSvfsgudEfNQRx2MOj3UbVLlhBlmSfqZgvRQz/D8thqVienEd3LSMv4aYgZXXAVvvFwNrBdAD5Ws9+Vqi46WPHUjRiBcYBaN4Vn4QJcVxDTedmSgJc6vQV+QFtNjqkN/WerM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=B0kvgoTO; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12732165d1eso4679444c88.1
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 11:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774722227; x=1775327027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iB0cCE3WCvRC67Xf0AcW1ajnHgViG1QsyhPCjiMGj9k=;
        b=B0kvgoTOTKV1AWqY/goilpX4EbaGqc6zokAj4bp3mznoydo3ZHwN0kc3jFUqBIROMK
         wUEupllJWE587KiWbP5xKlwddNpM6nuj8SQ4BcafiG3rl01JMFhArdHYNGxno9+GZ7tA
         XPdUUuwWrmtiVfuoU5OBx6vEPoUjmMwRKVwoyYYU9vJcNFHfHuOs8uADk2nH1Ouiup+U
         oDHJPVENWcozaI5ytODTqOUqGDEJ4Z12eT79AxGHm1pg3VsX2u2Awsc0HI6GO0ivuDaZ
         dqy5VwWWiTncfVeTgPEm0Xsx9LbygFVxz7kiVdrEOpEwHU9nGtywNMeKowFKnFTmO5cS
         QmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774722227; x=1775327027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iB0cCE3WCvRC67Xf0AcW1ajnHgViG1QsyhPCjiMGj9k=;
        b=F+2DUbn5PSx/agXlceQOp5ml7stmOcfYdP5V0NwFy4/ms8sKJhCMagaE3xTrZuTUgB
         hwRdJeuzIEUMFrD4a9JN3zIpdLl3azrDulyUpabknYS+ntWrKnU5yX50ikZRCg6pGRo3
         E2fo26sYbMNhDur7S7bRj0mj1WSIR5HR2770PSy9z24etuVOaMoo/3aebDgTo6aFocNJ
         uYgZ8tNB4nCX4mzIJxuhJzx/PjCCOuj/z/uM1Y153wS3u4MqAfkpXWiM5++P5UoOXuFN
         ZPO8WOph6YczeVXmTEy3u0VYVMRJMC7KuTvttIYjaNomRA4ebKZIJUiiMp6g89MGcM4K
         p+xA==
X-Gm-Message-State: AOJu0YzZe+GG8CK7RVSTfuK93lgcI7NgiXVtc9pZEg0hnJ11j/Mb2wEm
	h9ePV4DNSZ1yBTzu9h9iDU5QdssUbhoajhwEJ/kNrvEHAriujDcmtcjEs/rlOE7fb23SgdXebNH
	AJuYD
X-Gm-Gg: ATEYQzykgyE3dUkOQxOekN46iUbYh6mjDTrk14bGfV7P4r/9BGTw0E0S92E5S8RZ1eW
	Lutye4cfHof1MMBdKc41a11GS5oX2BxxtKyDklMBRDsyD+so92Ef/nFwW6M3GqsuuIDzGUqV1Vn
	PCLUNmVsac5KszicJhGtCfJt14S9KsMEKLxEGNVU91ykDmSQJh5swfWcdwnxeB5azO3Xeqz7LjZ
	axMPMnuxnhKfq99YbtNy+12jqsOCEiu9CZgKT4jHcIdmWab/FDa/euKd+hlkOIilX/6ZUhmZOKi
	AR+Ycq5C83J56Lqz0dD531NJWWUYgPZDaOFK3Rvp3ahYe7o42UX/PTtRTnXpgGrwEuN5Zi41wC8
	u5mf3VpkGGMdJBXXjJ2Jl6/VJfrDADI6t0Kl3Hs+WEXiLqaEayLiE9W45fXlVh79nUlKzXuOqy0
	MVPVVWWk4I1b18vUgZDHKzRHaYxOunXMIh
X-Received: by 2002:a05:7022:238e:b0:128:d1cf:8ab with SMTP id a92af1059eb24-12ab283baeemr3957248c88.6.1774722226810;
        Sat, 28 Mar 2026 11:23:46 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aba581027sm3133008c88.4.2026.03.28.11.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 11:23:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Peter Oskolkov <posk@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 5/5] net/sched: netem: null-terminate tfifo linear queue tail
Date: Sat, 28 Mar 2026 11:21:49 -0700
Message-ID: <20260328182336.392817-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328182336.392817-1-stephen@networkplumber.org>
References: <20260328182336.392817-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272795-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,networkplumber.org:email,networkplumber.org:mid,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: BFB0334F89C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When tfifo_enqueue() appends a packet to the linear queue tail,
nskb->next is never set to NULL. The list terminates correctly
only by accident if the skb arrived with next already NULL.

Explicitly null-terminate the tail to prevent list corruption.

Fixes: d66280b12bd7 ("net: netem: use a list in addition to rbtree")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index ce12b64603b2..4b27fab72fef 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -398,6 +398,7 @@ static void tfifo_enqueue(struct sk_buff *nskb, struct Qdisc *sch)
 			q->t_tail->next = nskb;
 		else
 			q->t_head = nskb;
+		nskb->next = NULL;
 		q->t_tail = nskb;
 	} else {
 		struct rb_node **p = &q->t_root.rb_node, *parent = NULL;
-- 
2.53.0


