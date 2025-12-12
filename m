Return-Path: <netdev+bounces-244458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B969CB7F60
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 06:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3742D305F64F
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 05:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886BA30E0EF;
	Fri, 12 Dec 2025 05:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=christoph.anton.mitterer.name header.i=@christoph.anton.mitterer.name header.b="XHuac/0H"
X-Original-To: netdev@vger.kernel.org
Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1715430DED5
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 05:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.254
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765518082; cv=pass; b=h+YOsNB/gE3dRo1WnlhPJAUEJFGZAQbYeKJTaM6o49jZ2vtl+MzESIsNNN28ZpfhfYGXpFTirwdtF8rs8AG8mR+foemoo9w16MGSc/r9r+KMNneZPpIy2VjLi/scZ50qGoSap2iQNOIclygPxYzWbETC65WH8w96d4Zc1MHkHy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765518082; c=relaxed/simple;
	bh=Xam4KLwNnCT5p4zwNHheu9gxEKcdsT4BkgincsRtxog=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XGsnD8R2EH/DkjvEV5jiAXQr/uE+h6kbZigYxqDrHB0UsEHZ0PUV8eYA69m2NN3wEUFyBAB/eTOJ1Z/qDhjtNu7GEALKKcxb8nv/OMOFN+aKjYqfozeiGqSQu/m4WUISaA/OYDRKSPIBX99w1AcdKfswxGPDKcKwCwvWYRxxv/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=christoph.anton.mitterer.name; spf=pass smtp.mailfrom=christoph.anton.mitterer.name; dkim=fail (0-bit key) header.d=christoph.anton.mitterer.name header.i=@christoph.anton.mitterer.name header.b=XHuac/0H reason="key not found in DNS"; arc=pass smtp.client-ip=23.83.218.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=christoph.anton.mitterer.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=christoph.anton.mitterer.name
X-Sender-Id: instrampxe0y3a|x-authuser|mail@christoph.anton.mitterer.name
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 7A209181100;
	Fri, 12 Dec 2025 05:32:06 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-green-3.trex.outbound.svc.cluster.local [100.103.73.45])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5F58B181095;
	Fri, 12 Dec 2025 05:32:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1765517525;
	b=jSvC5+I566YAYowF6hCav+dDLreO4tq3GzAoPKBUrxJjUuW/RXKoxdORCfr3dzq+p+Otap
	rGkScR/MXBm9cmQTiaHDo12OywsNwwUxptui/gtQ19vARkbLE4n6+jpytdONpdfliAM6EQ
	g3phzP4X61QBE44cYo2TFkukrCUWoZgvT1IryeW52tgQlvaL5Aa0Kvl3XGPEZZ4zbyJ4nF
	VsVeL3Go5dzP4/kNAHTTVLRRvuy9oNKsCcnOv4VKSypx+6FT1njz4cEd44RAlaqw1eaJ93
	rg0KPi9J5HUSX0wKQV2QxsyUkxlRnFuzOdDtkikNLk0M8h+ycEAEDCVR8OADUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1765517525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=PH9wXsUD3TqXbKj06yZU9jtLTvNVlws+4YhuwrUkOT8=;
	b=PfkZ6gboDzRRB9MBefXc32E9MiytdEds42cHz6t2iCVPjyo4fQuKhDY7e0BDd7gzH+pKWw
	QHqzPh/dvfItaFiS9q3IXZRnwrNOS7Yn2tbcOeb/ooKDnVgAvsy2wbqfoACGDlXcdgv4kJ
	JFVFR0AVAuUbXedC8ITfVS1RbsLGHtwM7sYmo1y3SMxvFDXxQ61tmiGD4qWR19RL21HEud
	k2CrJrtEQDL+weZ4T9fzCMsVzXSrfanUYmlZyVtPH4lI7ZiVzptqWPzpqRqflT5rWMq0nf
	yN+l6QSVsap+I17l7LD6GMY9OxWyGjlZA1SeOivEiLCvHUAEMXBrYXgd/yyXLw==
ARC-Authentication-Results: i=1;
	rspamd-76d6f8d547-lsvnk;
	auth=pass smtp.auth=instrampxe0y3a
 smtp.mailfrom=mail@christoph.anton.mitterer.name
X-Sender-Id: instrampxe0y3a|x-authuser|mail@christoph.anton.mitterer.name
X-MC-Relay: Neutral
X-MailChannels-SenderId:
 instrampxe0y3a|x-authuser|mail@christoph.anton.mitterer.name
X-MailChannels-Auth-Id: instrampxe0y3a
X-Attack-Lonely: 2c8683b210533471_1765517526261_1184083432
X-MC-Loop-Signature: 1765517526261:3117638827
X-MC-Ingress-Time: 1765517526261
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.73.45 (trex/7.1.3);
	Fri, 12 Dec 2025 05:32:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=christoph.anton.mitterer.name; s=default; h=MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=PH9wXsUD3TqXbKj06yZU9jtLTvNVlws+4YhuwrUkOT8=; b=XHuac/0Hi1J/
	QFqK9wcI1gy0nO5BsqeOSXUyZzYzKQ6TJLDnz9u/Lh5WdbeUiH7WIRiVdhWbzVEWDdOyaQ8FcDoOA
	60AeA3IfHimGWEJ+POmy3qrnqFNBQSLjwvRBY5d05R6bFZ8sJMITkP6mL4rixTVK1jYv/dVPHzJGd
	fYJxNFUx+7jECm5P25YsKYYHZmlmKZ8q4c5v+xlpQ8NgxvWTnL9N0/ENoH4rbI8TQnyRDzPNTMOTv
	soBpKzezYZdCAUP5FUZxOIeahy6NQNlVSBvbVQsgkoOvNi202ZNLSnMgKpYOslE86DR0b/o6NuuuX
	lbzWLgPjdqvxku0mIQ/ORQ==;
Received: from p5090f480.dip0.t-ipconnect.de ([80.144.244.128]:59382 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <mail@christoph.anton.mitterer.name>)
	id 1vTvl7-00000006Uq2-03K7;
	Fri, 12 Dec 2025 05:32:03 +0000
Message-ID: <773ec4dcde71466157d82b0d8a6af30660a374a0.camel@christoph.anton.mitterer.name>
Subject: Re: [PATCH 1/1] lib: Align naming rules with the kernel
From: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Date: Fri, 12 Dec 2025 06:32:01 +0100
In-Reply-To: <20251212135523.432c07a9@stephen-xps.local>
References: <20251212042611.786603-1-mail@christoph.anton.mitterer.name>
		<20251212042611.786603-2-mail@christoph.anton.mitterer.name>
	 <20251212135523.432c07a9@stephen-xps.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: mail@christoph.anton.mitterer.name

On Fri, 2025-12-12 at 13:55 +0900, Stephen Hemminger wrote:
> > -		if (*name =3D=3D '/' || isspace(*name))
> > +		if (*name =3D=3D '/' || *name =3D=3D ':' ||
> > isspace(*name))
>=20
> Do you check that this didn't break the legacy ifalias stuff?

No, I did not.

Where is __check_ifname() or any of its callers used by it?

Thanks :-)
Chris.

