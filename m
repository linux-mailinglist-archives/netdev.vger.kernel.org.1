Return-Path: <netdev+bounces-293607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OK8lOa8+HWq8XgkAu9opvQ
	(envelope-from <netdev+bounces-293607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 10:11:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E022661B493
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 10:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF1903004D09
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 08:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F1733ADAD;
	Mon,  1 Jun 2026 08:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESqOeAc/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5133242CA
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780301482; cv=none; b=cQiggZlSbawADz+nc/fJ0n/ZwAAmzAhFPannEZGf571tjg6DurNlFFrUzoWc5QUrw8qYFlMJriLkxDQISvIMNvR45kEMQwVE5504Sl2uJ89kQolimmg9emnMIV/IpFYnomFl9nq0cdHUoCSoP7sdkjPXxgnu3x405Kx9X0CzrI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780301482; c=relaxed/simple;
	bh=cvwCnHXYYRupaGgT6OXDm5nRfHmu20ohTaIkIL9NMtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAYm1shqqb59RQqjhPt2bILu5xX2T6OVLXH8ncQviv3TrS8a67xloq6aJ8/g2d10OcCELhMTQ2p9Hx96HJRSSm+p3/BURbsqo0IqcRCGH1tQEtwK08ypPJ+KsLpf3XEmYEnKBZ3152xK88oDIIr9mnIQLwK49hXUfIFFHx6tu+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESqOeAc/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CE41F0089F
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 08:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780301481;
	bh=cvwCnHXYYRupaGgT6OXDm5nRfHmu20ohTaIkIL9NMtM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ESqOeAc/cZ7ZbpYZOctMwBxBwvPcWoQcoVKKAUYqwfnfrqJmsWp9uNnBv3AMq6pBe
	 Z7yUQZ41R4DtLlnRP0FVqNnqcaHy1wIAbat+esnxt/l9s5/rOipgWiL4sAN2WSqVrm
	 tE4wUwbjxyWfWls4bo7fJoX9UuQIdHhCBQbGQ+/S4gSADRaoAahkhGJwRbTwmme3AG
	 i2aJlzsyz2JxWJK+stiLPBGsyWIFBT7E8L+sge1aim/Q1IWhKESjYxy9PV2qVLLkCT
	 SVMkrbc8tK+pmp8J92kHvGOUXsUyznPCFmI8BV6CwQ3wtnP3FC8sLizsN13sEAaBZd
	 1Yb8AnEqWu0dw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aa610cbd9bso1733905e87.1
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 01:11:21 -0700 (PDT)
X-Gm-Message-State: AOJu0YzcXwpXkgAzTVPbTGpMLeSkf24s4FzEVmXsfsw/2hvFcem2dACG
	pPS0NTbDO1HByV2BdfG24rIusfd9wsWhPxn0Eq66dZayQk0pb/RjGFEJ1unuOmSJTyVnzAoCGzo
	vno/bkyO6SxidNIQNKWuET41f0tjv2TU=
X-Received: by 2002:a05:6512:31c4:b0:5a3:ff48:f7d6 with SMTP id
 2adb3069b0e04-5aa61425d2dmr1909482e87.13.1780301479851; Mon, 01 Jun 2026
 01:11:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526-ks8995-to-ksz8-v3-0-c530f651989f@kernel.org>
In-Reply-To: <20260526-ks8995-to-ksz8-v3-0-c530f651989f@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 1 Jun 2026 10:11:07 +0200
X-Gmail-Original-Message-ID: <CAD++jLmXVKz3rUTAauohfHOK6-GGkn8__Zfory9AW4t4_M08XA@mail.gmail.com>
X-Gm-Features: AVHnY4KOb-KcbmskCyjdRMoVJ177wKi_qKWA7G6GEqxIRgG_y6tYdsfvPOahOWI
Message-ID: <CAD++jLmXVKz3rUTAauohfHOK6-GGkn8__Zfory9AW4t4_M08XA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/5] net: dsa: microchip: Add support for KSZ8995XA/KS8995XA
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
	Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-293607-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E022661B493
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 5:59=E2=80=AFPM Linus Walleij <linusw@kernel.org> w=
rote:

> This series breaks with the dated attempt to polish the old
> KS8995 driver, and instead implement support for the KS8995XA
> in the KSZ driver, and after that delete the old KS8995 driver.

Sashiko is only finding fringe stuff and hallucinations now,
I think this is good to go.

Yours,
Linus Walleij

