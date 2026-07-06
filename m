Return-Path: <netdev+bounces-305150-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id akRVNs3cS2p7bgEAu9opvQ
	(envelope-from <netdev+bounces-305150-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:50:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 755DC713823
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:50:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="DBm/mAnp";
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305150-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305150-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E86833004F39
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 16:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C67417377;
	Mon,  6 Jul 2026 16:50:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE8640D571
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 16:50:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783356619; cv=pass; b=OglV4/ientK48c0r92NlL8Enly+2srgxHfGadSm9b1BNjny8k20mUzujeNjsy5WX+rUCUiy/nFzzmVZs2vRQ1MBnxnZq2mtxHotRNztVxBQm+iMaf+gfiCWdErnWPOAiQPUpDK9zo7mVr7c+eNvgXRZVDykVR46Pls+GRtPZxfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783356619; c=relaxed/simple;
	bh=h3i7O9G++g7CBLweFVs39stc/Qs7bD4BkEbgxYquuZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y17o+GXWoXeyzDohryFCrt/6d3fWGQNvSpFejWvZJdzlNlBr3sRpaAhlkbKlgEGl1RLcgL0QHrLKvmhSRsf4MwBTNXZJ/bdofXdnZtFl4DSKc1hQbvJ94q1zESOjt07GerbwIIcEXgUEwDYqfZJtqp2LEfByNV/70jyrm6YmM94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DBm/mAnp; arc=pass smtp.client-ip=209.85.215.174
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c8fee9f63d5so1788490a12.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 09:50:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783356617; cv=none;
        d=google.com; s=arc-20260327;
        b=RN2nOtL+kSaPN27Td+7w4cNmUsplKWshWSpETeesJmB/agvw5Cl/hChnoX57vF7UtW
         HWeAdLv1ilfogc7DST8vJQ28o5VlX3owJP7n8pNmcnu92VZqssz9/1JBjV8EPR9JCrZj
         lck+ah/P/VzLpWjafEmKKxs6m3dJbfnOSYE5eNXlitc7YrQ3Sj1ob4FJjNwQz4S47Jbk
         kbgppbxMxJvdcdQlU/wo1cDJ0sChnKae1VNTvRImAYbc2/J993DVg81TdevQ/X3jxit4
         kXR2Cfj1+WByMYJtz5LpxVi/b15Yd58WeMCa1wgOXLcOS6PIzcyFS3E5IQ34RHeTKqU2
         6wYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y2Jo1cTANhVWri7WEWVQ3/UfiG/vKV5dfVAPXk5QZDc=;
        fh=0/3V+Bs8BenKT3mZ6+7qcC6tMGAxmIE5iPIuRa6FAnU=;
        b=iINPSW7OZXhL0MAJ4D+74xgqHy1VcEUgNYKic8xNwXMakMNyYJCoHaYo325ikcKoRg
         /PX0fBXMnRxxT1KtG83adtTJB18uDtzFG737qg6g43ofC3bVS1UpJ8Jl8VgOaLL5GCU2
         4u7qwJaCobHV2OtpF8ny5CU4ERThm6SKkGyNneb6gjqEDzu4/HPXZiCEtdD/5Vbju8b2
         6VqxhHPIn++Vr6iPAnzMHT5UhMYIleNYPApioVHFunDcm/WRV5B6sT+xIRN2YtL1B22S
         WXyt5PxYjIBTmydENa31OO5/rt46wnqcYU3yNe9wuhrVIHve56LvR1zTU64VfEeQbK9H
         ZOeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783356617; x=1783961417; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y2Jo1cTANhVWri7WEWVQ3/UfiG/vKV5dfVAPXk5QZDc=;
        b=DBm/mAnpp0Z+d7llVsIpQn0G0XjyfERW3LZQowX6ISYI/NWdU/XbojuKC8tb/Fb+2l
         3P+q2x64WQWJQZeLSnBy2HMZFt/90ZxPVmjjXslzDYLKQ8h2OwtlOgPftQodX2mLhGt9
         c39why2U8GOv3XrC7c7SzG6RurSgNF+uDbwJHx79CM8jEuWWJ+Twyx7F1h5TiAThHKtx
         p4uWOZGVziiDJ6VEBCJ7ji8XfnSvQK/MRuwQJTXU54HwnkGTIGN5VqeiXGoY/hg8W7Z0
         b+7r+E/MiKTIhzZZ/qc7jQCOCD9cMhqj2Rrl3oozDKfKQgCHGaNm6oV7Kb0+prDYjhgK
         RkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783356617; x=1783961417;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y2Jo1cTANhVWri7WEWVQ3/UfiG/vKV5dfVAPXk5QZDc=;
        b=PXU0WYlDauUICn8qRSfvW5SJA3KgS2Zg5m87ML79lqHBuFaHGoPrRJvh0AaH0hi7cq
         nR/5Y2WtPxPOdzYwK4ywFenhxKbCwrHx9SWc3ShSVTIjcZeZdIh6ZvAV2fXFleLlGLGx
         nv38lU/MZJ5woqTHEStaRu9QUy6hFyUNgFGRsZojKNZbI6KrlIFvRcwxL3QbBkLTda6V
         4x2jrDbZPyrbaQER/VmQlTOILSQTeoHhRDTurXfK1xag+8ttGtPiYFsGy/SD2vvm6G3B
         Tg4ggyC522utqY2NZiDT/L1C6wnOtKuxdKm6l7Mv06M41HO3aPl/lUv5Fe/T/Mby8jkH
         r6ng==
X-Forwarded-Encrypted: i=1; AHgh+RouGj4PX+08fZ/AvBrnYoSvrn04kIl2GudZ6V+O4OjI7nrpfNmPhtwMvyrDEvVpTsj0q258Rzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiFaX0+6lkAaQ6GotpG2AbxQFrPhKuQIzUn765mufwv3Yb4W8g
	NOGp2uXy7163HzYnH2gY8h5G4rl1JfYf/2duBlUr8o0ZMq0lMZoGwWSMLDLxr5aIFFDncD/w0ay
	r+q/PJRTObxjubuZfm8rD/QR0wZl11avqY35t0blw
X-Gm-Gg: AfdE7claaCySWcpVkAW4twd0PflWtA32tpXDqEANExcIbOuejB0ucFYxH/8QkKZp04p
	OoJcK1UWV4SxgJ8TYAyxPwpyTpjva5b27T/G8M0Iqxy9GTSjMlZB97pPZlLmrfeApTaSGxDAqwB
	kfP6+Of57nIIFvBlqvC/FVxNrSU5OA15gArpL0deTOVZnBzHgK86M/Mm2TWuPipyOnV/HfJfEkJ
	099hUEjRYSJA/vCYfTcFHdMOTvsW/hVb8fG+0y/JQsXmLeV4QAHbkQgLEOxP6qo+Cm0JaQf8zeU
	MvKc+/78j/FdT5eQj9fFxFVPd/JsSN2miOhD9VwOP9O84VZrOLs7xlmktehwMGppPIUO8HX1OIF
	wXfjxuQOq51tDSQsttf283i3lpREyHmme6Yy4SA8ySvsvsryjYA==
X-Received: by 2002:a05:6a21:689:b0:39c:235:c5ec with SMTP id
 adf61e73a8af0-3c08ee78247mr1685112637.34.1783356616384; Mon, 06 Jul 2026
 09:50:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703001009.1572444-1-kuniyu@google.com> <20260703001009.1572444-12-kuniyu@google.com>
In-Reply-To: <20260703001009.1572444-12-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 6 Jul 2026 09:50:05 -0700
X-Gm-Features: AVVi8CfIYSIiUMIVlknORlbnjbAi834eFRLtfRJ60imfAhQPdQlp4iLZgV8K3do
Message-ID: <CAAVpQUCgYwoEzsg5mWdRN=Pgp=h6YW3u2T0oAiGTLdM-VLmN+Q@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 11/14] ipvlan: Convert ipvl_port.count to refcount_t.
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305150-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 755DC713823

