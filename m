Return-Path: <netdev+bounces-289505-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFmLFUaLDGo1iwUAu9opvQ
	(envelope-from <netdev+bounces-289505-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:09:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC58158200B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73C1C316EE7E
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCE625CC79;
	Tue, 19 May 2026 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PZLPTfrM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4670724679C
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205002; cv=pass; b=nCyOwtOQ4HktOJoxhG9qgGqY0GFq1niImDRq8QbcGKCTABenwQUY7ZVaRnwIOM1SJ41RzNyMr/uTh/N17id7GAfjE1kLAwI6LyG55W9VoQqnUrKAQONfphUMt2QB2mDY7Dl8Wl4rBU1Zgf4wcRf40ngTkl1DOH/UoCJ4NfMRuDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205002; c=relaxed/simple;
	bh=RoW8xxcrfyxhHsHHJIqD8wSLm9cOVJUPT5gDCA0UmJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orHff6lhQg5hFeobNoDC0YqEFNXuMOmKACn8fKkE4idSJZJLta3SoS/YALZk4Pg/YEJywi3CmD+hvoBzWrElJaQZIGfgrdtt9TmKUviw++ObRQ3O3mmNvJ0pXnSvgFLaqApon9ch/YoeFFpAMaLSrSLg82kT/T10drDbu925d8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PZLPTfrM; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50d864c23bdso6461cf.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 08:36:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779205000; cv=none;
        d=google.com; s=arc-20240605;
        b=g3Ohd519iZdvkOb8H6vboh/Q54eW7XvNra7cJ8HXKvh2DfiBNmgKkmgLzSIW/YzIbd
         isD4CVT+3BxrDBr/4+hKy0xz8xLKD8JWefSsgIKJWScDEfNc96OismOUkdvE5ChuKDMH
         YwjOAsnzBmNMtPCXlDo2vgNszvmIACycnt5ZmczrfdB8LPz7OKUkDUVxoj92k7FUr97z
         viqeTXxczKMfgbTFwUREfy2EiN27g3KtCiKwA+F+l77tt66DEpZU1cNZJCzkcVPQ0N6j
         +MXKA1pnrvm6rGbHWi6nVUMLFgohkLbnbQEA6Sgg05ynMcEdCm2/3F4iwZDeiUbyLwnW
         HBjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kXd7Cus2AptV/QFC/1RRoAa92etv3I4OaJuLWjjIUAQ=;
        fh=wMrsGQCPRLHGDnKqt2BcJ7/0uUnIWGy4Y/9u5udFw/I=;
        b=IZkmbCNVgP1IzM3Nkpetwl6xLLMkfLFkiIEhDSDHgV+hISkOvH85Rb7WCY+25gVaPu
         lDUn3hQ+h+vkE/B/ouoM4RvlnQVU/pRTZAIHNw1gv2552UY83Di0851yX8ZaC2TfXQrY
         bqp9VoUgcTaJeufTx3fKQlQnqh6Gv4jzaASt8qI6wlBKQAtES8N5Px1KHXh1x7kkspQe
         Rc/gx0DhudKGavWfGUGLrwPx0y4SXsYaI0+ZbZRc95wZ1l1ec+7wXwWOMyW0tNI6+UiF
         BoFm/biUNlMXobBIlZCy4nuHBTxr+xvXUOfV6E7+S7yPHEZcoyadXfrYYJttvs75DkH9
         A3xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779205000; x=1779809800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXd7Cus2AptV/QFC/1RRoAa92etv3I4OaJuLWjjIUAQ=;
        b=PZLPTfrM1ri2z3z6fZAScCpCQGMhbaX6m5PNkWD82MeQmM++JYgnmu9qKt/bKUYdYS
         wFjttEz7HVni+/0mK8D35ScXk9xSCcFs5Qw7zHoji0v1DZL5tHbJmS3FOLWb7CvGKFlX
         qi4IarWYhL222QBCoS2q6cudD9msiglNJIk0JgHPgFCsxaLhJCNhL4yyaZrl8snu4ATH
         hLBJO/z3QhspwmFTnho0TU4S7MOPVsFJlOylF65gCHV4rfEJqBcyztCxXQnurqWsDoKg
         MtVgezVBGyXMSAfrz5xu092/6LJey5ECT0M8Ke3zpyVgNsLV0lgVm3i4QNXqxrwQ7qGL
         HKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779205000; x=1779809800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kXd7Cus2AptV/QFC/1RRoAa92etv3I4OaJuLWjjIUAQ=;
        b=mBvvAvlrMyHGeGNKRMZNhWhoV6LG/vX34ROOlbE0Li0YpntvG7nzBD8N5IDeyk8hwp
         S/glEknFgY3QwRDcWejOjEIh3ku0fIpgt/4w63QizQBzFSrjxACHAzke8WaIAmOYIbJW
         7bBRqGoz0u0UrlSsgRMUHi7KJf1RGVEwwShXMOmA9TekwCh3D/JBD0IbVIiy0IyeDTh5
         xxxRjNfKbSLV85KZqKpPRqpXrsORoBPIVE5IDbm7YTXNvndCLz/YMCwDsr0ORi/6MefQ
         Y1BiRFYyvjSsgYc2iN4W9zzo8ijN58/fyBgiAxc6xrQSrVqG612eJxfhJEzUKxH8pGYg
         YnRg==
X-Forwarded-Encrypted: i=1; AFNElJ+SmTkC6yIQ2Ejo0cAFkDM9PoMjdzeJ0HcnEGhyTQVNGchrcr0ZWqcFEoRDuYNjBlmJm6Y0esg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbYJAEcDCi1tbCuuYwc5zNb9ajmUgnp5jG3bm3LakzlX1GwZBZ
	u7OC/ljCfdgsYLaqtOMRzuoniZv3XjZOYZr7i4ubISu4MmbW2J+WX5wRrdmxI6pLxjRswvd2FRG
	G1aiOtiPAzRK1UteubobDI3yApeq4yS1KfSoaVIU3
X-Gm-Gg: Acq92OFsgwxbFKdkmBr2jfJXh1Zyfq3xKby4beha0yj3g/HtFiIw04CteXR5JA/Vo2Y
	+6a5n10QLVu9KPfru4B0ZD/v55ijGYZ5T6hN9yP/yRa+ouAR2DtrNrBxgYf3UgEnseV9ClLCs9m
	mMTt6WNJR8Mlpq/L0FYKzhChshSkTWN3Fn1UdTJPUJbRInSOX6BVqCAV4fzyDuHzHaYjawaPMye
	P0hRFPpOiRqcBRTCUKzgCe7HoB7NLYpMBqo24oZy6GG7Bi1MrDWmAvzXcJ3GtZsF+YYMU3rYsa6
	gSJ5o7P7iKuFIggqUw==
X-Received: by 2002:a05:622a:8414:20b0:516:8fad:8fd3 with SMTP id
 d75a77b69052e-516a76459bbmr5688511cf.11.1779204999660; Tue, 19 May 2026
 08:36:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517184158.2757505-1-sbrivio@redhat.com> <20260517184158.2757505-2-sbrivio@redhat.com>
 <CAAVpQUCiHA=z62udnWLVyv0LeGsAHr+A=_o-8fomHZfJZJO2aQ@mail.gmail.com>
 <20260517215307.13cda56a@elisabeth> <CANn89iKLfBmh3_t4xJz3dDJ8VkMsEtHRifg0mRV1PPAryNY1-g@mail.gmail.com>
 <20260518132831.5b9eb0a8@elisabeth>
In-Reply-To: <20260518132831.5b9eb0a8@elisabeth>
From: Andrei Vagin <avagin@google.com>
Date: Tue, 19 May 2026 08:36:27 -0700
X-Gm-Features: AVHnY4ILS8hWfz3SbwmbnPQHxpGxsdBLLlSMDwr6KPiAlNuv_xnow8izWMPaQeI
Message-ID: <CAEWA0a5AG6JmeybHcxU+EL_Ohi0uVnSaVCiz7Bp_oDVuEdtO=g@mail.gmail.com>
Subject: Re: [PATCH net 1/2] tcp: Don't accept data when socket is in repair mode
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Pavel Emelyanov <xemul@scylladb.com>, Laurent Vivier <lvivier@redhat.com>, Jon Maloy <jmaloy@redhat.com>, 
	Dmitry Safonov <dima@arista.com>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@google.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289505-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: BC58158200B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 4:34=E2=80=AFAM Stefano Brivio <sbrivio@redhat.com>=
 wrote:
>
> On Mon, 18 May 2026 00:57:16 -0700
> Eric Dumazet <edumazet@google.com> wrote:
>
> > On Sun, May 17, 2026 at 12:53=E2=80=AFPM Stefano Brivio <sbrivio@redhat=
.com> wrote:
> > >
> > > On Sun, 17 May 2026 12:05:45 -0700
> > > Kuniyuki Iwashima <kuniyu@google.com> wrote:
> > >
> > > > On Sun, May 17, 2026 at 11:41=E2=80=AFAM Stefano Brivio <sbrivio@re=
dhat.com> wrote:
> > > > >
> > > > > Once a socket enters repair mode (TCP_REPAIR socket option with
> > > > > TCP_REPAIR_ON value), it's possible to dump the receive sequence
> > > > > number (TCP_QUEUE_SEQ) and the contents of the receive queue itse=
lf
> > > > > (using TCP_REPAIR_QUEUE to select it).
> > > > >
> > > > > If we receive data after the application fetched the sequence num=
ber
> > > > > or saved the contents of the queue, though, the application will =
now
> > > > > have outdated information, which defeats the whole functionality,
> > > > > because this leads to gaps in sequence and data once they're rest=
ored
> > > > > by the target instance of the application, resulting in a hanging=
 or
> > > > > otherwise non-functional TCP connection.
> > > > >
> > > > > This type of race condition was discovered in the KubeVirt integr=
ation
> > > > > of passt(1), using a remote iperf3 client connected to an iperf3
> > > > > server running in the guest which is being migrated. The setup al=
lows
> > > > > traffic to reach the origin node hosting the guest during the
> > > > > migration.
> > > > >
> > > > > If passt dumps sequence number and contents of the queue *before*
> > > > > further data is received and acknowledged to the peer by the kern=
el,
> > > > > once the TCP data connection is migrated to the target node, the
> > > > > remote client becomes unable to continue sending, because a porti=
on
> > > > > of the data it sent *and received an acknowledgement for* is now =
lost.
> > > > >
> > > > > Schematically:
> > > > >
> > > > > 1. client --seq 1:100--> origin host --> passt --> guest --> serv=
er
> > > > >
> > > > > 2. client <--ACK: 100-- origin host
> > > > >
> > > > > 3. migration starts,
> > > >
> > > > Here, a netfilter rule or bpf prog must be installed to
> > > > drop packets temporarily until migration completes.
> > >
> > > Thanks for the review.
> > >
> > > I have to say it's rather unexpected to have to work around obvious
> > > kernel issues in userspace: TCP_REPAIR implies that queues are frozen=
,
> > > and this is handled correctly on the sending side (see
> > > tcp_write_xmit()), but was clearly forgotten on the receiving side.
> >
> > Have you contacted TCP repair authors for best practices?
>
> I Cc'ed them here, Pavel is the author (but as far as I understand not
> active in kernel development anymore), and I know that Andrei did some
> substantial work on it in the past, so he's Cc'ed here as well.
>
> But we are following what CRIU (the userspace reference implementation)
> does, and CRIU would be affected by this issue as well (depending on
> usage).

Before extracting the socket state, CRIU uses netfilter (iptables or
nftables) to block all traffic associated with the specific TCP
connection or, in the case of a container, the entire network namespace.

This approach provides two main benefits:

During the dump, we don't need to leave all sockets in repair mode for
the entire duration of the dump.  We enable and disable repair mode just
to grab the state. It's simplify a roll back if something goes wrong.

During restoration, it ensures that the destination kernel will not
process any packets until the socket is fully reconstructed. This
prevents the kernel from sending a Reset (RST) or getting out of sync
before the connection is ready to be resumed.

I haven't looked at the patch yet, but I have no objections to the idea
itself.

Thanks,
Andrei

