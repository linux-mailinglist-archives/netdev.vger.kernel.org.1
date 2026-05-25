Return-Path: <netdev+bounces-291313-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGghOjVAFGoXLQcAu9opvQ
	(envelope-from <netdev+bounces-291313-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:27:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0241B5CA799
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 868D6300BC8C
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2533822B5;
	Mon, 25 May 2026 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="JqaCY4eE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10716382F1D
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779711983; cv=none; b=bQiGaMLIrxDsNiQ6vHEBD4QaAtMxIcUgb1zip9EAZptP2HvPs9SWxsEIJ1sMljrwYmLPbICf7CLUka1nCecCgHyFlFtoClvyrW/Wx3VZHF3imXEVJguBoJINcX4Gom6XQrmksiqf3VYZTU/IzDGlu9jetQegk0hdNzjAkA9PA84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779711983; c=relaxed/simple;
	bh=HkqjX4xaUaJ7h1I6HQMEQEhhmvqh6iBJUac55g/MKpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kJlXVy2N9u1qvPhQD3SX9JO5d4rJjmUK9At3FI2BwuaU9gdWN8JfiBebs6izklIxAhAvuLEgsI3+l5tXJZsq5QVbTJvzV/dRUhAzzcgwytgEMaIrjYEuHGLoygbCUVbJOBXuiY9ZRqRjloktN7MkURvrB+pPA5kpvhMpICVxJqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=JqaCY4eE; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8acb3daf2aaso173469846d6.0
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 05:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779711981; x=1780316781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4MZ4gCQX5aiJYGd6/6mZ3hTNNCOODLmR4+1g7vNsW8=;
        b=JqaCY4eEFcwq5sZNYn8arAqHYnV1uQRol7tda7xdbmNWkHTSd3Sy86Eud8Ze0UiNYv
         EpqfEEQ6NjADnu594BIvxYoKBBCS3tywbodX0tchTvJQmeEQLdDvZscOJJYwlmJEVSq7
         SWb9mmnjA+sIcvnIpWiM3ZO4JVUeITm++G7fWMWvd4yhVMuBtfNWyUN/4Z3iXbOnHF4j
         fnQidnJi7cDvW8YPmYfxPBWMSG4qrfI/wuCR1uI+bzKQLy5sYY4tIDrdCZroWuRE7CSd
         2/LyvyQuzmtXcyBphRtIxBi2+yKtaLZ0Abzxo+LjGMXhr/2cwnLh94gc2LEw1kr4CTTT
         go6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779711981; x=1780316781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w4MZ4gCQX5aiJYGd6/6mZ3hTNNCOODLmR4+1g7vNsW8=;
        b=htNsqMmnkO+xp+jLD7lcALt/BgFmboIRfXbFhZjFZQnJ7Lcixw++gQSgECfHuTherw
         8uaJDYUzD5evOfXw6NgiznWxNx1OB0twFP1KNpkda45Unot/EGwTS9broblG5r6kS0Ir
         gOgTjXznR+45ZfNs79HBzEsyeYhvnu7tIWZx7fzQwxCPVaDBgcElprAHnGcmwsVZM4UU
         HP9G0VNOOn7PfMbbmBsmTr1Y6+J8P0zsiQAkSNqh+Os0C4fffMu/7w+dpmlr/sFP3yG3
         7SH0D5Kw2ci0OW+l+Slj9ezNnJU010az/EabGDy+jAbAbxMyg3NWwjyv6wojt2KyIHZs
         qGDA==
X-Gm-Message-State: AOJu0Yy83i5bsy3hE4O0AC9O4SIBSTR4+Zdt/4iCKU9w1O6KodEuPSZ2
	0gaIzXpuSN0fU83gxfzNuQqwgDyGbspIq4V9cbQrgl0ZCaL7/dUORmyn+vnDKOCRZcPYUdQiqVl
	0EFFiwQ==
X-Gm-Gg: Acq92OH5axAjcEuTVLDFnddVUGlxuUji4Vet66U+1t0qwGLV/RjdnAGaV9YuKytKoIn
	Ge3/+qRRWrvYE8Ljo5jL9Un8QevumdDVt2Z6NYmwopWc5aXxwx97F3DKR/P3JvewqBRw11KIcJ8
	Qr0LUh6Vaz4bGB954AWt+/oactoJ0yqHYO0Q5FAAAm+9Yfkj5TUD5N8bopulYRYrN/8Sc424jl5
	NJ5MGfs7mtbIg49WyyyKeMYiPTcQR+qeiIkgIKTUTKowDdql88uTEJie/DerDvyy+t+OeJ8eX2q
	TvFx4E5zlOAVem8zzM6D8F6Z/MEhGY3RZ8AtW+MdHw2aDoMCBgmEP10IgqsOmxAGlasHCl8ieIO
	EAM4187BlJSOBbVmWzwja0vrhnpGZ1uRJq4iM6hNg+iOC8acOOgoocyVe3xsIawRmkTVvl+u6Iz
	cOAWHT14I1wwJ80leobTb6VPiBWOE=
X-Received: by 2002:a05:622a:5c1a:b0:516:d66e:7b20 with SMTP id d75a77b69052e-516d66ec055mr184294541cf.36.1779711980916;
        Mon, 25 May 2026 05:26:20 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8cba4easm91351761cf.24.2026.05.25.05.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 05:26:20 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	stephen@networkplumber.org,
	will@willsroot.io,
	hxzene@gmail.com,
	victor@mojatatu.com,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net v6 7/9] net/sched: act_mirred: Fix return code in early mirred redirect error paths
