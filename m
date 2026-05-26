Return-Path: <netdev+bounces-291723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPHlJyywFWpxYAcAu9opvQ
	(envelope-from <netdev+bounces-291723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:37:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 040195D7B95
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 008C430FD6B0
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8AB3FE67A;
	Tue, 26 May 2026 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c36I0/UM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D123FF1CB
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805780; cv=pass; b=kM/D7sCd3TnGjPTiqr36zVd15GSfXthuXbLANDeU7YvR9s9pEuLFSUxM02w7EdUbmeskcMEV5MW51EzrIGpn0xzDdgN/A8pfMPXftwsmcscETU3bROC6OR7jCER4+P2NL18eO29ztiCHsG1Snj9TN6Mbj6SOx10Y7niRmJfVICE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805780; c=relaxed/simple;
	bh=vP0zaPMIbKqhvyxyqCPO4DwmVgyhZB5GN6q3P3VKB94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+BOwJpqPXq26yn28qezw4TwedkfrplkJEIBUVL7s1zT7fdJ9C08UP2VfNvAkX4/BN6xteg9jrPC/oXNRVrHwjxxJU2BmMWS+u1D4bUvSsGEUAzZS3XjsjA4UAOKDp3hsGIfqlB33t4q66FOi2VEhmWhpXbCLXMPBy2JgY20Rqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c36I0/UM; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3042a99f0ceso489540eec.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 07:29:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779805778; cv=none;
        d=google.com; s=arc-20240605;
        b=fdcI5BEn6Bg828ukMF7uWlMzRdpCpY2O7GFIwt0stSaupHB/pquRhjXxDakmvIapgz
         /jWYjG9L13fOV5M+ZBHsFaQwkWizULXkxFv7JO2QSiKC4+2IQ0toJhuOC94qAdLSJsTD
         SJBRzlJ5Q6OIBV1IopEDVMpLsUQ+tW0MRhvdjOPHQl+m22xMW4t5CP0A0sxcib0N+0vD
         pPMIuhpXIvH1SMC8iUx9VpF1nnwMoztz95h3BZoMEP7YndjY2y5SNPb2+0ghS+ph6F8O
         yfFTAOZDJmfAlADe+1tkxb3g6mizimDwPMprkPDVOGAU73DV4FXLjf7HSOUXNfrdhoQY
         uMGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GkahTBY7DttIBK8/I6RaDHQR+ZL3N1RSmhZ9vt+Nxj0=;
        fh=8RbbcqKYigWO729p3EvacJp7DMI9XVbLOM+KCjwGD6Q=;
        b=QLp27FRAzTWG+4D5HCbEpBxk3LUy2f0JloLtqhY0CHjt2tKKKo0B66Eo4bn/dO/VNH
         jSPNT6ONPXPxE7hoRDrR/xM56b3pU32JxMw+8XmFfMs+xQQupAWQBC7Fg4dnzSqn7RZd
         ztE2LweI7MoJ3q469gQjo+2xnB230cZF2dIEQUOqud3WDV/GWjYJy2504hwEg0wopYYP
         ceO6K/7e9WUUzJ1wn0XIfQWEGixYx4V8ljKJsqOm0/Dmhdw56+m6BKZqV6Nwz+wi8iym
         ckONouWoVmilMpnzrr5W8KK06CjA+MrTfYesFzXdloaDudh1iI1iLdUziww81FqOTAfE
         LZUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779805778; x=1780410578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkahTBY7DttIBK8/I6RaDHQR+ZL3N1RSmhZ9vt+Nxj0=;
        b=c36I0/UM4iInio3iXPuFHOM3FXvOBBUjtuyory5FpOCKx9dqvU/gOoFOMVVm6+diqV
         F06f1oBuFy00JtynQoRsiV5r9OJB1GpnIoQTVyw8gRpSNid1roxTy0sgObdyCnOE3O2n
         WR+EODXfykiViQNZzXvJ0wLwqPK7RbOECftzC/J62dqTF8xUalO790FAdGs2yUIHpXms
         bhu28U4np6zBcppVn+r5irKbyoza6zNVAjPnUWhVrcv0VbaOYg00sL98yssaSxhR3v26
         ojea7a2WsphLpCakslJKQhpHJyVVQHzS7t6jGcZhXe+UuXluH7uCpCwwSnnU4FBwMlJs
         i+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805778; x=1780410578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GkahTBY7DttIBK8/I6RaDHQR+ZL3N1RSmhZ9vt+Nxj0=;
        b=qzQ8R/y5kQjlJOyAz35o2RNBVfRT/JuPyVgP7jV3ohF4kRe8c/WuBcqk2X8hy8sQvz
         rXvvis8nogXljjEPxyMGOuvEgJp3ZCgcUdXOL6Xh9eFxr92bbJ+7BdiqK2nETGu+S4/7
         +4OIkwiUVrRyItly8hOvJBIdzi8XQw5ubNUVdkbfmDEhXI6bDHGms0/zYnzbYUuJRWb7
         Lspf7nCQIFeahWLI4U9nJadsaoRyIxDlhL8JG0qWYeb9T8BVDK8c1G7h9gBXouR/rGBl
         tB/v+ujaY8tt2T62X+0FthKP4aB6vzjojkNJea6kqmY6c5+NJg0/hc9WZ7halwX9UOGC
         g0Sw==
X-Forwarded-Encrypted: i=1; AFNElJ8mkmPxk6qddkA3pG60B+rCA9sQCXdI3jZCnnzZfVYzvuUJWAKInyfD4U6UeGIaPXcTquxvIOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRh4tZbRWZMpT/viX6ljMYvPstwhMqXbZOWEoyRzvtahhVx0R5
	xemc1wpMbAi69yWVq5LyNFhT8Ghb4Raa8u3R/Csy8YFzvUlo4rB/MzhXRU0DKJZuuRD5rmyHXDF
	5f5D4WuofcCpoCrV5ZH2hHYqxRN2meIs=
X-Gm-Gg: Acq92OGuvQ2iYc6B08RQkg93PDecGc+iJPi79H+Be246dcYqHxtP0ch3zPSjbL+odus
	EaxSbiP4vnyVeBbrnYKDQc9g1gU6x7VNyOpHKjZ6a0QDu5RDXuhKqG0DBqtvhYP3z1nCux+r/Sn
	Mpb2M9zBeSXPZhsya+0+mBn2FvmziFsAZv6FH4enmDUPthR8Hz6zO48tJpOauQGoejt52FLavC0
	WaeIVpLgHbDxYHuAm3u0MzxNEPE7aJ70OOFJHM/enCdMHFJLj6LHtW1B3JCGjMiynJges2RVMue
	N+I41CKwOGXHitl7fOkEzt6aW0k0PRfiBbV/uVUD6t53Txy2Q3TQl9qiSJ7lC2aIsgV7Rt8EOl8
	0OKb9noA52Rwu5sVd2qBfxgTSwFPZgw40TA==
X-Received: by 2002:a05:7300:ef82:b0:2da:b05a:5a7d with SMTP id
 5a478bee46e88-30448d0b97bmr3769857eec.0.1779805778357; Tue, 26 May 2026
 07:29:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525-binder-netlink-v5-0-a90e2923ebeb@google.com> <20260525-binder-netlink-v5-1-a90e2923ebeb@google.com>
In-Reply-To: <20260525-binder-netlink-v5-1-a90e2923ebeb@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 26 May 2026 16:29:26 +0200
X-Gm-Features: AVHnY4LeJi5SVDem9yk0z_BL7MLaNvMrDJVdmDpHefcP8syTnl8_FJAOfE4J2Ws
Message-ID: <CANiq72kRC_k1cnJLmG+AUSiUH6kDXVsox3nMJnV-c6HkNXOwBA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] rust: netlink: add raw netlink abstraction
To: Alice Ryhl <aliceryhl@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>
Cc: Carlos Llamas <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Matthew Maurer <mmaurer@google.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291723-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,linuxfoundation.org,lunn.ch,davemloft.net,redhat.com,kernel.org,garyguo.net,protonmail.com,umich.edu,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 040195D7B95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 3:17=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> This implements a safe and relatively simple API over the netlink API,
> that allows you to add different attributes to a netlink message and
> broadcast it. As the first user of this API only makes use of broadcast,
> only broadcast messages are supported here.

>  rust/kernel/netlink.rs          | 336 ++++++++++++++++++++++++++++++++++=
++++++

This should be added to an existing or new `MAINTAINERS` entry, i.e.
as usual, either inheriting it if the maintainers want, or delegating
it to a sub- or co-maintainer, etc. depending on what people want.

Cheers,
Miguel

