Return-Path: <netdev+bounces-256005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CML4GSEKgWkCDwMAu9opvQ
	(envelope-from <netdev+bounces-256005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 21:33:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBDBD11E1
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 21:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D295C301FA97
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 20:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBE02C0271;
	Mon,  2 Feb 2026 20:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBbfZ/nP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3A12BDC16
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 20:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770064401; cv=pass; b=RJXZIf5io0UZREgkkUf3qVb3PpeS3qLtARIleUEyFqEj+TUAE1F5wmfi85odgf5FZzGhokDbSsb4Fb0hyq6tIYdZizof0YR3dVByjRlgvmkuM8QkIxbNO9B95N0IuF1k3EJZqnW84HnLytxW7iMVHII6C2u+h8lw2uo0axft+YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770064401; c=relaxed/simple;
	bh=Zw33QJLuj4zDH1jnM7FwsEfVT4ksE2HRHBtT8OxgQ2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wesl659FdGe6Oq1DHWg7NVPSbuaJ0NyGOpbNT1yenPf9tBNMcWZzEk2dlBQsgA/7GhrgfTldCG1jhbpN5OlFbY20I0norZnkbQFMlaHVmr0B2e2StbK84Zb2aMqNVD3D4jWOGTDINlvuRxUKMDabvot3O3UbG2nkXgPRuUfKKYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBbfZ/nP; arc=pass smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-894a2309a29so1497556d6.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 12:33:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770064399; cv=none;
        d=google.com; s=arc-20240605;
        b=gmrd6z5QaqTq+tm7goXS987EqTGFssCpG0nDF5MDGLR0OgTKGbl9bxepG8giDmT1lR
         oaGXyNXOzy0RguPi2g+xshwtriMgRJYe19Sq8FYRVjup35eOZCtaOHntwTtvI+CqZXy5
         uahRKFnQdEVUMgIB3mY+V6fF7rAct6duztwEVosWwQRVAeBm+HUDLAkoiSrWViXFkHyz
         O3HZjRb3ot0zOdCanxGv9a4XpSzzMtZ0V1TnmtEvhxkUf7BNsZvg57USm45I394Y3YCn
         gBaPQr7GQ8YHyVMinHiD6diggiGN2+zEOmcNnSXDzLLb6lHu1nIrzkwD9wiVgg4hrOxT
         jxFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zw33QJLuj4zDH1jnM7FwsEfVT4ksE2HRHBtT8OxgQ2Q=;
        fh=y6LWFiVORlP+lzUcKcCftlCsuIQzxBo77dsk3Zu0X1U=;
        b=gLWZYDTbM/KPZcP3FIfRasWOskaQWU7gakYLW06+NyQtCRn1Li2KDrPaf1JZZ96VYj
         efxgsi3RN8ozLEz7eSK8x7m/2MuUXTvIvXEp6DsLS6xS+/l6ivyE8iEVP5hxAwGzJ3v+
         RAMFDmxPoL9t5OVvWc4bcjBt3+HYDnWqvUJKZUTG0hhmCiWSVIULkdGO5xRbzWSvBKKO
         5z6QUpX4SI0oN3IH1Iu5o/dLbPAAG8sQ0uzi/hat4o+mkovYVGyAjBx2SozEzgpmIla2
         +XtDc3LCWHP0ihOtN8ERFlzs4T9i10qcuDm03jEJqf1m2zWJTcGo5HfMQUCg3QwKzSGV
         8kzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770064399; x=1770669199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zw33QJLuj4zDH1jnM7FwsEfVT4ksE2HRHBtT8OxgQ2Q=;
        b=iBbfZ/nPM727rAHUVpxDEmU9ximHbZm2PZsukq+QQ6ysWqaAcE+pX4uF7bALK1g2+H
         6oVaWZ3ajgONPypjpjYReHAlmos1IS6C0OzzOqDrHPIilISJtcwMJbx/rmY9QU1o7OmN
         UXf0vh8pYTN56PWZSFiz4Jf09CzEShZ1jTeeP1MM3wZyNjdzuYpO6EinNFMXdmVeqotd
         jNpbm0GYZf9zOpkm5+y7w1hjr8DveNOGkgi1r8AsUNgR5QPOywyBZ8XRUO0j1AspDxc6
         CMwYQMAgfWAqPzblGt1LhOJ1bcjn/fWMIYp/cEnVDoZ3mDL2k1tNZP0ayDoYcBUPuL+j
         SlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770064399; x=1770669199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zw33QJLuj4zDH1jnM7FwsEfVT4ksE2HRHBtT8OxgQ2Q=;
        b=SMJqPXLRs8mwuXRHaZ98qY3EDZnjFYAqfiHZ53rit4/qQpz6eUR3hnrYjhCAvqK1z9
         ZbKKL/SPmmQIIaP5sjVxmnYyRo3PPtc+aQoD93mlKknu/n+ijl0Fx+17w86GMjkLdh1z
         smKY5HU2EwfTE3hlbArbw+inHG/Cpo6XpxV9R5QXF/U+5HnSkvMcQmCRE/0gY3gCd+Bm
         5zPkuu+/2fG1vqg8e2XTdvc1pZCKI5RLOPkBjTk2Fc7fM9k20briiUYyw/tGnCSx/ayW
         QxfypLIoajZTnZnEbl/yGXxOGTV+TM+7FcE4EE/bdXq1jsOnrpxh89DalZ8X/TabtFpi
         b+RA==
X-Gm-Message-State: AOJu0Yy7D+ujz+4Q99IIOw+vym+HohwNqE8KqcqzyHri1i7jtYfMLH96
	n0qYLHK/mVKjZSERKiYah1rYDdgMa7EScZFk4GMKABW+ySw8uLKS3lIrfiPLx+VkzeJcZ+hiwJP
	0MmG+d1jF8X/mKkEIunPDyRv5PdeDiIc=
X-Gm-Gg: AZuq6aK2Fd3f3U5ZaMmyt65XqBFFe7E4F7YFdDtvriOKvS/hB+lNGKb42FZyZFab0vx
	FjmvRmkgNkf1b/eNQxiWuDrccbXENt217RGoCr2za6A7v+Z2uGQ/hDSZyvh/gxpPamFgRcn3BCw
	sBrJ+GcYXSh5r8maIeK/7KT0oyrntQk48V+zGG9n6PN8oyMzGGDVjIpsDlRbIUIwtafsJTCTcX9
	ZpsqrjOpJSdORDJmahOxHbdIFTsebAzuk0M5FTSw8OB8keNbGg0dL3ai25bNiRh4MWE8VWBi1Q4
	ST/di1rckhhquJ9/n9j95JM98e2GsR/SdvWu9d8zV0BSIhUXuofsK3VV896KJG69cj6Rtg7qhw6
	nRPk69aXhT9PWsQ==
X-Received: by 2002:a05:6214:29ec:b0:890:2504:5450 with SMTP id
 6a1803df08f44-89518339570mr10555056d6.19.1770064399203; Mon, 02 Feb 2026
 12:33:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131004327.18112-1-enelsonmoore@gmail.com> <66924451-2b19-4a3b-ba99-16437dc79011@lunn.ch>
In-Reply-To: <66924451-2b19-4a3b-ba99-16437dc79011@lunn.ch>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 2 Feb 2026 12:33:08 -0800
X-Gm-Features: AZwV_Qg0cHrJ5V_p9yHhT8vkb6bWLIPXh8gwyXrWFaYVQlzEDDO-IwvtsniZn54
Message-ID: <CADkSEUjEYY=Wwyumv3Ft_T=xWLJY2hiy4uw_YMus=4o=61H+BQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: remove unnecessary module_init/exit functions
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-wireless@vger.kernel.org, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Ping-Ke Shih <pkshih@realtek.com>, =?UTF-8?Q?Thomas_M=C3=BChlbacher?= <tmuehlbacher@posteo.net>, 
	Oliver Hartkopp <socketcan@hartkopp.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256005-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,lunn.ch:email]
X-Rspamd-Queue-Id: 1FBDBD11E1
X-Rspamd-Action: no action

Hi, Andrew,

On Mon, Feb 2, 2026 at 12:29=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
> I could be missing it, but which module does not have an module_exit
> function?
None of them. That sentence was just to explain why other instances of
empty module_exit functions were not removed, in case someone else
tries to do that. I didn't realize module_exit was required to unload
the module at first, and other people might not either.

Ethan