Date: Mon, 25 May 2026 08:25:54 -0400
Message-Id: <20260525122556.973584-8-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260525122556.973584-1-jhs@mojatatu.com>
References: <20260525122556.973584-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291313-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,willsroot.io,gmail.com,mojatatu.com];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mojatatu.com:mid,mojatatu.com:email,sashiko.dev:url,mojatatu-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 0241B5CA799
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Victor Nogueira <victor@mojatatu.com>

Since retval is set as TC_ACT_STOLEN in the mirred redirect case, returning
retval in cases where redirect failed will make the callers not register
the skb as being dropped.

Fix this by returning TC_ACT_SHOT instead in such scenarios.

Fixes: 16085e48cb48 ("net/sched: act_mirred: Create function tcf_mirred_to_dev and improve readability")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260413082027.2244884-1-hxzene%40gmail.com
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/act_mirred.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index dbe4a4ff3e08..553342c55cf7 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -372,7 +372,8 @@ static int tcf_blockcast_redir(struct sk_buff *skb, struct tcf_mirred *m,
 					 dev_is_mac_header_xmit(dev_prev),
 					 m_eaction, retval);
 
-	return retval;
+	/* If the packet wasn't redirected, we have to register as a drop */
+	return TC_ACT_SHOT;
 }
 
 static int tcf_blockcast_mirror(struct sk_buff *skb, struct tcf_mirred *m,
@@ -410,7 +411,7 @@ static int tcf_blockcast(struct sk_buff *skb, struct tcf_mirred *m,
 	block = tcf_block_lookup(dev_net(skb->dev), blockid);
 	if (!block || xa_empty(&block->ports)) {
 		tcf_action_inc_overlimit_qstats(&m->common);
-		return retval;
+		return is_redirect ? TC_ACT_SHOT : retval;
 	}
 
 	if (is_redirect)
@@ -428,8 +429,8 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 {
 	struct tcf_mirred *m = to_mirred(a);
 	int retval = READ_ONCE(m->tcf_action);
+	bool m_mac_header_xmit, is_redirect;
 	struct netdev_xmit *xmit;
-	bool m_mac_header_xmit;
 	struct net_device *dev;
 	bool want_ingress;
 	int i, m_eaction;
@@ -462,11 +463,13 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 		return retval;
 	}
 
+	is_redirect = tcf_mirred_is_act_redirect(m_eaction);
+
 	dev = rcu_dereference_bh(m->tcfm_dev);
 	if (unlikely(!dev)) {
 		pr_notice_once("tc mirred: target device is gone\n");
 		tcf_action_inc_overlimit_qstats(&m->common);
-		return retval;
+		goto err_out;
 	}
 
 	if (!want_ingress) {
@@ -476,7 +479,7 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 			pr_notice_once("tc mirred: loop on device %s\n",
 				       netdev_name(dev));
 			tcf_action_inc_overlimit_qstats(&m->common);
-			return retval;
+			goto err_out;
 		}
 		xmit->sched_mirred_dev[xmit->sched_mirred_nest++] = dev;
 	}
@@ -489,6 +492,11 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 		xmit->sched_mirred_nest--;
 
 	return retval;
+
+err_out:
+	if (is_redirect)
+		retval = TC_ACT_SHOT;
+	return retval;
 }
 
 static void tcf_stats_update(struct tc_action *a, u64 bytes, u64 packets,
-- 
2.54.0


