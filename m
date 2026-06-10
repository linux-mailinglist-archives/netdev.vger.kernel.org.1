Return-Path: <netdev+bounces-297436-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MrcfEIvyKGpEOAMAu9opvQ
	(envelope-from <netdev+bounces-297436-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:13:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D09665E2C
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:13:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=I4jtxxH3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297436-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297436-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D5B73095145
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 05:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5C5370D6E;
	Wed, 10 Jun 2026 05:11:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B397B30C63B
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 05:11:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781068272; cv=pass; b=gFZc3t8n0LInxfLYP45+xLWUTrexfRd6IcnttIAgLQJ0KINJ1VCSfmuJfu6c7nHNXPY4f56o1Y79QpxMio2iKdUJUj6shqbWL9deoWqXOoYnbRc6z5qf0NQwE4Lv75pFLtNwaaYZelCJ9DAfXUzivv7IW+r2jJtkresHudBVwmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781068272; c=relaxed/simple;
	bh=RaoZu7AT59pWjSHSFhsYcGqd1OdcFRhOOHmZ9Wko9tQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlVksTnLL+87eA+J8jDAT7Uxrgdrz/8G/FlcvBjwB6YSowGfHs08CS3cPx8YqZj66n2r04WVaa87k8OnymqpwvuBHJaZZZDUK1uxBVD0tvYjooKBDVMono5aYlCCzO4TrZzsMDD+MgXwYbJr9RZgP9Mo9OU9Ex/N1OcYkgGSoNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I4jtxxH3; arc=pass smtp.client-ip=209.85.167.41
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aa69131836so5615414e87.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 22:11:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781068269; cv=none;
        d=google.com; s=arc-20240605;
        b=CHqtnY1omdMeCBJHiAgUWRel+g7k3wAtuKvwMnAN51+GDu+uO0lQeRI2qOKFKa5183
         9V3A1ITYD9Hr6n1+Mr+OPE2hbQm3Rc3pxiGp7qhpEhgWz1/5sN1btjMB357zcOMscnL0
         iNyK+5kN1dfInK7hDdEk0zTjilnoFq6yVV9+2aJDS/bu7M1CnK94tfvl+BqUd6rZQrax
         CieVgZY+//frutNxJ6mFdXL+GpD59vuyZcm2I26OJ4GLv0twM6PIloE3I7xuBTluQK4k
         PumxYw6RYhV+npiNxCBJtZWvf2q5jymyHIOSdem+3xTazJ+eHM7rmiHU7n1NOWY9nyNZ
         fH/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MjPZkuasfySIcKEliRg5Qwh1GS8tecOIWXm1vwJNGmE=;
        fh=GmxiGAdi/qmqDsWfPvfBB/bAIuhPOJ0i8NKl8E2Pr+4=;
        b=kjG4SkbLRQQhbaBSPp8eIWAUsnrpUGu15v+iI91x0P24krgGzzILqk2QqDy4r8kYWl
         NGxPvqw1nXIhhWjwU01xB7mwZZw00Wc+OjemOnUZac8x+z79qymaiMieNydeAAt8GhS2
         qKU4hW2QkOnRO3B0yIFHqK07HY6t6LLXo7Na9rTvBeR8rSG7FM9gcgi2qpweQ310DroY
         nHhto+hciRwu5ejAixOfGTsPzBu+8b1lyLcJN0xIyw1Tjg+rO4XGpnal93a8Ep0t23HT
         N3+HsOPaL2kNMMV3/soV2r0DIKmd+BwS7yiRpmBHzhLfMjncoVKdfbJImOrz0V3VnKa4
         HxhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781068269; x=1781673069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjPZkuasfySIcKEliRg5Qwh1GS8tecOIWXm1vwJNGmE=;
        b=I4jtxxH3dDAAvm3+VG+8ZyEjv1XPnsatmtSuTYI4bPFHiuLthRquM+KABcu3e8ICeF
         0aK13F+Boh2de5md/g0x4NtbDbO3MdOPTxi9ZjOcpjARZkpxWl8awQ9K/MX12xopVtwj
         79sRhXC+xcVwH5oGPDqE342GCdyvMInJPF45SURuLBmkhc7GdsFNN12oF7GEbVwxAXHQ
         o0QpvzRKjCOB4TQLm2iXg96B/q2JYn3+cHNv4W7MG9LaTsv54u8mi+m/UWTkRsNtpb/W
         A6Z3iolHJ3jqE4erXFSQWtr1bsTO9I+IlsjRs4jYjvINNhL81CLAS6K0E3ECDt3bFiaU
         b6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781068269; x=1781673069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MjPZkuasfySIcKEliRg5Qwh1GS8tecOIWXm1vwJNGmE=;
        b=JVghuiAc/QuS3QOs1yu0FnO9SzeJT95NaUksswPDQbyt/6VlIbg4IDHKIsMBzf51sT
         52T0mzp6EDblvjvdmR8OF/XCq/+QC+NjoslmWaaIQZ3cA+EMm8AbbA3XbID3F/H58zt4
         /+dnYdCdm8qvDJWGaJmjTeQ88PTUIzNIJ2e0Q/fH7t7K4FZ4tsd4svGr7PuRn/MXkX6x
         CGfX/cq4L3W1lX9cvFgwZ85RAFlIOjLf+0j8RdFFbFl/ZHdhJULfg02DkYZvJSJ5CiRy
         ty4BS0UHuJUtq15b+6Ud1oNZc+H13l1qHZQOOuubH4qdU09c/QUOe4btD+rHMLj4AKcj
         mNnw==
X-Forwarded-Encrypted: i=1; AFNElJ9mXF2RNS8jnjGnl+pbw5jubfoG2+V+An+IdJdinNKTTQvDWk1mg0W/7wobe4DuavYo2/Rd6hQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEI5tGzuOfcxrE0nYRF2Z7gmrR5WP0M1P9yCYZ/Uwq2hSr3swm
	gc1EP6LkI2YFzX1MailEQ4pdbredbajCT+fItedumUiSsVxju9ES8I7wNvOPdGDgsTzePGbk8Xw
	n9mzqp7a4qct66VbHb+Xo+tgtFNaTRlvwKsAyz6od6w==
X-Gm-Gg: Acq92OHCe12VQpOTA/fBzJc+gTnMfpV6C38vycIsCw/kHn3FrouKZ3PndI+ekqj5Qte
	deJad1J2Q/4jPR9X/qdOIlbOhtQPBo1wAm/6RF2TcNR+/zO21Z6ZhZwTqt8mT8zmc0HC7H63N0G
	kXE2XzMap44quOZkoEL42qmq31VBjLAzjDNVTvYToRas4tlyogNjJn6CKxQ8M7niXN3x3THebb6
	F7j8xSDScSzm4kW+t/K0Ghf86EhevNdxJiIHs3EvFvIlQUAHDjMCoHqtdo2oD/hsogcvQD9+Mep
	4SbQ30wRuAeLOQZv+JoxDLQ42o4WZEQOFUUoRxh++2hMuEnwt5F2pXlNHV3ayQ==
X-Received: by 2002:a05:6512:61d9:10b0:5aa:75f2:c996 with SMTP id
 2adb3069b0e04-5aa87bb9a8emr4450473e87.16.1781068269041; Tue, 09 Jun 2026
 22:11:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507130117.252825-1-marco.crivellari@suse.com>
 <CAAofZF5_MRtySWTMs-J3T676FwjJiLDpYLRWmsFaSXePo3nZPg@mail.gmail.com> <d9242324-720c-448f-9723-e11f0158f4b1@app.fastmail.com>
In-Reply-To: <d9242324-720c-448f-9723-e11f0158f4b1@app.fastmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 10 Jun 2026 07:10:58 +0200
X-Gm-Features: AVVi8Cd4rl3lKg-JT9WcRLU1iz-_cOhVgv4WWgAm98_6Ch-TnEwssJeJ6D60Ox4
Message-ID: <CAAofZF6UbVgtzDkpaQusrHBg6u1q0E-49upzNL=Te-+PzDNNrQ@mail.gmail.com>
Subject: Re: [PATCH v2] xprtrdma: Move long delayed work on system_dfl_long_wq
To: Anna Schumaker <anna@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	netdev@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Trond Myklebust <trondmy@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:anna@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:netdev@vger.kernel.org,m:tj@kernel.org,m:jiangshanlai@gmail.com,m:frederic@kernel.org,m:bigeasy@linutronix.de,m:mhocko@suse.com,m:trondmy@kernel.org,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297436-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linutronix.de,suse.com,oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,suse.com:dkim,suse.com:email,suse.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8D09665E2C

On Tue, Jun 9, 2026 at 8:55=E2=80=AFPM Anna Schumaker <anna@kernel.org> wro=
te:
>
> Hi Marco,
>
> On Fri, Jun 5, 2026, at 4:12 AM, Marco Crivellari wrote:
> > Hi,
> >
> > On Thu, May 7, 2026 at 3:01=E2=80=AFPM Marco Crivellari
> > <marco.crivellari@suse.com> wrote:
> >> [...]
> >>  net/sunrpc/xprtrdma/transport.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > Gentle ping.
>
> Thanks for the ping! I've had the patch in my
> testing branch for a bit, and just pushed it
> out to my linux-next for the next merge.

Many thanks Anna!

--=20

Marco Crivellari

SUSE Labs

