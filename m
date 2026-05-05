Return-Path: <netdev+bounces-284149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULz3GVBH+Wki7gIAu9opvQ
	(envelope-from <netdev+bounces-284149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 03:26:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A874C5BE5
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 03:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DB6A3014BC1
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 01:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F5C194C96;
	Tue,  5 May 2026 01:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4rT0w84"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D1BEEBB;
	Tue,  5 May 2026 01:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777944397; cv=none; b=H6/ztxESIs0iS2pxNV2K47HDN3hBufp6s6Izdr5rc9ZtntEL+v2AI1x06i3QHNQOO4eL7myB6fo4Kwe5J8lnhrKtaNVUc/BRfD2WETT9x90ExzuNvn4StDkLScfXASfpeWJVtvn4V39m9jZVDfxRNA3bQE4KbubZSJGi8jnsbew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777944397; c=relaxed/simple;
	bh=wmOzGc/Fp8zFwcVA/+EiRdoheVyhK7v5Xvoe5ybKfxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ReTJUlHOwcOa5L4msxxYlv/wE8/cdx/hYnhkZHJp9DtrBqpBiUdtP8vt2hS4m3Yd/X9gTHpNfv2lYjX/w+bVZDs+V513CuGr6TwEWYngCT4fTLLTBZcumUHVVxj36mLfRqlKxMK78ZoEQEQLKfP7t95DITcV780SzU7QFJJhv2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4rT0w84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3D2C2BCB8;
	Tue,  5 May 2026 01:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777944397;
	bh=wmOzGc/Fp8zFwcVA/+EiRdoheVyhK7v5Xvoe5ybKfxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s4rT0w84GV4YzmmCoUnJ5+KNl6+u6rX0I4juDTIJjtzGadKYVLDfCHW/TosEisKMw
	 eTqpXGgMExH3eVJtfOtVuW8ks3O5oJB+JQ5Uaij5ezWdtwlHSmuVumb1cuHT2xPlzU
	 t9jJM/ntS+0miFv8BaizcRRMvuLf3maGUV7i+96TcCSOUQSIOrPETj2IitohTXL0Sv
	 vx44UnA9sb9PT5kforhtsIgnhM9vM6ZeMbdTkNqfRVsdS34YD+np6E8pOnvZ5TdbKn
	 jCtjOOy42x3BHBSd6SiZgdw+VCbutpJ/VFJLoYpbq1+fQ6XOCVyIGcZrWxv2d3BLHE
	 CQaKH+E2p5DTA==
Date: Mon, 4 May 2026 18:26:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jon Kohler <jon@nutanix.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] e1000e: ethtool: add get_channels support
Message-ID: <20260504182635.39e1b7a6@kernel.org>
In-Reply-To: <D670011F-AA11-4AFF-A70B-4DFF03C5F049@nutanix.com>
References: <20260504154823.2535612-1-jon@nutanix.com>
	<20260504164901.7b3a737b@kernel.org>
	<6F0C5872-0388-47AF-8CD9-1D116EA13224@nutanix.com>
	<20260504180656.62539d96@kernel.org>
	<D670011F-AA11-4AFF-A70B-4DFF03C5F049@nutanix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B1A874C5BE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284149-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]

On Tue, 5 May 2026 01:12:29 +0000 Jon Kohler wrote:
> > On May 4, 2026, at 9:06=E2=80=AFPM, Jakub Kicinski <kuba@kernel.org> wr=
ote:
> >=20
> > On Tue, 5 May 2026 00:59:40 +0000 Jon Kohler wrote: =20
>  [...] =20
>  [...] =20
>  [...] =20
> >>=20
> >> Perhaps, but I=E2=80=99m not sure that is a guarantee. A good relevant=
 example
> >> is when I added get_channels support to enic, which supports all sorts
> >> of channels, so I don=E2=80=99t think EOPNOTSUP can be 100% consider r=
eliable
> >> in that case. Meaning, if it just so happens that the original author(=
s)
> >> didn't put in get_channels, that doesn=E2=80=99t necessarily mean ther=
e is only
> >> one queue.
> >>=20
> >> And in this case, there is an "other" queue as as well too, as far as
> >> I can tell, so the output is at least semi-interesting. =20
> >=20
> > Sorry I wasn't clear enough - if you have an actual, real life use case
> > why you need queue count of 1 to be explicitly reported - please explain
> > it and put it in the commit message.
> >=20
> > If you don't - please don't send patches for the sake of it. =20
>=20
> Ah, ok, sorry I misread your message, this isn=E2=80=99t a patch for the =
sake of
> a patch. Long story short, we=E2=80=99ve got a user space part of our con=
trol plane
> that reads in the output of ethtool -l as part of some broader queue
> management code. On systems with an e1000e device present, this specific
> component goes into a crash loop as it expects all NIC(s) to at least
> give it some sort of output.
>=20
> That crash loop is easy enough to fix to ignore unsupported outputs;
> however, my thought here is a simply defense in depth fixup, especially
> since the kernel patch is quite trivial.

Got it, thanks for explaining.

My concern is that if we are expected to always report channel counts
we're signing up for a major whack-a-mole with the existing drivers.
Most drivers don't implement it. The networking stack does report
the number of queues the device asked for via rtnetlink:

ip -j -d li show dev $ifc | jq '.[].num_rx_queues'

but in your case I'd personally lean towards user space fix.

