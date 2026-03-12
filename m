Return-Path: <netdev+bounces-266814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGamFjINsmnuIAAAu9opvQ
	(envelope-from <netdev+bounces-266814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:47:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B56E326BBFE
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BB963047BDD
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 00:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F6E28643C;
	Thu, 12 Mar 2026 00:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tc6Rc7IT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CA919D093
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 00:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773276463; cv=pass; b=DusBe90Z6qaMdiWKjiJmL2YQisFOL3b+joDTPmFsr936JDXNTCheKcS7n2+WDTml7x2mGJNsYosTWVUrGXvzetIoU0w9t469i5cyURtaRc/s6ZCNcCrAbtOiTMCvBFI4Cc7cPXyOgkOEKSCou9TFjSSRzBg05aMgcI/A/PnKeUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773276463; c=relaxed/simple;
	bh=qChoOcqT0Bh4qtlTj6sxASJPFnyqLT3Oe6HzIYFxysY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=eDio4eY8J41W6d5SYzp+ny7xT8uuIkifaRVCVP1pQCruwkBb07Q+1/i7cBR/cvMa5FMW1qTwW+dFkWgxFt6vsWAgHXn1EmaL5YumETTlewNjUCfDqhIRGT7GMN3v3fpcYZ+wKvN1FSenq/59vy5ZwpTJsN4+wJxmQnGrakH1JXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tc6Rc7IT; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-505a1789a27so2402241cf.3
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 17:47:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773276461; cv=none;
        d=google.com; s=arc-20240605;
        b=Fg6GyzV6t8omQe2avvKjBhAmTdNcU9mjLBALsTAR+wmZ6B1BQrpvEccMo1Ekf+jefs
         lbgiG2sdYOS0+iKkLce4roUxFtmzMxDhlR/Th9Mt98VS2EwImKtBt9r/mmwlCk4A7mt8
         sUOtM7MXCf4KBYIAjA3NaZjpXn7R9+e4Jv+ADuSE2UDN0G6M9bta2B9AvpgFQXYbRyUM
         fnOBIlqwaY7Lr3j7c0+zCO1SK7EY+EbNjlLm8XtmjWd5+eXnJXGFqfeBKJyKPjay/CSJ
         +iKBbMeGvbQMgKH/RYnaSLqlt/1a0021bf4DcN9VQpUX73ZtrC7k9RkO7nbxXsoQpraD
         gN2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=zDbNUREFhH5e2Yms+7Pk/fgTgUaGs5xch2OkY4EQ1Io=;
        fh=+DxCOYHhPQDYUtB90R8alexrIY0jA1EQroJRMMAyDDg=;
        b=hllJF96E41pcVm+M7enuWL8tAbBN2u1QHXsS/W1roTeCpiEBDdoGiSLnbJuQMTpNgl
         vf6jZvsr7lDwcZ/TCg62kaUDh5CySm6AI450yumJ0nN4ebeCkNZcQQH1k+DDCiNXyjuQ
         x0lmHDApSKgbDvzCiKdF5O0fLwlXCmUIZTYyMU/ImDiYhaPlXW3usGXcePg7rLRP0Q16
         bIa50bP19YIYOKeYBCXKx3LJKLlLJbrtp2fWVVJoXb8/fo8dDEZfjRYRNHcKDeS4J0/K
         UvVdof6+6svjG3FR1XfLOL/iUNgkk3iLdqLrRC7wuEVjDK5mNV3YkuoqQwlQbq5sgd6I
         VvWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773276461; x=1773881261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zDbNUREFhH5e2Yms+7Pk/fgTgUaGs5xch2OkY4EQ1Io=;
        b=Tc6Rc7IT57Z42QdDLDb6DX/WEu1g7KR48zCl601zKshI4/fDjeXlt6/rnshxlj5Gdp
         8uvPf7f1RNC7BuHt4KVkdx2DMx9dwH2Y4UyXFoFjl7krKkYnDj6vloliO5tGTFol1sZ+
         kTZlsNiRzfRihULg84reSATr9mrkFVs7i/rM0a6bnOBrJCm9oXon4oFFxiF/xouGhdCm
         h91xur7lBRB1Eslvl4WjxwzNHFDSgm7/99l5K6I8EsnfjDYHeROkzE7t5KN91bPwfYHA
         lezWz+OqfjwaLl4mItfxx34MYCzbSQBbMDsFNo9WWTXOMijLD1Li5+pXIsITSXAByoIg
         Jcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773276461; x=1773881261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDbNUREFhH5e2Yms+7Pk/fgTgUaGs5xch2OkY4EQ1Io=;
        b=cg4GF1SAylFNEVfWbFTnMCzcZT4utaNU6bEgRPn04oX46ssnrWjkhjKRt12i+sVd3U
         4SoK8828oqB3WvqIQfe/fJWV+9e8KLrqIxqhd/TpcvieajoZHRiWYwKx3GMSf5ghmT1O
         YhWf0Y2nmvxHqPW8UnUB7q3XuaM0nSZJ9n5lcTMqVtT4IoLRHpUnq4v+HcVnFQ8wgJ3v
         UFNo7zQW/dfuiGvps/I/UuGCB3vWPdbnqUDzCQ4codW9uYGeKb9+l2/ppsdJKh4KA1Ld
         BuFwBe+3Ja5vAJv+nbwc8RYfHe1bWpEkqzGSuwDAPWfH420/l6rA6UQeHNa5c8gFVMZQ
         O9mg==
X-Gm-Message-State: AOJu0Yygt9BTXokF/KWe3K56G3zEHzsJBE7NqHOLITN61mAvZxJX/ZBh
	5Fwb0kmY1lZroaCdBAuv1ab72O4V1to3k87F9QMb0OxlwCRD7E8CQLAcfvMYfZxmx7L2Wbtyhn5
	0283J6YObT2pOaLAbOBdkmQqD3Tl2zmMgYBiRI/s=
X-Gm-Gg: ATEYQzxBul+tlUgpF4VWzdt7C4F/vt/Jw0jS9Iz/Syg7iGLZMYUQ9/AaWLJ0dREkBdl
	ucqbaazHA3a5xKmIk+0cZox1XptAmCeL5X6FLOIChqYpbw0tGrSOGj2XX6VjQL0XcpPvNZUWUuF
	51qJqWSdED3qYG9r9EAGY122niUd02Dr09kPK/d2C6Yiv77vC7/s0bAqWO0Hort5uGiCCQNeUT7
	Rqnmk1mrQ+FgGVh9TvbbOItKlmvKSotZmgVZHoJ+4L1+IBlucCSvN1jo9tmosverqsqlp8hu24w
	akoK+rw=
X-Received: by 2002:a05:622a:1214:b0:509:17e4:cef7 with SMTP id
 d75a77b69052e-50939fa4e06mr54529121cf.13.1773276460933; Wed, 11 Mar 2026
 17:47:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Guanni Qu <qguanni@gmail.com>
Date: Wed, 11 Mar 2026 17:47:30 -0700
X-Gm-Features: AaiRm53GGwP07P9EF2CIR20wlFTaXJZykekNPdtBuvncEM-e6-U4PL_Q3kgBMqY
Message-ID: <CAFzOa14g0=VGLentBuj54ebm4rVWCXPrjGA1toxWHmZ4M1hKgg@mail.gmail.com>
Subject: [PATCH] ipv6: ip6_tunnel: fix use-after-free in ip4ip6_err
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	klaudia@vidocsecurity.com, dawid@vidocsecurity.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266814-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qguanni@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vidocsecurity.com:email,vidocsecurity.com:url]
X-Rspamd-Queue-Id: B56E326BBFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This vulnerability was discovered by Klaudia Kloc and Dawid Moczad=C5=82o
of Vidoc Security Lab using VIDOC tool, and independently validated
and patched by
Jenny Guanni Qu.


