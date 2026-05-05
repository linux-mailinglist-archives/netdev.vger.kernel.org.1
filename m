Return-Path: <netdev+bounces-284142-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHc1E6tB+WlP7QIAu9opvQ
	(envelope-from <netdev+bounces-284142-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 03:02:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD184C5990
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 03:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2264C3018C30
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 01:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1156C2DCF41;
	Tue,  5 May 2026 01:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grFstXbC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DF01C84D7;
	Tue,  5 May 2026 01:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777942952; cv=none; b=VD0HbGjq8Y9udYxjELABQp0jYL16YjOtnTfB2ndsY9jdNB9wbyAWT3dgPcsa3uodKKna73nIvD+UYuf40CPsOftTqI3DCQuVQi9pkDQ1GHVIAh7U7OSzuzQ9tAD52uG0oE+w4uISMVD+8z5ra5J8XqPqBCBi+6+5P0Go6LY2VXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777942952; c=relaxed/simple;
	bh=iEGXDzlDY4dzJ0j/v5KnsVQUb0689gZIcFlZ1AFxiGU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9QMoI2aaxoQQ5wUfr3L2bVMvqdxerY56ZmoSGU0m1QNxp3cUUGpTpqFR4bGPnq3O5PSRuUuYNqPpixY9EjG5SHsAbA6h7YUW55YLd4IheRNrady4n9oVmBwI5oPpKT5fT/pFflvzDDL/OafVaqrMUdgL7hdb6bHM+kw4mJTUsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grFstXbC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D92C2BCB8;
	Tue,  5 May 2026 01:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777942951;
	bh=iEGXDzlDY4dzJ0j/v5KnsVQUb0689gZIcFlZ1AFxiGU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=grFstXbCwhBGyTVmgTIhFOCAjCfAhphC5VCNADmCIDQLgEcq08XtGBvBiS6tiUn+A
	 Gl6jmAupztL64e0HtHVgcHVzUmRgEo+WC05tClgvtjeqTMMyRq9JaShOrodJgN6G9K
	 Yvfb3lFbYi7Nbw574MZqybscKJoAJmUkt0NEGGRhCME+7fmXfyU8Kp4npai6CFMrtI
	 ceUzWbQQPEpf+J/Y4pNnZI3N420ZHjOb7FOxhvQm5VCvvk+VJTixVlzblvmW17chZl
	 YYEuRz7ZyhOKyjhZOHfGaynn68YG0w3tyfsUB6QIzIjPiHGwcsPd+Xexw11Tq/4bbc
	 Sm7e8vdatShbA==
Date: Mon, 4 May 2026 18:02:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christoph =?UTF-8?B?QsO2aG13YWxkZXI=?=
 <christoph.boehmwalder@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
 linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
 Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet
 <edumazet@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 2/4] tools: ynl-gen-c: optionally emit structs and
 helpers
Message-ID: <20260504180230.34ec1561@kernel.org>
In-Reply-To: <afhgQgySpoxXFCn1@localhost.localdomain>
References: <20260407173356.873887-1-christoph.boehmwalder@linbit.com>
	<20260407173356.873887-3-christoph.boehmwalder@linbit.com>
	<20260412125502.3f8ff576@kernel.org>
	<adzVUdf74CVk2DwJ@localhost.localdomain>
	<20260413104939.5ef4d9dc@kernel.org>
	<ad4ox7ibZoiW-tje@localhost.localdomain>
	<20260414083548.02f76970@kernel.org>
	<afhgQgySpoxXFCn1@localhost.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BAD184C5990
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.dk,lists.linbit.com,vger.kernel.org,linbit.com,gmail.com,google.com];
	TAGGED_FROM(0.00)[bounces-284142-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, 4 May 2026 11:05:55 +0200 Christoph B=C3=B6hmwalder wrote:
> On Tue, Apr 14, 2026 at 08:35:48AM -0700, Jakub Kicinski wrote:
> >On Tue, 14 Apr 2026 14:08:58 +0200 Christoph B=C3=B6hmwalder wrote: =20
> >> But we still need to support the current family via a compat path, and
> >> I would much rather have two YNL-based families than one genl_magic and
> >> one YNL-based. Carrying both sounds like a nightmare.
> >>
> >> So the spec proposed in this series would never actually be used to
> >> generate a userspace client, if that's what you're asking. We would
> >> continue to use the current libgenl-based approach, with some userspace
> >> compat shims to make it work with YNL. Then, when "drbd2" comes along,
> >> we could "do things properly". =20
> >
> >Let's jump to the drbd2 work. =20
>=20
> We have a bit of a chicken-egg situation there.
>=20
> The drbd2 work depends on the DRBD 9 upstreaming series, since the drbd2
> netlink family will use the new DRBD 9 semantics.
> However, the DRBD 9 series depends on the current DRBD module already
> using YNL (or rather, *not* using genl_magic anymore).
>=20
> Our plan is to convert the current family to YNL in-place first, then
> incrementally add the new modern drbd2 family with DRBD 9 semantics in
> another series.
>=20
> How would you prefer to handle the YNL switch? If it makes it easier for
> you, just committing the YNL-generated code without the generator is
> fine for me. The old family is effectively frozen, so that would work.

That could work. Please float a series and CC netdev, we'll review.

