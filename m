Return-Path: <netdev+bounces-256717-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPiXNWZUg2mJlQMAu9opvQ
	(envelope-from <netdev+bounces-256717-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 15:15:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CD7E6EA5
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 15:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3D42300D97E
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 14:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3A040F8E8;
	Wed,  4 Feb 2026 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NRowoT7B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320C326F28D
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770214334; cv=pass; b=qqxnQ7+EQJcOYx/xUckm9vUhwLloszG9YdY81S4kLfES/K+9Op6YoL+rFqpMggg8z56v8mZhHieK6QQ41RvGjVKbQOf0ft16OrLc1AVjlIoi7ZxiIQBrwz9xLcpWKulVLLrsUZrLmquCLd+u8iDaQQue6qCi9avqGAAgKqvP3ZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770214334; c=relaxed/simple;
	bh=daKzq8PGe2wr5snGZ+XgZwIWyg5ohf/5cYZHEIAGqDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=COKtQodLcQNSRjnom2x+as2RXaN8+ScqWzHZ5NAzWqb4Ofg4mo9KpiAPXP3gZC2rFGK65p/mqUfpsw5RcO+AtG7hmogYglb+xVIrIy76tpqF1YXlO/yBKKdWy4P2G4HsHmjFcMeCHnfg5mVFDTh9SbQ0iJD2eR+UhnMshf/azVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NRowoT7B; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59e0d5c446cso8207671e87.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 06:12:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770214332; cv=none;
        d=google.com; s=arc-20240605;
        b=RkVFyetc9xyL5LSiVXx17tzdu4SuKcpkAfdQkU9zt4g3a12jQwC8Lx8Zw0MuKCGTIJ
         9lXzQTEOZAlvXxrIZS1ss10rlrzO8HaZ74Q0SSD0l+iOI95FeMTUlvfmlM8RZ92LEolF
         XaEAF5C7oUEhsrSOUHfuVdalQoKlFdXW3DtZIV3r1mYL4TgL9DK68R4yH3xPOvJJPRO/
         9XWLq4xp+68IKQcLN4F3kx1QMuDKvGCbYiH/mn7MSrCBNdECvDkLnvy8djlttRFsV7lU
         G/UKKMluuHvBhjxIH6sLnIQBKRSRv1UkWzUBG20uIRTi2sppe2G+lhDIbVyzyCCURiF9
         RkqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=daKzq8PGe2wr5snGZ+XgZwIWyg5ohf/5cYZHEIAGqDo=;
        fh=SrgPo8ydZ2arWb20ItrlygCNLfwFngMwWeNc6tua8ME=;
        b=FcKJYHrS0ROjs+a0ZNQZ2Jzn2Vl8f9Ahyzq3UDZwZz3iifAxlbwSmvzGdzCIKallYS
         zQjh5+sVTsMU3BNR8qh7bQq4cZiI+GIb5bJ1tlWLTZx/DCNwCFzPv8aGcHehw0p5mBBf
         o5+zJif2FgffReepsaDORWJkvWP/cQ/9Te17IjJcfF02pbnzWxcdSQKi+HnsYGoQz+f4
         WCUA9mKFtzXoB3LVy19FscZIwqMf+2B5FZSiLJ/ZcTGaOuFzlQFW1RjHiTN4pvcr3Aqu
         NvSTsSM4//jbVBYxr4Q2kmJv9cLJ2VfivuDIj69h8RVp2ovS5KxweuA6123WdOo8cw/I
         QrNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770214332; x=1770819132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daKzq8PGe2wr5snGZ+XgZwIWyg5ohf/5cYZHEIAGqDo=;
        b=NRowoT7BpW7BOc/J+LLD6JDFNcb+enR5YJXKLSTjAgGi9T17UkjUTfhB1+IK/lwCW8
         lxXQlxwLSw7FrQJt6DSppKXLq+s7hnsfP3VLB1X51F9ZiBjKXwGpAqaJkHCoA+3uMgR7
         QINNGIz2uJxODC9iA68VzlJSiFWLcSs8uVpIzmCJ0kqOiioGJ2cIZYwLdtEPz2RiLNBy
         3Lmj0eKacDfDadVK/MtCSM5qn8+O5cq0SIWMvA+zwOi94PTg+UoTSD0S2g4CNRI04y7K
         ls16/zDxfP1axccBt9vkOneuj1zkA7sO2w0zGi2kJAZ/4t9d575ubACEWUgYUYO0DOkv
         ddow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770214332; x=1770819132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=daKzq8PGe2wr5snGZ+XgZwIWyg5ohf/5cYZHEIAGqDo=;
        b=b9DGa3NNyZm9mauqnyCBHw7hbYkv/roFzDvZ8aTmvn7sgCtNx09lxYtu6ulu6xb9uS
         3YT7euiUJMvPMdTg24mN36jiXCQSK2WlArlEV51LIZTkBCLtShuP7qvTTbhuWm96J+A1
         8GqxZkYbcQg2b5Pe94Cpbn6nB1v+gC/dkIvR38h9EmHJ3E8+yBo3YXsIJ4pDVmoJSV+N
         OX9v2LyBRH+T7HA92yKPAEXzTkZOxMjHyAwxJZN+OzTTj/fyknmradH4MWKotVbAzese
         vCx4yDftrs6u6EFW5TRcOJTxk7aUh5COidMpOKAiGygeUipFcZkTHNK9n4dVPeUlGhqo
         MMhA==
X-Forwarded-Encrypted: i=1; AJvYcCX0WM6YrcwNBdJmv2H2BW7DwSh2+mdKAzHRsjVpNVmRlz21CDQD7vgcQ+G+fUyd4HqAwsTgEkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzES8jer68ZRIpU6mOuSpzHoaxjvzzxEeRTc1XLeEzUL/GSQFVK
	Cyki1USb3qxt6KhZRLCy7BYMp3pMZenEg3XNGSOV1D8u+RIMweO/UZ0mMI/3+ZkIXYBTYMZ1NSZ
	KOZdCpsf+HgA4iKZ/Huv5XgyZNTW38Nm0BwO5S5Nd1Q==
X-Gm-Gg: AZuq6aLb5liPxT9dqIMm92cVChGfgdtkJ2/bW83NR6FxSlXQh3O0o3qpouaW9dPjoiO
	Yhp7fx3kF7RI7ZUGi4NCQumjwO11v11dUzjGof0qrAeoEtJRQLk4kb19uu+SPzMy+HUQgQ/DrMY
	tMTvDjnPQqBTBRrvM56tvnI5QF8kPSaHdJLdAOy08WTlGb9K58PE/HJmA/kRJmSrbJ6/1QXqiOT
	JjY2rcEoUEA2t+7d/hL0Ae8rYeMGTKwf+Gbl9fYiWfZNlkkNataymsXnQYRyyW2zoXmRmtlYQxC
	tTQ1g14Sivz3ofp+G0DdPyglAYf3
X-Received: by 2002:a05:6512:685:b0:598:faf6:1009 with SMTP id
 2adb3069b0e04-59e38c42802mr1081291e87.53.1770214332342; Wed, 04 Feb 2026
 06:12:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224155006.114824-1-marco.crivellari@suse.com> <8d597858-a3e5-42dc-8289-2b74cd362d33@openvpn.net>
In-Reply-To: <8d597858-a3e5-42dc-8289-2b74cd362d33@openvpn.net>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 4 Feb 2026 15:12:01 +0100
X-Gm-Features: AZwV_Qi2v4najKZBQDm6bFsGfnUDEINuFxkro1_HxfL4IiCNTcaep8YGOOGJUjc
Message-ID: <CAAofZF6g57azQfytYyKEA8H6q1vdc9oWAMU8-eA3Z0Jb3mQ1dA@mail.gmail.com>
Subject: Re: [PATCH] ovpn: Replace use of system_wq with system_percpu_wq
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	linux-kernel@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256717-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,linutronix.de,suse.com,queasysnail.net,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvpn.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 38CD7E6EA5
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 3:10=E2=80=AFPM Antonio Quartulli <antonio@openvpn.n=
et> wrote:
> [...]
> Hello Marco and sorry for the delay.
> The patch looks good.

No worries, thank you!

--=20

Marco Crivellari

L3 Support Engineer

