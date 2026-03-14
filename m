Return-Path: <netdev+bounces-267872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGXYJljktWkN6gAAu9opvQ
	(envelope-from <netdev+bounces-267872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 23:42:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BD528F5D5
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 23:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A327B3006457
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 22:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5432267B07;
	Sat, 14 Mar 2026 22:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aT9HmYPy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623851A6819
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 22:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773528149; cv=pass; b=XynagjKo8mXjj+D48hsOoDu75ScQlZY+A26RtyOzgC7bDtvfTlX0jkWTprspBeD1vL4zYKiQhgES7DLV++zQRsrXwGqC10B5j1YdsmawwA1Wf942S7Ou8JXBKh/LCTW7TPtwdw39fbRlmHmFXIlP+YKIBtjV4o7Pnq953ELF1OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773528149; c=relaxed/simple;
	bh=7XvN9gnJhkYFMSSzXJCyi07H6UM2LdNXjpcngX5iFxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHGrOYggGfFXgKwzdytuQv4wjzjWyaaAPh245rdasrwq9SeIOoH9FlxDa5YTVXCSjJ2DHx8xBRYhd7S2CY9lQEYcyRVwu/IxFuc6gA0MAfcRjaNtFa84H0dFTNVWSHMnbrfpVuk6OWIBJ8jBtD6jnIOdEgGnc51kZ6RNGT0ereg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aT9HmYPy; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50917e02472so42089841cf.2
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 15:42:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773528147; cv=none;
        d=google.com; s=arc-20240605;
        b=Hmiz6w87LNJU5QJ6dxvGC9pKlcHn745u+i2tLW2sYpG6qhjqhO5LuVAU04AHiCrUFo
         Lmsc8kTEOjyfwxlzpjmlWxelc0DSI6pt/9d3vr8fH9zY0aYY3zJnk/At144ipxjBsT9y
         RjkgJy5HurIhYlWZZKh5vp7KtEIcIfcP1b6tYv0ZM18q5mCZLIpPpsnlzGczyQDlVHbz
         Zt+KR7/HbL4aSidlopSp3Iu8GVZBrVygOSnX08of4psZa7toqFIO7xnN8Xz2C+5QCa8/
         wBoDKS8Cl603YYR46LzQNFWhx4/L49NnWMjpESAaRVR04vPTg+S5MvS3B1zYMXJif/Ru
         GD0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LJ+pveZuG/X9ImF0VmLnI66Y9PVhj14SgzFGLom9dwk=;
        fh=oMqDLgFc8zeBPeejhlO9xqoTXUSQfXdxhFwMyA0NxsE=;
        b=Q/we2XHQm7rpxC955LIaiZU1p7wBI/w9Jqd5wivB5pHZJc9blQq1ijlD1m1AHQAu5t
         procWNjYr48Lo330e4ILqEv3SPVL0ishUjOhVqEq9bGeLCeF9jJ0FMP3FWT0C0s/iHH/
         qDP9wpJzbg9+GCBzUeXFHzE4VFUudMBugCk6UnnJCrRJwM0uNzkDKxHBywwbSAkYGouh
         GFO1ES/eo40t+I1aESzIXnfuszvSWqzegYhYqU9SCT2dXIYHZ4LUHBl1/W5Xl9HFvZx8
         u0OYWr7MnQB33E6mToBpN2LS0fhBQ8/Z5IJfVJWDz9qcex1/3satG12jsq8TBg6Ddcj4
         Cnqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773528147; x=1774132947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJ+pveZuG/X9ImF0VmLnI66Y9PVhj14SgzFGLom9dwk=;
        b=aT9HmYPyx3Rxwmtq+VqvanVJVQ2XVgtFWBUksBywaEQ+70Okt1m3LdKdV2CiXXz755
         4fnosESLMlduwxCFhWbsM1vNwY16wZr0Ebb3pCHfVH5m0eUZgRaUueV/vSEwYrau2Z+u
         VEtNMYHUZ9WVVlsohMG4P8i3poz4ckTYc5TP+v6Ko3sZS5IdYQX5FWG4GZoyZOICP4Ne
         SJiZyDlRJ04VEEeHx7Mg+4bBexA3ma5kiELfVCHRJEWL0JtPf5VJUf60cmnGVKsHkSJo
         oidPiDw7gCpR58x7TRB7H3Thbwn+UJvPKJaXJWIuoFaGnl9ni8DfEHChVE8cV5ODi3wA
         Ztcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773528147; x=1774132947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LJ+pveZuG/X9ImF0VmLnI66Y9PVhj14SgzFGLom9dwk=;
        b=kYp0+vFvmTfBe4MyIfNvnkEsNs+KzpAydT/thchxNoNcQFIuQbLVcItgt8Z4HdfbZM
         G3X61tZRVvcr1PYtkKqhPSTZzaQ7MBl1HKrSD88UAa+x/XXIVVGUwrDdYbCcXTVo3XTQ
         tF9qcJAU8mZg5Qi5Uwk2sYWIuSby+5rT4PbOmCi0BIv6o2TNCna8xnheZ17aJ0jQEUdg
         ZC6xl9UOWBs3U87zovAph8KJiSrPE8qqVTFdIsOLlok2gX8zavyOCV63ui0P1XKJ2to7
         AvYra3msLLBW/Am03tcV3afaaApC/BO6Jj2Eh8NfdpGpf52c0FllsdTaRfaaNwuNHKUr
         mX+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXm/E8y+Vo7FmKnsawVas3WOqOjxeLNgd34qztyIrESvbcHdmfr3H0PFdBooimxq+TVd+dM/M8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8PyvzDU6Pay4iKSLWc+VUTxtOy6ndQFulxv9MowY9DBgrKL7M
	phhrJvW2ti4Lv/D8gyZG5xDkJMfdsyHEoQ+QR6Yigcml1N10cUPZN07Qeos5DGu48G9WhPQ3Rac
	T4uLSEuCTKY3TXBTsdtNS9lzt2N/dElRyagOT4BEN
X-Gm-Gg: ATEYQzxLU7Ih+KLPAgqMdmC7SFhgTVJGliC1t1io63dzDO+XutOsbv8ekDwWi7uJRgs
	zOcfF3tmuKtqaBCkjXXP7Ii3w4XRHsJ2/HSRpnSydHJbnUWaTFcKidvvTeiZQdMHGniqaIpmwAh
	4dUpsMKotkRuOiX3iHtoeQKQSkPBu4x5fD1vdiZLYSS8FP+F4kbFPLkW8xhx21ig4munr2HMIgy
	gRVH6ojCGreKDF3kQxOl5xq32a5eShC9HexdvqwduO6hUuyUpF0xQ5YcI3RM9l2Q2BEBvnrpnBh
	0Ozhp/ka
X-Received: by 2002:a05:622a:488:b0:509:4d26:25e3 with SMTP id
 d75a77b69052e-50957e3261dmr101135111cf.71.1773528146886; Sat, 14 Mar 2026
 15:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314180802.50222-1-edumazet@google.com> <20260314145202.778a8535@kernel.org>
 <CANn89iJ7JUgU64dmEYGvD5sWqpf-ssymNQ=2dZKOY2zPjtq0Aw@mail.gmail.com> <CANn89iJb0aF_4z5+AoL-zgbsr76W8QqPc1=tfW8Td8=6h890Uw@mail.gmail.com>
In-Reply-To: <CANn89iJb0aF_4z5+AoL-zgbsr76W8QqPc1=tfW8Td8=6h890Uw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 14 Mar 2026 23:42:15 +0100
X-Gm-Features: AaiRm50Kvb48O9wERomSPTZWY37KMy0AEmHR35hLCty9VWfzQS1hn6BzYhQyxuw
Message-ID: <CANn89iL-m1Xt6RK90yPssdVQt5a5zR+Fhm+9pcCpjVDkceBqAA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] tcp: add cwnd_event_tx_start to tcp_congestion_ops
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-267872-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 45BD528F5D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 11:35=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Sat, Mar 14, 2026 at 11:27=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Sat, Mar 14, 2026 at 10:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> > >
> > > On Sat, 14 Mar 2026 18:08:02 +0000 Eric Dumazet wrote:
> > > > (tcp_congestion_ops)->cwnd_event() is called very often, with
> > > > @event oscillating between CA_EVENT_TX_START and other values.
> > > >
> > > > This is not branch prediction friendly.
> > > >
> > > > Provide a new cwnd_event_tx_start pointer dedicated for CA_EVENT_TX=
_START.
> > > >
> > > > Both BBR and CUBIC benefit from this change, since they only care
> > > > about CA_EVENT_TX_START.
> > >
> > > BPF still not building :(
> > >
> > >   progs/tcp_ca_kfunc.c:121:33: error: use of undeclared identifier 'c=
wnd_event_tx_start'
> > >     121 |         .cwnd_event_tx_start =3D (void *)cwnd_event_tx_star=
t,
> > >         |                                        ^~~~~~~~~~~~~~~~~~~
> > >
> > >
> > > https://github.com/kernel-patches/bpf/actions/runs/23096281431/job/67=
089276918
> >
> >
> > make clean
> > vng -bv CC=3Dclang >RES
> > make headers ; make -j100 -C tools/testing/selftests/net ; make -j100
> > -C tools/testing/selftests/bpf
> >  make -j100 -C tools/testing/selftests/bpf
> > make: Entering directory
>
> It seems my config missed
>
> CONFIG_NET_SCH_BPF=3Dy

OK this was a typo.

diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
b/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
index a4334cf4c6bd59a0552a5a2cccabf75489d46f58..0a3e9d35bf6f0c4c988c741c010=
fb7f3405fb43c
100644
--- a/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c
@@ -74,7 +74,7 @@ void BPF_PROG(cwnd_event, struct sock *sk, enum
tcp_ca_event event)
 }

 SEC("struct_ops")
-void BPF_PROG(cwnd_event_tx_stat, struct sock *sk)
+void BPF_PROG(cwnd_event_tx_start, struct sock *sk)
 {
        bbr_cwnd_event_tx_start(sk);
        dctcp_cwnd_event_tx_start(sk);

