Return-Path: <netdev+bounces-280679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBVgCqvn6WmFnAIAu9opvQ
	(envelope-from <netdev+bounces-280679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 11:34:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D271D44FBA2
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 11:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E29B301EBD8
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2947C3E4C63;
	Thu, 23 Apr 2026 09:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="IuUl4oxF"
X-Original-To: netdev@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715C93BF673;
	Thu, 23 Apr 2026 09:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776936505; cv=none; b=c7bTzqJ1iBLkHOxoDGNjH0/NLST7Qx97enKc0stZg8YR6agjkxBkuWXW5IhuYRiQOHWaCCFiwrSY5eaIO+kVCVzs798mUWKtKHew83IF281KnuDI9GJ0heT3K35zpxhj5CUNkO9gvdlsgSg0c/La0h6qEGWL0o6SABPQQRrQqCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776936505; c=relaxed/simple;
	bh=HuBA0Qzq/DYd0rcngJlieMV/XLHFFCqFQhkapYaGSQw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ArgDXBNPFHybZ8XPIePaSqc/fHww1KgluGLSrsag27kGM4n0hsDM4dobAKDdT4RTVTD41Cl1uHG1WlFTAWETFkqQqbru5Pccccil19i4TqshctCHhuJljOShL6BtBD+Z4YJEL92DMO1ZVwCIpY3ej0s9wuq54YJQjgOPZUd0Pac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=IuUl4oxF; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=zeWo4E4PlcntrIRoAt4bWIDzaFjt/YqZgC2/aPWnV5w=; t=1776936502;
	x=1777541302; b=IuUl4oxFjrX7RAQBfg6A9FUElSPdccwLFvOxZMchQmLQ/xT1gt3lyyAHfOPhP
	bo1Pk7p2WYLFWG5BQ0lQyBpTdD8t0ydCMsnNLlIg7m7hYYECVuTv0KY9cVGa328bKIL+xfE+RlJxP
	JhIslN1QEDRf3EuFypWWkag3Z+7RFRvC/R/Ibmw9M/Saih/VnEe239eP0arZftkkoS4cwH66S9QWb
	7mlbZTqKf6hQATgsXAzK6gmwiVytzZs1fdi0uwWL9mW6D7gzqv99x+W2MKV8GSsY0NEVk/VQlr+lu
	zBIzur5yuKhje9+FyAeTRUFffNiURygjzxXo0naDiu11V0LnQQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wFqM1-000000004TA-0qZk; Thu, 23 Apr 2026 11:28:13 +0200
Received: from p5dc559e1.dip0.t-ipconnect.de ([93.197.89.225] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wFqM0-000000033VG-3woU; Thu, 23 Apr 2026 11:28:13 +0200
Message-ID: <aee0393e2a2bd5a5d0bf8aee758122633e54aa06.camel@physik.fu-berlin.de>
Subject: Re: [PATCH net v2 10/15] drivers: net: cirrus: mac89x0: Remove this
 driver
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Daniel Palmer <daniel@0x0f.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Lunn <andrew@lunn.ch>,
  Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet	 <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni	 <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet	 <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Michael Fritscher	 <michael@fritscher.net>,
 Byron Stanoszek <gandalf@winds.org>, 	linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,  linux-m68k
 <linux-m68k@lists.linux-m68k.org>
Date: Thu, 23 Apr 2026 11:28:11 +0200
In-Reply-To: <CAFr9PXnECog56b+Jq9TBohhQ4oBB3hGV1pHj6OstOSLqkOpcTQ@mail.gmail.com>
References: 
	<20260422-v7-0-0-net-next-driver-removal-v1-v2-0-08a5b59784d5@lunn.ch>
	 <20260422-v7-0-0-net-next-driver-removal-v1-v2-10-08a5b59784d5@lunn.ch>
	 <CAMuHMdV-vF6sTvAi8kKzxGwZ9YUSBO1Qta5PDCRbA0zr-LEp_w@mail.gmail.com>
	 <c0c80113af470b265650405fa24deefe2d82ea24.camel@physik.fu-berlin.de>
	 <CAFr9PXnECog56b+Jq9TBohhQ4oBB3hGV1pHj6OstOSLqkOpcTQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[fu-berlin.de:s=fub01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280679-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[fu-berlin.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[glaubitz@physik.fu-berlin.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D271D44FBA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Daniel,

On Thu, 2026-04-23 at 17:52 +0900, Daniel Palmer wrote:
> Hi Adrian,
>=20
> On Thu, 23 Apr 2026 at 16:10, John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > > Macs do run modern kernels.
> >=20
> > Retrocomputing still is not well regarded by some maintainers, it seems=
 :-(.
>=20
> I've found bugs in drivers by plugging those things into exotic
> hardware like my Amiga 4000 and Ultra5 [0].
> So, it's not totally pointless. And having a shader capable Amiga[1]
> is pretty cool.

Not only that. Those exotic architectures also help iron out generic kernel
bugs and give new maintainers an possibility to get their feet wet.

> Sad to see fun stuff getting pushed out by basically spam bots. :(

It's not so much pushed out by spam bots but by the commercialization of th=
e
Linux kernel. Many developers think that the sole purpose of the Linux kern=
el
is to run on modern commodity hardware.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

