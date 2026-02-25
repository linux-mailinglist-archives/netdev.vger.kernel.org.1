Return-Path: <netdev+bounces-260961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DNCFGP+nmlAYgQAu9opvQ
	(envelope-from <netdev+bounces-260961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:51:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B16F3198615
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AA78306D8BE
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1900A3C199F;
	Wed, 25 Feb 2026 13:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="UJGKpdDH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE2A3C196A
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 13:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772027123; cv=pass; b=eqQn+92tm1ZdTVD19xQ3SGpgguwH/d7bm+5I3B2b97nUKANmXmIVJduJEiODoKdSiyRbnzjClAOQGjR4vXOSBGKB6fWboHT7XRFFIUXFjEXZND8xorGBpWrWB60yvaF6Nq66Ov6uJDTUHYq7uwffbOy82E87LYZ7LpkjxFkdEig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772027123; c=relaxed/simple;
	bh=NFgNLsvPHKV3rjCsZ0uIMaGA8hfvaIE8ZhHKIA+7aZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebC/nEI3E0O8/ljK1G0kbLtkRG8PgS+2Dy7eNoPqYqyC0tLAsbq84my5zDuWnVhfDgM8mHjY1XZrDqND/Ej3NLlWXazVrlhFzdXlOKdCHR+wtGS/74sxEjV/3xIP61eFUpq2DneFhkeRGxaW+lX1N7lDZwmND1Tq7dHVaPULnuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=UJGKpdDH; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-358f3ef464bso900515a91.3
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 05:45:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772027122; cv=none;
        d=google.com; s=arc-20240605;
        b=BnX9ifnuwgSHI28DUTLdcQtOuTUUzDTD8SmtqC1jOBqWgMh0ZqhQp6YcW5ybDxXSKE
         hHO5V4ao4CaRU33BgzqUnn5UAJT/FP4keCS0f0WemDtUwMQLlNfOTKe4snO5npkTIurw
         8X7pJcwj05vinr3WOAjwevmr6MCKDiMjUJ/sgvwBDB6fVTUcJMqDj4o4NI1NS64pBuP+
         CpGbTXDRc/D7jPRcYULRbWryF29pHmQG1Mtlx7IsyH3ZN3nO9qjwI+iqNWy7FL/O+6WS
         eEBmryI18QE39rgCDNBj8ivqXzN/xjfRW9vZ/7skPKR43AalW7GJsFYGFqo6SejopolN
         ZamA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ELtbWp1JWcLapCtb8EORqUYFREzoqoeiE7kP7vh9lFU=;
        fh=6niVe/oviuG9jOHs9h0UExEEAE/3kSiaRpRYDDCbcro=;
        b=Z3Df2S5/Tx+ulyYClyRyfx6iimHRhqtZB0xP9lsFzPga3VWQ+cuUTcEq00B0lQgPUw
         FSKbWA2N7bWvmgKvYYtqmZ0iIkypfjUWjCsmYaO+Cri3VGGYtDR+Zi2244BJsjAm2Yty
         UL7skc09JJvIlOSZ08LIGWwLGF64YJVlOQ9wmib8MP+/Ly5L4oeuTzhM4BCgZ4hYGAy+
         /NiAC5A1b1BaPF4ENnCd/xZcOrrpcDZxhbh6MwYxkxOoVf4IPBnbBqb7719NqP1qddoB
         lIljULdxkv4otYcHnifj31xx+SdbHhuGfecOORe/priPv2NElwTGY1AQfwnanzgbhvo9
         i7Dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1772027122; x=1772631922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELtbWp1JWcLapCtb8EORqUYFREzoqoeiE7kP7vh9lFU=;
        b=UJGKpdDHfM/hgbDL6YhjSRxPzCb96mL/7r/gyCuyqRv+8qVnfqxnuhoLWcvycDeger
         CSs5ewXsQdtQhBnS8Nj6tdU5bwxRJhPeePNJfHKVx7iFuK0sXM/wAamdic4f9TADAsSF
         lTjHku+ScdAZXkbdsymh4fxNXQ3cj3lIDVfkEzi6uXAFyEWwZDncTD2RCjvV87aCS/1l
         8Gsgq3OZyQ9kjXF6/dfkSLk4NC9HyTfNEZs8XoH4Li20zTAKOVxtRgxEbfiPALPmuM5B
         r00l/ofLXuzA68eb1msyy2ADU+P1vIdj7h0FT6j9xH4HXDbcP6/e9xUvZZeiLjATyAU4
         Nx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772027122; x=1772631922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ELtbWp1JWcLapCtb8EORqUYFREzoqoeiE7kP7vh9lFU=;
        b=qYJtpBBq/AGjKAefiqy8HR1MyRd0rqjog1ENBg9mVfS2R5MRlVY1FLBXqetJicmQRO
         6KQE8u78+Fs+nwypyQxXDZwNI5ig4ijgrWBrdksywNej4pfA1eDNh1nenQriDkZa2btZ
         ue29yrfe9VWZKkNOmGq9tEXcBfvKsBoCFdTb/MLWEqtLA1GI0O8S0THAIQgp9qfku3e3
         uN0cjd9uM8gnJDLhGvjAZini0g0JefLeYK6OGlA/svN34eA9nqRbLpW4fcK+rSiYqbq6
         1v5ijahNhJOnWI150FLUtv3ygsBAqqWYgwrFdfcsSXcMSsZShFUZhn21HCiq9Od4s4Rf
         N8aw==
X-Forwarded-Encrypted: i=1; AJvYcCVhxYxEcB3/yPJYYdZd+sO754iOnvAUFjjsh6KIvqCebVF5iyH7uuFR/R8cNTl+ZZ+aSihHntY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAocXazZiQSP0ClCteBrdxPfcMXuWy+HpbY0ukW6nNq0NJuJ+N
	cW/M0+uwvbY5bFH4Tui7nyyVOame8aqInpRCOqoHpqumaNOjCQnVA2xBgmef4i2/2Lhd4BIEXby
	IKvnk6TghzN+jjcTI7tPcbuCMJ6wlHQI6LmhersWrWlpNx8SWjdI=
X-Gm-Gg: ATEYQzx2AJPbTpyy6C+C4R5ACVK4wZ5MRJF+48cRMq1p2Ggx3+4qFsjaHJkfJyhtljs
	rwiQ0HFRTBUhLR5pDtrjXUzghvjOcKORj8qWr7hhZYbWWEZkIee9JQsv0VOVce3IRXWIgWUe3sd
	mqWd28gmMMZ08GidyjD8h5qwumGY8CRVE1Q8Myip2U7+mrU15qY/RWwe2XCPsLOLPOzzILz+0r/
	Srii6+G3EhXcj2nR3AH+uu7lLdaKyhMGOS+cJwDt/yt/Bqc1caM1FC6djXDrEO5Fon6LKiBWWgw
	pKv9GCeXF9UoSk0=
X-Received: by 2002:a17:90b:35c7:b0:356:3cfd:3ed5 with SMTP id
 98e67ed59e1d1-358ae8b79b6mr15921780a91.18.1772027122084; Wed, 25 Feb 2026
 05:45:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <28504887df314588c7255e9911769c36f751edee.1771964872.git.dcaratti@redhat.com>
In-Reply-To: <28504887df314588c7255e9911769c36f751edee.1771964872.git.dcaratti@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 25 Feb 2026 08:45:10 -0500
X-Gm-Features: AaiRm52IPf97axinIVryHo2xfZHgZJFyL2sw3EqjHThVqSdBXWzxvtjN7IMUMeI
Message-ID: <CAM0EoMkBsSn_xpdtutUozEQyEjSnhFyf94MHQ6oVLmgGLNyoCA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: ets: fix divide by zero in the offload path
To: Davide Caratti <dcaratti@redhat.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Petr Machata <petrm@mellanox.com>, Ido Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260961-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,mellanox.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,mojatatu.com:email]
X-Rspamd-Queue-Id: B16F3198615
X-Rspamd-Action: no action

