Return-Path: <netdev+bounces-297685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Rx4sLTdpKWqaWQMAu9opvQ
	(envelope-from <netdev+bounces-297685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:40:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B436669D40
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:40:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=TyqHQ8lu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297685-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297685-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C6B730A3F3A
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565373E4503;
	Wed, 10 Jun 2026 13:37:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D903D8128
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 13:37:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781098663; cv=pass; b=HC3t/M1H/zBlNoV4zt8Cl8GVoO7alhnV2DyMyb+n1OLBcLscDO2rTd+iVWFnteVCsOqF3qqcoYGY+luG+FeB6PGHWgxryhCP818T07R2Qey6n7iKxNwAJ/qVy8/7qBl9RdLFLjConYIOXjYr+Vcf9Vz9tRHqZYE2APDtWHvOi04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781098663; c=relaxed/simple;
	bh=VEAtOHSeCILe9nmhAhgM807kAtl+38tXEbWp+hXpRK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VR05JD+PiFyNw3QG0iARTjoQRSWyzU27z5TRn4b6jC3ID/YAVcG6U/qiuwcs0RWPDMpdz/2S0c3YawgtQCBjtDOZeZUeLUSrzgiIa1z9ggH72UoBre1etDwtNifnzGXwAw+viFfE47+qOd+y2RD+vcpFtGGK6FEClGFxlkmriNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyqHQ8lu; arc=pass smtp.client-ip=209.85.161.47
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-69eb8b6bea8so570431eaf.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 06:37:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781098657; cv=none;
        d=google.com; s=arc-20240605;
        b=HYf17CZvpo7Wopn97ZM7Lg3zbsQr0uO61oGQpOqT/kD2hSd9BWtYZn5+D2ZF6mAXax
         W5I7hEL/ziADiDrHVrHw0eesh5oqND7M4GlDSC7rkVuLqZoAcVkdXPdD/a7U6fXAqtLP
         tZKf0g+6c/MFrhs/AOZmFj7Woq1UjyB3r8AOPQF3Zmt8jEYHQUoIxGLfNIMnwtC6Gysk
         Sw48c47Pf6f3+5H35WrtttK/EsqufNfnEF6Za8G+KPMQ8SN76e1Y0Of7wqJKwPeGaSrJ
         pqlU09h/Y1l61Cws0uv6pi/rUCrBU4G5wWAb+JP76CvS518/DmaG2V+bzsg44YrqQm5B
         sfnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ndQpbdvkdgycbhNqFO9kgiT3WB92TAhq4B5U6TOyRY0=;
        fh=1ffhz1LCn+XjckKwJV4d58j3PNJFvGXtZYChy/J7jCo=;
        b=PZqGVyc1V8KBU4jaRLWitYcDEkUmLWJQ2nQMKGtlOx0yxHZcNamCrBzsSwcz5hJWgF
         qNIsFB/p7qFoD6J1shw93PZ+ZeP7D+O++dusKaf1vB5rCn9YTVkCRzYXyKgMIy2yDXw2
         dX64k/OYYNfh0kFVHHkYOawflY5Hf2HNFZ4o898c8EAQ5UTB1phJbkc7ZGSo1mX30vgd
         foyF3C0t5Db2zyA07prFMacYeM887xEJuAl2aco9HZcm7nbLD8A+FTrbo6dmF90qXSMG
         8mO1d0X7NOcu9icWXQLo5qbWMA8oSFXZZclMD9SFyvidiQOU3iARjykNLYBveGei/7YC
         ugcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781098657; x=1781703457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndQpbdvkdgycbhNqFO9kgiT3WB92TAhq4B5U6TOyRY0=;
        b=TyqHQ8luvH5QQ7Ft/yN5GKCW9WL6sTXylCiwdGmFLGWPv7GtmSuc/DFFWoIH7lnvR6
         CAuXrsdEFeqRvvaJUJax4M/w3CHpeWRxgEFFudgGr0d0tOFEaUycVyh7zVFRnL1miUQm
         0UDUDzndGGPz2PHknYet9l8RDnNFih5s2Fp4Hb9XcP4/9bVJMwQiJSR2aRRifx7XwNdC
         EaYh05gS15VqovJHXoZUKKHGl2iM82e1+ERgE2Wmwz+URqTC+3ANKt7qR/yH7MN2n/TI
         gVeaPealohVXFbZN/3C6OtGBIGdSS/AigvMQ8WH8useZri1RWwZDLoslTuIBKOtS6nzm
         ovWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781098657; x=1781703457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ndQpbdvkdgycbhNqFO9kgiT3WB92TAhq4B5U6TOyRY0=;
        b=ArNKR06KMBwNNzihJ7mKMyXu2xh495/3bLPOVhBv491xozNeXfTURKh/5mJscXAPc6
         CgaIubVPqKU5pFnEsYV6Zq/F4VdX8OCkChMpVyGd+3OHOETapxlo3Pv4BSnBIic6ola0
         7Q5qz5eKMSzLF4dSuklovrjXj1DAY0HP5HoaSMRIbmZSm+hL7wVBn98d/FCnN6vaa6Sp
         bK+8LSUwdbYpgQJXqn6FRAQEy7g1DxvcQRLOUMHzc00nKkGdMYU7eK3Sc8SEH0fmSb85
         NZ3KyCZOV263sKdolUUav/W+noS7nXMZY3OokQniibJqP7DRjKK7Za0LnCg5+PxjWA+N
         zPMw==
X-Gm-Message-State: AOJu0YygOFO8lpCZthliOOsLFF5X/gd4/VGW7p0hF3S/lV9xPCVbYQ4F
	d3osCgqV9gG6sBpDPkg0zW+85S0Xisr73W4m8SjUEGl12Reyyaa9MSDlfpE4h0seuNjGImFufOv
	U1Ph6n/rhAzFUr4egKELXOiesZlhmQYY=
X-Gm-Gg: Acq92OHbEYDBJwZpeHTkSd6Nir4jppewdcF6nlPk6wvYq5PCyciDzEZYC55gJh7152/
	oQ1CLjNMHyBnhwp/jLOARmVxNNc6aPZQ9Nh8cm/RjVmNqD90M8ylxBSXC5snclaz9rpUVdzUXVO
	zV+pJWYeYJNWNbQmB/O2zcXw3VmRQd0i6ds1jtWSWsoR1JH4npKrhWpwqF7+/dkE/Y8dRxlWl2o
	CAO+LgwQtiV9dZy9gwKUvpwbAIYr7L1PPbR9BkBnXT7t3oTBAJRkJFadvmACfFjEDg877eUbNzR
	pk3G6XeAr8jBPvDrVlM9VP0+ZXGpbdfEKr4iLv/tD8a5S4ShiRst9EgOQ2PB
X-Received: by 2002:a05:6820:82b:b0:69b:196a:de67 with SMTP id
 006d021491bc7-69e685faf92mr14061388eaf.0.1781098657451; Wed, 10 Jun 2026
 06:37:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610062554.769892-1-mmyangfl@gmail.com> <53211107-5f22-4ea6-8374-b70317b9b2cb@lunn.ch>
In-Reply-To: <53211107-5f22-4ea6-8374-b70317b9b2cb@lunn.ch>
From: David Yang <mmyangfl@gmail.com>
Date: Wed, 10 Jun 2026 21:36:59 +0800
X-Gm-Features: AVVi8CfEUAix4lJwWHGZ24ZQrGP-tC0lzZCqTqyp4h1QCYWOmWK6_DQP1NSIH2k
Message-ID: <CAAXyoMNjX5rMpcj2N-WTkUD871tp0-2ceaOzMmUdwWSSGG6J4g@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dsa: loop: Fix devlink resource ID
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297685-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B436669D40

On Wed, Jun 10, 2026 at 3:23=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Jun 10, 2026 at 02:25:45PM +0800, David Yang wrote:
> > Fix collision with DEVLINK_RESOURCE_ID_PARENT_TOP (0) by keeping the
> > real resource IDs in enum dsa_loop_devlink_resource_id starting at 1.
>
> Please could you expand on this. What is actually wrong here?
>
> When i look at mv88e6xxx, hellcreak and b53 it does the same.
>
>      Andrew

dsa_devlink_resource_register() is, but other users of
devl_resource_register() (mlxsw and netdevsim) avoid 0 explicitly.

In this case for dsa_loop, the usage is semantically questionable (0
being its own parent) but might just work as well. But it is a real
problem on mv88e6xxx, where ATU_bin_* are in fact registered as
top-level siblings, not as children of ATU, due to ATU ID colliding
with PARENT_TOP.

