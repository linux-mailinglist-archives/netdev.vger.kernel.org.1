Return-Path: <netdev+bounces-267669-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Qyf/HBTjtGnMtwAAu9opvQ
	(envelope-from <netdev+bounces-267669-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 05:24:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7C328B8EE
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 05:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A33D53020E80
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 04:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842EC2F1FC3;
	Sat, 14 Mar 2026 04:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EJK+x1pS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2965C239E9A
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 04:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773462287; cv=pass; b=gjgBkKH3emrL5ZoFVsrle5uxf8HoOi7kB8N46VSKbnWdPLLB+ZR34yOZhU+H7nXi3bTenUhPo0mMEDBQa9Du5yjQdgY4Koyaxu1fbxwN00GKIyXqk0Am6dY3dqdMTieChNX4GcO7aaANxCH7llC6/duZ7xzmp6leigVeKxaMLQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773462287; c=relaxed/simple;
	bh=jxmUOhNMf/fACuXoe9uJztGOxbZI8Y6WZs5AXLunSgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjFV/hzPWGmxKBGOAiJvFfL6wf1pJaukx8xVBg2GrUqBGQ1YfFM6/nXcE8kwXvEXaQys244vMONmaWGDMDEpHXNAl/sIGAt96vzhWFq9Vg8NQJlevfnUH0FwA2pqSTgbPMCahEpwwn/W+mcuXZXMG3muCxKAICwMTgsWcclIvgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EJK+x1pS; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-506aa685d62so14500281cf.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 21:24:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773462285; cv=none;
        d=google.com; s=arc-20240605;
        b=WLucSagKj61qa9dDtBNwrHgTPVbkgU/a3qgqFR9n4ZZCi9aY5e3R0BVAidFfjaVyv4
         gFeM/Jr6ypoUKXy7T4iVzIpZ4gavoR3h10KmPTPUmyBjVSMOq+eC7ZRGMyTt3QYr2Z3o
         F0PLKwGvBfAhA2I9m1O2/ysuycCgWMuU3CHV+fWqhcIyZbbEM7KP73lQ/bJEpo1MPqRk
         JAUSgR90G1Mvky/dyFrV9IOMBTri7kCMlfCNnv6ArZ9IW+OccAbgZ1Gctmg+QX/R/VM9
         vM1sM5V6IwqptfurovRvv5M1Sm1zyXGA+q+4NraAAD8ZWM/VftPJ0l9tjD2J8HX9qp9Y
         6lVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GD9EwzMdUI0ZeJI+HPmyVrA3AGetD8YB/VV25P7e1t8=;
        fh=IF/ZSln+6ttT7xQC6EsG50hlJatRdmNNOcG3vs6PJE4=;
        b=TlfKg3zBzu4Qrtc7YDOKiqi3AhKB41EcxnF9BX37QYRjlUGq1H405KN14s6xM6CViI
         c/4t9fjYowDTeW4/b1/ClmlO2yXxMh87ATanrKfhIaPjyFC9oMD2y9S2hiOgxE7VW3oX
         pKoREepz7j1X9ETGb3TxBHzN0cNIJ5diiwSe/I+ywjDC562rlHyggvq+VLp1zNex/wIO
         lhHex3kCJ/YUVrsNV1deG+DWxAqYlzkjq4L4Y1KptmyYJsg0zYgpkhGjOR7J3izO/CQR
         56fzXJoUtp2dWX2lvVmdsboWBIZdRfsikp+4JVD8zb7ARikSODWbyBuPjCDXcCprVion
         vi1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773462285; x=1774067085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GD9EwzMdUI0ZeJI+HPmyVrA3AGetD8YB/VV25P7e1t8=;
        b=EJK+x1pS5pt3VKALlEzjH/kuplnpOntVXtH6v+jiUHEVn1Su8sjnE21Qa6obmheOST
         Qokje+USNw/PObpwlxPKgh15IKL7TYmAnfV9jjgYRroUkszfXT4N8Knmht7fccqCBX2Q
         9vcbDhS2kgweqDrOeO84/s4KcPZ98x59bZuaQ8h82RMvVkjDdnqr+S+FgaautYVW1Bp8
         JlSiV7HaGcaZf9wIYmL/tDJkzzU78CLIn22EXM+q7Mhmcdn8/fB30PEEMMPTdNUW7IKs
         9n5wLioC0gn1y7+TmcaejAHgo7mR6hEZEexscwbiR9fPw7XJQLhLFbcNiixgxMFQ2LhQ
         JG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773462285; x=1774067085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GD9EwzMdUI0ZeJI+HPmyVrA3AGetD8YB/VV25P7e1t8=;
        b=Qyy/2nGDFaswL17JNQP61V71gn5KsNy8BrOsoJylSSsZYPqhhk8hZEpFe/eAmY/RPm
         E1KZ456rg/k2TRXrAbSW6TdXuMB9xykSCjDpcoo3TokPGgFLJnuNDEuKZ5dFBPY/NjO5
         heKFquRFdFKaFWoFCu+BEYZHycxqaIuUZA0TOI7FkoRPoFTxy/zeFA/+0PPH446NG30W
         NoM/9aE+z8CCTPUpkN2WBNKRJiJnTiEd00qEaLYlqh45SDGq0kYUqcGDmSFUwvqfy8KE
         X0OD9XE5gewnfu6o/B139Y+BKZ2OLb3Y2AJpOaI6Hs8d2Gp6qyM0mh9ISaYr4eOFkTRA
         TaJA==
X-Forwarded-Encrypted: i=1; AJvYcCWJMsmvBPeehz0ugmche6x5hkOg7hnD/G0YLlUTt5Wi/wP3911wC1patVIsKf51soDtPbEQo5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVjapXA3AiIloDDg4juMIsaE1HBMyyjZoJm482I26YDYzXGgrN
	XoxghD5PLA746waXM4MkpiNkmQ9O2On/T0J0Ih+qfskHToZOmMw1NgXkr7nt9XHnDXfCjcItQKZ
	h5GAPXatPzlEgQ0HcOroeY54bJxg6s68qG8pffPSi
X-Gm-Gg: ATEYQzzb+4P7BpIEt4DzUhsr95Z6wqmexDUShMZqugbidkR/kV0q12J7oMeEBDHeGfP
	gyjD3n3xrZezCRIFqy+/hQVVSFCweSEyarFoWh8E90kq/zAfbf2kh1qa9dnw6fK67zuuUmfD/i6
	VxOb79WYxyMVTv/fsauo9hTgyxx6ec7UZ7oQWQ6sm/otA+N6Y60MctnXEhx1J55EIh0B57G9W6D
	qo2v096+ss9jn9y1xE06tk/5j+v7pHXncpt59Kbz20M0V/AgbxuW7DOFgcyhU2yaM8ub7iOkUwE
	Lz8IyuE=
X-Received: by 2002:a05:622a:1346:b0:509:2ce4:28d5 with SMTP id
 d75a77b69052e-50957e7c068mr75344531cf.72.1773462284578; Fri, 13 Mar 2026
 21:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313202802.1201129-1-edumazet@google.com> <20260313150710.0edaa6b9@kernel.org>
 <CANn89iJen547z-NOnu4QBe5K=92+tfeaO8T5A0X=_0vHdgQ4RQ@mail.gmail.com>
In-Reply-To: <CANn89iJen547z-NOnu4QBe5K=92+tfeaO8T5A0X=_0vHdgQ4RQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 14 Mar 2026 05:24:33 +0100
X-Gm-Features: AaiRm52gfiitSzkGLxlRpg-H_XSYHykNlN1yQupDQKhosqUiJkZBiJ9g01TZvIA
Message-ID: <CANn89iL9J-3T1GYfMypz7VkVzbb=usEZhZk=DmQT4nhsqCcjpA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: add cwnd_event_tx_start to tcp_congestion_ops
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-267669-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD7C328B8EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 5:13=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Mar 13, 2026 at 11:07=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >
> > On Fri, 13 Mar 2026 20:28:02 +0000 Eric Dumazet wrote:
> > > (tcp_congestion_ops)->cwnd_event() is called very often, with
> > > @event oscillating between CA_EVENT_TX_START and other values.
> > >
> > > This is not branch prediction friendly.
> > >
> > > Provide a new cwnd_event_tx_start pointer dedicated for CA_EVENT_TX_S=
TART.
> > >
> > > Both BBR and CUBIC benefit from this change, since they only care
> > > about CA_EVENT_TX_START.
> >
> > BPF selftest are not happy:
> > 857
> >   progs/tcp_ca_kfunc.c:121:33: error: use of undeclared identifier 'cwn=
d_event_tx_start'
> >     121 |         .cwnd_event_tx_start =3D (void *)cwnd_event_tx_start,
> >         |                                        ^~~~~~~~~~~~~~~~~~~
> > --
> > pw-bot: cr
>
> Ah, I missed this because the bpf tests on my side have many errors.

I will squash this in V2

diff --git a/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
b/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
index 0aa47d99513d1f1af8f4be0b92a7632b699286dc..bccf677b94b61226a3dd0517e0b=
2e64168de711f
100644
--- a/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
+++ b/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
@@ -23,7 +23,7 @@
 #define TCP_REORDERING (12)

 extern void cubictcp_init(struct sock *sk) __ksym;
-extern void cubictcp_cwnd_event(struct sock *sk, enum tcp_ca_event
event) __ksym;
+extern void cubictcp_cwnd_event_tx_start(struct sock *sk) __ksym;
 extern __u32 cubictcp_recalc_ssthresh(struct sock *sk) __ksym;
 extern void cubictcp_state(struct sock *sk, __u8 new_state) __ksym;
 extern __u32 tcp_reno_undo_cwnd(struct sock *sk) __ksym;