Hi Davide,

On Tue, Feb 24, 2026 at 3:30=E2=80=AFPM Davide Caratti <dcaratti@redhat.com=
> wrote:
>
> Offloading ETS requires computing each class' WRR weight: this is done by
> averaging over the sums of quanta as 'q_sum' and 'q_psum'. Using unsigned
> int, the same integer size as the individual DRR quanta, can overflow and
> even cause division by zero, like it happened in the following splat:
>

Was there a setup/test that resulted in the splat? It would be nice if
you could document it.
The fix looks good, so:

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

>  Oops: divide error: 0000 [#1] SMP PTI
>  CPU: 13 UID: 0 PID: 487 Comm: tc Tainted: G            E       6.19.0-vi=
rtme #45 PREEMPT(full)
>  Tainted: [E]=3DUNSIGNED_MODULE
>  Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
>  RIP: 0010:ets_offload_change+0x11f/0x290 [sch_ets]
>  Code: e4 45 31 ff eb 03 41 89 c7 41 89 cb 89 ce 83 f9 0f 0f 87 b7 00 00 =
00 45 8b 08 31 c0 45 01 cc 45 85 c9 74 09 41 6b c4 64 31 d2 <41> f7 f2 89 c=
2 44 29 fa 45 89 df 41 83 fb 0f 0f 87 c7 00 00 00 44
>  RSP: 0018:ffffd0a180d77588 EFLAGS: 00010246
>  RAX: 00000000ffffff38 RBX: ffff8d3d482ca000 RCX: 0000000000000000
>  RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffd0a180d77660
>  RBP: ffffd0a180d77690 R08: ffff8d3d482ca2d8 R09: 00000000fffffffe
>  R10: 0000000000000000 R11: 0000000000000000 R12: 00000000fffffffe
>  R13: ffff8d3d472f2000 R14: 0000000000000003 R15: 0000000000000000
>  FS:  00007f440b6c2740(0000) GS:ffff8d3dc9803000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000000003cdd2000 CR3: 0000000007b58002 CR4: 0000000000172ef0
>  Call Trace:
>   <TASK>
>   ets_qdisc_change+0x870/0xf40 [sch_ets]
>   qdisc_create+0x12b/0x540
>   tc_modify_qdisc+0x6d7/0xbd0
>   rtnetlink_rcv_msg+0x168/0x6b0
>   netlink_rcv_skb+0x5c/0x110
>   netlink_unicast+0x1d6/0x2b0
>   netlink_sendmsg+0x22e/0x470
>   ____sys_sendmsg+0x38a/0x3c0
>   ___sys_sendmsg+0x99/0xe0
>   __sys_sendmsg+0x8a/0xf0
>   do_syscall_64+0x111/0xf80
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  RIP: 0033:0x7f440b81c77e
>  Code: 4d 89 d8 e8 d4 bc 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 =
83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 3=
9 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
>  RSP: 002b:00007fff951e4c10 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
>  RAX: ffffffffffffffda RBX: 0000000000481820 RCX: 00007f440b81c77e
>  RDX: 0000000000000000 RSI: 00007fff951e4cd0 RDI: 0000000000000003
>  RBP: 00007fff951e4c20 R08: 0000000000000000 R09: 0000000000000000
>  R10: 0000000000000000 R11: 0000000000000202 R12: 00007fff951f4fa8
>  R13: 00000000699ddede R14: 00007f440bb01000 R15: 0000000000486980
>   </TASK>
>  Modules linked in: sch_ets(E) netdevsim(E)
>  ---[ end trace 0000000000000000 ]---
>  RIP: 0010:ets_offload_change+0x11f/0x290 [sch_ets]
>  Code: e4 45 31 ff eb 03 41 89 c7 41 89 cb 89 ce 83 f9 0f 0f 87 b7 00 00 =
00 45 8b 08 31 c0 45 01 cc 45 85 c9 74 09 41 6b c4 64 31 d2 <41> f7 f2 89 c=
2 44 29 fa 45 89 df 41 83 fb 0f 0f 87 c7 00 00 00 44
>  RSP: 0018:ffffd0a180d77588 EFLAGS: 00010246
>  RAX: 00000000ffffff38 RBX: ffff8d3d482ca000 RCX: 0000000000000000
>  RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffd0a180d77660
>  RBP: ffffd0a180d77690 R08: ffff8d3d482ca2d8 R09: 00000000fffffffe
>  R10: 0000000000000000 R11: 0000000000000000 R12: 00000000fffffffe
>  R13: ffff8d3d472f2000 R14: 0000000000000003 R15: 0000000000000000
>  FS:  00007f440b6c2740(0000) GS:ffff8d3dc9803000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000000003cdd2000 CR3: 0000000007b58002 CR4: 0000000000172ef0
>  Kernel panic - not syncing: Fatal exception
>  Kernel Offset: 0x30000000 from 0xffffffff81000000 (relocation range: 0xf=
fffffff80000000-0xffffffffbfffffff)
>  ---[ end Kernel panic - not syncing: Fatal exception ]---
>
> Fix this using 64-bit integers for 'q_sum' and 'q_psum'.
>
> Cc: stable@vger.kernel.org
> Fixes: d35eb52bd2ac ("net: sch_ets: Make the ETS qdisc offloadable")
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
>  net/sched/sch_ets.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> index 306e046276d4..a4b07b661b77 100644
> --- a/net/sched/sch_ets.c
> +++ b/net/sched/sch_ets.c
> @@ -115,12 +115,12 @@ static void ets_offload_change(struct Qdisc *sch)
>         struct ets_sched *q =3D qdisc_priv(sch);
>         struct tc_ets_qopt_offload qopt;
>         unsigned int w_psum_prev =3D 0;
> -       unsigned int q_psum =3D 0;
> -       unsigned int q_sum =3D 0;
>         unsigned int quantum;
>         unsigned int w_psum;
>         unsigned int weight;
>         unsigned int i;
> +       u64 q_psum =3D 0;
> +       u64 q_sum =3D 0;
>
>         if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
>                 return;
> @@ -138,8 +138,12 @@ static void ets_offload_change(struct Qdisc *sch)
>
>         for (i =3D 0; i < q->nbands; i++) {
>                 quantum =3D q->classes[i].quantum;
> -               q_psum +=3D quantum;
> -               w_psum =3D quantum ? q_psum * 100 / q_sum : 0;
> +               if (quantum) {
> +                       q_psum +=3D quantum;
> +                       w_psum =3D div64_u64(q_psum * 100, q_sum);
> +               } else {
> +                       w_psum =3D 0;
> +               }
>                 weight =3D w_psum - w_psum_prev;
>                 w_psum_prev =3D w_psum;
>
> --
> 2.52.0
>