1. BUG DESCRIPTION

In ip4ip6_err() in net/ipv6/ip6_tunnel.c, the route object returned by
ip_route_output_ports() is released via ip_rt_put(rt), but rt->rt_flags
is read immediately after the release. This is a use-after-free on a
logically freed object.

  skb2->dev =3D rt->dst.dev;
  ip_rt_put(rt);              // frees the route

  /* route "incoming" packet */
  if (rt->rt_flags & RTCF_LOCAL) {   // use-after-free read


2. ROOT CAUSE

File: net/ipv6/ip6_tunnel.c
Function: ip4ip6_err()

ip_rt_put() calls dst_release(), which schedules destruction via
call_rcu_hurry(). The rt->rt_flags read happens in the same function
context before any RCU grace period can elapse, so the memory is still
accessible but the object is logically freed.

Note: KASAN does not detect this because the RCU-deferred free has not
completed by the time rt_flags is read. The memory is not yet poisoned.


3. AFFECTED VERSIONS

- Confirmed on 6.12.64-87.122.amzn2023.x86_64 (via kprobe instrumentation)
- Source-level analysis confirms the bug on 6.12.0 (arm64)
- The put-then-use pattern has no fix in HEAD as of v6.12
- Architecture-independent (logic bug)


4. EVIDENCE

Kprobe instrumentation on x86_64 by Vidoc Security Lab showed 40/40
path hits where the same rt pointer value is observed both before and
after ip_rt_put():

  vidoc_pre_put:  ip4ip6_err+0x1b6  rt=3D0xffff8bee1cad73c0
  vidoc_post_put: ip4ip6_err+0x1bb  rt=3D0xffff8bee1cad73c0

All 40 packets sent via ICMPv6 Dest Unreachable to an ipip6 tunnel
endpoint hit the vulnerable path every time.


5. TRIGGER

Send ICMPv6 Destination Unreachable (code 3) packets to a configured
ipip6 tunnel endpoint.

  from scapy.all import IPv6, IP, ICMPv6DestUnreach, send
  inner =3D IPv6(src=3D"2001:db8::2", dst=3D"2001:db8::1", nh=3D4) / \
          IP(src=3D"127.0.0.1", dst=3D"127.0.0.2") / (b"A" * 8)
  pkt =3D IPv6(src=3D"::1", dst=3D"::1") / ICMPv6DestUnreach(code=3D3) / in=
ner
  send(pkt)

Requirements:
- ipip6 tunnel configured (ip6_tunnel module or built-in)
- Ability to send ICMPv6 packets to the tunnel endpoint


6. IMPACT

- Use-after-free read on a route object (struct rtable)
- Under normal conditions: reads stale but valid memory (RCU protects
  the actual free). Behavior is correct by accident.
- Under memory pressure or with KASAN slab quarantine: could read
  corrupted data, leading to incorrect routing decisions or crash
- Exploitability: low in practice due to RCU grace period, but the
  code is formally incorrect and violates memory safety


7. FIX

Save rt->rt_flags into a local variable before calling ip_rt_put(rt).

Reported-by: Klaudia Kloc (Vidoc Security Lab) <klaudia@vidocsecurity.com>
Reported-by: Dawid Moczad=C5=82o (Vidoc Security Lab) <dawid@vidocsecurity.=
com>
Co-developed-by: Jenny Guanni Qu <qguanni@gmail.com>
Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
---
 net/ipv6/ip6_tunnel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index b60e13c42bca..857a7ff8a041 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -567,6 +567,7 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm *=
opt,
  u8 rel_type =3D type;
  u8 rel_code =3D code;
  struct rtable *rt;
+ unsigned int rt_flags;
  struct flowi4 fl4;

  err =3D ip6_tnl_err(skb, IPPROTO_IPIP, opt, &rel_type, &rel_code,
@@ -615,10 +616,11 @@ ip4ip6_err(struct sk_buff *skb, struct
inet6_skb_parm *opt,
  goto out;

  skb2->dev =3D rt->dst.dev;
+ rt_flags =3D rt->rt_flags;
  ip_rt_put(rt);

  /* route "incoming" packet */
- if (rt->rt_flags & RTCF_LOCAL) {
+ if (rt_flags & RTCF_LOCAL) {
  rt =3D ip_route_output_ports(dev_net(skb->dev), &fl4, NULL,
     eiph->daddr, eiph->saddr, 0, 0,
     IPPROTO_IPIP,
--=20
2.34.1


8. TIMELINE

- 2026-02-09: Original discovery by Vidoc Security Lab via kprobe
  instrumentation on x86_64 (40/40 path hits confirmed)
- 2026-03-11: Source-level validation by Jenny Guanni Qu on 6.12.0
- 2026-03-12: Patch and disclosure


9. CREDIT

We request that any CVE assigned for this vulnerability credit both
parties:
- Discovery: Klaudia Kloc and Dawid Moczad=C5=82o, Vidoc Security Lab
  (https://vidocsecurity.com)
- Validation and fix: Jenny Guanni Qu


Thanks,
Jenny Guanni Qu

