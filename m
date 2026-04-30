Return-Path: <netdev+bounces-282868-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKAvG0db82lfzwEAu9opvQ
	(envelope-from <netdev+bounces-282868-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:38:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C704A38F9
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36A143005598
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472514279F8;
	Thu, 30 Apr 2026 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VkBPTlwC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17B2421A14
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777556293; cv=pass; b=F8kA00zW5+q3IZRTZaQStb2NuHeYVNiitrRi/zYNXzwOm2hqWfu8rCPVLOqbIZZOeuJKwXKxYXCD5NwhiUk27m2a4HIMNJM93tydS1Hc90m7XH12Y1yHP47UrntdHh7bAqAIWkO64CmpBDGDC2PPH6hYNwuiPsGJXidmkIU6/pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777556293; c=relaxed/simple;
	bh=iGEBFU6IYIG8LwjqApNYFgkeniyMQP+8C2AVOEOMXvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qE8lPDyDtU18YYjq8QBIsT++oT8g0uTrMCGQJc4SqN3Gm1HVuR9STba/Yx0e06GDliL0n1Iw+0PuNYYNJSeV+jjpOLGcnT9j1GVZhzPKjbpO3cD2OE2qHmN7Exrnd+ls16dQxRJ3yYo+E9YG636I4c7Njuv6Ue/VH9B/lSIZYS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VkBPTlwC; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-506a7bbe9d0so6241071cf.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 06:38:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777556291; cv=none;
        d=google.com; s=arc-20240605;
        b=XbWFn5bsKl6Pto3uP2s8O592L3ypea+TmyDUQNGoH6sIDx4Nk78D/QZJdCdJcoXvRD
         Ri5eq96nkQ04o0IKqhporGsB+hBC3RMWJCEuKaurEb/6l6GSGfvws7piJkH9m8Bwa66P
         kS4cSVeeM/03aDggBZRfywsk60BG8uTtYhebcFHVs+uyZxH6LQu1SBl5zElIG+AWeMVu
         LgPXZ+HAbiWTukfWVOY2cPShlM0DBL7qoiEiWyXRdfXJmD39fGueJkt9eUAch/qAtYDq
         Ra3+M1dkYexJa5bxSDnkvDVBpQOegCjcNGuwQpLEvRq+VJHf7WASih4Z/PA5BcS8Fkgo
         Yfpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O383Vp7SC820ZNHik1BT/8RwgbKb7j29ZgfHB3bQSiM=;
        fh=XAP/NFhdQKj5EV/4sRjo2gudU1EN2dVwOItQVbby6O0=;
        b=UaXDETctSmPYPH/A+syVRzotMo5rdbzEWWdSnQeJk8squhhtYowW1wlYlEkb07YTpz
         Euh0YdSOlzsuaHWWrMFnvFbTJfHF4U0maWGkCW5r9UkbzgREfO49zuReyohK3cIKqkG/
         a/KbUMEV+B2d5V5o8Pwg2mr46/LMoBaBPnn61+riTBQb1efSp8Z48Qq4CvckapZj+Skd
         NakQHFrllyClqeaG6Jdgc7qoIFFcifhNpFsFOMcT+ZL2pYJw3nhS4oTgAyMtwVdCAHL/
         cQWxvX6ENfceUDbUC9gbZrx7eUdSVIii22VXfYl6DwiJSUxxg/+tSeVnBYrEtidmR7ps
         0taw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777556291; x=1778161091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O383Vp7SC820ZNHik1BT/8RwgbKb7j29ZgfHB3bQSiM=;
        b=VkBPTlwCKejnNj5C3HXzm1krllC3XGiShAZFJuYAjiRyGuM27FOhJ7TO1pysH+ibZv
         /77mcm5b4u0aTKAW5rq4AfR7AKb427rKVl1PzKl1r5aZYB5mUl+UtU5oj6+8mHsWNyA5
         MnadpPH9uAuIfm3aWsv7xKXNsEp79l3xWPm5rV9QSTjoeTZPIDkqUVz+TrnTlJwlrkql
         1VduLqgyMv2S6+QCgHfuatyWs6hJWLvOV5USdB+Pxg0NM8aGlPOE6Z3SsXjkB00nEf00
         0xoNSJYiq+uCyoTM4ghsecFq2EP0SLMtf/Joz7i4uGbPtan7PnjQ19+o+B9PrLXwx6Iv
         BiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777556291; x=1778161091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O383Vp7SC820ZNHik1BT/8RwgbKb7j29ZgfHB3bQSiM=;
        b=AyUy5TYiAxuVlxTP9op7ujIi2PCIMUd5tkRaeFC3pzXPDV5p6p1bbLqN8oUPszuPVN
         dDe1R9Wqbcw4D4DrqPcAGd/j4pUE94q7QEOJWwyDSLoPZsmSkr8uNZnanr3193nUvDTQ
         zg/mPQw+ONUvp72mBQNx1dGrjcHaO4B83qVCo1ziYFqeF+Rz/2LHSZxEllC4BHA6dDlY
         H6dTj2RyKVbgsd5DoDd+OcyMQKxWEfb2NXY07/6wTrEzBQTlpcnIEE1+n1uF1BLxMDVp
         FIT0TBHNGDD53IM+VDYUSmTd5FBb96GnWKYIY5HqBWHNNwYlz7rahv6lOsw5XQT/Zbp5
         4yuA==
X-Gm-Message-State: AOJu0YxkyAfIl2AZcc8F7o/QvU4Sli8bpG424zRymfFbIQ6vpzOdZhnr
	bj/o7dDoEFH9G4PFNzAKyMtlINr3CJZ+wuFlXFzsS2fg+fk94b3Vq82GnLiT03mymxT0mDZplBm
	3wxodjgUmP7fiealgSZ6AmNfqgtLwJUAPaHQL1BnB
X-Gm-Gg: AeBDiet1dXMGABvgREeotDIxff9J1bjEf4Odv29lPYJp7VlH8gFAYbEZmwnYaovOvvi
	DUrDw3OPkODG6amGJKv2sRGS4kQD+O+OOEXZgTNpRMcBrKLS5h/92zSc/2E85X3EFMrDRNsTvp+
	IKLqBKeXNE/3VknvNL8y2N+vr8Xmkm5xmRq+TtcnBjD1EQ2tDAPq374l8zXpQyRwDDfpuCvGktv
	gYKyUJro3WTcarkhSih8DX0lmS0+itdJgjo+00s1xN6ypVzXikYpmYJNqExloT+s9F8tutSX3wj
	817p7L1VOvl+sEmmBhfUYyoF7eW2oE6ogC0BDkKEWIEj3XIhS6Z9d6hAMFu4O61IwUapl7Gd9RS
	0KXGyX18BgaWJqIehaj0/gtsqw0XCPUEprgPKnp9M
X-Received: by 2002:ac8:6f0c:0:b0:50f:bcfe:e8dd with SMTP id
 d75a77b69052e-5102aae9c68mr41202371cf.8.1777556289569; Thu, 30 Apr 2026
 06:38:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429120120.514491-1-antonio@openvpn.net> <20260429120120.514491-3-antonio@openvpn.net>
 <5b281966-c278-46d5-ade0-9dc24175de6e@openvpn.net>
In-Reply-To: <5b281966-c278-46d5-ade0-9dc24175de6e@openvpn.net>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 Apr 2026 06:37:58 -0700
X-Gm-Features: AVHnY4I32SgPRTxm6rxNswM90u-O0Oq341vFX9UCKU2fP5-o8EUCB8yo-7yVDCg
Message-ID: <CANn89i+kGAXWEmgSwrUyRhh7kk6r3FjEza9mjDXq4AjwbC5DZA@mail.gmail.com>
Subject: Re: [PATCH net 2/2] ovpn: ensure gro_cells_receive() is invoked with
 BH disabled
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, ralf@mandelbit.com, 
	Sabrina Dubroca <sd@queasysnail.net>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 09C704A38F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282868-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,openvpn.net:email]

