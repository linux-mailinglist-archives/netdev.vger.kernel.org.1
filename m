Return-Path: <netdev+bounces-293044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLlSDOZJGWrzuQgAu9opvQ
	(envelope-from <netdev+bounces-293044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 10:10:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ABB5FEFEF
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 10:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 379483015C02
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 08:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85723A8723;
	Fri, 29 May 2026 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNz7L5B8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2554C2EC0B0
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 08:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780042030; cv=pass; b=uk1m0jEFdm2ucd0o8GA5Kv6Dastex/w7oPO+3K0dNwLJRN9R6U9sItvyIOqT6UIM+rF9u1lG499PIVjUl+VLLi6lteUjkDy6A8/8M41bgHhv6AojZbul9h1zi7T6UC3YXvtpYO7vJfPM/viwRfx4jvEAriOccf4drzACJXq2qMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780042030; c=relaxed/simple;
	bh=26uGjKJhF7Ddakx44i4KXkTkJJYN6EmrqWm7kC8zH14=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qOBLjvwQEeuiO+Zx5r2AjS00MBQ9K4+ejI3iAsyi00VqxTiPo8lOTncvG5a06r26dPWVhmkl5A8dVFLsIE9pDetgDdlShFBM162CiMb7BoVfbxbNoUgj8PMdvmhZjuR6iDXWLDmImWNyTpvYCvcmDWp9Rtt2kdaoQsZU45ZySpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNz7L5B8; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4903f7a90d1so65177145e9.2
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 01:07:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780042027; cv=none;
        d=google.com; s=arc-20240605;
        b=GiprFZJRZ5/LWSgJf5ILO8tcINr+gZn3XwOg8txh376hzJSbppfNvORkehM5kHf9UP
         /Ko/195Dycw20wWtbYgTl3tvNP7C81fyr30p2a3hbB5BpZLVXOxTnbmhrJ/MUEzYVmHG
         vkHaPYXfPHwtyzqSfazr7kiSkywHNB7PX2j4q6DrCh8XrmRsBz/7W3omKSn4aVus0xJx
         7kPQaS1IqQpNKTyGL/7q15+7BelFzb5TiWqUl+Mptn+3pMZT9l4TvYfEaktmBacoKWcd
         pJ7UazNj8MIqZwzayXcrfOGZ+fC1wzyBIlZslT8L7dBRNE6YrfKbJ1tA41x1E+FXo/YB
         x3fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Y6+Ljo6gp5N8XVnYpENupK4cMgNC3atHXTjpWfz4OOU=;
        fh=01eV1YuiE89+KTW4Fbp9aV9TlaGYFit/gRGGD3Q8Hmo=;
        b=gYRWGl0rONtJEvkhYFGUr4b1gGYmr8u3xwzkrdasOoSvmmBdiJdRcUaqWKYQ0Ng1wR
         ZG3N/DnnqeAFaqR88a1anp1LArgIiUSOfYWkTQmjiBJnEsqzGwHtzgj/rMwOuko77tea
         voKUi2eES3efwjNYSkpPm2I/apT0BZTQ+LQZlokXCLGYEcKTu4D/Tt0pTTGpUMqcG3g/
         NSNRada63bod1xgsMeqV4dd0T6zwS0sG7uVX9V9kavL0HlgipsBgLNXexW8d7uBOhdUj
         8qfjiZbivIpGgtSHtEaoTHZnv+4Cw+sOViCnXhKTaD/nM4z9QA34J44a6tfvkE1Ws34v
         gnpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780042027; x=1780646827; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y6+Ljo6gp5N8XVnYpENupK4cMgNC3atHXTjpWfz4OOU=;
        b=PNz7L5B81VC/u3yrfYsyXiotOKhbA5f8IAY9rHmg07xH2fodQ9zXD/AOawpLHfFsp9
         5f+CvfSZPlODiedu8/o0hAqnk6md0U0FpIqEdpq77+sPErwH9j8qQVndLe/XcX2YeOxQ
         bEPDTpeU/kHczDoS+mcAHB3sJ28PLHwyzMgwE/OaB26gcQCzlqX1Kf/IHKALOgZOCNja
         DUiW5NZqluo78KkuSmvkZPsPf7EL8w5t7jQIkPgVpKF55xmAyllYFipLR3U4NNJxq/CT
         OjAqsH7kZbGMFQl0IirfzYodFEUN2X/LBhxTLpWw7CTiBAp30QH97Y0glahYPDTtvlho
         5rGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780042027; x=1780646827;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6+Ljo6gp5N8XVnYpENupK4cMgNC3atHXTjpWfz4OOU=;
        b=LpfArcmzOaL4SlyoKz1IKqv9GJIPzcUDlj9Eb60R1RbKpZmUlMaozICy1A0yLqfGIZ
         T8F7blCJKWElT3CntC/EWcyNiJKZfZy6RwErjDTqxxzRQ/NPo8nY6B4zL4dW0vQ8Ahgh
         9IzioNPpJfXZ7wKR3niSKOWgXjKzHJCw5WbfgdGxrxYceENdjLYWWIdnPTWV72hRTzYt
         uTK5s503C3rZsdAbI6N2ucSg7/K8WlF2CkIJLepOR1bNIf9l0VW2yoroVKujvlRBn/N5
         XWo84PIqAaQK5onLo7eA2enH6yWkpjB44KSNlFQVD20BKUIO5z+gAL3uLXYyQxx0nCNM
         mhhw==
X-Forwarded-Encrypted: i=1; AFNElJ+4oyGLLuxFRvQUeg9ZGTGvzssyfy3Zl/5QaNvTBd4TNtt86YnUqgVEcPr/Cf6pWY+44JnHR0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw21IhMZzKlMzbPiPSHNOkXRU1pF5XITjLxRq5azvyzmkhWwSOL
	dRRxZWwrxcYKJ70Mf+AoE6r0EsTkMdr8Dn9YJstYQpEeFhQJT3kHdnQfIuR67F8q6wl/wLg1rbD
	QmU28cIwgSUF3XVbHxbDyC+CVi0/knVI=
X-Gm-Gg: Acq92OFzm1EEQynG3GaI9RvHOD4VxYQmy3wmgast7P8yfG/RWxxzBXN6mm/p7qa/L1G
	4qc87TDgHtCYsxS00KohbmEhfdtQ5ZaxMBexHmKBpz4To6/cTE3HH/n5TKTnGp/UMQtFyL7JhwP
	behw3mL9gBdguSgvOCUYS+E6x0RaYFpS5Tz7T9ZHOrSJIZHxMCRiYwkp17Mhlm+D8GXC/TOyJBQ
	ZBBCC0Xo8H1rFYa7M8bpCN0LHfHhMRRmQBoN67JCJdlhMyKt+xAzQ31qXOzrWGg5YPb1Wak/R1F
	GQwhSlvZ+sYvxyL1OeER/DxFoZiPe5T083ez0/YufsaLHdHQgw==
X-Received: by 2002:a05:600c:a40c:b0:48a:6fd4:d3d3 with SMTP id
 5b1f17b1804b1-4909c0ba8bdmr18419205e9.20.1780042027350; Fri, 29 May 2026
 01:07:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
Date: Fri, 29 May 2026 17:06:29 +0900
X-Gm-Features: AVHnY4JwoEVN6N5Y0_V0VbcQQSlXevwSP7QlMYIawaPq3KGA-RzACpaaQeUpin4
Message-ID: <CAOrxSK7v1BK_KsrfreHHAbfthAMDCZOBpOrCtzAjff1Wx-gr6w@mail.gmail.com>
Subject: [PATCH] xfrm: policy: Fix use-after-free on inexact bin in xfrm_policy_bysel_ctx()
To: steffen.klassert@secunet.com
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000b9e5b70652f05476"
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293044-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanghyunparkcnu@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C1ABB5FEFEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000b9e5b70652f05476
Content-Type: text/plain; charset="UTF-8"

xfrm_policy_bysel_ctx() saves a pointer to a xfrm_pol_inexact_bin
while holding xfrm_policy_lock, then drops the lock to call
xfrm_policy_kill(). After that it calls
xfrm_policy_inexact_prune_bin() on the saved pointer. A concurrent
xfrm_hash_rebuild (triggered by XFRM_MSG_NEWSPDINFO) can free the bin
via __xfrm_policy_inexact_flush() -> kfree_rcu() during the window
where the lock is not held, making the saved pointer stale.

Fix by pruning the bin while still holding xfrm_policy_lock, before
dropping it. Use __xfrm_policy_inexact_prune_bin() directly since the
lock is already held. This is safe because the function uses
kfree_rcu() for the actual free, which is non-blocking. The wrapper
xfrm_policy_inexact_prune_bin() becomes unused and is removed.

Race:

  CPU0 (XFRM_MSG_DELPOLICY)         CPU1 (XFRM_MSG_NEWSPDINFO)
  ============================       ==========================
  xfrm_policy_bysel_ctx():
    spin_lock_bh(xfrm_policy_lock)
    bin = xfrm_policy_inexact_lookup()
    __xfrm_policy_unlink(pol)
    spin_unlock_bh(xfrm_policy_lock)
    xfrm_policy_kill(ret)
    // wide window, lock not held
                                     xfrm_hash_rebuild():
                                       spin_lock_bh(xfrm_policy_lock)
                                       __xfrm_policy_inexact_flush():
                                         kfree_rcu(bin)  // bin freed
                                       spin_unlock_bh(xfrm_policy_lock)
    xfrm_policy_inexact_prune_bin(bin)
    // UAF: bin is freed

Reproduction:

  1. Build kernel >= 4.19 with CONFIG_KASAN=y, CONFIG_XFRM=y,
     CONFIG_USER_NS=y (for unprivileged reproduction)
  2. Boot in a VM
  3. Compile: gcc -O2 -o repro -static -pthread repro.c
  4. Run as any unprivileged user: ./repro 30 4
     (30 seconds duration, 4 threads per type)
  5. Check dmesg for: BUG: KASAN: slab-use-after-free in xfrm_policy_bysel_ctx

  The reproducer is fully unprivileged: it uses unshare(CLONE_NEWUSER |
  CLONE_NEWNET) to get CAP_NET_ADMIN inside a user namespace, then
  races XFRM_MSG_DELPOLICY (by selector) against XFRM_MSG_NEWSPDINFO
  (threshold changes that trigger hash rebuilds).

  Note: the race is hard to trigger with vanilla kfree_rcu because the
  actual free is deferred past the typical stale-access window. Adding a
  cond_resched() delay after xfrm_policy_kill() or replacing kfree_rcu
  with kfree (for testing only) makes it reliably reproducible. The
  lifetime violation exists regardless of whether KASAN catches it on a
  given run.

KASAN report (reproduced on 6.12.91 with immediate kfree for testing):

  BUG: KASAN: slab-use-after-free in xfrm_policy_bysel_ctx.cold+0x59/0xb8
  Read of size 8 at addr ffff8881153c4700 by task repro_xfrm/387

  Call Trace:
   xfrm_policy_bysel_ctx.cold+0x59/0xb8
   xfrm_get_policy+0x7df/0xc00
   xfrm_user_rcv_msg+0x41b/0x950
   netlink_rcv_skb+0x16d/0x420

Fixes: 9cf545ebd5d8 ("xfrm: policy: implement selector-based inexact lookup")
Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
---

Hi,

I'm Sanghyun Park, a security researcher. I found this while auditing
the XFRM policy code. The bug has existed since 4.19 and affects all
kernels since then. It is triggerable by any unprivileged user via user
namespaces (CLONE_NEWUSER + CLONE_NEWNET), making it a potential LPE
vector on systems with user namespaces enabled (all major distros by
default: Ubuntu, Fedora, Debian, Arch, etc.).

The C reproducer is attached separately (repro.c).

 net/xfrm/xfrm_policy.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index fca07f8e60..fef6cff511 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1156,15 +1156,6 @@ static void
__xfrm_policy_inexact_prune_bin(struct xfrm_pol_inexact_bin *b, bool
  }
 }

