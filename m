Return-Path: <netdev+bounces-284500-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALo4MJ8V+mntJAMAu9opvQ
	(envelope-from <netdev+bounces-284500-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:06:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8441D4D0DFF
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 04987302B04A
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 16:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BA148B39A;
	Tue,  5 May 2026 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TXITp4kL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEB048B36F
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997149; cv=pass; b=e6GPfMYU6FWiguX7dWJVK6xn37nmZm6qW+3+FXpd23r/HwAvIjTPHX8XijNSDUGVgjSWdiqJ27fshrMX6LOkqM0I1rrzrzbMLAzEv4utL0SCv4zfW4aOMI9RhWBdJ/GrmTZuYbeJHw/2bBzdNq+9GvkE1NGMv5gAuFNplgq2UEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997149; c=relaxed/simple;
	bh=J6ANT64o73Oy/MqjWeiTVaKBLJandxdhBxQ3kDb+K3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EI6Z5ntDCQOThUI9fRMfxPRTCGgsMCojJsBrAtHI0ZOQnwl7MV10bDYoqhTxyrL/ykyETzmO1WXxhuHSlniiBtnOFGCHdzqDUY+2BbxE362bKxD9cHvh+mYL+bSl+H1M3Fu8ZMm5iqibau9MZWlWrIul3FuEUFSGJM16JREh0GI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TXITp4kL; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-130c653cce4so1537434c88.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 09:05:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777997147; cv=none;
        d=google.com; s=arc-20240605;
        b=iwzYopwgYqEyqC2cQKqn3Cwa2T+03KaCFDypTyrq1u/lntONL1KF+TUwYeJgGFCHFY
         uo6bgl1ZK1H2e4zYjxnBoiJ27F/HYStINKDzP74yCLlXhnkJ8FE4/FHTcmreVLfLG2ZC
         /2S5JKuW2N8q64WvWQdvnD37g5AnngsqSYIeKcBaTF33p6gJLIiO1GmBrBG+IJXVqe4o
         qXeTKF4kSPSYMJEPWkNQTsPZk0z2KRwh8gWG6pi4lCOrhuZM0JDm11fA1YcAJyVD2MzH
         V7cxsBorXWvtjt0VWO8qVcPeCRoApdo6LYhLP1GUOiD/spLq5f5OHAjM3slDAjAgx6UA
         zMdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jr+WQFKJTcHJZ0sRMLiTHOm1qsMvrLUcWME2L+LwpFY=;
        fh=v9brgHMdAUtMj4y7B+xYMi5uVezbOn2TcuGa9qGrP2U=;
        b=fD/tHCAb60ZRqQ0abs7aJ4ze8OYShcLuM44EqArmXoYx3DaK24E1zYNMBmBRrcuDIH
         IGcbM5LftwNpnOLGmJmKs/OFVi4en5iMyDqGlUaN3nfiHaxVJqcnoAi4BJsqHoiISb3P
         pc5z+/JTBawaZdZ2jtuI9MvlSrCWnlqH3BwXsUaQN92bZtpdX8vBgGJYvH6RUay2kEvX
         7rQSpx6RLqwG0z08xyrnTsMbo912xNjIAxbHHpCTHWKrxCtRM3g8F52XDt3qEIpmNhmP
         C52GooAwUfO6Qkf18Pzn6wwZzUxICdxkT+TJ+U1/0CXw2ucoTFmj2frKi/Eq6p5ON4Gj
         y4tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777997147; x=1778601947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jr+WQFKJTcHJZ0sRMLiTHOm1qsMvrLUcWME2L+LwpFY=;
        b=TXITp4kLzGaLEQ2tD87iXCniwLYk0Hoh67wTjG6eywIBT8W8M9bYjQuTxUtBqXjcnz
         Z2A0YG2LTUTtYeaxAqFcvAPxJN18EGASAFFdhU+HBfELiWbMX1c5fXYpKnv8xPnHDDqU
         0a1zZoY8i4YZu58ZThlZJuMMvfXkFC5jFwPBRaNr0E3VFzQ0y8nuZum+qTbtSVodOz7s
         EUWJQGc2aZttD9MmCEKR5WUmXgNW88yJdHSQHO2Q0kd1jZKzfvrL4LHqBhEEgRkG75zC
         bZ4edVIte6ee4zBIDibknoORQmZ2R2BIy2irgABosj6PQEOXV3cxTH9mAqFLzuxmET+i
         8TMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777997147; x=1778601947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jr+WQFKJTcHJZ0sRMLiTHOm1qsMvrLUcWME2L+LwpFY=;
        b=jVlfpkaYBviVrCCwBwenZBTKgeQLBfF4syWE/mRrOiBXWsC1T8sQeZefBxd8VA6i2x
         7SBFRTZkHFxrRKiG7lYQM1fxWLqkaTJ5GpAY+tBdF+kDfSP4xmXDxvhplYW/AO3GAjYj
         gp8yyXY+z8t1fP7A7l8RN+r142SHNZAHrS/ufrc2IdQL/czNQ1XVeQ5i/7HqoP1PE1Db
         BPklF73azg9PZ7eVWjTjSeHqjmvPf/rsyO7cH9ejP5sY2Uj2wvPlFNIFcUO3Gd29C/K5
         PNqDjIhOPwSdbku/ykR86Xp+ir/kqrNUwWfDufNQO+QqR0bkdAZ35a+ZMmnGAh8fNYJG
         H2Pw==
X-Forwarded-Encrypted: i=1; AFNElJ+ESKnxGlnXH289iZw6RiagyZtCfWVQb9Yp/2DsIehv0oYKomXC3slAWQNb//aqdE3OQsQD4is=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIjROHbUJS/XRizJKK0ExIlU3AXJldWtjoCvqAn4i6xmbj9BLF
	N08Yc4ywyTGV4my2+uOJ8MH9uHVVA6Px8003Vk7G8yrDQ+JVY9XidGUrsa26+jH9U0V9OoeYxgY
	7Ze1TIzrvSByDwNjvoDHmymJHmzkXznDdJxOxV8g9
X-Gm-Gg: AeBDieviaiYDCfJlrfwCOX5j++JXUSXMjVq/IBGuxCOOQft6GDpykr0kxLDGHp2RZ4+
	PXCb1wxcI8ehSpy6lAI7WNUvz2pIrEo0+joi0kaKxnbDgsS01PnMNsdQQabliZxjXsJhvDXLRFP
	N7yQpD5IQRl6KXg466ojGmoIhWwbEZF8ArUlJBru9BJPjeS/KsyNwtBBm8lbuhOhZJE/3kJOTBy
	dA9a9J+QsLIh2M6Yiwa+y8alcFJgRH19uEBTxxOuA1dDLFuthHde1YA0reqfI3h6dGB396d+kvW
	SOpNNT6/17VUAVRQ5EtbFwFRG7HPnMWAVeBAe7T6
X-Received: by 2002:a05:7022:6628:b0:12d:b214:7dbc with SMTP id
 a92af1059eb24-12dfd7da15bmr7713863c88.7.1777997146733; Tue, 05 May 2026
 09:05:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com> <7-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <afkH3pMJKkIbElhI@google.com> <afoSQWreOWDIfVxZ@nvidia.com>
In-Reply-To: <afoSQWreOWDIfVxZ@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 5 May 2026 09:05:19 -0700
X-Gm-Features: AVHnY4I9kiI4Q1jkqtdnHvyGsFiT-Xosh4J8OR2OjxYfYINDrozPSiggYWTK0ps
Message-ID: <CALzav=c2r5cBSpgnG6-Njc3sGrrtt-weFXo1pRUL862SdK7w=A@mail.gmail.com>
Subject: Re: [PATCH 07/11] vfio: selftests: Allow drivers to specify required
 region size
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8441D4D0DFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284500-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmatlack@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]

On Tue, May 5, 2026 at 8:52=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Mon, May 04, 2026 at 08:55:58PM +0000, David Matlack wrote:
> > On 2026-04-30 09:08 PM, Jason Gunthorpe wrote:
> > > Add a region_size field to struct vfio_pci_driver_ops so drivers can
> > > declare how much DMA-mapped region they need. The mlx5 driver will
> > > need ~18MB for firmware pages. Existing drivers leave region_size as
> > > 0 and get the current default of SZ_2M.
> >
> > I would like to get rid of the magic SZ_2M to make it easier for other
> > tests to use the driver framework. Can you make this commit update all
> > the drivers to set region_size? They can all use the same approach:
> >
> >   struct vfio_pci_driver_ops foo_driver =3D {
> >           ...
> >           .region_size =3D roundup_pow_of_two(sizeof(struct foo)),
> >           ...
> >   };
>
> Sure, lets put the roundup in the core code?

Sounds good.

