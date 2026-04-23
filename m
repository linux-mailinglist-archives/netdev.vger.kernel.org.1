Return-Path: <netdev+bounces-280630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHchA1nG6Wk4kAIAu9opvQ
	(envelope-from <netdev+bounces-280630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:12:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 585AF44DDBC
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB443301C3E7
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 07:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A28E3DDDB6;
	Thu, 23 Apr 2026 07:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="iZehZlWn"
X-Original-To: netdev@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B030F306B1B;
	Thu, 23 Apr 2026 07:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776928268; cv=none; b=E94yuSHrKUAfq+fOBbr1nejc3TO0tCWwSF8KTVAD2mJPWr4HBoomDD5prkiYVlVz3re1OUtlMfMkoQ8IIwLo1YPfxrFzc7GmUelbQ+lC0sDiKjuQ7VUiO7plMYQWlBMaE/rj+0WlNZvw0pv9a6ajCRlVq7qpOl49jkV679RTBp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776928268; c=relaxed/simple;
	bh=LYQjav1+M0ex3hpkWVMK2sCF5Dqe6CRgVEjdIRc8Raw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ewTyBg53f6tCAytIEuSAztX45ToeNEIlmZQF7WYQYectPwKjHo1yKTTTRfgVONue7nS20jX2gFWHD+HK23CW/8kQJHw+d+TlowZeFEC0+g2mOLad1EzPbu8Iw91rgCpvFGg8rB3HH43t6L4UhhMtt9qu6b8EzlLj6uBnYL7mffM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=iZehZlWn; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=xf2383DMdOzCTXTOjjwO8eiUKdwPb5DTudpvtG9JtQg=; t=1776928265;
	x=1777533065; b=iZehZlWn9mDHvCQ6KHQXTiGjpSo8XYmR3mEt1I1501X04oR1FlznQXjKAXqks
	NPP+m+/K9j/qcDF9Ztg6qhQbwDL3jYLsGY74DxcEGN3lvxsKyXBFp7AwqpFropFpJAdoPCj+5d2Rp
	3OO8pvIQqzvBlN6lrfhXUwu6wWMLgFPskijx5aZxCFfjoY2xlOxoBItWmHqaCWyBRO/3yx29IhYo4
	6JsiZ65vXI6XNSSD+I5vJFhH4EK6sZIqlbfyHE0hEjfIMKYNkme6rgT76F0TQEnA/Z9E8R/t2xPqS
	e3JR2jDIu2hTnjBqfh9Jmqs/DDmpgdcYsMHeHGxRdGfWIiIx+A==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wFoCy-00000003DnR-04e0; Thu, 23 Apr 2026 09:10:44 +0200
Received: from p5dc559e1.dip0.t-ipconnect.de ([93.197.89.225] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wFoCx-00000002VRm-3CBv; Thu, 23 Apr 2026 09:10:43 +0200
Message-ID: <c0c80113af470b265650405fa24deefe2d82ea24.camel@physik.fu-berlin.de>
Subject: Re: [PATCH net v2 10/15] drivers: net: cirrus: mac89x0: Remove this
 driver
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,  Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>,  Michael Fritscher <michael@fritscher.net>,
 Byron Stanoszek <gandalf@winds.org>, Daniel Palmer <daniel@0x0f.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org,  linux-m68k <linux-m68k@lists.linux-m68k.org>
Date: Thu, 23 Apr 2026 09:10:42 +0200
In-Reply-To: <CAMuHMdV-vF6sTvAi8kKzxGwZ9YUSBO1Qta5PDCRbA0zr-LEp_w@mail.gmail.com>
References: 
	<20260422-v7-0-0-net-next-driver-removal-v1-v2-0-08a5b59784d5@lunn.ch>
	 <20260422-v7-0-0-net-next-driver-removal-v1-v2-10-08a5b59784d5@lunn.ch>
	 <CAMuHMdV-vF6sTvAi8kKzxGwZ9YUSBO1Qta5PDCRbA0zr-LEp_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fu-berlin.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[fu-berlin.de:s=fub01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280630-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[fu-berlin.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[glaubitz@physik.fu-berlin.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,physik.fu-berlin.de:mid]
X-Rspamd-Queue-Id: 585AF44DDBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Geert,

On Thu, 2026-04-23 at 09:07 +0200, Geert Uytterhoeven wrote:
> CC linux-m68k
>=20
> On Thu, 23 Apr 2026 at 02:29, Andrew Lunn <andrew@lunn.ch> wrote:
> > The mac89x0 was written by Russell Nelson in 1996. It is an MAC
>=20
> It is based on the ISA cs89x0 driver, written by Russell Nelson.
>=20
> > device, so unlikely to be used with modern kernels.
>=20
> Macs do run modern kernels.

Retrocomputing still is not well regarded by some maintainers, it seems :-(=
.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

