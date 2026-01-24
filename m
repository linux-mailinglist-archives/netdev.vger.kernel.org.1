Return-Path: <netdev+bounces-253033-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNmwF6hkdGnb5AAAu9opvQ
	(envelope-from <netdev+bounces-253033-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 07:20:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4973E7CA4A
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 07:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 721673002932
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 06:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63691242D78;
	Sat, 24 Jan 2026 06:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0qadA0f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90661FDA61
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 06:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769235619; cv=pass; b=t7U10kZOS9zmNpSQxulQsY2zdn+x9JfBZHovKm5Ji6xAr3vHKMSL8VF5AjDrepIV6rSe4KtMc/WppcdxBBslYSyHtazrKozgNNrReYShn3enD6OTKg9BVb0lu38dVqXtis+WqG5A/HiQP1bEbbfR7ETjrkliKjrjoNpaqH/g9/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769235619; c=relaxed/simple;
	bh=bYVnKH94c44l8f5gXIeNkxr1XQ6EJ75Z7gGV5+ZBVGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EeYIhSLI3ll2ZDLP9cWwkTz1CGT5HyVT7La+cjz/em0tKe+rAp1GHTt0I793TFYCqTPzl8XY51dRCu3Mb5RfhQyqiMYasI/VFAg+vePWCXn4Uh0EmzxigQTFIMDX6cdmkYbci88E3mwtBQPt9osi7n9wnr1gpEY/ppeYM8wiz/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0qadA0f; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64472c71fc0so3568922d50.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 22:20:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769235617; cv=none;
        d=google.com; s=arc-20240605;
        b=H98yI7FlI04gzVt51izxAvuyAkYMGZHnHTXPWka0QIC2p3jyeJyOGDICYirYqwc35u
         f/XvlyVvaa4Vl+9KBZV6+tet4a91KkUpy3LVFabGIefuDEaaIQeR4A82aXaUpT/4vB6M
         qj6IQSiXdCiCgaVbFvNJLIklmCxVHtB+P7r5MI/huD1EOxPNmEK5AeaSxEMLJaVOCvgz
         brUwpT4wgt2mCcnZPEfJXVkpq5ZQlXal3rgxVA6lD9K+QZIIzbTXu6Jh/BwJzeJUneeg
         FGb4ho1I+OcDigXmKNEQW7gG8KR/HTHcwjMwZO8RALwTOiSXsrTFmWSL2IfUyspwhRLq
         httg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0Jj4kHSwisGbQx6sKYU/nCdMsGq5B9cjKeLubIX68B4=;
        fh=wZINhht1ARSOupkpG3StP+iU/pd7DaEJ6OoBvK3jfbI=;
        b=U0RjM+tOS+Cq2Yl+cpiq+IQHTznTu6ilv6p5x2ncDOxqRCZeFrK4/bfbYzGR5B25qG
         UQsNkULffWo6i/JBUk+Dp663WUzRF+AKF9fDs4Ia3HXno9t3W/IVaoPPmD0g4hIBJxVE
         /YTrt9+ByDDPnjbm/XBIZrZfohsyBAy9aLl3HyAbaSufLMUbcfgrH0rIJ4+aI91G5nTW
         9CqZSWOGPI73CEiIr32X5XV8qP5nIhrBf7JVpxnY3cRxtEBibOu1MZ0A91l8c8ToYDR6
         Br8cEIjIkWzSY21OIzpTr8OE92CjAyr5LKrXB3f1L+KxrxT1eMMWiq4/O8oWRspapYNS
         ZKxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769235617; x=1769840417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Jj4kHSwisGbQx6sKYU/nCdMsGq5B9cjKeLubIX68B4=;
        b=O0qadA0fdb0cMuvqBpiNPnPzNU+rTtArn+W3lv16ePHEZUodMap0/KNknvnPdW/Zje
         1//xlG1u5W6EegpHu6PQ5viSO1VgIU0ZnWRoiaU77w55SppQzC9jx2ol4W4XXpkrvuQ2
         lpgTo08fZxLkINfetVP/rNnTRXAibJDitAK5ZXOKih0HZTpadmf1hU4Kv/W7hLsUClrl
         y1bbYNMROkJBnKtpnCgQCfzzQR2oozfSnrUQayF2Mr52yBhAOYnQJeTcful0plBzWsj9
         todqE9aD1IhZWYpbb+SLdkEWHyB2eMHhXAPrg5xYxOTr4u4BK/oIn4ZTN/eRvVPuaciE
         opBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769235617; x=1769840417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Jj4kHSwisGbQx6sKYU/nCdMsGq5B9cjKeLubIX68B4=;
        b=BWqxn1UCFUzwCtHlhnJ9tRco0qibRMx0hbMs9z/3J0GvfQrRIepiozgIapgBTb85KQ
         F25o9osSu+OGzKuRv4KP2ManmQ7OkQv4TtdWS06de53keFxIV1z9KR6sHLZ5FOIboh5F
         TbpL7jvkBy4ybcjxr0Fx84RHXvCWD0vTeEPd4zHNOf83Q3AFPPx+z+VE3coVWNkt0SZ5
         NV/nxwAmZKrnL1tut8KknjkUbdZkAuUf5ywWoJgYUTTOocKiMnkOjelud4Tnsi1wWcOt
         GNrg7lvfn8gB4XKsvdq1wbNqX9XtgGrfCf4fCpk5P1y6z/jKMqNma+yZWsrsAQkq0PcF
         KEOw==
X-Gm-Message-State: AOJu0Yy9oSnalOKUTQ0KVceSL8whTWPfzKOBffrusKdLUblhE0v0LwD6
	xzfxKr1zHQnAQxn2ZFlcwIs4CUDT+JoHcISxxvXvSVm4NAGCyrXU4q+TTddyHWqtEyyd8Mcpenc
	kwhBf6rBF67xfgWI3U5oZN7qFBnzOj5Y=
X-Gm-Gg: AZuq6aKCqfe9Y7hqqOMs9V8IiDb7fj7WNlleyQhP+4lYKFlsJSx0FMUXXYykD8UgjhF
	9PT8s2qn046L2wjHr1x3y2qiAF7a6rlfNkA1UIwFnWC0Brjj5inVqUU9Aym7WD64ygwSivZddj7
	jq/6TC+aJySbymm3Nxv1gNIea1b5uXjpzyGO62WbpmSN7EuFkf5qj+OOZnA+XPh3e/VM6Db1U4P
	mStxRsc0cN4aNeDOuISMm606L10J4LfNr7sxiU5mZj1pD3VQDOJXaqCNxmjbHy7h1CmNXbw
X-Received: by 2002:a53:b984:0:b0:645:5bfc:8bd3 with SMTP id
 956f58d0204a3-6495bfe9ae3mr3662906d50.72.1769235616850; Fri, 23 Jan 2026
 22:20:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122185357.50922-1-mahdifrmx@gmail.com> <willemdebruijn.kernel.1682586fd684e@gmail.com>
In-Reply-To: <willemdebruijn.kernel.1682586fd684e@gmail.com>
From: Mahdi Faramarzpour <mahdifrmx@gmail.com>
Date: Sat, 24 Jan 2026 09:50:02 +0330
X-Gm-Features: AZwV_QiUrAxIcPon7mC8O4qreGr4xsoHEGZXH3Mxf9GSsPkzieuMRW9yFmyk4oc
Message-ID: <CA+KdSGNvJ3np3gitnSmztxD9n=WuNcRHGsvKsJUE+FDJM6Zmjw@mail.gmail.com>
Subject: Re: [PATCH net-next] udp: add drop count for packets in udp_prod_queue
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kshitiz.bartariya@zohomail.in
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253033-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahdifrmx@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4973E7CA4A
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 12:56=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Mahdi Faramarzpour wrote:
> > This commit adds SNMP drop count increment for the packets in
> > per NUMA queues which were introduced in commit b650bf0977d3
> > ("udp: remove busylock and add per NUMA queues"). note that SNMP
> > counters are incremented currently by the caller for skb. And
> > that these skbs on the intermediate queue cannot be counted
> > there so need similar logic in their error path.
> >
> > Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
> > ---
> > v5:
> >   - check if drop counts are non-zero before increasing countrers
> > v4: https://lore.kernel.org/netdev/20260108102950.49417-1-mahdifrmx@gma=
il.com/
> >   - move all changes to unlikely(to_drop) branch
> > v3: https://lore.kernel.org/netdev/20260105114732.140719-1-mahdifrmx@gm=
ail.com/
> >   - remove the unreachable UDP_MIB_RCVBUFERRORS code
> > v2: https://lore.kernel.org/netdev/20260105071218.10785-1-mahdifrmx@gma=
il.com/
> >   - change ENOMEM to ENOBUFS
> > v1: https://lore.kernel.org/netdev/20260104105732.427691-1-mahdifrmx@gm=
ail.com/
> > ---
> >  net/ipv4/udp.c | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index ffe074cb5..41cf8f7ab 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -1793,14 +1793,31 @@ int __udp_enqueue_schedule_skb(struct sock *sk,=
 struct sk_buff *skb)
> >       }
> >
> >       if (unlikely(to_drop)) {
> > +             int err_ipv4 =3D 0;
> > +             int err_ipv6 =3D 0;
>
> nit: whitespace between variable definition and code block
>
> >               for (nb =3D 0; to_drop !=3D NULL; nb++) {
> >                       skb =3D to_drop;
> > +                     if (skb->protocol =3D=3D htons(ETH_P_IP))
> > +                             err_ipv4++;
> > +                     else
> > +                             err_ipv6++;
>
> No need for separate counters.
>
> All counters will either update IPv4 or IPv6 stats. Similar to how
> the caller of _udp_enqueue_schedule_sk is either __udp_queue_rcv_skb
> or __udpv6_queue_rcv_skb and chooses the SNMP stat based on that.
>
> Can check sk_family =3D=3D PF_INET6 once.
I doubt this. How does this work in case of a dual-stack socket?
>
> >                       to_drop =3D skb->next;
> >                       skb_mark_not_on_list(skb);
> > -                     /* TODO: update SNMP values. */
> >                       sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_PROTO=
_MEM);
> >               }
> >               numa_drop_add(&udp_sk(sk)->drop_counters, nb);
> > +             if (err_ipv4 > 0) {
> > +                     SNMP_ADD_STATS(__UDPX_MIB(sk, true), UDP_MIB_MEME=
RRORS,
> > +                                    err_ipv4);
> > +                     SNMP_ADD_STATS(__UDPX_MIB(sk, true), UDP_MIB_INER=
RORS,
> > +                                    err_ipv4);
> > +             }
> > +             if (err_ipv6 > 0) {
> > +                     SNMP_ADD_STATS(__UDPX_MIB(sk, false), UDP_MIB_MEM=
ERRORS,
> > +                                    err_ipv6);
> > +                     SNMP_ADD_STATS(__UDPX_MIB(sk, false), UDP_MIB_INE=
RRORS,
> > +                                    err_ipv6);
> > +             }
> >       }
> >
> >       atomic_sub(total_size, &udp_prod_queue->rmem_alloc);
> > --
> > 2.34.1
> >
>
>