-static void xfrm_policy_inexact_prune_bin(struct xfrm_pol_inexact_bin *b)
-{
- struct net *net = read_pnet(&b->k.net);
-
- spin_lock_bh(&net->xfrm.xfrm_policy_lock);
- __xfrm_policy_inexact_prune_bin(b, false);
- spin_unlock_bh(&net->xfrm.xfrm_policy_lock);
-}
-
 static void __xfrm_policy_inexact_flush(struct net *net)
 {
  struct xfrm_pol_inexact_bin *bin, *t;
@@ -1707,12 +1698,14 @@ xfrm_policy_bysel_ctx(struct net *net, const
struct xfrm_mark *mark, u32 if_id,
  }
  ret = pol;
  }
+
+ if (bin && ret && delete)
+ __xfrm_policy_inexact_prune_bin(bin, false);
+
  spin_unlock_bh(&net->xfrm.xfrm_policy_lock);

  if (ret && delete)
  xfrm_policy_kill(ret);
- if (bin && delete)
- xfrm_policy_inexact_prune_bin(bin);
  return ret;
 }
 EXPORT_SYMBOL(xfrm_policy_bysel_ctx);

--000000000000b9e5b70652f05476
Content-Type: text/plain; charset="US-ASCII"; name="kasan_dmesg.txt"
Content-Disposition: attachment; filename="kasan_dmesg.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mpqn1d1e1>
X-Attachment-Id: f_mpqn1d1e1

