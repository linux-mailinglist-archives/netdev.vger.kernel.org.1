Return-Path: <netdev+bounces-258991-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJJRCoA3lGlpAgIAu9opvQ
	(envelope-from <netdev+bounces-258991-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 10:40:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4404314A7D8
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 10:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06EC03008748
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 09:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9EE30FC0B;
	Tue, 17 Feb 2026 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VT5K2gMS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E2030F931
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771321192; cv=none; b=gQJgJ0+mJE/SWsKbIYRFZIREtBWg/vhuVpRm+v/QsM//PlXhHvJcZmpqQ1+gJrmvRkIycLrfPW4bYlVXW1iz4Wei17U1GxONPR2EMaA6eLTklVztsJXkfCZERlaV9Z1jGESgkvOrnjyYF01zF4NdeBBUeAAuf2MH/8V5i3kUYps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771321192; c=relaxed/simple;
	bh=Vm66pWgc99XKf4I5UTtPNuaY0Is4DlulWzBHZNZpbxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N3VqKhHV7ygriGRZrNqS/71ISv8Q4B6Cnwq44nOO6aIS1tiQKexxdxf8UBhm3WMGKHv2jpmuVyP/KR/k1uAWxnBrxDtatIq1LvIY+8rtXwyVG4l4JBnO9a2FXdjeV8IvthC8io2axN68lhj7qX75kMSeXgWFqyRnDLwqIXdUA8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VT5K2gMS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771321189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vu2OYVoTAR9MKJTTlJp0cG97I99hsl6me1NCQkIU8Hg=;
	b=VT5K2gMS8so8R+RZyq8bKG8QHvD5aPdPH7dVeKT4P/X3cEvyG3Ow3Bm7LuuVX2J4NyysGW
	iRmskDj1ZN9my6UQmEO7hKLajU5w1b2LvQTKxgAMAETB7qSgqd2hFQL8V7uGDP2qnwf0uz
	sABuz4Z+mcUaucSNsGOm486AA1or06U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-zj3gZSLVP_OdVC4hDPHZWQ-1; Tue,
 17 Feb 2026 04:39:43 -0500
X-MC-Unique: zj3gZSLVP_OdVC4hDPHZWQ-1
X-Mimecast-MFC-AGG-ID: zj3gZSLVP_OdVC4hDPHZWQ_1771321182
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7663E1956071;
	Tue, 17 Feb 2026 09:39:41 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.177])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1CA4D1800348;
	Tue, 17 Feb 2026 09:39:36 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Henrik Steen <henrist@henrist.net>,
	Olivier Tilmans <olivier.tilmans@nokia.com>,
	Bob Briscoe <research@bobbriscoe.net>,
	Olga Albisser <olga@albisser.org>,
	GangMin Kim <km.kim1503@gmail.com>
Subject: [PATCH net] net_sched: act_ct: drop all packets when not attached to ingress
Date: Tue, 17 Feb 2026 10:38:52 +0100
Message-ID: <674b8cbfc385c6f37fb29a1de08d8fe5c2b0fbee.1771321118.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,resnulli.us,davemloft.net,google.com,kernel.org,henrist.net,nokia.com,bobbriscoe.net,albisser.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-258991-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 4404314A7D8
X-Rspamd-Action: no action

Since the blamed commit below, classify can return TC_ACT_CONSUMED while
the current skb being held by the defragmentation engine. As reported by
GangMin Kim, if such packet is that may cause a UaF when the defrag engine
later on tries to tuch again such packet.

act_ct was never meant to be used outside of the ingress path. Making
defrag really works for act_ct outside such constraints range from very
difficult to completely impossible.

Address the issue making act_ct drop any packet when not attached to the
ingress path and additionally emit a warning about the bad
configuration.

Reported-by: GangMin Kim <km.kim1503@gmail.com>
Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
CC: stable@vger.kernel.org
Link: https://patch.msgid.link/16f6b264373ad60ab18eb8525809e7267442afa7.1770394932.git.pabeni@redhat.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Catching the bad configuration at runtime instead of init time to reduce
complexity
---
 net/sched/act_ct.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 81d488655793..e8eb0d195f4a 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -987,6 +987,11 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 	tcf_lastuse_update(&c->tcf_tm);
 	tcf_action_update_bstats(&c->common, skb);
 
+	if (!skb_at_tc_ingress(skb)) {
+		pr_warn_once("act_CT should be attached at ingress!\n");
+		goto drop;
+	}
+
 	if (clear) {
 		qdisc_skb_cb(skb)->post_ct = false;
 		ct = nf_ct_get(skb, &ctinfo);
@@ -1109,6 +1114,7 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 out_frag:
 	if (err != -EINPROGRESS)
 		tcf_action_inc_drop_qstats(&c->common);
+
 	return TC_ACT_CONSUMED;
 
 drop:
-- 
2.53.0


