Return-Path: <netdev+bounces-280583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNMPFguM6WkecwIAu9opvQ
	(envelope-from <netdev+bounces-280583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 05:03:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B114244C70B
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 05:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FB93300697E
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 03:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7ED02DCF57;
	Thu, 23 Apr 2026 03:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtHS0KWw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A569223FC5A;
	Thu, 23 Apr 2026 03:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776913416; cv=none; b=E+YSlZV/GaiyksuIMe7m6Hj3SzwqWlVxT6Q63G3z7uq7g/gDkcXBl+WBZ5y5sNgpRnl9iSUTK9BsZX6oDZ1E3oOLc9O6KjqMmtX6dUb0GpsFPaJFDXRD9jdPNQB8wJPMo2iWRGas8XlKiFWsHm8752jBPeqqy4q36bvl8vhm2ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776913416; c=relaxed/simple;
	bh=nxm9Oh6taLuXO9o0gYbpRDn0kH92kZteFVYn0Mwxiyg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SJGCfaA8PeAM8SM8yVPcFlwNxo+pFPCZ+h2WBjxqt0Crvnx0sKsbftgwMYF31t9pQmMHMz0PsSPhpWxr5UrQCvJfnCd8Exx5Dr/68zAaGc6L8YnNgPAppU1H7qu7w0n03LF6zzsWqftVT6CT45i7MFd9MJQ/jMk7AnP7qak9b94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtHS0KWw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D862AC19425;
	Thu, 23 Apr 2026 03:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776913416;
	bh=nxm9Oh6taLuXO9o0gYbpRDn0kH92kZteFVYn0Mwxiyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZtHS0KWwBDKJm/HK0rmLS6rvWYTj0UQ1OmVNBpbZ+tV5gCjJtR2MBuWTCI8fvmARW
	 9yJAOy4HN1sZsSW2SLRCCza0MvEv+31uAikymcce9+3JAAIlF54199LjXTlamjbUbi
	 mePP7wFEfLJXX2mVhEfY+Qtu/eoCfW/3yywlV6Cl3bqbSeBihsTQF00DyIdGryb47G
	 ZAFwwUBQl1K5rDdjkDpVN0Aaw8rSJqgdIhswPN0A2uFdDd40udUfIxtN0UR7v/lJy5
	 keiLhya6vBlOlc6UEHYNfLIdaPgdDlUZzuzgC+GwG5nw9ipOf3rKJWvtMPxtb+fqsF
	 ZSVzJiWLiOFzw==
Date: Wed, 22 Apr 2026 20:03:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Heidelberg <david@ixit.cz>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Michael Thalmeier
 <michael.thalmeier@hale.at>, Raymond Hackley
 <raymondhackley@protonmail.com>, Michael Walle <michael@walle.cc>, Bongsu
 Jeon <bongsu.jeon@samsung.com>, Mark Greer <mgreer@animalcreek.com>,
 netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev
Subject: Re: Path forward for NFC in the kernel
Message-ID: <20260422200335.1d0428fc@kernel.org>
In-Reply-To: <938496c6-84c1-4d53-bb56-73bbd7b2bdd7@ixit.cz>
References: <20260416101041.4c533306@kernel.org>
	<9c4a4acf-b4f1-4e84-93bf-cdf080cb9970@kernel.org>
	<1725ea8d-ac1f-49d2-8d8c-2e09721454c2@ixit.cz>
	<20260421071044.67a3cee1@kernel.org>
	<938496c6-84c1-4d53-bb56-73bbd7b2bdd7@ixit.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,hale.at,protonmail.com,walle.cc,samsung.com,animalcreek.com,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-280583-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B114244C70B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 22 Apr 2026 15:11:16 +0200 David Heidelberg wrote:
> Yes, this is broadly in line with what I had in mind. To clarify the =E2=
=80=9Climited=20
> reviews and basic maintenance=E2=80=9D phrasing: that was more an attempt=
 to set=20
> expectations conservatively. I=E2=80=99m prepared to take on the responsi=
bilities you=20
> outlined =E2=80=94 maintaining a tree, collecting and triaging patches, a=
nd sending=20
> regular pull requests.
>=20
> Regarding reviews and responsiveness: I can do the 48h turnaround for ini=
tial=20
> feedback on submissions (excluding weekends, and occasional travel), and =
I=E2=80=99ll=20
> make sure no patch sits unattended. For more complex changes where my cur=
rent=20
> NFC-specific knowledge may be a limiting factor, I=E2=80=99ll seek input =
rather than let=20
> things stall.

Sounds good. The discussion taking long is perfectly fine. Main concern
to us is not hearing any response for a long time. Then we have to guess
whether the maintainer is planning to respond, or AWOL.

> I=E2=80=99m also planning to ramp up my familiarity with the NFC stack as=
 I go, so I=20
> expect both the quality and depth of my reviews to improve over time.
>=20
> If that works for you, I=E2=80=99ll proceed with setting up a public tree=
 and start=20
> tracking incoming patches.

Works! :)

