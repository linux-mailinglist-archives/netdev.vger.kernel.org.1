Return-Path: <netdev+bounces-274140-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIj1Njk4zWnDawYAu9opvQ
	(envelope-from <netdev+bounces-274140-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 17:22:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D72E337CF52
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 17:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F94230714C0
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 14:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E6A3F8801;
	Wed,  1 Apr 2026 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="AOkmJ3DM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FCB361DD4
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775055219; cv=none; b=sHxoSzF6PMI9nDlrqNOFYJ+6xGxcBVsxqWR6yopMczgpIku80BEXoQ+ErJ5LU+kmTOQmd7wvOAB5tpM92sJUaCGFcnYP6rAnKPLnVro/ux/Cx2Sjkmp6Ubj9yPWjy93kpvpf1DDU9vQuabY8TSOVWwhTRDouIqJMjXzU1s47ai0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775055219; c=relaxed/simple;
	bh=4YzR0RT9+pwUNwlsBXG96fmgGJsmVlZwx+0otA70hL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwncIAp9STmjDYsUQu0oNyHH+orxl+cy27T+0udMKL/R2fuzXOLu/GQtNNX5+SrY+OIVveyJ0AU1cQ6RmX842RmnPWS261f1SMiu6wwH+ETUI3dFxya3VqAZdL7Pg/hrbDI7ar7dbLUG3A5t4TqfOxXvjjQFLuMsUPENzKTypYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=AOkmJ3DM; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2c54c68db4dso6467943eec.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 07:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775055217; x=1775660017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQEU246ZQ8XEOpZb4Pory1ftv7hcOK58ObhfiXMiXQ0=;
        b=AOkmJ3DMq8CDn3GSeXAR5YYmfaQrPXlX/bCpaSoCwL3C4uNK9iZYiakKCEalnzfR7c
         pgYrlZhVLAiZ05BQqvxaim7fDYPlJu/KO6nONP4fwg+fkzsD2vzme2N5Mgz93v08AQKN
         vCZjWEQTbNYY/O8JbHsnHniEJjj+5nF+KyKJxggH1p8lZ+R+1bXn651tIkqZAyQXxOMN
         bE3Oq+4sq0Bbv0Y5AYovBl3e92UBGUdXzMsZ1canvzt31IWV1qRWZ03+Va0x4G9NM/R+
         k5EiX1wCH21HHRX+oA8aT3/dFkEIRQGQ3+SVDbSKQa3dh7/DaPGDdFCCtGLQy3KMeRLR
         DO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775055217; x=1775660017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UQEU246ZQ8XEOpZb4Pory1ftv7hcOK58ObhfiXMiXQ0=;
        b=I6eD/3nVmLXdpwsD5TifJClBO/6jsh+Reemmel5zRN10b1SDsFPO9nRqA6tuQZ15bD
         AcQ9xpPpGUZyh2RgtQTGEWNzZycCQc5+QsynK/hF6ilhWO5/Gt8wpsVeABisoPgSFK1k
         oVSeHm5PXzoRQ5L4X4JnbZHdKxFMxBkTgisEihFY9mG0fGfEo3/x/Akeq2hpR4anc2Cy
         ykOPfnxkXKrc0xB7YNBERmuE4CZcJNhghb8VhYwoZ4zGfh86GqDD8RPPTX2oQE+cVjpJ
         M6T5sJ1/8PpNL0DPtWjuWjxGVKFZnBNK5vK2KV4y5/CWiPokDkyISF4EXQQSaoYBqSPr
         qThg==
X-Gm-Message-State: AOJu0YzVafPN1bO0uduOhdscITcPq8GPDjszCyJuofLMKwalBaFoQR89
	d41UGC4IptxryZR8a0C85S/xP5l63Y13AKGCKX87Z/tcLekJ1IVlUKQFxiaBigdEjzz3iOg9KDg
	BQg7C
X-Gm-Gg: ATEYQzzQHzBoPEQVE5oK4nKS3uOHxllRo4/wc/fXgdrUBM9sV2w0VhWnPR2/kZr1qul
	e+Ky22Qpr52VpVCX1++W1EkqkrH/HLjeKzrYuMhnUPnF73M1GXPfwj+qOPaq7iNVJ6b3OQXvVje
	6JKJ55Snh/akpcDEMdSJxfw5/RrvMjqTKbTdhSrPPMUkZeYTFaJh0RS8xJxyeBKXr+iEe+O+VK6
	ZxHFa/t8rtdloHFnH/uhtpupNuWhqymdz/xAmkX3f+MCo6l1lwbN0/D0WNZ1Mr1dmzM8iAQ/o0f
	6yglUge4WJtEGEPcNy7w4o0eEUHCMCCEFo8y6EmFzLjN8sK/AjhXjNph3XeUDfhzsbb+pRAHyfZ
	STJYpbteV2bZroPbpbgeKsP1tKtKcaYMiEyv1uhxYrYykew6h/9rrOkP4635WeKUnkmeDL/HkhY
	REhVx0BasU39A2ZfNRAiPCSAceofihaiyl
X-Received: by 2002:a05:7300:ed06:b0:2c8:72ff:bfb8 with SMTP id 5a478bee46e88-2c92e03c293mr2042700eec.0.1775055217518;
        Wed, 01 Apr 2026 07:53:37 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bda13csm12804830eec.6.2026.04.01.07.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:53:37 -0700 (PDT)
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
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 2/7] net/sched: netem: fix queue limit check to include reordered packets
Date: Wed,  1 Apr 2026 07:51:54 -0700
Message-ID: <20260401145332.78285-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401145332.78285-1-stephen@networkplumber.org>
References: <20260401145332.78285-1-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274140-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,networkplumber.org:email,networkplumber.org:mid,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: D72E337CF52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The queue limit check in netem_enqueue() uses q->t_len which only
counts packets in the internal tfifo. Packets placed in sch->q by
the reorder path (__qdisc_enqueue_head) are not counted, allowing
the total queue occupancy to exceed sch->limit under reordering.

Include sch->q.qlen in the limit check.

Fixes: 50612537e9ab ("netem: fix classful handling")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 2cc3acaa4068..6cc48b698e48 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -523,7 +523,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			1<<get_random_u32_below(8);
 	}
 
-	if (unlikely(q->t_len >= sch->limit)) {
+	if (unlikely(sch->q.qlen >= sch->limit)) {
 		/* re-link segs, so that qdisc_drop_all() frees them all */
 		skb->next = segs;
 		qdisc_drop_all(skb, sch, to_free);
-- 
2.53.0


