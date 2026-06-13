Return-Path: <netdev+bounces-298900-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CAI5EOHRLGrhWgQAu9opvQ
	(envelope-from <netdev+bounces-298900-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 05:43:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAC267DA1B
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 05:43:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=h2EKWwZt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298900-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298900-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03E5730CCF6B
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B140390990;
	Sat, 13 Jun 2026 03:43:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6D4315D21
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 03:43:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781322205; cv=pass; b=cR6W1oi32xkO0tA7gXnzynRBUGHBA6q1Pz+ZlAvMjV5u0guUG5NIvzaOo/1rIS3oVcL7Sp6hUbKZ7ahJM1nnvAYA437iGaKX81euIDlE3/s10ePdFa2fUkNyNLP+FEJgz/p1fxoUdzf0jvX2xWo5Prks8tWNiYIJ/Ega5Qw8Bp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781322205; c=relaxed/simple;
	bh=6g1VC+dw6fAg19W4wJnrVzOTNCJQ03941hAWJbJIOys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePhTnUTldrFOpJ6EBG9zOSMFlLpY+m4THA7mjBPUe74SfASquC433X97NrtWXimn1QYEp3zCG1RduSPekY3gxXNZStGON3++YHV7ux1NX9pciFvY1WnpaJzyXRpzuOsQnpYzr1OVoGzLGdnKebWCYLoemUb6lByR+Ku0pjToJIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h2EKWwZt; arc=pass smtp.client-ip=209.85.218.42
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bdb3fd39045so246530766b.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 20:43:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781322202; cv=none;
        d=google.com; s=arc-20240605;
        b=QuJtVo3GOJREDLAiZnXDLGTpzR1IV5bISak3MQUyngBMOCHxjsHpqBwW5B/uMcB7b7
         irOLiZpX55g9sQfCLqxKTRjovE0ac9DaDoG35KBjLozwqpIL0B1IkYhkvc10zuCv4XD1
         4QBEYa/3d6lSQZOqrn/cJXms1zYult8528hf3+jtlhtEx2lN3hUSp3I4jVw39Dkedyiy
         BnxT7MF/peleB2eQEEkNYecGI0oNoQRRNniuH2Us2Cg2NID0LVZgLhK0P7HHQPH3xopf
         hmR4PwGoPNEWsalKhxz7d80YegFs9EzNNmCcjiO2WHZR5hehv8fjSl7M5MnvHZL0Kb6k
         qtog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UEwj+IHBbN3WTeFz3qyjlWd8XyyoB7WQ6QnNQf7pvac=;
        fh=rj/U5vhcoRfdQdMoKU4dDgh7qi5f5kNapG3MjTlIOg4=;
        b=fWJFm9Vxm8qJj/C276GvpTwGUHwjJWuE6vX63S2yYtnbCsMkdhbwKniZOhjY54yTFK
         EQpBSJwaSr5OxGBlx5BrA0WkhwZRc6HVJ4qLtbACpxnqLJFygrR545Wys442NkEek4zP
         z5sSUvA0Bzgz+owb28cWl/X5/S43hhWP+IJxdRnhveCyAl7OloLK5glsu32n7Va/5gEG
         5fqp+AtH2V+KplZW2Tjoe+3z8L1GkWhuzYT8n2aWzgS8SiGR34fwJtHBsg3PuwTeCKBj
         lbG3iBUNaxq3SBnHSrHwxdXOi7K660je893YgfYnGeuMGj6Th/w+ii9fmnre1WwA6gDa
         tT7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781322202; x=1781927002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEwj+IHBbN3WTeFz3qyjlWd8XyyoB7WQ6QnNQf7pvac=;
        b=h2EKWwZtioOtxU+BIz/baaueY/flSUeVcaBL8r4iVHIoSNOqc3pw9gFXNDE+iE2NyW
         i3+mHtE/FQU/UbJrkvKU99SirVqb7Ac0OcHnKeUWx1MyX348avrNP27xNS8JLwjvxC+R
         dYVWeJX4KHbVUY/V2oM4diw0a0pGXltYnkeBtwBHivneSiJQ6uHC+g+o6wRYD7z6bb4Q
         XNtL1DvoZ9W9mC6H/qLyaHi9CtYdUb3wCMR9TPLHObir/2kEb9YDPd3i6VsrIWyoqh9I
         IGg1uSIs8JxeUGSxWn0TsRl7d2V7vBf36EOOrlUyarQ/yb43cPVt97cOtVa6QGSx7ekU
         MXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781322202; x=1781927002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UEwj+IHBbN3WTeFz3qyjlWd8XyyoB7WQ6QnNQf7pvac=;
        b=G4aFBKdFx4Je10VdbLy87PDSeogUMBK/NpfkMv/NbLRlUzqLIur8U/H71ePjOeWu4h
         /OktQ6BM9PYU/8XJSXOTyAtp4TVGMoVltTH/kDXTY/KqC8PTP3Jx+/Ec8D1RWxiK+0mr
         4ONeKjUfXgv46/DjHoNs39r0DXDbIJo+wfPbBkCr+8cBEneDnBDsbXSp7yX1cxRnciry
         6OuSxtVtUZA6DGtrdRiV292Tuhm7PzDkJU/EspcJoLmxzJwOyUK3sm/zZHUm3Antew8f
         A9g1M8EeV2ttM5xFXM89zTjsQAM4l+SuguIU6W4aNNg5Lnb9xMPqjKuBL5IITzb2YObm
         hG6A==
X-Forwarded-Encrypted: i=1; AFNElJ9CWy/+MpLo3Fk5NodAyMTM3ZyIH7xlZW+qxaldj6ZtRBLe7VCIwKJZ11S2SqkExdN4/OYOAx8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2dRhfwmRUpgYJyzn7riLJXjKmh722mUREV2n//lcrTv3+Fw2g
	cWkk1njYA7I7PRcBQIxdnQcIg3GCNCyG6p8bmtND0eNKFmJ4bQica64RMzBLi26sShkRjZd5JwJ
	jOi12QglXnfVLdlsHUIkBPPzopHhr51rqD+Hq+dnx
X-Gm-Gg: Acq92OHQxoAgMvpePUKUo8e0fUYO5vcbKMEBTzSdcEPoFabiWKEXL0SYTaptCySENZs
	nRsYETw5TUtRXombHh5OwL7DrD7+AlGC4voGivjt2XloBTuTMqXfTSMiKD1iE9hKtUsj6Rg0MoA
	odevu6vwqbODAtDOWxNpgI1GwBxm9Ew5I3SKRbYalYUm8FvFmQH04y+4pSzOlpUNQ+azidOKe1w
	J5QoC/l1S8wy7p8p7FIqw33bJHkybqZp8rwJXifNoQX6bBpvg/cTPkaP+vLzDvExcwoOTURJ550
	5XyX3Ux3F9jKzdtcKJXKsm5Fe/mSzoY77JdHHHMuKlOMNN4YvYXm8Yn0gksnlncwVDfziFnvPbT
	46xXaM0cIvKxk31iOr2ExBhsPuCSquZjlQQE0+Vr60L4nnoOGp35mDlNtNcL7WxE=
X-Received: by 2002:a17:907:8b92:b0:baf:e47:1b6a with SMTP id
 a640c23a62f3a-bfe2a217e07mr217607466b.24.1781322201586; Fri, 12 Jun 2026
 20:43:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613010039.1362312-1-kuniyu@google.com> <20260613010039.1362312-2-kuniyu@google.com>
 <aiy_eV7RP2nPlxmJ@devvm7509.cco0.facebook.com>
In-Reply-To: <aiy_eV7RP2nPlxmJ@devvm7509.cco0.facebook.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 12 Jun 2026 20:43:07 -0700
X-Gm-Features: AVVi8CdubgUn6NuoVme7O0oFJFs08u5cj-F7wrSgd6J27XwpuOhByoTjw26cSpY
Message-ID: <CAAVpQUAP+d6yCmPSdYyQ9UYB1ZcNkQCCHLDqNp+0Rh3bGXdRTg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next/net 1/5] ethtool: Introduce
 ETHTOOL_MSG_TSINFO_SET for virtual interfaces.
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-298900-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sdf.kernel@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:sdf@fomichev.me,m:andrii@kernel.org,m:john.fastabend@gmail.com,m:memxor@gmail.com,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemb@google.com,m:kuni1840@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:sdfkernel@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,fomichev.me,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FAC267DA1B

