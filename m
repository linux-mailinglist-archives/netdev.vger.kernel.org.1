Return-Path: <netdev+bounces-261098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOpmFDuOn2nYcgQAu9opvQ
	(envelope-from <netdev+bounces-261098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 01:05:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC00319F466
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 01:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 206A8303137A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 00:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21D1288D6;
	Thu, 26 Feb 2026 00:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="HRsgHMBv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-244123.protonmail.ch (mail-244123.protonmail.ch [109.224.244.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B15413AF2;
	Thu, 26 Feb 2026 00:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772064310; cv=none; b=SyZ3ARQmrNZ20flOkTTsSEUpMMmm7Lhc6QztHSMahjd2N3T81hdfJChQCnGwrE1/MXFVurKQ9nLbUy2uW3XZcXeBcOdAhkqZpOwRu3GrKTeKww0AEb5PWjfoOMzwNEB8OOps1GSlJYTaVcsHxhLLZXqWhaT6NrVor9LYvynljgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772064310; c=relaxed/simple;
	bh=YZehy9s56FWNSb3Pf5eTDIK64u7tA+L61r81m1GERPw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jR6L2Sk8PxJhzLBqGuJNlL8gwflILqehrD8p9kiONHanBVoEEJyGcLrspk61RCtLnesWxwhmEE3VoY0Kd/87bYhB4F99IQU68PMEwLjq53F2cs0gZofOj8ILEBbo+8ekm2gF0BnY9U3YoCZwIpYUWGrIAb0Y9IS95Ko0EtnAJ+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=HRsgHMBv; arc=none smtp.client-ip=109.224.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1772064300; x=1772323500;
	bh=YZehy9s56FWNSb3Pf5eTDIK64u7tA+L61r81m1GERPw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=HRsgHMBvEZYgBplu3iyoFwJ7Q3yLZBnJVZEKozwsnCH9+ZJ/j+ydQ7QHvCPset6Hn
	 EgQiuQ65rE90ShUEJ6IPLJFtBJzjcaDxDOXWfUXoY0Ikr1p/SgTZNRgVHN8VegX4Ic
	 /DMQeGPHB90wUhar7R2n/jFGCGOinULoZRYky2ztM2DtMwzJIAS/pOoiKaRytfxjoT
	 9bvp9/H4j2+9yTEE8a30FGtORY1rcz1p7JNv5iE84wjDDJNrUAHZgYmI1J/7ZZAPD+
	 uO+0bJbZYGSe9i1rCgmdN/PqEycjBRk15xRgQoo1xS7fLLbPD/KuOlazA29tlj2PQ+
	 pwcbNccW9EU9Q==
Date: Thu, 26 Feb 2026 00:04:54 +0000
To: john.fastabend@gmail.com
From: Leon Kral <leon.j.kral@protonmail.com>
Cc: kuba@kernel.org, sd@queasysnail.net, chuck.lever@oracle.com, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Leon Kral <leon.j.kral@protonmail.com>
Subject: [PATCH] Documentation/networking/tls-handshake.rst: Fix of minor grammar mistake
Message-ID: <20260226000915.27898-1-leon.j.kral@protonmail.com>
Feedback-ID: 184191534:user:proton
X-Pm-Message-ID: 322c60e1bbec04ea3cae28319ea7f3466915e1bf
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[protonmail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-261098-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[protonmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.j.kral@protonmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,queasysnail.net,oracle.com,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,vger.kernel.org,lists.linux.dev,protonmail.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DKIM_TRACE(0.00)[protonmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[protonmail.com:mid,protonmail.com:dkim,protonmail.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC00319F466
X-Rspamd-Action: no action

The word "a" was used instead of "an" which is grammatically incorrect.
Fix by changing from "a" to "an". This improves readability of the
documentation.

Signed-off-by: Leon Kral <leon.j.kral@protonmail.com>
---
 Documentation/networking/tls-handshake.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/tls-handshake.rst b/Documentation/net=
working/tls-handshake.rst
index 6f5ea1646a47..4f7bc1087df9 100644
--- a/Documentation/networking/tls-handshake.rst
+++ b/Documentation/networking/tls-handshake.rst
@@ -7,7 +7,7 @@ In-Kernel TLS Handshake
 Overview
 =3D=3D=3D=3D=3D=3D=3D=3D
=20
-Transport Layer Security (TLS) is a Upper Layer Protocol (ULP) that runs
+Transport Layer Security (TLS) is an Upper Layer Protocol (ULP) that runs
 over TCP. TLS provides end-to-end data integrity and confidentiality in
 addition to peer authentication.
=20
--=20
2.53.0



