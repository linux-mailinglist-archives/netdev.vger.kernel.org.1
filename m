Return-Path: <netdev+bounces-274643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFD7INyrzml+pQYAu9opvQ
	(envelope-from <netdev+bounces-274643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 19:48:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F377E38CBE2
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 19:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5FDC302B500
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 17:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3D33F075B;
	Thu,  2 Apr 2026 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhtC0Cid"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E13836C0D6
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151962; cv=pass; b=AOeAbtx7JmKJ7VKhh1F0Yh6XkBLut1Hv3SQgIVghRUGbvG3JWtYMCwJ2mgjSp2kXiXIRvOZg5l19IXs+9ZJ60xOERv8gEXrbfTu2Rzs1Zv72AIDz0z7nQYWvKLxxq7nH9xqRHBPlSJb2FUhl0+PVdsw+PvVO6L+XJ404ihd4ST0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151962; c=relaxed/simple;
	bh=tojv1aMsDMqXST17MzgGYQM39sIEZXweMpssAefWpSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6FbCmcN42IVIlTWLu4jyMrao1BFFZtPWnpzBT8NdUxLTupaBS/aH+yiL4Fuo68jZublPyrcv7nQ2Sb9EA59+ayc8YodWWshNatBNGSJx3/0mlVsrqITxLXknIgvLsnafxlF069mBPyNmuwGW/SlboysczHwImb4K/Lw7hZmqZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhtC0Cid; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4152698e745so504964fac.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 10:46:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775151960; cv=none;
        d=google.com; s=arc-20240605;
        b=NQ5MM06ezfSey4cQKEnurA26DlnGfyPsbfdCfsnbrhqBzSNuOF66YYf8C89bFdeoki
         QXaGfrv6Q1nT1eZjyxFcad+HWjh3Cso/6TpMi+nF2qbsuLMX7VSZWzLuC6jqGXSup0/f
         8ianXZxsIzPMCfWEYD7TB3kolhPhzqR44mxIabZcqNGPSWj+5O+3XtNwEJ75rdA1rwdo
         cXwhAPZ3KHJymuP/0uTu58tAqL9LKKp0czAUGNOUBZBl1mJt+vfRV3/b1kLgfeiHYBOb
         SiA1hv0Ko8sCtck2l/P61D9S7i25eM05lqB3Kah+UnE5dW9i/SqESt/4ZuV0GzQT6lxj
         YMQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=drNSS/8xqoOB/vk6Azz5QoQdOOaSz/N84Q7K+Cojxxs=;
        fh=Dduuoo9rPBLSa6g6Ek+Gm5d9yM5mhuK7u2EPjU6Pct0=;
        b=InrxxptnmRpPuUTJ5onQom1ojpDvjxBSpkB5YcRzCrG1BGdydH4sNK4I1kgtHH1Ewy
         QfZlbQ6mHqsywJbbXpXgjzQTUN3p1P6sAdfONVA2lgbbY9+6qhiwMbWdR7CP6MRqpQ03
         HY4/EnjppQ3ZbeZ1vfGE/kXBvyRsk0Lh5nYq857fdwdl668ppr7iMnDGd7jBZXP5p6rT
         lQAS+QE+PWATel9sT2MDEincRB5bvSpJ1Oa0soF0V3dJluadUQUoKfn/UEqswNJzlDLb
         LZZzRa/FoqjLlHWXMPvT3FBvDDlAfH+HX5YDx7X3DHEiQnWSKRiJFSJ1FMesQu7MsT/X
         TGfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775151960; x=1775756760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drNSS/8xqoOB/vk6Azz5QoQdOOaSz/N84Q7K+Cojxxs=;
        b=RhtC0CidW91uHg6Y27QAV6zLFrTWI+8lvLrVn0qHB6La5+MER7gNhevKyS4TMVkvwg
         4azjU8r7ztUCs6AIdahRgXITTeiory2bZDEMuaClew8ltMV68WsMoxDyaZB+hbmH8bxY
         PLlzCJ0dwKDkEikQ6xgDT/t32x1jIZo0BQaeza5Pb6gdmn5UJYvmpeNpsZNqWQQe2Qxh
         1ztMSVcyrz/ogePvdRfXEm3/OoXMUe1wbTv7xllGI2idLU9XSuxKNcQN0IrZ4Q2Q2J/P
         wzrhZywFHirdx6mT9Ax90uz5D8in1zPZOVhaZhUdwf8ii90vasgxciAhoZ77LdkneF2j
         4MjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775151960; x=1775756760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=drNSS/8xqoOB/vk6Azz5QoQdOOaSz/N84Q7K+Cojxxs=;
        b=Z+gLazcQ5zdOhcuyY5WinT62Z2E+QKyKuKvY5ig5jt05p0wdgiyQ04FMtLjlcBVhbH
         1HYRRW+y0f5eR8WYduGl01g4fDe0nFUBQvev1zwoFaYB486Yw2+HlhtHelvwJhe2afu9
         Ycp66Ki5+G2HF1hSuT+i2rFLFb2l0tJhQCNWv5vUypsB5YPTSKBG7VORI5UgJdz6AoVw
         O4i1i1boVwjxV8UG6x7cN39lboO/UbUCo7WKlUe30IxEcg9dOloMjkiITkh/1owDVtrZ
         fEDQ7TfEQVZ7I/J3ECXPQZWFruRjuKLGynIwrX1s1q6uSZ5FyVdb5d/Qp9oy6IpYxZ28
         uviA==
X-Gm-Message-State: AOJu0Yy4Z83VdBSZmdNNZl/zx/1Z8ltmEktAwGJAEmF0TvfrBQLI82Du
	1dmYn96pB2KsLIUR/H/nIakTnDdtUKJDsQj6LmfLZ5Cis1QBNz8GMVFx6swdf8BvyGx7p3H77S8
	X5fnxmDUZF9dIKVk9rVFWSCFGWW0PjZ0=
X-Gm-Gg: ATEYQzxVZIyICttB2b9PoWM5io5sy0Kqc97Zxs6fVEC0p2ixvFPQEP74/p4Mf6k8g1A
	n+MjwwLKNTZDimal4JNW0awRcZ7ZIggLo2CW8UczO6xoTO1zs/LtnNUcXQBt5wskt9d5eHjvpGq
	Ovavt2+pBfL5MkIgSKW2NxQrZssry+WKRQUvrLQV/9SVk1Yrt5erxsWi6AEqlDGiV56DXWCMRdZ
	BQcQ5yDvWYGifxsNx67V5b3Lrqh2YHaPQXUfhuu5Cl2J4xFo+N13XL3qigG7bWOzZUUbLjVG3AA
	er/nwjtBWqqo+E5uw/LdxyPG6zazsgkYV7CdFZVlXhfi0bKer81KZ2JCtKoR1O5gAIXn0UVZZRX
	MKdX41RIDApCmXIMh1bELa5w=
X-Received: by 2002:a05:6820:208e:b0:67e:1ce7:77cb with SMTP id
 006d021491bc7-6821dc62870mr52530eaf.24.1775151959932; Thu, 02 Apr 2026
 10:45:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328213338.450601-1-nickgarlis@gmail.com> <20260401194553.6e8a17f8@kernel.org>
In-Reply-To: <20260401194553.6e8a17f8@kernel.org>
From: Nikolaos Gkarlis <nickgarlis@gmail.com>
Date: Thu, 2 Apr 2026 19:45:48 +0200
X-Gm-Features: AQROBzBlTUf3p8BLQZJX7VoAVd4igdQjkexD-LrDDx6vlpy4B8e6yCgaBP8ZRNk
Message-ID: <CA+jwDR=9UgxAW828FF4geu8RukGyi7OLTS0ShVr4S8-36SWamw@mail.gmail.com>
Subject: Re: [PATCH net v4] rtnetlink: add missing netlink_ns_capable() check
 for peer netns
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274643-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nickgarlis@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: F377E38CBE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 4:45=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Sat, 28 Mar 2026 22:33:38 +0100 Nikolaos Gkarlis wrote:
> > -static struct net *rtnl_get_peer_net(const struct rtnl_link_ops *ops,
> > +static struct net *rtnl_get_peer_net(struct sk_buff *skb,
> > +                                  const struct rtnl_link_ops *ops,
> >                                    struct nlattr *tbp[],
> >                                    struct nlattr *data[],
> >                                    struct netlink_ext_ack *extack)
> >  {
> >       struct nlattr *tb[IFLA_MAX + 1];
> > +     struct net *net;
> >       int err;
> >
> >       if (!data || !data[ops->peer_type])
>
> There's an early return hiding outside of the context here.
> the patch is technically correct, I think, because if we take this
> shortcut we end up with the same netns as tgt_net so we'll validate
> that it's capable later. But it's probably not obvious to a casual
> reader of this code (or AI agents, sigh)
>
> So let's rewrite this along the lines of:
>
>         struct nlattr *tb[IFLA_MAX + 1], **attrs;
>         struct net *net;
>         int err;
>
>         if (!data || !data[ops->peer_type]) {
>                attrs =3D tbp;
>         } else {
>                 err =3D rtnl_nla_parse_ifinfomsg(tb, data[ops->peer_type]=
, extack);
>                 if (err < 0)
>                         return ERR_PTR(err);
>
>                 if (ops->validate) {
>                         err =3D ops->validate(tb, NULL, extack);
>                         if (err < 0)
>                                 return ERR_PTR(err);
>                 }
>
>                 attrs =3D tb;
>         }
>
>         net =3D rtnl_link_get_net_ifla(attrs);
>         if (IS_ERR_OR_NULL(net))
>                 return net;
>
>         if (!netlink_ns_capable(skb, net->user_ns, CAP_NET_ADMIN)) {
> ...
>
> ?

I agree it=E2=80=99s a bit confusing with the early exit. I=E2=80=99ll appl=
y the suggested
changes and send a v5.

That said, would it make sense to introduce a separate
rtnl_nets_add_capable() helper that wraps rtnl_nets_add() instead?

Something along these lines:

@@ -334,6 +334,19 @@ static void rtnl_nets_add(struct rtnl_nets
*rtnl_nets, struct net *net)
     rtnl_nets->len++;
 }

+static struct net *rtnl_nets_add_capable(struct sk_buff *skb,
+                                         struct rtnl_nets *rtnl_nets,
+                                         struct net *net)
+{
+    if (!netlink_ns_capable(skb, net->user_ns, CAP_NET_ADMIN)) {
+        put_net(net);
+        return ERR_PTR(-EPERM);
+    }
+
+    rtnl_nets_add(rtnl_nets, net);
+    return net;
+}
+
 static void rtnl_nets_lock(struct rtnl_nets *rtnl_nets)
 {
     int i;
@@ -4059,18 +4072,29 @@ static int rtnl_newlink(struct sk_buff *skb,
struct nlmsghdr *nlh,
         ret =3D PTR_ERR(peer_net);
         goto put_ops;
     }
-    if (peer_net)
-        rtnl_nets_add(&rtnl_nets, peer_net);
+    if (peer_net) {
+        peer_net =3D rtnl_nets_add_capable(skb,
+                                        &rtnl_nets,
+                                        peer_net);
+        if (IS_ERR(peer_net)) {
+            ret =3D PTR_ERR(peer_net);
+            goto put_ops;
+        }
+    }
     }
     }

-    tgt_net =3D rtnl_link_get_net_capable(skb, sock_net(skb->sk), tb,
CAP_NET_ADMIN);
+   tgt_net =3D rtnl_link_get_net_by_nlattr(sock_net(skb->sk), tb);
     if (IS_ERR(tgt_net)) {
         ret =3D PTR_ERR(tgt_net);
         goto put_net;
     }

-    rtnl_nets_add(&rtnl_nets, tgt_net);
+    tgt_net =3D rtnl_nets_add_capable(skb, &rtnl_nets, tgt_net);
+    if (IS_ERR(tgt_net)) {
+        ret =3D PTR_ERR(tgt_net);
+        goto put_net;
+    }

     if (tb[IFLA_LINK_NETNSID]) {
         int id =3D nla_get_s32(tb[IFLA_LINK_NETNSID]);
@@ -4082,10 +4106,10 @@ static int rtnl_newlink(struct sk_buff *skb,
struct nlmsghdr *nlh,
         goto put_net;
     }

-    rtnl_nets_add(&rtnl_nets, link_net);
-
-    if (!netlink_ns_capable(skb, link_net->user_ns, CAP_NET_ADMIN)) {
-        ret =3D -EPERM;
+    link_net =3D rtnl_nets_add_capable(skb, &rtnl_nets,
+                                    link_net);
+    if (IS_ERR(link_net)) {
+        ret =3D PTR_ERR(link_net);
         goto put_net;
     }
     }

Note that this changes the order in link_net, checking capabilities
before creating the object.

Disclaimer: I=E2=80=99m not very familiar with this code, so this may be a =
bad idea.

