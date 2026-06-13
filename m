Return-Path: <netdev+bounces-298901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f88YKPnSLGozWwQAu9opvQ
	(envelope-from <netdev+bounces-298901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 05:48:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E438267DA27
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 05:48:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=i72ooAqO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298901-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298901-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D561317F7A4
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A83308F3E;
	Sat, 13 Jun 2026 03:48:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405CD24BBEB
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 03:48:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781322486; cv=pass; b=RrbFvdXRMt02Sv2dz8cT0LPZSw6nVtoCeHqQ9WSgY2esXIaIAv3eFy57gDlY4xgGRyJ9pqlApLTM4mZ0C3THC7lfB3yP3uSy1Cbi0ISCs7fwOBvwLdAamfS/7BOHyzJuVKe1gRXut+G9z9Oz1MhlrPiLsdU7U1NXWPX5bveP3Ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781322486; c=relaxed/simple;
	bh=PTT0e55buj0YG9/1MMQA4jaq3wK3NZVUQ2isvJJCnb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hV+2d9+KJhA9zKprMcuqzu5r/0gZU/1cgNpAyT8HzngoBB2wuOGizyiyGctutFAsZ2lj35qBEEjK0m9KuHwBU1IgKsLd8d2gMsu2UYfZ8F+0PjAmWXHSh4pLBwqzG+yjBpa8dY2TxYdAt5JMmbNsbH0feT+IIPZHDoYjTi8K7nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i72ooAqO; arc=pass smtp.client-ip=209.85.160.178
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-517dc520840so16437581cf.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 20:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781322484; cv=none;
        d=google.com; s=arc-20240605;
        b=HeT2lOxLFI1+gFS+akDKzDUeLgMVJzXpxrp8LvRYei0umB2r5Rc1hmDr+GwEmwCmrd
         HNy5C8M4XBjGPS43huO7EarR/ITIT3Fn0gUy3pzVuxkASTCbO9ktGyuayfbt6B8jl+G8
         uNCmnh8j5XxSQ5n9lp7nIcSAi59OLEhu7X+ui86XZsMJK33OIlXZUoRYD4ggVjgiqmKD
         1pDjIrD+eLLK9JkSiOxVtU8iwDsASXSgmu92Qm54mjTUEHzJ5LiKihsMnkjgBXR9XKUS
         qD200SLg0oS3A+4VkNJ372vfJSQWGX+SihuFSp3eFTrpQ6oJHE24ohPlbGqU7AELuNgT
         DInQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TWnRv1o61FJfa++GKj6vlPEqaubP+zQje2H6T1P+XHg=;
        fh=g1zmKwuldEwcfKEOtTCO9VZTCvznyTO3GSBul31OB0c=;
        b=CiR5AV2fQGzqy8rC3xHSaWzjqcsdcOkpLOSgpQqTSlYNdwy5m8u7Vehp2M0Va7V7mI
         u+TBUHDno819ADl2XCzvngYT3XTqOQLf4fKSNjQLaoqtr7P+rsRk2lFQlvQjf36pmAF/
         9DHBwe4nWw/nIp1HrbDXMiAOsr4C1QTMZS+751EUbbhjrsVZpqDLv6dSsUQ7S0t/AWx2
         yZ2beqIsd+8++TfqWO36pw5kpSaI9r20OCr9kSCXfy7J8hTndaIc2jyy0fwc2qSqp+82
         U8uSi9xlZ7e3trzntxOd3cV3Tf4iDvvTEoUNsDNd9QcaMvmFQq1n7rUOkMka2CqdH27Q
         CHRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781322484; x=1781927284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWnRv1o61FJfa++GKj6vlPEqaubP+zQje2H6T1P+XHg=;
        b=i72ooAqOd0VmV0WuVAKG2PPOEBzc62SSHti5Iyf7QjXxuQ3ELkgKsyow80eTUN4b73
         hsqx/OSl92kuxc4JTjiQZtxy03KEuoNImtmRmLpHVpCJaks2Ma/Xhq1O48ydEUC71Mov
         I7W/MS7kw10fTOatIUuG03QaOoD9wvFOj83pPb6YJQr6jZcH5Y3JEqobDiUgm6a2ZXIV
         +uN/Mo8gEMxKMHGwNeRT/Atacff62PuFsz59hwVLMITCnG0QobHqdxNxtwwabqZbKGII
         XFFU91h0Xn0JV5lt8+nXbvyw6dSz0SEEU6S3S68jxsJFYVHk2nA394i2dTn/W12tQ0cI
         kwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781322484; x=1781927284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TWnRv1o61FJfa++GKj6vlPEqaubP+zQje2H6T1P+XHg=;
        b=IfkiZUIWOoE7C0a/7J7lwpa+zKuAD4XV1wnAddYtiXWK0oY6EYwUltO7Pm/h8MxWEa
         GHDn2sn8EEnS9WX/UDARHiwf0Jp2GOvnBX3jLP9jdpVaAB5yIXWDuU2fYgH68KIH2rMz
         vVc750R7zUuTvmBRbHwpIvMaCh9nITWn5/9X7Sq0++5QZsMmtN/8bHx3bdksHxInXEsL
         CzSW6Vmuq6zyQnbdPKfEkVB6jKsp/6uwnWADDgsn5tT1vWIeoHgP6k0a0lro6qFAxg2v
         wvJz2jt73Q01sjq8X/RmTug2j7/HZK/pojg+31paXvfUKAXjWMzCzHE9wlyJTngU94tc
         23vg==
X-Forwarded-Encrypted: i=1; AFNElJ/E5PLLUXORToTkoB9aR/qMSMC/Nk5sGqdOYySWgMba7IvSqnlN0jmib2cnKr1QQNlOmqhvHa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrfVswCBS31AgIPJGDO9qnCucHUEj/meOjmPHbXuDezgGVAclo
	8YpGcoTYEPN2H9UN7eSatZ/qr3Al9f2XNs6QbxkBULvOfAFo+sP6rMASQ9nHO+rsfkmKMLRDfHR
	DGOSEnzxxVYyUK1Y/yaKOWsBYGteykDXmgmwE/g1c
X-Gm-Gg: Acq92OHjA7tTdUmJnhIeZM2qxyBsetgIGc0NXp27MoI+8brl049EjbyjQmvBuHwTZMK
	MXyJzLZ6gsBQJA7rNOMQwZG1N4OsouBXCyN2uOzrfTPo7pDCi1sdH6OqvbX39wdcMdt3y531deP
	G6LyCqj2eAC1NAiGiNg4e9goRm4Sk+nzR2dc2zS6gd9CoOHuHg4putA3MMpPYPY7N8dVosIO8yI
	Guwz9BGCACli2KWJH3XSjuZWjGRDplu0Ub8WMBvh9vu8TLWAKFr9aTgnQ12P0h13EX3UUM8aWZ5
	CPkaiqgvRzUjRrDEHd1U65RM4Pd8NtK+xRc+IujMXwGko4raNzdAMSqMaGN/FJe+TYWyskosAyf
	7EiFF5IOfHqKmcQp28OE=
X-Received: by 2002:a05:622a:8c7:b0:516:d943:175c with SMTP id
 d75a77b69052e-51953718a35mr38279101cf.56.1781322483597; Fri, 12 Jun 2026
 20:48:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610-tcp_fin_more_restrictive-v1-1-eefc30d7ddd8@gmail.com>
 <20260612154355.37bb426d@kernel.org> <aiyY24QTFcqQVW25@gandalf.schnuecks.de>
In-Reply-To: <aiyY24QTFcqQVW25@gandalf.schnuecks.de>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 12 Jun 2026 20:47:51 -0700
X-Gm-Features: AVVi8Ce6rvKkrMfk0xWMvM-M4ZP8z44lu3cO9P_x35gogfIaOzJbfKwZXPJcc3k
Message-ID: <CANn89i+q3Q_k3PHvwOJfOgor4xD1YzSVYO-G+fY4+_ddkKLTQw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: tighten the FIN exception in tcp_sequence()
To: Simon Baatz <gmbnomis@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298901-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gmbnomis@gmail.com,m:kuba@kernel.org,m:devnull+gmbnomis.gmail.com@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devnull@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev,gmbnomis.gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E438267DA27

On Fri, Jun 12, 2026 at 4:40=E2=80=AFPM Simon Baatz <gmbnomis@gmail.com> wr=
ote:
>
> Hi Jakub,
>
> On Fri, Jun 12, 2026 at 03:43:55PM -0700, Jakub Kicinski wrote:
> > On Wed, 10 Jun 2026 00:09:24 +0200 Simon Baatz via B4 Relay wrote:
> > > From: Simon Baatz <gmbnomis@gmail.com>
> > >
> > > Commit 1e3bb184e941 ("tcp: re-enable acceptance of FIN packets when
> > > RWIN is 0") added a special case in tcp_sequence() to mirror the FIN
> > > exception in tcp_data_queue(), which accepts bare in-order FINs even
> > > when the advertised window is zero. That behavior is not
> > > RFC-compliant, but was introduced in commit 2bd99aef1b19 ("tcp: accep=
t
> > > bare FIN packets under memory pressure") to break tight FIN/ACK loops
> > > caused by broken clients.
> > >
> > > However, the condition added by commit 1e3bb184e941 ("tcp: re-enable
> > > acceptance of FIN packets when RWIN is 0") is broader than required
> > > and allows other non-compliant packets as well.
> > >
> > > Tighten the tcp_sequence() FIN exception to only allow packets where
> > > the packet is a bare in-order FIN and only the FIN flag extends beyon=
d
> > > tcp_max_receive_window(). In particular, this exception is only
> > > reachable if tcp_max_receive_window() is zero. Otherwise the packet i=
s
> > > already accepted by the normal sequence check.
> > >
> > > The existing packetdrill test tcp_rcv_zero_wnd_fin.pkt exercises this
> > > behavior already and does not need to be changed.
> > >
> > > Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> >
> > This is odd. You are sending this patch which shares a lot of
> > similarities with Eric's patch:
> > https://lore.kernel.org/all/20260608151452.706822-1-edumazet@google.com=
/
> >
> > Why are you submitting your own patch instead of discussing it further
> > with Eric and letting him send v2?
>
> That's what I understood from Eric's reply to my comments.  He asked
> for an alternative, so I sent this as a concrete sugggestion.

Yes this is fine, please next time includ a link to the 'other patch'
since this discussion
was started by someone :)

About your patch, I thought that it would be fine to allow a remote
peer to add a FIN
to a payload packet of N bytes even if RWIN =3D=3D N

It seems the bug of your other stack is that the FIN can be sent with
no payload,
and this is a less broader case.

FIN storage (a bit) is there, we can generalize the acceptance of FIN for f=
ree ?

