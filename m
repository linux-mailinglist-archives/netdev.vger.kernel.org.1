Return-Path: <netdev+bounces-279242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJqpMgLV4WnQyQAAu9opvQ
	(envelope-from <netdev+bounces-279242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 08:36:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCE94177AD
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 08:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA14F30EC894
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 06:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E7536606C;
	Fri, 17 Apr 2026 06:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wi/oaEJ2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14661363C51
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 06:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776407746; cv=none; b=rwOLwp1sloDAqYwKIaD6Z0fAVjzvWtp7WuBIGmvfgoeakSETerCpR8I9EIlWy/ItbyTrk1QBTNYRjuhKqewSd37eLYjAOzbSsqFYdIdSrHNGTNV6kfKvK5qdT9Lmr1NIMQViijnqde3pG9co4yGEpCHePasGZXiYe+PlfUV62dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776407746; c=relaxed/simple;
	bh=+h2JPILIrzNLN8u1NARqjUeaXnNBvYVVk5Aknn7p9kQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=qkacSyGF9KYt/758FsF0oHvbIjL1VWND2yfvAiX4FZoMjXHS1Cxz69RdbYInPbIzbHTHD/wq5mfTHIdSnCETUNjAsj0o61xOrGuVBkLXWhAUbaeMUoC3vrybw4f/8OfZrkbv0H4JYqOne+W6Idj/CKb+1FTscCzXRXUDXCmvFkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wi/oaEJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DC2C2BCB4;
	Fri, 17 Apr 2026 06:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776407745;
	bh=+h2JPILIrzNLN8u1NARqjUeaXnNBvYVVk5Aknn7p9kQ=;
	h=Date:To:Subject:Cc:From:References:In-Reply-To:From;
	b=Wi/oaEJ2CXivwdvy3Fw57s4o8992ng50ukMyHNfElH294COY3t06Xf1OtzXp8ihRJ
	 zeaIlyg9gAAj+/5rH0z7860aQISdt0LrFrSaf3ItCQUTCq1QSMiZ0wvCx+7BZmv+kI
	 z8XqN79QSuGLtjj1vSex7U6rGTYzY7OFGc1lcZtbiZsR/CJBEDm74YyS/ZcZw6f4US
	 iT35xW7yR1u23B0ecbjHouw0sr6SkB7GoFWn3y1sU7NQL+OaTnxi2MMQZnxe0Mh2Iq
	 P15A3qktiVgZtylmO5hZhHvndBfQ7uArZpXF0atCAvyuywWAvbF7GdZ7G2cq5l45qb
	 axTlt+FfyNZ9w==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=560c4b5666bbe89eb39f2ef496bc820d022cbe73297389acd79dc6ec9b8d;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 17 Apr 2026 08:35:41 +0200
Message-Id: <DHV7ZMEI94AT.3O3RRPYOM7LPI@kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>, "Michael Thalmeier"
 <michael.thalmeier@hale.at>, "Raymond Hackley"
 <raymondhackley@protonmail.com>, "Bongsu Jeon" <bongsu.jeon@samsung.com>,
 "Krzysztof Kozlowski" <krzk@kernel.org>, "Mark Greer"
 <mgreer@animalcreek.com>
Subject: Re: Path forward for NFC in the kernel
Cc: <netdev@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.20.0
References: <20260416101041.4c533306@kernel.org>
In-Reply-To: <20260416101041.4c533306@kernel.org>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-279242-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,hale.at,protonmail.com,samsung.com,animalcreek.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mwalle@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1CCE94177AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--560c4b5666bbe89eb39f2ef496bc820d022cbe73297389acd79dc6ec9b8d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu Apr 16, 2026 at 7:10 PM CEST, Jakub Kicinski wrote:
> Hi folks!
>
> We are struggling to keep up with the number of security reports and AI
> generated patches in the kernel. NFC is infamous for being a huge CVE
> magnet. We need someone to step up as a maintainer, create an NFC tree
> and handle all the incoming submissions. Send us (or Linus if you
> prefer) periodic PRs, like WiFi, Bluetooth etc. do. If that does not
> happen I'm afraid we'll have to move the NFC code out of the tree,=20
> put it up on GH or some such, and let it accumulate CVEs there..
>
> I'm planning to send a PR to Linus to shed the unmaintained code early
> next week. We need to have a maintainer established by then.

Thanks for asking, but I'm busy renovating my house, sorry. I
couldn't put much work into that. The former is already stressful
enough :)

-michael

--560c4b5666bbe89eb39f2ef496bc820d022cbe73297389acd79dc6ec9b8d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaeHUvRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/iVrgF/SxUZ2vB4XFUFCpYoMdQehshhCkbso9Ci
HG4A2EFiru4hN893eLJDBPJ01cux0Nc0AX48mgaUGvBL4+nqtqtGDh1yrxKYZCIg
Fw58i9qJcXhVyGNOgddGSY+5/kh2ej7OkRc=
=XaVJ
-----END PGP SIGNATURE-----

--560c4b5666bbe89eb39f2ef496bc820d022cbe73297389acd79dc6ec9b8d--

