Return-Path: <netdev+bounces-258338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPqQJIvMjGnJtAAAu9opvQ
	(envelope-from <netdev+bounces-258338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 19:38:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A0D126E45
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 19:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 314063004079
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49853352C44;
	Wed, 11 Feb 2026 18:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dD4Bysm8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C13734575A
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770835077; cv=pass; b=eMvfQX89dBm65G+/AhTShf9zdX4eWdFy3zR1RgGyeBDK+v/RB2DyCfcXWGWuSzeIe6a4jwi12rwQhj0IVnl6XYwVDf8/ZR4Nw1sOkqtewAjjSElknHanJ0LfO546H1ygjvMsd7tQH42l7+eN4fux9760VYpQ0uwhMJkG+4SGc5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770835077; c=relaxed/simple;
	bh=9ZWLjOloP1Q5uHjLNR70INYP0pXvmwZRE/FY/ppnIWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rwit4o9QhJQIR2uqbBOPKMCu0A/hYv7FfwtvIwEjkmrohBoltv7MxM+9VKoaUXtFb1jWHS+V97D9kDszti9BR5so9DvJDm+i57EhOlX8brsidSrhe6BTeekYJnZV/RkOwJRZWWgQf/fe/xS6Oat+SBppQ45g8HAoKEXisrQ5bkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dD4Bysm8; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8220bd582ddso1472265b3a.2
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 10:37:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770835075; cv=none;
        d=google.com; s=arc-20240605;
        b=JaF2H2Rd1krD7VeEMK4P5rPZ3SZ1qeYrcf4iOnmPH4A+qXrWCGk2PsvG2y3TnEhgc6
         cZVRAYPCpWY5/Xk1WeULFovmn9DUoriHqu26LHjzC8zXyHwFF2QLBqol4nABGLZ3kYJP
         i+GPlGUW52CVcX0nrdZHr+msdcZJDXYCqe26gyE//cL1CjruBPcIVZQDlC4PIMx6/7SB
         hvruUylfrQSeFK7E75TvxJ1y9ScW8u/ci0LIqaYLs2Pk+rV7yACOOsgQuq1X3EzPs1iF
         HYNDS5UwIQis3D18BvqZTm3PZV4UzjNifImz02XdgzmKut3Pmj/uwu+rVUIUYRuIrh94
         Ha+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NMPWpykIwqzVnKpU0MqZGbLM8pCJKBxgV4mw17dHpGg=;
        fh=PJhBwxrC5FuhakGH6RrdfdOpPcSeXS0IJehVOYztiuQ=;
        b=HLEPmCjaxKQn2Tb/hqGmpwOT2gPbZz9RInnKae/KrwJXUilj39JNvMthiYvcjaF8a5
         NaxU9k/EQpWobkV3+TOUUqwfLaVNzBkSCVnwMQLj0AsWwUjKVOwrmPJM9/LdvYyWrfoQ
         VplWzUL+I3a6OSkqy2Dv/dN1mL5a8dFcAaRzpuqQFxL/oXiV2uUUzcPniZ4Qiqeykprf
         HKCsdReYj8zqL7q20gQ7tRKBwCVpqqtrZbWbJO6oquMIwXg0ABwMxlSeBdoqX/ZvCxAv
         oi25O/Fh5CnuW3HE8FSXo6n0MkZPmHwkHlTrvTUp+zCuaAUsKGhhvJh4lwnsCQwdIJpM
         QFlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770835075; x=1771439875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMPWpykIwqzVnKpU0MqZGbLM8pCJKBxgV4mw17dHpGg=;
        b=dD4Bysm8qx2oNt/ljYK2dY+kw68Z2xBUGiI0IXibgjRxcMEVvrlAUFoHXtwbDrscd4
         3bbAWi/WA7yXun3eogVkRIca5PJYESQuIeDF3pTW5GFXqt24PGzOq7OK+u0hiHrk9GGn
         d/BYnuxs5gunbHQntQ5QV5y9KiWksyLfJgP3dPiDJZI5D+Uzq9fQlzV+VVgNAUL1cVT6
         C2t26hPMMmIkLOGmPBw+Ko9eL8cvflZ/D4s5J14PGOmx9h7tZX9xLNviXi5pzhhMZkDX
         dvsC6t4X5H2tKmh0gmhUDoRB+bpRtAiIYFrn2qNaXoTlilkJyv+rWnRChdQF/jW7I726
         ZtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770835075; x=1771439875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NMPWpykIwqzVnKpU0MqZGbLM8pCJKBxgV4mw17dHpGg=;
        b=oG8pvMRaB+QXsd1P9knL5G5BALgAACzF15k783H5VtHI1/qVFbXXdEg5DcjD5F+0vb
         dajCyaq4R/ACL6FU07L1pZrQDs8x7AGmXFIrJ3nVcTqkFiT6e0YcDzb3vt09Q4dPZMfm
         xD48bHRrNhaIbZp828ecfv66BQ5iEh535tLjXBsJtfawzfk0x04MrhWd34pdWQw7673c
         oljC+ryto/2+ovH5snzCbBLN7BGgRp2Z6ao6HJsAhQoVP46bbOwxjKhSBqV6Q0+xCWR2
         sxMENm+M2NlIyF8ISLOl3bS3xo1cRcXNzNNmJVNV/92N8NevDU/g4R9fb8wb2VXAVNav
         3dHg==
X-Forwarded-Encrypted: i=1; AJvYcCUVR9ewStihDR6f1yfei8Kl3LDZYwVrT2m3oH9qkMeTizMb/9C68jD2gBTR02deJ7PQXpdy2z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwafzXEHgoh4393ewRtKZ5RpV8StXO3/qkB5Zdk4BJCnDuRMsiW
	8NeNkfGDUMnN+PLNE79/l6UNRY1y3l2yBx5bTqAKi1IieuDYIBqbkL+wbKyHzrlbQVYWSva2fvz
	z4bVrQW5ciA2KfBhtm5b/9Lb6jLDc4Rc=
X-Gm-Gg: AZuq6aKOfxJ0B47HPVFVWVIBSAj407dC3CVXe3Yw3zDT8xPIMwLnuPRfY+jueyNqt2M
	p2SB5Im5VmFzz50Y3vimq+moVt0gHxNKPOY8f7nr6gIC/NiwX80Xxt6PkPQgWj/pRYD3bWEDopy
	PyFNqEwPwsMnnHAlMj4P0NbZ2mXKHzkjPZaMOEdKAA0kkcAZ4pICM5pKY3vSyIqqDdmXMMytcbq
	wCGbUc9gfR+cyrAy85eVaKrjWSppyLkkxOS1lGJSrcUVMeAqfDf7M6MoW+Y/7WbW1MBHZrja791
	ZgyV358=
X-Received: by 2002:a17:90b:5211:b0:356:282e:7eb5 with SMTP id
 98e67ed59e1d1-3568f3f7f89mr227816a91.24.1770835075473; Wed, 11 Feb 2026
 10:37:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205-qrtr-control-port-access-permission-v1-1-e900039e92d5@oss.qualcomm.com>
 <20260206183657.0477e50a@kernel.org> <5b2fm4nbceqdmeu532vsr26il7jroli2sh6azcwirzm43b32da@grqzpgmmdvyp>
In-Reply-To: <5b2fm4nbceqdmeu532vsr26il7jroli2sh6azcwirzm43b32da@grqzpgmmdvyp>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 11 Feb 2026 13:37:44 -0500
X-Gm-Features: AZwV_QiEMEu8q-izEMqXgVPWSyu-zfy2ppyFTX5F5JMm-3LkhB33GLI1JN_qEvc
Message-ID: <CAEjxPJ4VA58rtSEEZpxeUZHMjURtrUbZCvV8kAkWwJaoR1YN2A@mail.gmail.com>
Subject: Re: [PATCH] net: qrtr: Expand control port access to root
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn.andersson@oss.qualcomm.com, 
	chris.lew@oss.qualcomm.com, 
	Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258338-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephensmalleywork@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0A0D126E45
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 12:20=E2=80=AFPM Manivannan Sadhasivam <mani@kernel=
.org> wrote:
>
> + SELinux folks
>
> On Fri, Feb 06, 2026 at 06:36:57PM -0800, Jakub Kicinski wrote:
> > On Thu, 05 Feb 2026 13:51:31 +0530 Vishnu Santhosh wrote:
> > > When qrtr is loaded as module, qrtr-ns runs from SELinux kmod_t
> > > domain. On targets using upstream SELinux policies, this domain
> > > does not receive CAP_NET_ADMIN, which prevents it from binding
> > > control port even though qrtr-ns is a trusted system component.
> > >
> > > Granting kmod_t the CAP_NET_ADMIN capability in policy is possible,
> > > but not desirable, as kmod_t is not expected to perform networking
> > > operations and widening its capability set is discouraged.
> > >
> > > To address this in a contained way within qrtr, extend the control
> > > port permission check to allow binding when either:
> > >
> > >   - the process has CAP_NET_ADMIN, or
> > >   - the process belongs to GLOBAL_ROOT_GID (root-equivalent tasks)
> > >
> > > This permits qrtr-ns to successfully bind its control port in
> > > kmod_t restricted environments without broadening SELinux capability
> > > assignments.
> >
> > This really feels like a one-off hack, but it's far from my area
> > of expertise.. Could you get an ack or review tag from some kernel
> > maintainer working on security, capabilities or permissions?
>
> I'm also not too sure about the problem because it looks like kmod_t has =
almost
> near root privileges, but cannot do network administration.
>
> Maybe there is a valid reason for that?

On Fedora, kmod_t is an unconfined domain and is allowed all capabilities.
Upstream refpolicy likely hasn't encountered a need for net_admin
during module initialization previously and thus doesn't allow it just
as a matter of least privilege.
Since you referenced kmod_t, I assume this is just for Linux, not
Android (which has an entirely different policy).
I would fix this in policy rather than changing the kernel module code.

