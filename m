Return-Path: <netdev+bounces-285963-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKJENyY7/mkroAAAu9opvQ
	(envelope-from <netdev+bounces-285963-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 21:36:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F1B4FB2F2
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 21:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54B4A307200D
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 19:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FE83FBEAA;
	Fri,  8 May 2026 19:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boZEVMj8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBB333F38A
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 19:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778268804; cv=pass; b=FDDjIXt6oKqjCq2vibL66kDF/y8bx71hw8QJk20stm7TGqihce9gOU7aXh5Al30PLG6W0omkbYAWNegmNkVtGlkXpeLhZSqbPfOyd8rxlbr1AhyfH9qnM5MViHGqpe+yiJmRVZL7kxBCktjM6BeNKBWz/PSdEOIDJAWQbDAy5Ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778268804; c=relaxed/simple;
	bh=KOz2CthW9DZTi9DtDOS4s6UwKiyzP3Sh6aGujr/riF4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ipRl6JophdGQwdREHLXYJd/J7KKK/bZ3mYg8hYn95wcdQZUWU/I21XpZeMkIj5UkEHk7yu7D6Wkb3JdC3jzJb1ENJrjvXTxYjrmszdwlF2xD/fy1E5boAKz2g8q+2k1Xz8jFF9XnJCFwchHdC9BmluWYu/Kl5yRbYXXuraRgkkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boZEVMj8; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7bdf83185bbso25108207b3.2
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 12:33:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778268801; cv=none;
        d=google.com; s=arc-20240605;
        b=hiAzmLbOWd3+1PkFoS+o+h+ShxNa2JQlAGoC8u0SqV8xOu0UcAHTtkvlrZYNZO0/io
         2IB1f1j4DI1Q2aYKQ1eFx5jGszZMtLdSSweIwM3/080KebWxYElTFiKPCKTyPpbDqCmI
         BDfk/E6h4W0pm3egSkO2pM5YBLpIhDpd4oUjgVEr7B5+/LuWi5JNnbpNlk8jk7BMWM1w
         CyMJ7GupHQFWsUIJOF3bryBhz3rfhD6AiBRLQej0+jlkyXFtfbNRJ19JL0jThq+qbce2
         03v3hqpNAPcQTKTG5twtXbD2k8DPOA7EqzAtE0moUhMKvUzPJxf+9tv3LCkW6EkWqT9R
         jKAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=9WbqQFwC9sQ1kT2Ez9037TuxaYTirplDCZyYgdcthAE=;
        fh=G/BR9Ob0AYURlkXI1DLyBLqzN+VK4qnelkaOlb8wNJA=;
        b=dX6uwQtsXWmXuuG/AaRp5eBDWVqqOt1IEMhm0pqOrw4DEkFsP++USC6Oztdw674gh7
         2fYYf0Faj3IuMOiZQhPRHIxJNvG+RHW0IJhMRaTCmiDUgE8CY6U9fhaWF4/YAi4d9bvy
         zlWZDmVVY+mtMEty3tmF/DVPY6YStjOdlxJU/nwTFncnF4p2cVH2dmSwzBhw1bWQMkYX
         Fr1oc+cwjCbGP51SWPJKMnero4+d5xR3XjB6kmA+i+CCt6pfPk914gSW+TumorQk3x1P
         hbcePTpF10drq7B3PC5lXN+AqGTFZjH3cGRBHj64SZxngH8xQoFfuoURK2XgKtOiaZBu
         X9VQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778268801; x=1778873601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9WbqQFwC9sQ1kT2Ez9037TuxaYTirplDCZyYgdcthAE=;
        b=boZEVMj8RhGvjAkdwEjwq5DtKyLdb9sXKJONA4I5PbKTihIXgsrRXpNDO8d5NtFw/5
         hlrNB7nLNpOzjtWGfzvMjznhLPmDGL2sRWh3gMOrWgWser5ZBcsI5vUJ0rBok96sFnSH
         AyShRTK0PZxIy5aKMQetKrJ23HQjckcDYNwtOkXbRt3nuBIPLh/U1TgEwZ10aMXTusK4
         YNr2sEBFvgLlNSXvACQCrA6OlSh8PaASTxrZSGA+2dsA7PDOqGba7h0qv/gDyHMJ/wA+
         kcvJ1ZA84TT0HTIihx8m9tcA6/7AboezqcaLjtmCiyubuBEYOCTszGtDeyBhkTDMjvuc
         ETYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778268801; x=1778873601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WbqQFwC9sQ1kT2Ez9037TuxaYTirplDCZyYgdcthAE=;
        b=JPCs1gfhFokAeyoVMOmZdQumVfQL0kf31l4sHwfpqzjsHwPd6Z0j9exJbeGOrA3icj
         /SMrxzvOwFnrs6T7klmxP6+vWiwH4eRHxe/028vvgJ1zegGZFwNjwOzsa8s6JJrGVLho
         TG0Q4OzZAoX+IKz0JM234wwnBPlyVA7JcUh5q8ri+J7nVkKdY5oucgQ2T0nnYMTT5+/B
         XNh+0LSNq1eHCZUqZJyeb91fERMKWw0JaHvU7Ihe70XuT1N4eKz8pxj4hU9GbQk16J0S
         l8FbxuYwFhVLtVAqF7kwaZFV/i3SL/zpGIBLmCfZP6EHaTtSyola/ca1jLSZZgRrCp7g
         kqfQ==
X-Forwarded-Encrypted: i=1; AFNElJ/jLkHsDNII0YOikr9j32LN8V4UmGPVovFVS4I8R8pDz6F1hqgzS44+qlO0pG2CJHe1N6jR67Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqEVZvfaTNlZkMduxPFSBJKeEl+cluXeAsNLy4ttaxVvxl73Kl
	GbrDJFe1hlvtxGuYB/QtvOtUh0x5aKatv+JhkLQ6nO5VPfh0bp3q9/BCVIJj1JzuRm5JcX2zRZq
	UasvLwm0VTlEpJE+P6GJyK8kSeGCcxNY=
X-Gm-Gg: Acq92OFDoA1qHkko8KdJq4rWdwRAtPVgxKCETdU6EyvYivUuowsr2Hd6+PfFr5GzOaS
	QfKK4PQNg8B7VNU4Aegy2rrmqEZppRpRhSSYDojIEBpU9TFH+3vNwQTh6lIoSNNpfuuTQK2NcME
	tu1bqM2ObdPdCJpNETBg3xLRMvKYlOd+N4bu/QK2No4vaGRDvOE36x1nia1DULUUVJFHYZauvO3
	dosW1586LCU7ZcD0jD9xxzk7gjzz4Yybbv1ghx0BRHueFinWm8yeyS/unoJnJaDUTYD+XmclwVo
	Zsj3+HaG9UWfSeNqO/Chj/mkZdvYcGnCEk9dbpITaFr7HCvdn48cj5zEOtdiFQ==
X-Received: by 2002:a05:690c:3482:b0:7ba:eefe:9f9c with SMTP id
 00721157ae682-7bfb93b91bfmr36362517b3.23.1778268801312; Fri, 08 May 2026
 12:33:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Nicol=C3=B2_Coccia?= <n.coccia96@gmail.com>
Date: Fri, 8 May 2026 21:33:10 +0200
X-Gm-Features: AVHnY4IhlBncjhRtEcRWNeScfK7pKvEfB82Sn4DdDRYZUjuTlbimERLOeRjk1Nw
Message-ID: <CALSA8UaEKUHRqYaYqKFYbUQb4KHipDBDHfgMZHj2Tq0D1Ah7zw@mail.gmail.com>
Subject: [PATCH net] net/smc: fix sleep-inside-lock in __smc_setsockopt()
 causing local DoS
To: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	sidraya@linux.ibm.com, Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, mjambigi@linux.ibm.com, 
	=?UTF-8?Q?Nicol=C3=B2_Coccia?= <nicolo.coccia@leonardo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 97F1B4FB2F2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285963-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ncoccia96@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

A logic flaw in __smc_setsockopt() allows a local unprivileged user to
cause a Denial of Service (DoS) by holding the socket lock indefinitely.

The function __smc_setsockopt() calls copy_from_sockptr() while holding
lock_sock(sk). By passing a userfaultfd-monitored memory page (or
FUSE-backed memory on systems where unprivileged userfaultfd is disabled)
as the optval, an attacker can halt execution during the copy operation,
keeping the lock held.

Combined with asynchronous tear-down operations like shutdown(), this
exhausts the kernel wq (kworkers) and triggers the hung task watchdog.

[  240.123456] INFO: task kworker/u8:2 blocked for more than 120 seconds.
[  240.123489] Call Trace:
[  240.123501]  smc_shutdown+...
[  240.123512]  lock_sock_nested+...

This patch moves the user-space copy outside the lock_sock() critical
section to prevent the issue.

Signed-off-by: Nicol=C3=B2 Coccia nicolo.coccia@leonardo.com>
---
 net/smc/af_smc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -XXXX,X +XXXX,X @@ static int __smc_setsockopt(struct socket *sock,
int level, int optname,

  smc =3D smc_sk(sk);

+ /* pre-fetch user data outside the lock */
+ if (optname =3D=3D SMC_LIMIT_HS) {
+ if (optlen < sizeof(int))
+ return -EINVAL;
+ if (copy_from_sockptr(&val, optval, sizeof(int)))
+ return -EFAULT;
+ }
+
  lock_sock(sk);
  switch (optname) {
  case SMC_LIMIT_HS:
- if (optlen < sizeof(int)) {
- rc =3D -EINVAL;
- break;
- }
- if (copy_from_sockptr(&val, optval, sizeof(int))) {
- rc =3D -EFAULT;
- break;
- }
-
  smc->limit_smc_hs =3D !!val;
  rc =3D 0;
  break;