On Fri, Jun 12, 2026 at 7:30=E2=80=AFPM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> On 06/13, Kuniyuki Iwashima wrote:
> > Before enabling SO_TIMESTAMPING, applications typically try to
> > enable hardware timestamping on network interfaces via SIOCSHWTSTAMP
> > (or ETHTOOL_MSG_TSCONFIG_SET).
> >
> > The timestamping capability on an interface can be checked via
> > ETHTOOL_MSG_TSINFO_GET:
> >
> >   # ethtool -T eth0
> >   Time stamping parameters for eth0:
> >   Capabilities:
> >       hardware-transmit
> >       software-transmit
> >       hardware-receive
> >       software-receive
> >       software-system-clock
> >       hardware-raw-clock
> >   PTP Hardware Clock: none
> >   Hardware Transmit Timestamp Modes:
> >       off
> >       on
> >   Hardware Receive Filter Modes:
> >       none
> >       all
> >
> > These operations rely on the driver implementing two callbacks,
> > dev->netdev_ops->ndo_hwtstamp_{get,set}().
> >
> > However, among all virtual network interfaces, only bond and
> > macvlan currently implement them.
> >
> > As a result, most virtual interfaces cannot advertise the
> > capabilities of their underlying devices:
> >
> >   # ip link add ipvl0 link eth0 type ipvlan mode l2 bridge
> >   # ethtool -T ipvl0
> >   Time stamping parameters for ipvl0:
> >   Capabilities:
> >       software-receive
> >       software-system-clock
> >   PTP Hardware Clock: none
> >   Hardware Transmit Timestamp Modes: none
> >   Hardware Receive Filter Modes: none
> >
> > While these callbacks could be implemented in each virtual
> > interface, this approach is limited to those directly linked
> > to a physical device.
> >
> > Not all virtual interfaces are tied to real hardware; for
> > instance, packets from UDP tunnel devices eventually pass
> > through physical devices and can be hardware-timestamped there.
> >
> > Let's allow configuring the hardware timestamping capability on
> > virtual interfaces via ETHTOOL_MSG_TSINFO_SET.
>
> I don't have a lot of state on this, but when adding xdp hw timestamping
> I remember fighting a lot with those apis. Now we are adding another
> one, but (seemingly?) for sw devices. Can you explain a bit more about
> why can't existing SIOCGHWTSTAMP (or ETHTOOL_MSG_TSCONFIG_SET) fallback
> to your new dev->tsinfo.enabled codepaths for the devices that
> don't implement the ops?

Simply because we mainly need this for ipvlan and geneve
so limited the condition to cover such sw devices only.

If needed, we can loosen the limitation and support sw devices
 w/ ops (bonding/macvlan) and even hw devices too.

