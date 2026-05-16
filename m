Return-Path: <netdev+bounces-288603-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3zVaOzBBCGrCggMAu9opvQ
	(envelope-from <netdev+bounces-288603-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 12:04:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6223F55B03C
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 12:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A8C930157DD
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 10:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1363793CD;
	Sat, 16 May 2026 10:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6ZqlCeR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1D1405C46;
	Sat, 16 May 2026 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778925866; cv=none; b=JHjejoc3TwGy1jfagwNZIe14iY+gcOTxgOBK5cLOOvEXym+8BYmbLgop0tIplu84q5nJdUQnrFL86Ef6K6OsUODxK1+ldrt2JHIPNG8PuN+kloz3xoUp9JtrgNgncWawxK3b6bdMeKD/0zcejvb4fGWqLOIFGexq7gLNirRzSVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778925866; c=relaxed/simple;
	bh=dq4MMd0lbPDQmhF9bMo2JYiaEO7Ae9IgHeGxKuczcsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxaqCgw0wgh9xJMPlNUDTArKseT99VE0oBkmFfIzW56eMe5pgYZ6bQHe/NSqW7+hYzMG5wzit0UgnS0IE9KOuk1JFzpmruSa2rLMYAJZe/qKaqVYH2VVk6stDzhh9eE1iNUoe66pQh2ugrOtlS4LRAlbuk/0y89+s/uqsUW77AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6ZqlCeR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E19C19425;
	Sat, 16 May 2026 10:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778925866;
	bh=dq4MMd0lbPDQmhF9bMo2JYiaEO7Ae9IgHeGxKuczcsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A6ZqlCeREAbVbXx+FMqWutfacguKU2jNDSPEwCDlFJNyYCowyBK7dOsA2luxNoEXy
	 7K/EQDDxLNl/ivZGfYVlcNHCJ4AT4WEX9n7OSn0XgiICT77jGbO+8fBkeD5hubgz9u
	 k6v93LRXWLVHm11ROEojOFFFjmeS8rHubSlhOT5zNFwyUrp9p2LUPgfMkAaUGWvkLd
	 1fP+ha4k/2erwL3zPx1OPve+vX26xKzxCkpeGHEO6l3d4OMxvyHWVrmzTU9E7rfdRq
	 OWi9XJH4FaXJUrmp2CSCZKU063qyBLRgUe0bl4AjetEqcKMhg+8U1jhV6ljhs76WyR
	 gukjVCDo1msgQ==
Date: Sat, 16 May 2026 12:04:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>, 
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/2] dt-bindings: net: updated interrupt type to be
 active low, level triggered
Message-ID: <20260516-acoustic-rapid-lorikeet-7c1a2f@quoll>
References: <CY8PR02MB924916514D414B698DEB9A1883042@CY8PR02MB9249.namprd02.prod.outlook.com>
 <ab821805-49dd-4b55-a77d-0f25e0247bff@kernel.org>
 <3bfd9650-bf67-4abb-8820-2cab95ef6402@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3bfd9650-bf67-4abb-8820-2cab95ef6402@lunn.ch>
X-Rspamd-Queue-Id: 6223F55B03C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288603-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 06:40:45PM +0200, Andrew Lunn wrote:
> > Also, did you consider the board layout?
>=20
> Hum. How would a board design convert a level interrupt into an edge
> interrupt?

I don't know how feasible or useful in practice, but such converters in
theory are simple:

1. RC differentiator + Schmitt trigger
2. Logic-gate edge detector
3. Monostable (=E2=80=9Cone-shot=E2=80=9D) pulse generator
4. Flip-flop / synchronizer logic in CPLD/FPGA/MCU
5. Dedicated interrupt-controller or GPIO expander ICs

Different point is that Rob said these flags should represent what the
device expects. I disagree with that, because except RC delay GPIO
bindings, we do not have representation of any inverters, thus this flag
should rather represent the final board layout.

>=20
> Use the level signal to gate a clock signal? So while the interrupt is
> low, you get a stream of edges? Does that really exist?
>=20
>      Andrew

