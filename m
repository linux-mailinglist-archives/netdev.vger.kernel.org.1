Return-Path: <netdev+bounces-307471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UYwLIG84Vmq01gAAu9opvQ
	(envelope-from <netdev+bounces-307471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:23:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B82E07550B6
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:23:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LFflbgXP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307471-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307471-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86C8730B832E
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 13:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD5C12C534;
	Tue, 14 Jul 2026 13:16:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C847B20E023
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 13:16:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035016; cv=pass; b=PCe+f04EJIIV2kRgVuSTmMgcmAXITTPCA3+91+pz4sk+SjeXx7bTDs9wwyI3jbNGb19wH4hEygKOtPpSS1ffaabmKE71u095pe2B2rx1FSFop6D4MRfTsZsb2DO/vBUdr4+dIBzswgppf7vORpGToMcgtBLlRWCgCNOAnna6mKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035016; c=relaxed/simple;
	bh=+Qa31FkKnglaUmIYRBmzMSRGYBZhx0ZbYMJM6VbwPV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HyWJxUno2dcpzDsuBw3YE8rHB7tBUBC4LYQeNEqriQZzZD/n6OWqChfTfhwyIDAAtOEezEkK5YeJIjIYpzKHFZ3qmYiMEGGNX6Kj+6FyTuqXBv83Tvk06G3yxeJj7N/4nU3Cr4+W9Wg8SNy8Msflodl+AJYc7AclkBNKvGs6mps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFflbgXP; arc=pass smtp.client-ip=209.85.160.47
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4513435cdd2so1613431fac.2
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 06:16:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784035013; cv=none;
        d=google.com; s=arc-20260327;
        b=L1NVYdQA89pf0gNlXYHvtOzBJfxSEivn9szq9xN/EAjttcLhgm6OoR64UQQwU4bMJd
         zLV6e3ZNJfuOdhAevABMyGH6BHtedunK4nS/uxbkT3eeVAZdqvJ4Do8qMaT5j7PK8SFY
         T30qGuVfbl1mYSc1TAvFcSdz7BwHS4ySJXjd21tPwxAMVKJAvm8kgHYwbssWn8Kd2kZj
         p5ai591KUaCAOc8qFN+5TJ6/ETySxYN3IzLCo7LnSVz4Vj2+7woce6jhG4UimCGqLLZp
         yzgYGTNNtrWVR08XGgiyqJcE1lQDD/DMu8Uue5e6w1Y1Za6Pm/QJ5t8R7YvYk8E9CtaE
         IJ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KGMO/nPW1YmA6+F7rceUFtVBz0j4a6IVdMY1D/4tlo4=;
        fh=FQcT5/dJx/Wv81EtHaq2NBqXYT8IAIxgMoIot90K2cE=;
        b=pQ2xaEG2AwNHeQqPcRiC6PRXCfZ9lmMzBbHT/h7VfTEK4vWzVyJZNid5JVOre+G0u/
         ziRk2w315+HFMx59nKL2hU7dsk2G4/Kzypr1pqt81W7yoTNrOgD/O7Wt18kAMUu7iFVJ
         gdBm+4UqwQzM3ikG9PhgBpEEtE6ryrAnTvJrpjqI6zZfgxgzlKvexf6Q4NcgQrVj9ixV
         p3lYqmPgYvkXrfZejwNBcTQrRHLmlb/TkEd/xDBEr48Tv8j7KSacP4qnlTZG/nlBdCXU
         ckVAOQ1Lvf958jqg5tjJicyP6x3/gXXYYoGJFXo35Tz0Eae+m70CojxglKlz5OPnHCLw
         6Aaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784035013; x=1784639813; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KGMO/nPW1YmA6+F7rceUFtVBz0j4a6IVdMY1D/4tlo4=;
        b=LFflbgXPL4CoP3mtR/HTvXde+lDlabAsmllujBEY5inrFoLZ9UBDoogfp5JDTh6RtI
         WiRjwporiP3FD19MR4ZQSQCIX/LerO3EMKj+3o5G5Rhb5qEr/S3yK3glcI3lM04jjZBx
         fBiUAFazRXevdxCA1fstYR7/gg1dQA0UZr0C5CbZCc1/RGHqCn+nmKrTIVG/vmyPZn7p
         G8FxLCjk+zgkXncxc0nnJHQ9lX1UzW982gHBJk/pVfXf875wQ2c7dYAdTpIovUa1iEXB
         9mcQ50JqFC2MxFXueeVUwAB6k4jmjm3hprCOdsSywFQIOYlH8/12o3hoI2m/SHTFSGJG
         7Nxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784035013; x=1784639813;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KGMO/nPW1YmA6+F7rceUFtVBz0j4a6IVdMY1D/4tlo4=;
        b=AFef2NqCWMAYjJfznFi1BZivknvESnGtBnRSMgKUmr2ah2lIxohBzCEolc5cP3+M7P
         sd5oZJO8dpwrWKWHyDuvbfkBd0qt53tnmPq/je6WDIaoUOwMEjJOm9EF9WyXlemnnlht
         P1VIufrYbjl1m/oSS4Ch6Z6bjCEOiUZW8sRr2STv0tcMORIoxlPWCgT+qGlXpFDJELf+
         J3e01Q6hggECT3go/FAG3LU33OwFReV8UDJRZ1H7FkTq+UIViQX/QtQrjCy+0rjY8DKK
         MGIVeZn+ajZPz2rNC3ROsOUsOM1E1UB4gt3+ncXuYrjjXy590Z364kFujtTpwTM+AjTv
         5e8g==
X-Forwarded-Encrypted: i=1; AFNElJ/wWUfbdWnVkY5Ea+o0kMA8jlwo9t10sIDFHwa9qVdtS5IQIEfh+XP0C0YSvYxHjI4lvvnPWFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNyoyhfuGJnTUpgTBmDbsMNHxosns3FSRmI0siiOefN9+X4yEC
	jG6nU6aOJWgzrzeQXw/Y68XN80M0ykt0AS63XxkGV/8QAmUmbuQ3aFzA0pUNBM3KElH44HrZvvH
	Y6vM+EOJHd/R6vPHrCI7LiX0Z+2TbHWg=
X-Gm-Gg: AfdE7ckXYxAVAuJhJTGpJdtYDfkNtwDuDVH5qa0PgYdaC5WzNlcGdw5VEFGUwa8AUkJ
	boOBpqp+olY+S91ZJPLrqBSvuIgPo+u7OeBsEUpleZhiKFJE/9HCbRmWNewDoQ3Y1KotrKWclwX
	9aQLvoA3Y4GH9m2hOaVkJ+L8NLyJ6A10TMtGoJY9BHYoWqqOZyypNGafWs3nE96GGkoro1q7HmY
	5LngrTk0dAeGBQsTbyuoeYRUDA0nesd5Xgz8aGdJtr1nzevO8CAnEWacYnB4Py2rh6fOwyqUA==
X-Received: by 2002:a05:6808:1782:b0:4a3:ff0a:e407 with SMTP id
 5614622812f47-4a47a58da31mr1525402b6e.15.1784035013438; Tue, 14 Jul 2026
 06:16:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710014109.536177-1-xmei5@asu.edu>
In-Reply-To: <20260710014109.536177-1-xmei5@asu.edu>
From: Taehee Yoo <ap420073@gmail.com>
Date: Tue, 14 Jul 2026 22:16:40 +0900
X-Gm-Features: AUfX_mxrFT0VoGVUrtX3aFxNN3oqJ2d4CSKGgM_1R3EMY-gbyyzjOOwkYn6GMCw
Message-ID: <CAMArcTVGfCzcnOrrKFRqD0a6Q2LgC19Yge1Lh2fvKMx2oqwtmw@mail.gmail.com>
Subject: Re: [PATCH net] amt: refresh cached IP header pointers after MLD/IGMP checks
To: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com, 
	kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307471-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[ap420073@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ap420073@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B82E07550B6

On Fri, Jul 10, 2026 at 10:41=E2=80=AFAM Xiang Mei (Microsoft) <xmei5@asu.e=
du> wrote:
>

Hi Xiang Mei,
Sorry for the late reply.

> amt_dev_xmit() and amt_update_handler() cache iph/ip6h before calling
> ip_mc_check_igmp() / ipv6_mc_check_mld(), which may pskb_may_pull() a
> non-linear skb and reallocate skb->head. The stale pointers are then
> read (amt_dev_xmit: group.ip{4,6} =3D iph/ip6h->daddr; amt_update_handler=
:
> ip{,v6}_eth_mc_map()), a slab-use-after-free. tx is reachable by an
> unprivileged user whose amt device has SG enabled; rx by a tunnel peer
> sending a membership update fragmented across several IP fragments.
>
> Reload iph/ip6h after the check returns, like commit f0e42f0c4337
> ("ipv6: sit: reload inner IPv6 header after GSO offloads").
>
> tx path:
>   BUG: KASAN: slab-use-after-free in amt_dev_xmit (drivers/net/amt.c:1238=
)
>   Read of size 16 by task exploit
>    amt_dev_xmit (drivers/net/amt.c:1238)
>    dev_hard_start_xmit (net/core/dev.c:3905)
>    __dev_queue_xmit (net/core/dev.c:4872)
>    packet_sendmsg (net/packet/af_packet.c:3114)
>
> rx path:
>   BUG: KASAN: slab-use-after-free in amt_rcv (drivers/net/amt.c:2530)
>   Read of size 4 by task exploit
>    amt_rcv (drivers/net/amt.c:2530)
>    udp_queue_rcv_one_skb (net/ipv4/udp.c:2388)
>    ip_local_deliver (net/ipv4/ip_input.c:262)
>    ip_rcv (net/ipv4/ip_input.c:612)
>
> Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
> Fixes: bc54e49c140b ("amt: add multicast(IGMP) report message handler")
> Fixes: b75f7095d4d4 ("amt: add mld report message handler")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>

Thanks a lot for this work.
However Michael Bommarito is already working on this.
https://lore.kernel.org/netdev/20260711151934.2955226-2-michael.bommarito@g=
mail.com/

Thanks,
Taehee Yoo

> ---
>  drivers/net/amt.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index 951dd10e192b..8bc61c539b0a 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
> @@ -1210,6 +1210,7 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb=
, struct net_device *dev)
>                 } else {
>                         data =3D true;
>                 }
> +               iph =3D ip_hdr(skb);
>                 v6 =3D false;
>                 group.ip4 =3D iph->daddr;
>  #if IS_ENABLED(CONFIG_IPV6)
> @@ -1234,6 +1235,7 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb=
, struct net_device *dev)
>                 } else {
>                         data =3D true;
>                 }
> +               ip6h =3D ipv6_hdr(skb);
>                 v6 =3D true;
>                 group.ip6 =3D ip6h->daddr;
>  #endif
> @@ -2498,6 +2500,7 @@ static bool amt_update_handler(struct amt_dev *amt,=
 struct sk_buff *skb)
>                         netdev_dbg(amt->dev, "Invalid IGMP\n");
>                         return true;
>                 }
> +               iph =3D ip_hdr(skb);
>
>                 spin_lock_bh(&tunnel->lock);
>                 amt_igmp_report_handler(amt, skb, tunnel);
> @@ -2517,6 +2520,7 @@ static bool amt_update_handler(struct amt_dev *amt,=
 struct sk_buff *skb)
>                         netdev_dbg(amt->dev, "Invalid MLD\n");
>                         return true;
>                 }
> +               ip6h =3D ipv6_hdr(skb);
>
>                 spin_lock_bh(&tunnel->lock);
>                 amt_mld_report_handler(amt, skb, tunnel);
> --
> 2.43.0
>