Replying to Sashiko review,

On Thu, Jul 2, 2026 at 5:10=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
[...]
> -static void ipvlan_port_destroy(struct net_device *dev)
> +static void ipvlan_port_destroy(struct ipvl_port *port)
>  {
> -       struct ipvl_port *port =3D ipvlan_port_get_rtnl(dev);
> +       struct net_device *dev =3D port->dev;
>         struct sk_buff *skb;
>
> -       netdev_put(dev, &port->dev_tracker);
>         if (port->mode =3D=3D IPVLAN_MODE_L3S)
>                 ipvlan_l3s_unregister(port);
> +
>         netdev_rx_handler_unregister(dev);

---8<---
Can this trigger a lockdep warning due to a missing global RTNL lock?
---8<--

Once RTNL is removed, yes, but out-of-scope of this series as
mentioned in the cover letter.


>         cancel_work_sync(&port->wq);
> +       netdev_put(dev, &port->dev_tracker);
> +
>         while ((skb =3D __skb_dequeue(&port->backlog)) !=3D NULL) {
>                 dev_put(skb->dev);
>                 kfree_skb(skb);
> @@ -111,6 +114,27 @@ static void ipvlan_port_destroy(struct net_device *d=
ev)
>         kfree(port);
>  }
>
> +static void ipvlan_port_put(struct ipvl_port *port)
> +{
> +       if (refcount_dec_and_test(&port->count))
> +               ipvlan_port_destroy(port);
> +}
> +
> +static struct ipvl_port *ipvlan_port_get(struct net_device *dev)
> +{
> +       struct ipvl_port *port =3D NULL;
> +
> +       rcu_read_lock();
> +       if (netif_is_ipvlan_port(dev)) {
> +               port =3D ipvlan_port_get_rcu(dev);
> +               if (!refcount_inc_not_zero(&port->count))

---8<---
Is there a potential NULL pointer dereference here due to CPU read-read
reordering?
In ipvlan_port_get(), netif_is_ipvlan_port(dev) checks dev->rx_handler,
and then ipvlan_port_get_rcu(dev) fetches dev->rx_handler_data. Because
there is only a control dependency and no data dependency or memory barrier
between these reads, the CPU might speculatively reorder them.
If this races with netdev_rx_handler_register() on another CPU during
interface creation, could the reader fetch the old NULL rx_handler_data
along with the new non-NULL rx_handler, resulting in a NULL port pointer
being passed to refcount_inc_not_zero()?
---8<---

No, ipvlan_port_get() is called from ipvlan_device_event(), and
netdev_rx_handler_register() is called from ->newlink(), so they are
under the same rtnl_net_lock().

