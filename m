Return-Path: <netdev+bounces-305247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BI67MWtBTGqViQEAu9opvQ
	(envelope-from <netdev+bounces-305247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 01:59:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BF9716648
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 01:59:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=VMZdM+n1;
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305247-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305247-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3DC13027961
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 23:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FAC3EDE6E;
	Mon,  6 Jul 2026 23:59:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A166D34A3A5
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 23:59:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783382377; cv=pass; b=g7cYxh2IQ5qUuFXvPlsYzuzt+fzm+Er2oul1uinsa+wsT0+2MgRRglxaDZ303wqqOzb2DrFRfoEq3JCwyD95hav1hstQYCK7WifJFzYuuPEQJSM3rFWwUtPa+F2FMLR3JPVhiAt7BL7rN1R3O7y5jmC1JgZYarknwTUjqBCRznQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783382377; c=relaxed/simple;
	bh=oPhkeLKPQDLv/GGb3+U/t+kDfUwmkAfWwWU37v1UMG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Szo8XjOI/pIf8pWOCWLxE3L4Cex1Yq+Gns9jqlCnqc3SfHEZE6CWtV4owP6JeGvrLd5NOTtBt7BD5HVSjNxY3/PqWFkZCd8t8157HivLFyYx+AUQdjQU9t/GCxT1t5Dqvgy1wXbw8S2Kv8i4PBeXXrmD3yQ9DVCJbA/xjRrZYPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=VMZdM+n1; arc=pass smtp.client-ip=209.85.210.179
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8471013fac2so3925632b3a.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 16:59:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783382375; cv=none;
        d=google.com; s=arc-20260327;
        b=oMBUXA4viTBbmuMC+GoLZO9coz4rj5xywaNmv/PD+vrauRA89StAHddxNCDDyHChGJ
         IFUahd4f0zmbBZ+j982BahejjnVRrNzs5vZEkuszb85vD/Tf0WSBC0iG7F0CrNta40ef
         bjcx14s7W76wTZTXOrzFRARXQp3QvmPb5cB8Yc8Cx/T58G07Y7Ima60BEKPzaz+w2vmP
         C1NM5xtHqc9UJZdsuCwM1SSvMHiIop3UXECceLpcnUraxYzOMGTIRy02to505XwevOhi
         FWEgAE4lzE36lYd3BJK1HuN61yZDGOezZSnilmCkB3yqy6AoomCMPAm6cY7x/iqDxTxk
         SJLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NGnjV3nyHEtkwVotSk8EvCO/k6Ver5KbWx3DnxrgKbY=;
        fh=6NyaKGwm1b0DTn9v/LFeWQo2uT5CvQ0hWeKUVfew86k=;
        b=C6Db4Gi+yqo4Jjyi6UG+ifKWOcAWWiNiECNOoYtXsgdpHE2njCeTHAoupDoNLFg6Jv
         llt6HxaNUTqKmmSgYUaJo+OYkw5jLCeEII2Q5JFzwVYiTdWUcHB1psD+H+N0ZqZkQ+x+
         W9pACxFjxqqHk4/i+V0Yt6T64FiAmf27h3Ywh1PFa16TauKtu/ed3VsfOqTcsv46gajR
         5lc8TCmlxOJ8hNTZ51O6nHNX3kcOScJGcLrtYpuUSRkYc4i3bVhKqcHAmGneIhg9io/y
         ICiveN0ZiociF0wZ7kZaMTiTw6/qNRB6iYVC46NCIaWSiMu+xpNqa/99gOQs9+CPajzU
         +HrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783382375; x=1783987175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGnjV3nyHEtkwVotSk8EvCO/k6Ver5KbWx3DnxrgKbY=;
        b=VMZdM+n1c9vVmUYyWShBj+GI7g0TN3mSAaG8af6wP39qDcjwSIPMSefZfuS+vLUZwC
         Y/+tIyaJ+RlFujud9lOA2NO234myLhFeXomObrXZTITIZx/rrxDgV7JeHMcMGskRBYaO
         2+TW2EbQgM/pwpaesFikjOX1PWoVOoGjuL8iuGdt+5RjbQ7aQDFB4dx65Av0FvRf7WEt
         p8Z4GpDc4e28e9T+3t0rHHGDhyL04+zNwErRRvvwGxBP8QnTclT9IbbN8KwFRb87MKna
         Q4EQHyllFCgu9LmgU7FJ8P8wiDfC77bSOwK7ozZtSVrNucE04KyCIhXzM9C8jowxYbGk
         xYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783382375; x=1783987175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NGnjV3nyHEtkwVotSk8EvCO/k6Ver5KbWx3DnxrgKbY=;
        b=KC9feGR7COPyCUVM2Ufc1VLI3UBLM4X5rtmWgL2qvDXKQPz9Fj/ilrfDwT1+AO/3dF
         4sn2/jyk+p5tT37HffNbelYdAWruHNAaWggvStzD2ySOvisajloXv2/h4WqKeMz3lGRq
         Vhg8HnnGEPvzdIhI3xM9C8225Rbj4wtKguWsP9llz15ksW9FlxmO8uXkpDjwLtfGDieZ
         PRlmpaYdJ4wk+s6Qg6adhWZ23Qu0sD2VKO3FLUaoqLR7wbPuMuBw52irs2ETRpC95cFv
         rGh2nJSuyz1XWtqGk+b5aGI+6j5VBKd7V1t2BSFdttfU/mQoCWuI1k8T4I4zIQlNg0CZ
         73wg==
X-Forwarded-Encrypted: i=1; AHgh+RpuOHvP9yps/hCX6lbBgwIZw3DX4ZsQr0hq/qfuQ84boeXOWPDET8Y+NFU2Mw3r73Sv0RE/eGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx05tYG2sucwAG0QMciozx1GppgGCGwezYVEynVKNcvK8z5Dvc
	ed1rs6zKdThKPnsX+eVwM82dyPVSTRD6xDoEe5FQYNcZNg4bcztoSNUDQLGVg//vFBKLkuDyf3r
	iWqzxIUTwUF/Cq4N4HgBaFbkrxflFK9+mvqSdu8n1
X-Gm-Gg: AfdE7clcpT79/HE44Q86jKsmH0fotdvm57VjD85kveL1OAk+k2nHVMdVRZaUvmPhou6
	R1fodAezACyOQxv/QVMIU0+189Xf989IeIyFolnCfbkjzziyizwgDrbpbagRjgtSkwUTUgH4YaQ
	Y9XzS2F67vBXG7DiTAQ101TSBqJSvFiX37jij+wx7qEfKvRc8O04xMKjUaBeUjgdyoOFwJNZs+6
	lO1SriOJlOpmrvx/WLr6ci3JP9R8t++ux0sKz+8reDPJWKryb5Vd+qdehuU6JbtwvQy1APmkbo4
	V9DfQROvE4yMHy8e31NuAoKkGhReCg==
X-Received: by 2002:a05:6a00:3a07:b0:847:8a1d:cf73 with SMTP id
 d2e1a72fcca58-84826d694f2mr2627513b3a.43.1783382375014; Mon, 06 Jul 2026
 16:59:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706233344.3334648-1-xmei5@asu.edu> <20260706235614.1726605-1-kuniyu@google.com>
In-Reply-To: <20260706235614.1726605-1-kuniyu@google.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 6 Jul 2026 16:59:23 -0700
X-Gm-Features: AVVi8CeBHj8uQXoFwVxAYV2b9PwIaAA9wAOd4bayVdnai42PxihieCsKdLPZ-l8
Message-ID: <CAPpSM+Swu_7SdhVV-sDNAOsx21OSp1V9UFMcwvMEkVtVN7cPaA@mail.gmail.com>
Subject: Re: [PATCH net] vxlan: add missing NULL check for vxlan_sock in GRO path
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: AutonomousCodeSecurity@microsoft.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, kys@microsoft.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	tgopinath@linux.microsoft.com, tom@herbertland.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-305247-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:AutonomousCodeSecurity@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:kys@microsoft.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:tgopinath@linux.microsoft.com,m:tom@herbertland.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:from_mime,asu.edu:email,asu.edu:dkim,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27BF9716648

On Mon, Jul 6, 2026 at 4:56=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
> Date: Mon,  6 Jul 2026 23:33:44 +0000
> > vxlan_gro_prepare_receive() reads vs->flags from the vxlan_sock returne=
d
> > by rcu_dereference_sk_user_data(sk) without a NULL check, unlike the re=
st
> > of the driver (e.g. vxlan_rcv() does "if (!vs) goto drop;").
> >
> > udp_tunnel_sock_release() clears sk_user_data to NULL and waits an RCU
> > grace period before the socket leaves the hash, so any callback running=
 on
> > the tunnel socket during teardown must tolerate a NULL sk_user_data. If=
 a
> > VXLAN device is torn down while GRO runs on its UDP tunnel socket,
> > sk_user_data can be NULL when a packet carrying VXLAN_HF_RCO arrives,
> > faulting in NAPI/softirq context.
> >
> > The GRO path was the only sk_user_data reader on the socket missing thi=
s
> > guard (vxlan_rcv and vxlan_err_lookup already have it; the gro_complete
> > callbacks do not touch sk_user_data). Add the same NULL check so GRO
> > flushes instead of dereferencing a NULL socket pointer.
> >
> >   Oops: general protection fault ... SMP KASAN NOPTI
> >   KASAN: probably user-memory-access in range [0x2018-0x201f]
> >   RIP: 0010:vxlan_gro_prepare_receive (drivers/net/vxlan/vxlan_core.c:6=
78)
> >    vxlan_gro_receive (drivers/net/vxlan/vxlan_core.c:713)
> >    udp_gro_receive (net/ipv4/udp_offload.c:841)
> >    ...
> >    dev_gro_receive (net/core/gro.c:522)
> >    gro_receive_skb (net/core/gro.c:640)
> >    tun_napi_poll (drivers/net/tun.c:259)
> >    ...
> >   Kernel panic - not syncing: Fatal exception in interrupt
> >
> > Fixes: 5602c48cf875 ("vxlan: change vxlan to use UDP socket GRO")
> > Reported-by: AutonomousCodeSecurity@microsoft.com
> > Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> > ---
> >  drivers/net/vxlan/vxlan_core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_c=
ore.c
> > index b5b1253ac08b..f2235bae9bfe 100644
> > --- a/drivers/net/vxlan/vxlan_core.c
> > +++ b/drivers/net/vxlan/vxlan_core.c
> > @@ -663,6 +663,9 @@ static struct vxlanhdr *vxlan_gro_prepare_receive(s=
truct sock *sk,
> >       struct vxlan_sock *vs =3D rcu_dereference_sk_user_data(sk);
> >       __be32 flags;
> >
> > +     if (!vs)
> > +             return NULL;
>
> Please work on the latest tree, it's fixed 2 months ago.
>
Thanks for the reminder. I apologize for my mistake.

Xiang

> commit 30a45c0bffdd62350261e2f2689fdba426a33578
> Author: Kuniyuki Iwashima <kuniyu@google.com>
> Date:   Sat May 2 03:12:59 2026
>
>     vxlan: Fix potential null-ptr-deref in vxlan_gro_prepare_receive().

