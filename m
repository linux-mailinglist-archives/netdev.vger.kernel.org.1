Return-Path: <netdev+bounces-254033-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ5dKLdCeWmAwAEAu9opvQ
	(envelope-from <netdev+bounces-254033-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:56:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0459B480
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A12C1300C00A
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 22:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB232DC76E;
	Tue, 27 Jan 2026 22:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqWEf1Ex"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678C12EACF9
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 22:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769554612; cv=none; b=smG8EdHif6HtXUUc7V9JjXSbdjRtCcSpKYgdKDsgZ33KsWPap0xoLwZ8+ONxqWljnxPokt8nkYgkSC3rxBgm+oW9ZggbTPE/c3kE2HkyWPE5AyTcrz4VANfnhbX9j0OisWoujYCynYzNaMmLjiVk5bXrDkzZIrb5oIguQ1wSs0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769554612; c=relaxed/simple;
	bh=6vaafjP0Uwb9/080lF02t8LDytLkowHMim8pDa81jso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ML0RnKnf4OTrFd+fR+2nYJmBE9f9io61tOcLLjGvk/HBUGU3G2gWt1buE8QqS9pK2IMMiqemsfDtqYmBg0MAV4bvkBuDn/6NZAfFOWo43Dd0uSy04y1CL2uIwpHmcu+pFZuUghv8KIH7d8YIApeYVeZEYy8y4UUrUUBmO4nrtdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqWEf1Ex; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-432d2885c85so678722f8f.0
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 14:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769554607; x=1770159407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YJj3rkrCWGO4XsqbS2RQcoD9sLDEl4QbuTlyvB/piF4=;
        b=kqWEf1ExfgqWjQwDLkioLUA2cNmyAZn38A+Gt3WYsSaxnL1qsLV18FlnfIvZXcjsaV
         E+Q4PbZDL9jd8BXSh0DF63GfOguP1TrvEgoP5Wm/E4GdTimzcg2c7fqTFa4fFdOu0u2p
         EK9NklqXrhrB2wQualKWSXHtFl0e8JKSoYq+oLzUcIAblqABypCAo0KsMy71aQhP/lzP
         A85lcVE6nPLFIl//qBBesYjIJV8WhQAe4O7T3esb36SbwhKZzZKpKmx5qQ0JZO1+FH8X
         SH1V7SSqWqu5JdEXkSNUs0b6seQawTT/CpkQFg7wzk5PYrzayTG8TeeFXXges4reBzMo
         gAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769554607; x=1770159407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJj3rkrCWGO4XsqbS2RQcoD9sLDEl4QbuTlyvB/piF4=;
        b=ehHl74RktATCIcYW+CYWn9Nu9zG+SGBJwfVQ7qrca9uRVsgq3p6zjD1PFuPxzyBWSc
         rGxC5YHQzOHZdo93P/b4Hmiy5foq/fBjY6upnGgKryEweb/vMQTPoMXRA2uDVMcgUGZ/
         O3PoaKyKPPoYjz9S0Cg37LEtCzTxEXzvbqNAWNhvxQ7lNoESEhXtrAiMZ60CWeVMCB9m
         WhQc3S5Q0g5AN7JC2l3ns09EMwt788NjWElE/r4cKOZ0cLqcwBqGQeoWwh5A1HrxtR7p
         4x+Ix09GmTXDGjNHap+ORkqAJnAjHL9pXSbg4+vmj6nnvGqWLMK8oVs9MR0pmOPsPWAJ
         Dk7A==
X-Forwarded-Encrypted: i=1; AJvYcCVxsxby5PnQ8On19tZ5y86kMlnAY68XKA4je6Duav27BM6QFaJZCyaNWlIHyt12vUvXmkKik28=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKEYvur/jrvpdV4FHs5qcjYrxKPCNlLRqrp2IAtWVb3iouBVtI
	Dh50066EH8B7mx48TTbyFUTY+zQct/ijLPc+ZQRdl0vZsC83BOkPB48F
X-Gm-Gg: AZuq6aIDw6hR+6Vba3YTIHOuukdeEnI2liF5jNi6GnzHRim3cqj2VERdqhsO2kfESig
	XOvHJVHC8k3d9BfYZB/UUbQtojevMHyUTbbzjBq9RnbyoXjXumXIbWshxM4VLzn7JN+6jM8qlah
	wXRxrUmE7c4vwKYivIZkmob/F1q4qor25b6ns+wLT0Ql6Z6lBzs5Ds2aGveQVh9q7D9E6Ae4Jc1
	RnDE+vhGWwzrWircGOWWZQtQoO6jJE7UwlIjZikhongbVAXg6pe0yND/QMjWr+8BKA7fzEEDloR
	djoqFkgb1Gb21xBvdc9TJToDVJRmWWRIbI4oGGdqCddcVBC3TMOx99hbJ+A1GQxU4L2EzqHaPDG
	6klRyRvOJVwZzAqdjmbB/6QzoZpBVqUO5ar9yygwppG8vFcl38aWQWAXg9rnPuxDQ6QBVFcUkaP
	Qa8Q==
X-Received: by 2002:a05:600c:3b19:b0:47d:3ffb:39ed with SMTP id 5b1f17b1804b1-4806e5a17b9mr2102095e9.4.1769554607085;
        Tue, 27 Jan 2026 14:56:47 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:6c51:3f46:e918:f0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cdebf86sm19928945e9.8.2026.01.27.14.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 14:56:46 -0800 (PST)
Date: Wed, 28 Jan 2026 00:56:43 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v9 0/4] net: dsa: initial support for MaxLinear
 MxL862xx switches
Message-ID: <20260127225643.qe4lpeyjmtl6flc4@skbuf>
References: <cover.1769549559.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769549559.git.daniel@makrotopia.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-254033-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DBL_PROHIBIT(0.00)[0.0.0.0:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C0459B480
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 09:37:40PM +0000, Daniel Golle wrote:
> This series adds very basic DSA support for the MaxLinear MxL86252
> (5 PHY ports) and MxL86282 (8 PHY ports) switches.
> 
> MxL862xx integrates a firmware running on an embedded processor (running
> Zephyr RTOS). Host interaction uses a simple netlink-like API transported
> over MDIO/MMD.
> 
> This series includes only what's needed to pass traffic between user
> ports and the CPU port: relayed MDIO to internal PHYs, basic port
> enable/disable, and CPU-port special tagging.
> Follow up series will bring bridge, VLAN, ... offloading,

I'm surprised the Kconfig help text says:

	  These switches have two 10GE SerDes interfaces, one typically
	  used as CPU port.

yet only PHY_INTERFACE_MODE_INTERNAL is set in phylink supported_interfaces.
You're also not making any mention of future SerDes support. What's up
with that, how do the SerDes ports currently work and how are they
described? (as internal?!)

> and support for using a 802.1Q-based special tag instead of the
> proprietary 8-byte tag.

Why is that?

Another (related) question. You have this comment in tag_mxl862xx.c:

	/* switch firmware expects ports to be counted starting from 1 */

from which I don't completely understand how is the firmware involved
(does it process the tags?). Would the expectation also apply to the
802.1Q based tagger?

What's the real story behind port index 0? Does it really not exist, or
is it some attempt to hide an internal port that's not supposed to be used?

If the latter, I guess something like the snippet below (seen in
arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dts) would simplify
the driver by a bit:

	ethernet-switch@0 {
		...
		ethernet-ports {
			...
			/* Microcontroller port */
			port@0 {
				reg = <0>;
				status = "disabled";
			};