On Thu, Apr 30, 2026 at 6:28=E2=80=AFAM Antonio Quartulli <antonio@openvpn.=
net> wrote:
>
> Hi Jakub,
>
> sashiko came back with an interesting review of the per-cpu stats update
> in the surrounding code.
>
> As far as I can tell its explanation makes sense, but I am no per-cpu
> expert.
>
> IIUC it basically says that if gro_cells_receive() is invoked with
> bottom halves disabled, the following dev_dstats_rx_add() should be too
> to avoid deadlocks and corruptions.
>
> See below:
>
> On 29/04/2026 14:01, Antonio Quartulli wrote:
> > diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> > index d92bb87be2b2..c0fdb9504241 100644
> > --- a/drivers/net/ovpn/io.c
> > +++ b/drivers/net/ovpn/io.c
> > @@ -91,7 +91,13 @@ static void ovpn_netdev_write(struct ovpn_peer *peer=
, struct sk_buff *skb)
> >
> >       /* cause packet to be "received" by the interface */
> >       pkt_len =3D skb->len;
> > +     /* we may get here in process context in case of TCP connections,
> > +      * therefore we have to disable BHs to ensure gro_cells_receive()
> > +      * doesn't enter deadlock
> > +      */
> > +     local_bh_disable();
> >       ret =3D gro_cells_receive(&peer->ovpn->gro_cells, skb);
> > +     local_bh_enable();
> >       if (likely(ret =3D=3D NET_RX_SUCCESS)) {
> >               /* update RX stats with the size of decrypted packet */
> >               ovpn_peer_stats_increment_rx(&peer->vpn_stats, pkt_len);
>  >>             dev_dstats_rx_add(peer->ovpn->dev...) << not visible in t=
he diff,
> but it's here
>
> from sashiko:
>
> Can this lead to seqcount deadlocks and stat corruption since
> dev_dstats_rx_add() is executed with preemption and bottom-halves enabled=
?
> dev_dstats_rx_add() operates on per-CPU statistics and protects 64-bit
> updates with a sequence counter (u64_stats_update_begin()). When called
> from process context with BH enabled, on 64-bit systems, this_cpu_ptr()
> is evaluated with preemption enabled. If the task is migrated mid-update,
> it risks cross-CPU stat corruption.
> On 32-bit systems, u64_stats_update_begin() disables preemption but not
> bottom-halves. If a softirq (e.g., a concurrent UDP packet reception)
> interrupts the process context and calls dev_dstats_rx_add() for the same
> interface, it will re-enter the seqcount writer lock on the exact same CP=
U.
> This corrupts the sequence counter, causing readers to see an unlocked
> sequence during active writes, leading to torn reads and corrupted stats.
> Should local_bh_enable() be moved after the statistics updates to ensure
> the entire per-CPU update is atomic with respect to softirqs?
>
>
> Do you have an opinion?

Sashiko suggestion seems good to me.

Proper Fixes: tag would be:

Fixes: ab66abbc769b ("ovpn: implement basic RX path (UDP)")