WyAgIDQyLjA1NzY4MF0gQlVHOiBLQVNBTjogc2xhYi11c2UtYWZ0ZXItZnJlZSBpbiB4ZnJtX3Bv
bGljeV9ieXNlbF9jdHguY29sZCsweDU5LzB4YjgKWyAgIDQyLjA1ODU3OV0gUmVhZCBvZiBzaXpl
IDggYXQgYWRkciBmZmZmODg4MTE1M2M0NzAwIGJ5IHRhc2sgcmVwcm9feGZybS8zODcKClsgICA0
Mi4wNTk1NDRdIENQVTogMSBVSUQ6IDAgUElEOiAzODcgQ29tbTogcmVwcm9feGZybSBOb3QgdGFp
bnRlZCA2LjEyLjkxLWRpcnR5ICMyMwpbICAgNDIuMDU5NTU1XSBIYXJkd2FyZSBuYW1lOiBRRU1V
IFVidW50dSAyNS4wNCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MgMS4xNi4zLWRlYmlh
bi0xLjE2LjMtMiAwNC8wMS8yMDE0ClsgICA0Mi4wNTk1NjJdIENhbGwgVHJhY2U6ClsgICA0Mi4w
NTk1NzVdICA8VEFTSz4KWyAgIDQyLjA1OTU4Ml0gIGR1bXBfc3RhY2tfbHZsKzB4YmEvMHgxMTAK
WyAgIDQyLjA1OTYyM10gID8geGZybV9wb2xpY3lfYnlzZWxfY3R4LmNvbGQrMHg1OS8weGI4Clsg
ICA0Mi4wNTk2MzBdICBwcmludF9yZXBvcnQrMHgxNzQvMHg0ZjYKWyAgIDQyLjA1OTY2NV0gID8g
X192aXJ0X2FkZHJfdmFsaWQrMHg4Ni8weDY3MApbICAgNDIuMDU5NzAxXSAgPyB4ZnJtX3BvbGlj
eV9ieXNlbF9jdHguY29sZCsweDU5LzB4YjgKWyAgIDQyLjA1OTcwOF0gIGthc2FuX3JlcG9ydCsw
eGRhLzB4MTEwClsgICA0Mi4wNTk3MzZdICA/IHhmcm1fcG9saWN5X2J5c2VsX2N0eC5jb2xkKzB4
NTkvMHhiOApbICAgNDIuMDU5NzQ1XSAgeGZybV9wb2xpY3lfYnlzZWxfY3R4LmNvbGQrMHg1OS8w
eGI4ClsgICA0Mi4wNTk3NTNdICA/IF9fcGZ4X3hmcm1fcG9saWN5X2J5c2VsX2N0eCsweDEwLzB4
MTAKWyAgIDQyLjA1OTc2OF0gID8gZmluZF9oZWxkX2xvY2srMHgyZC8weDExMApbICAgNDIuMDU5
Nzk4XSAgeGZybV9nZXRfcG9saWN5KzB4N2RmLzB4YzAwClsgICA0Mi4wNTk4MjFdICA/IF9fcGZ4
X3hmcm1fZ2V0X3BvbGljeSsweDEwLzB4MTAKWyAgIDQyLjA1OTgyOF0gID8gaGxvY2tfY2xhc3Mr
MHg0ZS8weDEzMApbICAgNDIuMDU5ODM0XSAgPyBjYXBfY2FwYWJsZSsweDFkNC8weDI0MApbICAg
NDIuMDU5ODc5XSAgPyBfX25sYV9wYXJzZSsweDQwLzB4NjAKWyAgIDQyLjA1OTkwOF0gID8gX19w
ZnhfeGZybV9nZXRfcG9saWN5KzB4MTAvMHgxMApbICAgNDIuMDU5OTE0XSAgeGZybV91c2VyX3Jj
dl9tc2crMHg0MWIvMHg5NTAKWyAgIDQyLjA1OTkyMV0gID8gX19wZnhfeGZybV91c2VyX3Jjdl9t
c2crMHgxMC8weDEwClsgICA0Mi4wNTk5MjZdICA/IGhsb2NrX2NsYXNzKzB4NGUvMHgxMzAKWyAg
IDQyLjA1OTkzMl0gID8gX19sb2NrX2FjcXVpcmUrMHhmZGYvMHgzYjUwClsgICA0Mi4wNTk5NTFd
ICA/IF9fbXV0ZXhfdHJ5bG9ja19jb21tb24rMHhkZS8weDI1MApbICAgNDIuMDU5OTU3XSAgPyBf
X3BmeF9fX211dGV4X3RyeWxvY2tfY29tbW9uKzB4MTAvMHgxMApbICAgNDIuMDU5OTYyXSAgbmV0
bGlua19yY3Zfc2tiKzB4MTZkLzB4NDIwClsgICA0Mi4wNTk5NjhdICA/IF9fcGZ4X3hmcm1fdXNl
cl9yY3ZfbXNnKzB4MTAvMHgxMApbICAgNDIuMDU5OTczXSAgPyBfX3BmeF9uZXRsaW5rX3Jjdl9z
a2IrMHgxMC8weDEwClsgICA0Mi4wNTk5NzddICA/IG5ldGxpbmtfZGVsaXZlcl90YXArMHgxYWYv
MHhkNTAKWyAgIDQyLjA1OTk5OF0gIHhmcm1fbmV0bGlua19yY3YrMHg3Ni8weDkwClsgICA0Mi4w
NjAwMDNdICBuZXRsaW5rX3VuaWNhc3QrMHg1OGMvMHg4NTAKWyAgIDQyLjA2MDAxMF0gID8gX19w
ZnhfbmV0bGlua191bmljYXN0KzB4MTAvMHgxMApbICAgNDIuMDYwMDE4XSAgbmV0bGlua19zZW5k
bXNnKzB4OGY3LzB4ZGMwClsgICA0Mi4wNjAwMjZdICA/IF9fcGZ4X25ldGxpbmtfc2VuZG1zZysw
eDEwLzB4MTAKWyAgIDQyLjA2MDAzNF0gID8gX19wZnhfbmV0bGlua19zZW5kbXNnKzB4MTAvMHgx
MApbICAgNDIuMDYwMDQxXSAgX19fX3N5c19zZW5kbXNnKzB4OTA3LzB4YTYwClsgICA0Mi4wNjAw
NzVdICA/IF9fcGZ4X19fX19zeXNfc2VuZG1zZysweDEwLzB4MTAKWyAgIDQyLjA2MDA4MV0gID8g
bmV0bGlua19yZWN2bXNnKzB4NzdiLzB4ZTYwClsgICA0Mi4wNjAwODhdICBfX19zeXNfc2VuZG1z
ZysweDE5Ny8weDFlMApbICAgNDIuMDYwMDkzXSAgPyBfX3BmeF9fX19zeXNfc2VuZG1zZysweDEw
LzB4MTAKWyAgIDQyLjA2MDEwNF0gIF9fc3lzX3NlbmRtc2crMHgxNzYvMHgyMjAKWyAgIDQyLjA2
MDEyMF0gID8gX19wZnhfX19zeXNfc2VuZG1zZysweDEwLzB4MTAKWyAgIDQyLjA2MDEyOF0gID8g
dHJhY2VfeDg2X2ZwdV9yZWdzX2FjdGl2YXRlZCsweDVkLzB4MWIwClsgICA0Mi4wNjAxNTRdICBk
b19zeXNjYWxsXzY0KzB4YmIvMHgxZjAKWyAgIDQyLjA2MDE3NF0gIGVudHJ5X1NZU0NBTExfNjRf
YWZ0ZXJfaHdmcmFtZSsweDc3LzB4N2YKWyAgIDQyLjA2MDIwMl0gUklQOiAwMDMzOjB4NDU1Yjgy
ClsgICA0Mi4wNjAyMTldIENvZGU6IDA4IDBmIDg1IDcxIGRmIGZmIGZmIDQ5IDg5IGZiIDQ4IDg5
IGYwIDQ4IDg5IGQ3IDQ4IDg5IGNlIDRjIDg5IGMyIDRkIDg5IGNhIDRjIDhiIDQ0IDI0IDA4IDRj
IDhiIDRjIDI0IDEwIDRjIDg5IDVjIDI0IDA4IDBmIDA1IDxjMz4gNjYgMmUgMGYgMWYgODQgMDAg
MDAgMDAgMDAgMDAgMGYgMWYgMDAgZjMgMGYgMWUgZmEgNTUgNDggODkgZTUKWyAgIDQyLjA2MDIy
NF0gUlNQOiAwMDJiOjAwMDA3ZjNkZmM5YTNmNjggRUZMQUdTOiAwMDAwMDI0NiBPUklHX1JBWDog
MDAwMDAwMDAwMDAwMDAyZQpbICAgNDIuMDYwMjQ3XSBSQVg6IGZmZmZmZmZmZmZmZmZmZGEgUkJY
OiAwMDAwN2YzZGZjOWE1NmMwIFJDWDogMDAwMDAwMDAwMDQ1NWI4MgpbICAgNDIuMDYwMjUxXSBS
RFg6IDAwMDAwMDAwMDAwMDAwMDAgUlNJOiAwMDAwN2YzZGZjOWEzZmUwIFJESTogMDAwMDAwMDAw
MDAwMDAwNApbICAgNDIuMDYwMjU0XSBSQlA6IDAwMDA3ZjNkZmM5YTNmOTAgUjA4OiAwMDAwMDAw
MDAwMDAwMDAwIFIwOTogMDAwMDAwMDAwMDAwMDAwMApbICAgNDIuMDYwMjU3XSBSMTA6IDAwMDAw
MDAwMDAwMDAwMDAgUjExOiAwMDAwMDAwMDAwMDAwMjQ2IFIxMjogMDAwMDAwMDAwMDAwMDAyMApb
ICAgNDIuMDYwMjYwXSBSMTM6IGZmZmZmZmZmZmZmZmZmZDAgUjE0OiAwMDAwMDAwMDAwMDAwMDAx
IFIxNTogMDAwMDdmZmViNTk3MGNiMApbICAgNDIuMDYwMjY2XSAgPC9UQVNLPgoKWyAgIDQyLjA5
MDY2Nl0gQWxsb2NhdGVkIGJ5IHRhc2sgMzg3OgpbICAgNDIuMDkxMDc3XSAga2FzYW5fc2F2ZV9z
dGFjaysweDMwLzB4NTAK
--000000000000b9e5b70652f05476
Content-Type: application/octet-stream; name="repro.c"
Content-Disposition: attachment; filename="repro.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mpqn18j10>
X-Attachment-Id: f_mpqn18j10

