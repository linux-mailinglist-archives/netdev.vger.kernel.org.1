Return-Path: <netdev+bounces-251875-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDJNElXZcGnCaQAAu9opvQ
	(envelope-from <netdev+bounces-251875-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:49:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D532357E84
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D77E60E699
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03627426696;
	Wed, 21 Jan 2026 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="FinjMozh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch [79.135.106.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA322F7AD6
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001647; cv=none; b=Y1zbcvEWbHsTUfl696I2WxnmZ6ZSDf6fq07fMuLNG/zF0HM+x74ym04BPlPQC/RhCPHZIE0e6y8c/6a8ut8LcCHnTEc8RXNRKte6VVX5EcsbUgUgIXWZgJd3rxFBi+8kNQ11mje6pyGZqDnLMut8tqdo2swiiL6VapMnTHMBrYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001647; c=relaxed/simple;
	bh=yd2NOl8qR9vazUYyuNp5iURVq8i3q+QR3gXcTq1q5bM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NMlP+OAME9dk1nM3QwFhdf0D4PFJoTthKRuM2ptVjdn1UM/E1GbHF2UXb9YrZt9h55CMazIvxQJeEkPBb9aannE5L+P/l1+eHwOs68l/PIYyKkdyPe1dtCX3s8PSuFArLuXN6fcY/uGAaDSTkpeawmE69s3//JVYUM6X/Z7MUFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=FinjMozh; arc=none smtp.client-ip=79.135.106.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1769001638; x=1769260838;
	bh=uR0vWLX68z8KOTADUQfKb6VvihqOcenbH5spIdlB5Z4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FinjMozh5Z5R9rPjNI107142E9H/ovUjDxoovDjwCOOJrkK2gsjBnZ38IzCwG6ymA
	 C031a+Sl/TKWnCq2ifB3EhSLmXj7NfNRYzR7YzUCGgpGbptpSc4xs6CXcuEBePyedx
	 jQf4FAl1hh/sKqD6sl5J6KAOmbyXOS/DB6csf47/jY91YHNmye0G5VJRBGBeUD9Tjh
	 hJXkTkBRWxB5fZAdWFHl5fxrO6vqKDn1P6TMN9Devwg+0Iwi/mFs3o86ha3IOSw9Rp
	 Z7jvyo7cVlea2PPQSXAJ9lKSzzMxxRH/HHexB3gywu8SgsDa5BI5JEo3SlaL1kXxsb
	 /E5ONiWnWAgIA==
Date: Wed, 21 Jan 2026 13:20:35 +0000
To: netdev@vger.kernel.org
From: Paul Moses <p@1g4.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>, stable@vger.kernel.org
Subject: [PATCH net v3 1/7] net/sched: act_gate: zero-initialize netlink dump struct
Message-ID: <20260121131954.2710459-2-p@1g4.org>
In-Reply-To: <20260121131954.2710459-1-p@1g4.org>
References: <20260121131954.2710459-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 2edab436c14d019c28ffa4bb4b211b0ade442e2d
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251875-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,1g4.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[1g4.org:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[1g4.org,quarantine];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1g4.org:email,1g4.org:dkim,1g4.org:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: D532357E84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Zero-initialize the dump struct before selective assignment to avoid
leaking stack padding in netlink replies. This matches other actions
(e.g. act_connmark) that zero-init their dump structs.

Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moses <p@1g4.org>
---
 net/sched/act_gate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index c1f75f2727576..aacd57e5f4374 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -499,16 +499,16 @@ static int tcf_gate_dump(struct sk_buff *skb, struct =
tc_action *a,
 {
 =09unsigned char *b =3D skb_tail_pointer(skb);
 =09struct tcf_gate *gact =3D to_gate(a);
-=09struct tc_gate opt =3D {
-=09=09.index    =3D gact->tcf_index,
-=09=09.refcnt   =3D refcount_read(&gact->tcf_refcnt) - ref,
-=09=09.bindcnt  =3D atomic_read(&gact->tcf_bindcnt) - bind,
-=09};
+=09struct tc_gate opt =3D { };
 =09struct tcfg_gate_entry *entry;
 =09struct tcf_gate_params *p;
 =09struct nlattr *entry_list;
 =09struct tcf_t t;
=20
+=09opt.index =3D gact->tcf_index;
+=09opt.refcnt =3D refcount_read(&gact->tcf_refcnt) - ref;
+=09opt.bindcnt =3D atomic_read(&gact->tcf_bindcnt) - bind;
+
 =09spin_lock_bh(&gact->tcf_lock);
 =09opt.action =3D gact->tcf_action;
=20
--=20
2.52.GIT



