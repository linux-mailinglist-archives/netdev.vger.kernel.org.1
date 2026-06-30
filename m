Return-Path: <netdev+bounces-302865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZKMBGSESQ2o6PAoAu9opvQ
	(envelope-from <netdev+bounces-302865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 02:47:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 038D86DF705
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 02:47:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=IF9utlaC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302865-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302865-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFE30302B3B2
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 00:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EA321A457;
	Tue, 30 Jun 2026 00:47:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F0420C029
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 00:47:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782780438; cv=pass; b=T2Y83Ar7bEBjRW6VywS/lRDiv6s6By+vvLyMq6DdDPPRIS5xdcOAc4PEg9LPOcKReRwgm6YTBEY3UAWE33S4p8Jl9F+0i0sLQV5I4qbMI0KjqRpr+TPI2q+K4dHnAx4lqXVrDx+o0wGuVsysvjBJAgXaSCRl5Fyiqd5Ht/TSSqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782780438; c=relaxed/simple;
	bh=VSIZSjyLVSUbgNMmTj7rlDvbYCLAbV38QomywhLV1Rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYVFvgtaiRxNxnJEX+RstUZl2cdiMnTWCviCTgf49khtzMieHdJJk7r+3XaLXMXhhefn/0DYVIEvaRbsT7kajbIZABeV2NsT4InMdnoTBKSEeu9c/iC3LYnLBmZVjwrgbDeHePleI354vzcjxXZ79YgwInR5BtTM2MOqAUamorU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IF9utlaC; arc=pass smtp.client-ip=209.85.208.50
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-695a3842230so5169a12.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 17:47:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782780435; cv=none;
        d=google.com; s=arc-20260327;
        b=owr78AxjVTaM8fqIjob++EfGcvziZ1DGa9eEOxUXDf10fQV9NJkW5VoDggUR5+zqS5
         XtwMr8Dzp4kCKKAxRNy/X6RMZsPRiyhJHKkanTMPzxQHtF30U/Ug7GchBbp0OtB2tcBi
         l2DVbuNRVrJVBlAxjVzeg2zgKt6mZvktd/XFiFv/DInGcPh03fBc74oKEDlbK0dqyxcA
         snZ2IsrEvJrTwSACSYsx2mFZsW5Oa8NDghLjPnLWLovqRojAnazXKRpO5q0+mT2XVA61
         yHrGmM0vKntfbmyIyJe/HxgObkwzF3kgM3swP4N3B/O1WUomQBJWNnFoZRUPx1jtmqSi
         R4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VSIZSjyLVSUbgNMmTj7rlDvbYCLAbV38QomywhLV1Rw=;
        fh=2EZzKtQ1TskpIQNA8WmtddDDQESjIaPG9MHu3w61tFk=;
        b=YHN0noGebxchKFXJO/COkfseuYchv2iH1qiUxkD2bcABNODmEEG6ruVPeWVsn9K3nU
         BGIy+NKmG21DO7ufXI4wZvrUyAXUiEImeJh360fs0/LEwbIUcxsGrK+EffE8bhU5xjix
         og7Kq57yM1uoLeTgpg2X04vSZF1pmKFj9ykfhfVjvrYrMFhWKI82jb7q/vRArfopCzgN
         EcX4JS+7jalH1Vf+909p6B4gG4S8Wxy4yq+5wKirk7grhCBV5mlJDx7pcOpZTe/I8k7r
         XMM4glW+PvjJcWRwp6HGxE5QimngxLaVQfIUfj6c4YdvsoBare5Znloym0g2dOyUOnuH
         QYVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782780435; x=1783385235; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VSIZSjyLVSUbgNMmTj7rlDvbYCLAbV38QomywhLV1Rw=;
        b=IF9utlaCafmp8o33CXrw8CQxGfmWH1KaO0gqJaT4bnbBTB5fxlmQ1b5/r4N/TvVueI
         6ppPBMRdzvGvpLfDyOOJ9l2kXoYCBAN6l11AJJuABFehnmVESkeb8AIdwfEUkA0CGQlW
         gvEluCslD96fPTNg5zLlMqmYGIjoFJFeavctmbIdsxlvExWK7yAB+pKzS79U7GbQ6M6m
         KmJz04+o4zR56K/AjJM678FCnwrPgXgH7D7yd1PNltrH8my6Q1sLEtv+E7goJDkKQRes
         kFzMXxXxEpQdpEr2qsZ/Z8eN54Pk2PwxPgjnwg57rjJSg85ABT+XvxGRMAilh53szrfa
         GXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782780435; x=1783385235;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VSIZSjyLVSUbgNMmTj7rlDvbYCLAbV38QomywhLV1Rw=;
        b=r4XFY/Fk70J7pYQNamoxq0+40tsFjtjunqG47Sxdyu/e9r8kdwCOW4pxPa77DfUASG
         ZanQ/qroDWVKQj+xHZvHcuXOCWKv+gVTunnCwOrA+cFfQ4yapodl9R8KhJ41kM3xoy6m
         znOCEWrpNhZTZ+U7qRnSX9qSi8cxAcY4z4BqogPNSALPzwbL4BKJ78P0QoCP50+6Dtke
         yMCCDPOYFDZle87YWcJXXQlm2edSWCbe/OVVeNUGAmvkOQn7wV+t2mlTwcNPGw76G8BX
         NeExy1B69iIs+y6IIZ6r9fqQE+zNfQREVVA1HfiCgKaQhd1Ir+AhU2m6rxrIAjnC8ejV
         9b2g==
X-Forwarded-Encrypted: i=1; AHgh+RpolQyx/buiA2eBmXsxKulybRN+ncWOJD0ZV1ITux7EkcFjp8XQ/T+hnmj/6GjfqJMkwNlZMTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnuVJ1TzLrn4q0Q7mIIetjtIh7qQm5fkgH1vBtBR3izB/uzT2K
	eVByqp/ndo0yisjVwJ5Oce/B1iKPWSegjpBxIJ39jphggLFTPFuk3YfJhvaXHzGw2weps5Npasl
	Lp1j6DiqdXQpU1gI1lyZtq4dVKexiCJn/ogAyh00Z
X-Gm-Gg: AfdE7ckO99UzjeTGoA8tK8I8Y1wSM/kM2Pvoby1bBzhkh5EvuyXiSdeN0rxCIVBB/VM
	xpecZezncuadbGNJ1yReJ85XSbDTy3iV0fq0oX5x6FDS5u326nOhsB+m3KLYtOhDsImOtoZZIwj
	YXTaCGrTCZ827B07DbDDjVxg8EFg5Ru3Abi+UbjAQr3Y9gfyIiy1nFFfZMvAnsT/sFy9T8jxLWs
	f4R/DuHJDHPZIaeOFa/EgjU/fyVFpd7Xm0ji6Hdz+56fy9LI00nrovhfqaX7glnGbW2XakgK4oq
	0ehLKspb+RThJpdRVOQgpdKXcAg=
X-Received: by 2002:aa7:cc06:0:b0:697:e82f:e4f2 with SMTP id
 4fb4d7f45d1cf-6987c8c6b20mr12507a12.4.1782780434872; Mon, 29 Jun 2026
 17:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629192029.4013794-1-tanshuhao@google.com> <20260629162619.55297244@kernel.org>
In-Reply-To: <20260629162619.55297244@kernel.org>
From: Shuhao Tan <tanshuhao@google.com>
Date: Mon, 29 Jun 2026 17:47:03 -0700
X-Gm-Features: AVVi8CeyPv_HP2xk8ySnhnc0pqyT64kuNUxCMJ35qQdjLil091krpfhQ9C5nrWU
Message-ID: <CAABY+HEcNnh+ATyA_JMg4LnVpP=egprTTi4UXxV9CfW2+71z+g@mail.gmail.com>
Subject: Re: [PATCH net-next v1 0/2] Reuse threaded NAPI kthread across napi_del()/napi_add().
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:shuah@kernel.org,m:almasrymina@google.com,m:skhawaja@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302865-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[tanshuhao@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tanshuhao@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 038D86DF705

On Mon, Jun 29, 2026 at 4:26=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 29 Jun 2026 12:20:25 -0700 Shuhao Tan wrote:
> > These drivers destroy and recreate queues during configuration
> > changes. If a NAPI was threaded before destruction, during the
> > creation, a new kthread will be spawned for the NAPI.
> >
> > Some drivers do not have this problem, e.g. netdevsim. But these
> > drivers and the drivers mentioned above will still lose kthread
> > during link flap (ndo_stop/ndo_open).
> >
> > Because the kthreads before and after these configuration changes are
> > different, all the attributes associated with the kthread are lost.
> > These include CPU mask, priority, scheduler policy, etc.. If the
> > threaded state is preserved for a NAPI, it makes sense to want to
> > preserve the attributes of the thread as well.
>
> Send a netdev Netlink notification when NAPI is re-created and
> let the userspace re-apply the settings?

It feels surprising that the userspace needs to reconfigure thread
properties when changing NIC configurations unrelated to threading.
Another downside is that when userspace configures NIC configurations
in quick succession, re-application becomes messy because a previous
re-application might still be in progress when the thread is gone.

> Keeping a few u32s
> around is one thing but keeping a thread running and visible
> in /procfs for the lifetime of a machine feels a little bit much.
> IDK.

The thread will be parked, so at least it will not eat CPU cycles.
Regarding visibility, the only case that I am aware of where a thread
can be unwantedly visible requires first setting the device/queue to
be threaded and then reducing the number of queues. If certain
configurations are applied before the reduction, it makes sense to
want to restore those stuff when the queues get added back (like
irq_affinity today). Moreover, the user can stop the stale thread and
completely remove it by disabling threaded NAPI on the device. So the
thread is not completely tied to the machine's lifetime, and there is
a way to get rid of it.