LyoKICogWEZSTSBQb2xpY3kgSW5leGFjdCBCaW4gVUFGIFBvQwogKgogKiBCdWc6IHhmcm1fcG9s
aWN5X2J5c2VsX2N0eCgpIHNhdmVzIGEgYmluIHBvaW50ZXIsIGRyb3BzIHhmcm1fcG9saWN5X2xv
Y2ssCiAqIGNhbGxzIHhmcm1fcG9saWN5X2tpbGwoKSAod2lkZSB3aW5kb3cpLCB0aGVuIHVzZXMg
dGhlIHN0YWxlIGJpbiBwb2ludGVyCiAqIGluIHhmcm1fcG9saWN5X2luZXhhY3RfcHJ1bmVfYmlu
KCkuIEEgY29uY3VycmVudCB4ZnJtX2hhc2hfcmVidWlsZCBjYW4KICogZnJlZSB0aGUgYmluIHZp
YSBfX3hmcm1fcG9saWN5X2luZXhhY3RfZmx1c2ggLT4ga2ZyZWVfcmN1IGR1cmluZyB0aGF0IHdp
bmRvdy4KICoKICogUmFjZToKICogICBUaHJlYWQgQTogWEZSTV9NU0dfTkVXU1BESU5GTyAtPiB4
ZnJtX3BvbGljeV9oYXNoX3JlYnVpbGQgLT4gc2NoZWR1bGVfd29yawogKiAgICAgICAgICAgICAt
PiB4ZnJtX2hhc2hfcmVidWlsZCAtPiBfX3hmcm1fcG9saWN5X2luZXhhY3RfZmx1c2ggLT4ga2Zy
ZWVfcmN1KGJpbikKICogICBUaHJlYWQgQjogWEZSTV9NU0dfREVMUE9MSUNZIChieSBzZWxlY3Rv
ciwgaW5kZXg9MCkgLT4geGZybV9wb2xpY3lfYnlzZWxfY3R4CiAqICAgICAgICAgICAgIC0+IHNh
dmVzIGJpbiwgdW5saW5rcyBwb2xpY3ksIGRyb3BzIGxvY2ssIHhmcm1fcG9saWN5X2tpbGwocmV0
KSwKICogICAgICAgICAgICAgLT4geGZybV9wb2xpY3lfaW5leGFjdF9wcnVuZV9iaW4oc3RhbGVf
YmluKSAtPiBVQUYKICoKICogUmVhY2hhYmlsaXR5OiBGdWxseSB1bnByaXZpbGVnZWQgdmlhIHVu
c2hhcmUoQ0xPTkVfTkVXVVNFUnxDTE9ORV9ORVdORVQpLgogKiBYRlJNIG5ldGxpbmsgdXNlcyBu
ZXRsaW5rX25ldF9jYXBhYmxlKCkgd2hpY2ggYWNjZXB0cyBDQVBfTkVUX0FETUlOCiAqIGluc2lk
ZSB0aGUgdXNlciBuYW1lc3BhY2UncyBuZXR3b3JrIG5hbWVzcGFjZS4KICoKICogRXhwZWN0ZWQ6
IEtBU0FOIHNsYWItdXNlLWFmdGVyLWZyZWUgb24geGZybV9wb2xpY3lfaW5leGFjdF9wcnVuZV9i
aW4KICovCgojZGVmaW5lIF9HTlVfU09VUkNFCiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8
c3RkbGliLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVk
ZSA8ZXJybm8uaD4KI2luY2x1ZGUgPHNjaGVkLmg+CiNpbmNsdWRlIDxwdGhyZWFkLmg+CiNpbmNs
dWRlIDxzeXMvc29ja2V0Lmg+CiNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KI2luY2x1ZGUgPGxpbnV4
L25ldGxpbmsuaD4KI2luY2x1ZGUgPGxpbnV4L3hmcm0uaD4KCi8qIFhGUk0gbWVzc2FnZSB0eXBl
cyAqLwojaWZuZGVmIFhGUk1fTVNHX05FV1BPTElDWQojZGVmaW5lIFhGUk1fTVNHX05FV1BPTElD
WSAweDEzCiNlbmRpZgojaWZuZGVmIFhGUk1fTVNHX0RFTFBPTElDWQojZGVmaW5lIFhGUk1fTVNH
X0RFTFBPTElDWSAweDE0CiNlbmRpZgojaWZuZGVmIFhGUk1fTVNHX05FV1NQRElORk8KI2RlZmlu
ZSBYRlJNX01TR19ORVdTUERJTkZPIDB4MjAKI2VuZGlmCgovKiBYRlJNIFNQRCBhdHRyaWJ1dGVz
IChmcm9tIGVudW0geGZybV9zcGRhdHRyX3R5cGVfdCkgKi8KI2lmbmRlZiBYRlJNQV9TUERfSVBW
NF9IVEhSRVNICiNkZWZpbmUgWEZSTUFfU1BEX0lQVjRfSFRIUkVTSCAzCiNlbmRpZgoKI2lmbmRl
ZiBYRlJNQV9TUERfVU5TUEVDCiNkZWZpbmUgWEZSTUFfU1BEX1VOU1BFQyAwCiNlbmRpZgoKLyog
TmV0bGluayBoZWxwZXJzICovCiNkZWZpbmUgTkxNU0dfVEFJTChubXNnKSBcCgkoKHN0cnVjdCBu
bGF0dHIgKikoKChjaGFyICopKG5tc2cpKSArIE5MTVNHX0FMSUdOKChubXNnKS0+bmxtc2dfbGVu
KSkpCgpzdGF0aWMgaW50IG5sX2ZkOwpzdGF0aWMgdm9sYXRpbGUgaW50IHN0b3BfZmxhZzsKCnN0
YXRpYyBpbnQgbmxfb3Blbih2b2lkKQp7CglpbnQgZmQgPSBzb2NrZXQoQUZfTkVUTElOSywgU09D
S19SQVcsIE5FVExJTktfWEZSTSk7CglpZiAoZmQgPCAwKSB7CgkJcGVycm9yKCJzb2NrZXQoTkVU
TElOS19YRlJNKSIpOwoJCXJldHVybiAtMTsKCX0KCXN0cnVjdCBzb2NrYWRkcl9ubCBzYSA9IHsg
Lm5sX2ZhbWlseSA9IEFGX05FVExJTksgfTsKCWlmIChiaW5kKGZkLCAoc3RydWN0IHNvY2thZGRy
ICopJnNhLCBzaXplb2Yoc2EpKSA8IDApIHsKCQlwZXJyb3IoImJpbmQiKTsKCQljbG9zZShmZCk7
CgkJcmV0dXJuIC0xOwoJfQoJcmV0dXJuIGZkOwp9CgpzdGF0aWMgaW50IG5sX3NlbmQoaW50IGZk
LCBzdHJ1Y3Qgbmxtc2doZHIgKm5saCkKewoJc3RydWN0IHNvY2thZGRyX25sIHNhID0geyAubmxf
ZmFtaWx5ID0gQUZfTkVUTElOSyB9OwoJc3RydWN0IGlvdmVjIGlvdiA9IHsgLmlvdl9iYXNlID0g
bmxoLCAuaW92X2xlbiA9IG5saC0+bmxtc2dfbGVuIH07CglzdHJ1Y3QgbXNnaGRyIG1zZyA9IHsK
CQkubXNnX25hbWUgPSAmc2EsCgkJLm1zZ19uYW1lbGVuID0gc2l6ZW9mKHNhKSwKCQkubXNnX2lv
diA9ICZpb3YsCgkJLm1zZ19pb3ZsZW4gPSAxLAoJfTsKCXJldHVybiBzZW5kbXNnKGZkLCAmbXNn
LCAwKTsKfQoKc3RhdGljIGludCBubF9yZWN2X2FjayhpbnQgZmQpCnsKCWNoYXIgYnVmWzQwOTZd
OwoJaW50IG4gPSByZWN2KGZkLCBidWYsIHNpemVvZihidWYpLCAwKTsKCWlmIChuIDwgMCkgcmV0
dXJuIC0xOwoJc3RydWN0IG5sbXNnaGRyICpubGggPSAoc3RydWN0IG5sbXNnaGRyICopYnVmOwoJ
aWYgKG5saC0+bmxtc2dfdHlwZSA9PSBOTE1TR19FUlJPUikgewoJCXN0cnVjdCBubG1zZ2VyciAq
ZXJyID0gKHN0cnVjdCBubG1zZ2VyciAqKU5MTVNHX0RBVEEobmxoKTsKCQlyZXR1cm4gZXJyLT5l
cnJvcjsKCX0KCXJldHVybiAwOwp9CgpzdGF0aWMgdm9pZCBhZGRfYXR0cihzdHJ1Y3Qgbmxtc2do
ZHIgKm5saCwgaW50IG1heGxlbiwgaW50IHR5cGUsCgkJICAgICBjb25zdCB2b2lkICpkYXRhLCBp
bnQgZGF0YWxlbikKewoJc3RydWN0IG5sYXR0ciAqbmxhID0gTkxNU0dfVEFJTChubGgpOwoJaW50
IGxlbiA9IE5MQV9IRFJMRU4gKyBkYXRhbGVuOwoJbmxhLT5ubGFfdHlwZSA9IHR5cGU7CglubGEt
Pm5sYV9sZW4gPSBsZW47CgltZW1jcHkoKGNoYXIgKilubGEgKyBOTEFfSERSTEVOLCBkYXRhLCBk
YXRhbGVuKTsKCW5saC0+bmxtc2dfbGVuID0gTkxNU0dfQUxJR04obmxoLT5ubG1zZ19sZW4pICsg
TkxBX0FMSUdOKGxlbik7Cn0KCi8qCiAqIEFkZCBhbiBpbmV4YWN0IFhGUk0gcG9saWN5IHdpdGgg
c2VsZWN0b3IgMC4wLjAuMC8wIC0+IDAuMC4wLjAvMAogKiBUaGlzIGdvZXMgaW50byB0aGUgaW5l
eGFjdCBiaW4gYmVjYXVzZSBwcmVmaXhsZW4gPCBoYXNoIHRocmVzaG9sZCAoMzIpLgogKi8Kc3Rh
dGljIGludCBhZGRfaW5leGFjdF9wb2xpY3koaW50IGZkKQp7CgljaGFyIGJ1Zls1MTJdOwoJbWVt
c2V0KGJ1ZiwgMCwgc2l6ZW9mKGJ1ZikpOwoKCXN0cnVjdCBubG1zZ2hkciAqbmxoID0gKHN0cnVj
dCBubG1zZ2hkciAqKWJ1ZjsKCW5saC0+bmxtc2dfbGVuID0gTkxNU0dfTEVOR1RIKHNpemVvZihz
dHJ1Y3QgeGZybV91c2VycG9saWN5X2luZm8pKTsKCW5saC0+bmxtc2dfdHlwZSA9IFhGUk1fTVNH
X05FV1BPTElDWTsKCW5saC0+bmxtc2dfZmxhZ3MgPSBOTE1fRl9SRVFVRVNUIHwgTkxNX0ZfQUNL
IHwgTkxNX0ZfQ1JFQVRFIHwgTkxNX0ZfRVhDTDsKCW5saC0+bmxtc2dfc2VxID0gMTsKCglzdHJ1
Y3QgeGZybV91c2VycG9saWN5X2luZm8gKnBvbCA9IE5MTVNHX0RBVEEobmxoKTsKCXBvbC0+c2Vs
LmZhbWlseSA9IEFGX0lORVQ7Cglwb2wtPnNlbC5wcmVmaXhsZW5fZCA9IDA7ICAvKiAvMCAtPiBp
bmV4YWN0ICovCglwb2wtPnNlbC5wcmVmaXhsZW5fcyA9IDA7ICAvKiAvMCAtPiBpbmV4YWN0ICov
Cglwb2wtPmRpciA9IFhGUk1fUE9MSUNZX09VVDsKCXBvbC0+YWN0aW9uID0gWEZSTV9QT0xJQ1lf
QUxMT1c7Cglwb2wtPmxmdC5zb2Z0X2J5dGVfbGltaXQgPSBYRlJNX0lORjsKCXBvbC0+bGZ0Lmhh
cmRfYnl0ZV9saW1pdCA9IFhGUk1fSU5GOwoJcG9sLT5sZnQuc29mdF9wYWNrZXRfbGltaXQgPSBY
RlJNX0lORjsKCXBvbC0+bGZ0LmhhcmRfcGFja2V0X2xpbWl0ID0gWEZSTV9JTkY7CgoJaWYgKG5s
X3NlbmQoZmQsIG5saCkgPCAwKSByZXR1cm4gLTE7CglyZXR1cm4gbmxfcmVjdl9hY2soZmQpOwp9
CgovKgogKiBEZWxldGUgdGhlIGluZXhhY3QgcG9saWN5IGJ5IHNlbGVjdG9yIChpbmRleD0wIGZv
cmNlcyBieXNlbF9jdHggcGF0aCkKICovCnN0YXRpYyBpbnQgZGVsX2luZXhhY3RfcG9saWN5KGlu
dCBmZCkKewoJY2hhciBidWZbNTEyXTsKCW1lbXNldChidWYsIDAsIHNpemVvZihidWYpKTsKCglz
dHJ1Y3Qgbmxtc2doZHIgKm5saCA9IChzdHJ1Y3Qgbmxtc2doZHIgKilidWY7CglubGgtPm5sbXNn
X2xlbiA9IE5MTVNHX0xFTkdUSChzaXplb2Yoc3RydWN0IHhmcm1fdXNlcnBvbGljeV9pZCkpOwoJ
bmxoLT5ubG1zZ190eXBlID0gWEZSTV9NU0dfREVMUE9MSUNZOwoJbmxoLT5ubG1zZ19mbGFncyA9
IE5MTV9GX1JFUVVFU1QgfCBOTE1fRl9BQ0s7CglubGgtPm5sbXNnX3NlcSA9IDI7CgoJc3RydWN0
IHhmcm1fdXNlcnBvbGljeV9pZCAqcGlkID0gTkxNU0dfREFUQShubGgpOwoJcGlkLT5zZWwuZmFt
aWx5ID0gQUZfSU5FVDsKCXBpZC0+c2VsLnByZWZpeGxlbl9kID0gMDsKCXBpZC0+c2VsLnByZWZp
eGxlbl9zID0gMDsKCXBpZC0+ZGlyID0gWEZSTV9QT0xJQ1lfT1VUOwoJcGlkLT5pbmRleCA9IDA7
ICAvKiBmb3JjZSBieXNlbF9jdHggcGF0aCAqLwoKCWlmIChubF9zZW5kKGZkLCBubGgpIDwgMCkg
cmV0dXJuIC0xOwoJcmV0dXJuIG5sX3JlY3ZfYWNrKGZkKTsKfQoKLyoKICogQ2hhbmdlIFNQRCBo
YXNoIHRocmVzaG9sZHMgdG8gdHJpZ2dlciB4ZnJtX3BvbGljeV9oYXNoX3JlYnVpbGQuCiAqIEFs
dGVybmF0aW5nIGJldHdlZW4gMC8wIGFuZCAzMi8zMiBmb3JjZXMgYSByZWJ1aWxkIGVhY2ggdGlt
ZS4KICovCnN0YXRpYyBpbnQgc2V0X3NwZGluZm8oaW50IGZkLCBfX3U4IGxiaXRzLCBfX3U4IHJi
aXRzKQp7CgljaGFyIGJ1ZlsyNTZdOwoJbWVtc2V0KGJ1ZiwgMCwgc2l6ZW9mKGJ1ZikpOwoKCXN0
cnVjdCBubG1zZ2hkciAqbmxoID0gKHN0cnVjdCBubG1zZ2hkciAqKWJ1ZjsKCS8qIE5FV1NQRElO
Rk8gYmFzZSBwYXlsb2FkIGlzIHNpemVvZih1MzIpICovCglubGgtPm5sbXNnX2xlbiA9IE5MTVNH
X0xFTkdUSChzaXplb2YoX191MzIpKTsKCW5saC0+bmxtc2dfdHlwZSA9IFhGUk1fTVNHX05FV1NQ
RElORk87CglubGgtPm5sbXNnX2ZsYWdzID0gTkxNX0ZfUkVRVUVTVCB8IE5MTV9GX0FDSzsKCW5s
aC0+bmxtc2dfc2VxID0gMzsKCglfX3UzMiAqZmxhZ3MgPSBOTE1TR19EQVRBKG5saCk7CgkqZmxh
Z3MgPSAwOwoKCXN0cnVjdCB4ZnJtdV9zcGRodGhyZXNoIHRocmVzaCA9IHsgLmxiaXRzID0gbGJp
dHMsIC5yYml0cyA9IHJiaXRzIH07CglhZGRfYXR0cihubGgsIHNpemVvZihidWYpLCBYRlJNQV9T
UERfSVBWNF9IVEhSRVNILCAmdGhyZXNoLCBzaXplb2YodGhyZXNoKSk7CgoJaWYgKG5sX3NlbmQo
ZmQsIG5saCkgPCAwKSByZXR1cm4gLTE7CglyZXR1cm4gbmxfcmVjdl9hY2soZmQpOwp9CgovKgog
KiBUaHJlYWQgQTogcmVwZWF0ZWRseSB0cmlnZ2VyIGhhc2ggcmVidWlsZCBieSBmbGlwcGluZyBT
UEQgdGhyZXNob2xkcy4KICogVGhpcyBjYXVzZXMgeGZybV9oYXNoX3JlYnVpbGQgLT4gX194ZnJt
X3BvbGljeV9pbmV4YWN0X2ZsdXNoIHdoaWNoCiAqIG1heSBrZnJlZV9yY3UgdGhlIGJpbiBpZiBp
dCBiZWNvbWVzIGVtcHR5LgogKi8Kc3RhdGljIHZvaWQgKnJlYnVpbGRfdGhyZWFkKHZvaWQgKmFy
ZykKewoJaW50IGZkID0gbmxfb3BlbigpOwoJaWYgKGZkIDwgMCkgcmV0dXJuIE5VTEw7CgoJd2hp
bGUgKCFzdG9wX2ZsYWcpIHsKCQlzZXRfc3BkaW5mbyhmZCwgMCwgMCk7CgkJc2V0X3NwZGluZm8o
ZmQsIDMyLCAzMik7Cgl9CgljbG9zZShmZCk7CglyZXR1cm4gTlVMTDsKfQoKLyoKICogVGhyZWFk
IEI6IHJlcGVhdGVkbHkgYWRkIGFuZCBkZWxldGUgYW4gaW5leGFjdCBwb2xpY3kuCiAqIFRoZSBk
ZWxldGUgZ29lcyB0aHJvdWdoIHhmcm1fcG9saWN5X2J5c2VsX2N0eCB3aGljaCBoYXMgdGhlIHN0
YWxlIGJpbiBidWcuCiAqLwpzdGF0aWMgdm9pZCAqYWRkZWxfdGhyZWFkKHZvaWQgKmFyZykKewoJ
aW50IGZkID0gbmxfb3BlbigpOwoJaWYgKGZkIDwgMCkgcmV0dXJuIE5VTEw7CgoJd2hpbGUgKCFz
dG9wX2ZsYWcpIHsKCQlpbnQgZXJyID0gYWRkX2luZXhhY3RfcG9saWN5KGZkKTsKCQlpZiAoZXJy
ICYmIGVyciAhPSAtRUVYSVNUKSB7CgkJCS8qIFBvbGljeSBtaWdodCBhbHJlYWR5IGV4aXN0IGZy
b20gYSBwcmV2aW91cyBpdGVyYXRpb24gKi8KCQl9CgkJZGVsX2luZXhhY3RfcG9saWN5KGZkKTsK
CX0KCWNsb3NlKGZkKTsKCXJldHVybiBOVUxMOwp9CgpzdGF0aWMgdm9pZCBzZXR1cF9ucyh2b2lk
KQp7CglpZiAodW5zaGFyZShDTE9ORV9ORVdVU0VSIHwgQ0xPTkVfTkVXTkVUKSA8IDApIHsKCQlw
ZXJyb3IoInVuc2hhcmUoQ0xPTkVfTkVXVVNFUnxDTE9ORV9ORVdORVQpIik7CgkJZnByaW50Zihz
dGRlcnIsICJUcnlpbmcgd2l0aG91dCB1bnNoYXJlIChuZWVkIHJvb3QpLi4uXG4iKTsKCQlyZXR1
cm47Cgl9CgoJLyogV3JpdGUgdWlkL2dpZCBtYXBzIGZvciB0aGUgdXNlciBuYW1lc3BhY2UgKi8K
CUZJTEUgKmY7CglmID0gZm9wZW4oIi9wcm9jL3NlbGYvc2V0Z3JvdXBzIiwgInciKTsKCWlmIChm
KSB7IGZwcmludGYoZiwgImRlbnkiKTsgZmNsb3NlKGYpOyB9CgoJZiA9IGZvcGVuKCIvcHJvYy9z
ZWxmL3VpZF9tYXAiLCAidyIpOwoJaWYgKGYpIHsgZnByaW50ZihmLCAiMCAlZCAxIiwgZ2V0dWlk
KCkpOyBmY2xvc2UoZik7IH0KCglmID0gZm9wZW4oIi9wcm9jL3NlbGYvZ2lkX21hcCIsICJ3Iik7
CglpZiAoZikgeyBmcHJpbnRmKGYsICIwICVkIDEiLCBnZXRnaWQoKSk7IGZjbG9zZShmKTsgfQp9
CgppbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCnsKCWludCBkdXJhdGlvbiA9IDYwOyAv
KiBzZWNvbmRzICovCglpbnQgbnRocmVhZHMgPSA0OyAgLyogbnVtYmVyIG9mIGVhY2ggdHlwZSAq
LwoKCWlmIChhcmdjID4gMSkgZHVyYXRpb24gPSBhdG9pKGFyZ3ZbMV0pOwoJaWYgKGFyZ2MgPiAy
KSBudGhyZWFkcyA9IGF0b2koYXJndlsyXSk7CgoJcHJpbnRmKCJbKl0gWEZSTSBQb2xpY3kgSW5l
eGFjdCBCaW4gVUFGIFBvQ1xuIik7CglwcmludGYoIlsqXSBEdXJhdGlvbjogJWQgc2Vjb25kcywg
dGhyZWFkczogJWQgcGVyIHR5cGVcbiIsIGR1cmF0aW9uLCBudGhyZWFkcyk7CgoJc2V0dXBfbnMo
KTsKCgkvKiBWZXJpZnkgd2UgY2FuIG9wZW4gWEZSTSBuZXRsaW5rICovCglpbnQgdGVzdF9mZCA9
IG5sX29wZW4oKTsKCWlmICh0ZXN0X2ZkIDwgMCkgewoJCWZwcmludGYoc3RkZXJyLCAiWy1dIENh
bm5vdCBvcGVuIE5FVExJTktfWEZSTSwgYWJvcnRpbmdcbiIpOwoJCXJldHVybiAxOwoJfQoKCS8q
IFNldCBpbml0aWFsIHRocmVzaG9sZHMgdG8gMzIvMzIgKGRlZmF1bHQpIHNvIC8wIHBvbGljaWVz
IGdvIGluZXhhY3QgKi8KCWludCBlcnIgPSBzZXRfc3BkaW5mbyh0ZXN0X2ZkLCAzMiwgMzIpOwoJ
aWYgKGVycikgewoJCWZwcmludGYoc3RkZXJyLCAiWy1dIHNldF9zcGRpbmZvIGZhaWxlZDogJWQg
KG5lZWQgQ0FQX05FVF9BRE1JTiBpbiBuZXRucylcbiIsIGVycik7CgkJY2xvc2UodGVzdF9mZCk7
CgkJcmV0dXJuIDE7Cgl9CglwcmludGYoIlsrXSBYRlJNIG5ldGxpbmsgb3BlcmF0aW9uYWwgaW4g
bmFtZXNwYWNlXG4iKTsKCWNsb3NlKHRlc3RfZmQpOwoKCXB0aHJlYWRfdCAqcmVidWlsZF90aWRz
ID0gY2FsbG9jKG50aHJlYWRzLCBzaXplb2YocHRocmVhZF90KSk7CglwdGhyZWFkX3QgKmFkZGVs
X3RpZHMgPSBjYWxsb2MobnRocmVhZHMsIHNpemVvZihwdGhyZWFkX3QpKTsKCglwcmludGYoIlsq
XSBTdGFydGluZyAlZCByZWJ1aWxkICsgJWQgYWRkL2RlbCB0aHJlYWRzLi4uXG4iLCBudGhyZWFk
cywgbnRocmVhZHMpOwoKCWZvciAoaW50IGkgPSAwOyBpIDwgbnRocmVhZHM7IGkrKykgewoJCXB0
aHJlYWRfY3JlYXRlKCZyZWJ1aWxkX3RpZHNbaV0sIE5VTEwsIHJlYnVpbGRfdGhyZWFkLCBOVUxM
KTsKCQlwdGhyZWFkX2NyZWF0ZSgmYWRkZWxfdGlkc1tpXSwgTlVMTCwgYWRkZWxfdGhyZWFkLCBO
VUxMKTsKCX0KCglzbGVlcChkdXJhdGlvbik7CglzdG9wX2ZsYWcgPSAxOwoKCXByaW50ZigiWypd
IFN0b3BwaW5nIHRocmVhZHMuLi5cbiIpOwoJZm9yIChpbnQgaSA9IDA7IGkgPCBudGhyZWFkczsg
aSsrKSB7CgkJcHRocmVhZF9qb2luKHJlYnVpbGRfdGlkc1tpXSwgTlVMTCk7CgkJcHRocmVhZF9q
b2luKGFkZGVsX3RpZHNbaV0sIE5VTEwpOwoJfQoKCWZyZWUocmVidWlsZF90aWRzKTsKCWZyZWUo
YWRkZWxfdGlkcyk7CgoJcHJpbnRmKCJbKl0gRG9uZS4gQ2hlY2sgZG1lc2cgZm9yIEtBU0FOIHJl
cG9ydHMuXG4iKTsKCXJldHVybiAwOwp9Cg==
--000000000000b9e5b70652f05476--

