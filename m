Return-Path: <netdev+bounces-260414-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIUUBXNqnWnhPwQAu9opvQ
	(envelope-from <netdev+bounces-260414-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:08:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68059184423
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A9883077237
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DBB369998;
	Tue, 24 Feb 2026 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LzyR5/v2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA3339FCE
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771923782; cv=pass; b=GCPb6UnOfe5UDwrokaZzet3kCgH45eFJ0O2wd919CkoPi8L7yrD/y2etwgHa9atHfDmt8UJYye6k1wdxhouvDEszKItJgeeetN5RwRCl2yPJVeBJYsHGWmSZYQzdLMBjdlgWHuElRRGq/CgUYJpIsPBOuIvtZgdZPnWQ7d3u1b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771923782; c=relaxed/simple;
	bh=PDMz8x/JghcFqHfljeMjWqqIZhQmuD3RMw8bsgaXXPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLRx9u0np+dXD1hnZcDi1H2VbgmTiDMyZIcU/YEnGHZJLvfh/3JYqVTKYgwF3xmnJTlaJijB+h9TOMz4U8kKx2I8P0Sh5qbK7kew35Zt7534Gkg1F+bhLz3wMSUDEipH5CAIUWgUsznezDrxBf+ic5r4AajUsdwEZTaOni4gVJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LzyR5/v2; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-899a98c2421so7370106d6.3
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 01:03:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771923780; cv=none;
        d=google.com; s=arc-20240605;
        b=aIWH1cJIGNTJi1E/wDK402S/lEAHF2iXkCpIVjsDYScgFnraxO5Eu3/rmc5RZcFJEQ
         mEYIyuW639/cLMN0aGZTLIQk6wUWDSEweasN2SE78kd5OCjU50v+l966anfPSgzYNw09
         WD6aSbnd6XrTlp9IttjIdz7sjXqgCGWNZjlF04LB6CiAv8yWi3paOxKBuPEzFqkX9xmt
         kfdxAWWMW0nzxB92J1V/ZAGG7PLTAc7YLa5DYC/+0xClDB0/X0bfRLeJLkR7JxP0zmu5
         0BdajfkPHxdBGR0cUZ5yRWV5jxr8NVMEUGKf63iZ9Fp95ygoNFjjFA9kQece7jgLa5Zt
         3/Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bycDUMVgUJx7agXXwbni4Y8VvCN7P7wLRWhjQ/lPALo=;
        fh=qV/SqkEE6tsDeUzlkUwccPh0OvJNSSNziFjidSsYAMM=;
        b=i7978eHFTpt4cBTx/X94ljr9gOKXFhCZy2aDZ3eE/A7T5hZgNGoQPtnSvEgazSE/pP
         AjE9nh36i/5c0Fdt7+D38nRz+oYS5FaS2HzThbuCEwb2vUQdDQU5uL7M1XJqixg9dKqm
         G/dBcxPXBZZUtuiJyBHCa0Eqfx99jrcHmE2DeaMdbczqb54wj9w/WA59bkF/4RqjmfCe
         FY4SZztBkwHStKx/Qc7lqLFXEhSZfagzZwP/IilTBQoq9WEGgTVTin3mLXac9hchi03E
         RJcQIY2RC67cWviercLP6vM0LhhLZsgC+ZUDtJCmehtN4Qk7S2NZHx/+VuRFqiJ1aL3H
         Y4Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771923780; x=1772528580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bycDUMVgUJx7agXXwbni4Y8VvCN7P7wLRWhjQ/lPALo=;
        b=LzyR5/v2Rj4xy+5PwroDVpSddKD/O328BpYXcaETeH34SFpgAHX9Szp1qrq2F37FMT
         AlJNdqqc8bv1j7Dz4Rm8lOWCGni6NjSMv3ksr0aOwh9iNINGuoA0va7Fg6hskQ7uJ/C0
         NgnMkWGaMoCpnydIeePyTEUAMD8VmoR3TbXDns2crEXo8+lB5WGYMrn9NkZV4Jajghly
         JE3PfoLRpTJQJbtozCzDLvwndCk583Qi0jFMwjeiBbHeO6hl4kt+gDH2rrBx5Z2x+pwW
         g5EWLdkXhP6RD9zVSpf/x/zVN4Fzc5THxupr1m22D7EWcvm9xFMuAnQeM6qGwSayZMJX
         D7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771923780; x=1772528580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bycDUMVgUJx7agXXwbni4Y8VvCN7P7wLRWhjQ/lPALo=;
        b=AwK23IqgTnZfMdk/5ZkTWYdpo+UXWzquJqb+99rqxb9AwJa+1BsegIn+45Y6gRsUc1
         e1Yb9rqsDS4KgKvxyc0wZ6RCYFlXKkrCxijcWERxYWkiEBOY1iY3fpS4Esmt4gyHloGQ
         QsDJSz1nX8iTqRZthzDPzJUY+qsBXrq8Az6fbqe7s3KlFs+YzXFwg7mqawlHeHOduLCK
         Li26kdUeL0NsrebgnaiPQTyG87ReOT0GYbgkOtxYlqVZih2VBnppN0uZww3uVt9Kc5Eu
         MW7vqQIAJFhh5KK9nEdpdZgeuiQC36fNuzbC8lRGLilib7LwC9M1mj57cLkCt2+8AAIa
         vhTA==
X-Forwarded-Encrypted: i=1; AJvYcCWLz3FmkGwS/3iGo0b09RzAw//Gs8BzkYIae/5wd9P2DauCIHsgjSN2aif7Jqct58NtE6hCN2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl4jsRJA1RzqyQCfh0Q4ikT/jLCF1i2ybf/c2FIgrpSTyC1EwR
	NPtghtrqS2mOzulkriX5BNR03JZMQNPxE/9TgbITz0+s1r4bTfRETyjqM/OCYB5xwct89wb0HFc
	FiK0aawGHEOEA15R5J5Rrq0y+pLrJPjhArYqxgltT
X-Gm-Gg: AZuq6aJHKcmYDwl4mZzvr6CAMarp6TZeT0hkyR9ra6rM8929RSjv0JSNoeZf2CR+NGm
	ife9hXUa8iLwYeN/8fkUpYAjVqohg66V3V0nDzBoMkvfaKg1KO1vKnZQYqZmWC624hZkHsLXGiU
	6jTKfkp0nrISmS6fmX4lo28rhLG5sctbdgYVtp+QHgaXIXAd/8xLeq/7e7tfzNDNS0y0myxrq2A
	RQNez3jONWyWxOfZzKGsl5UZQQVD9fQ+dvgVajYl797C7Exy7AQmytTiZx9C74aV4/TYu0zqh/J
	mAIwHmdtVA5uCmHk1gvcX46vyJ79s9nsceCYEkrLeA==
X-Received: by 2002:ac8:5985:0:b0:503:2efb:9a09 with SMTP id
 d75a77b69052e-5070bd00c15mr160783121cf.76.1771923779404; Tue, 24 Feb 2026
 01:02:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220183858.N4ERjFW6@linutronix.de> <20260220132932.1ed45656@kernel.org>
 <willemdebruijn.kernel.85c1623c5d65@gmail.com> <20260220140241.51be1e30@kernel.org>
 <20260223170750.q5nhbkSe@linutronix.de> <20260223152738.7e8e95fb@kernel.org>
In-Reply-To: <20260223152738.7e8e95fb@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 24 Feb 2026 10:02:47 +0100
X-Gm-Features: AaiRm51hzt5pFBynY_NxVp67Pr12O4MEBiO93gwBhtgDfI-eCwUJ0hskxiMTqZ8
Message-ID: <CANn89iLcbysm43F7RPH87vjQBrswT4GNNwJ+ySGF7mhPsThr0w@mail.gmail.com>
Subject: Re: [PATCH net v2] net: Drop the lock in skb_may_tx_timestamp()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Kurt Kanzenbach <kurt@linutronix.de>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linutronix.de,redhat.com,gmail.com,vger.kernel.org,davemloft.net,kernel.org,google.com];
	TAGGED_FROM(0.00)[bounces-260414-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 68059184423
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 12:27=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 23 Feb 2026 18:07:50 +0100 Sebastian Andrzej Siewior wrote:
> > How do we move forward? Merge this, backport stable and then convert
> > in-tree user away from IRQ delivery _or_ fix the driver one by one and
> > backport them stable? Or=E2=80=A6
>
> If we plan to convert in-tree users away from IRQ delivery I'd do that
> directly, without applying this patch. But I'll let Paolo have the final
> word. Eric's review tag seems to indicate to me that he disagrees.

This patch is orthogonal and will reduce cpu costs for NAPI drivers ?

We probably can remove sk_callback_lock cache line dirtyng in other places.

For instance:

diff --git a/net/netfilter/xt_owner.c b/net/netfilter/xt_owner.c
index 50332888c8d233aab0915a31f2f616f3171da45e..4ce9fae5eaf92bee7235c461988=
0bd9690005121
100644
--- a/net/netfilter/xt_owner.c
+++ b/net/netfilter/xt_owner.c
@@ -63,9 +63,10 @@ static bool
 owner_mt(const struct sk_buff *skb, struct xt_action_param *par)
 {
        const struct xt_owner_match_info *info =3D par->matchinfo;
-       const struct file *filp;
        struct sock *sk =3D skb_to_full_sk(skb);
        struct net *net =3D xt_net(par);
+       const struct socket *sock;
+       const struct file *filp;

        if (!sk || !sk->sk_socket || !net_eq(net, sock_net(sk)))
                return (info->match ^ info->invert) =3D=3D 0;
@@ -76,10 +77,11 @@ owner_mt(const struct sk_buff *skb, struct
xt_action_param *par)
                 */
                return false;

-       read_lock_bh(&sk->sk_callback_lock);
-       filp =3D sk->sk_socket ? sk->sk_socket->file : NULL;
+       rcu_read_lock();
+       sock =3D READ_ONCE(sk->sk_socket);
+       filp =3D sock ? READ_ONCE(sock->file) : NULL;
        if (filp =3D=3D NULL) {
-               read_unlock_bh(&sk->sk_callback_lock);
+               rcu_read_unlock();
                return ((info->match ^ info->invert) &
                       (XT_OWNER_UID | XT_OWNER_GID)) =3D=3D 0;
        }
@@ -90,7 +92,7 @@ owner_mt(const struct sk_buff *skb, struct
xt_action_param *par)
                if ((uid_gte(filp->f_cred->fsuid, uid_min) &&
                     uid_lte(filp->f_cred->fsuid, uid_max)) ^
                    !(info->invert & XT_OWNER_UID)) {
-                       read_unlock_bh(&sk->sk_callback_lock);
+                       rcu_read_unlock();
                        return false;
                }
        }
@@ -118,12 +120,12 @@ owner_mt(const struct sk_buff *skb, struct
xt_action_param *par)
                }

                if (match ^ !(info->invert & XT_OWNER_GID)) {
-                       read_unlock_bh(&sk->sk_callback_lock);
+                       rcu_read_unlock();
                        return false;
                }
        }

-       read_unlock_bh(&sk->sk_callback_lock);
+       rcu_read_unlock();
        return true;
 }

