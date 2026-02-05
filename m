Return-Path: <netdev+bounces-257259-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOTEJ77PhGk45QMAu9opvQ
	(envelope-from <netdev+bounces-257259-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 18:13:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 059E2F5B9E
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 18:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1E0C3033D35
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 17:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC45443C05D;
	Thu,  5 Feb 2026 17:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/rytbrH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99BC421884;
	Thu,  5 Feb 2026 17:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770311500; cv=none; b=aiF2Q5bUSZCShId9bP0PgUCID+iY8bOZvQkzj+0EYazPVnw+CNRBDucknyt0LOHFaY7W+oL5ke0yTysVrn+v3ocFX/wugvIFU8zXuKZqHEro7/SlyT4T5TXpBnyVG88KBv2H4XmUL0XJ0CtT2LY8PafIetM2uo9h/wJLrXxQk9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770311500; c=relaxed/simple;
	bh=1vEAUIJ8ntu04mOg+huAQsOlBddqkCYWp8F0aGZikdI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vl0I4o1ZKEZsNzInkhVLHCIEe4x+5aWxIdisvlDeMPgYSMWUZNHYhzhw0zKLx83wFkFD6G8641unULSUbK09uRNDE9J6d5/zQ4AteYuwSjTbucWv6CP/ln+QC4Q8BH03MM0pLw5Y84hNhnJl503iUeX3yw4E5jAUNBVojGc4ABc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/rytbrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0571C4CEF7;
	Thu,  5 Feb 2026 17:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770311500;
	bh=1vEAUIJ8ntu04mOg+huAQsOlBddqkCYWp8F0aGZikdI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s/rytbrHpRX6Qlpsf9FZ1FoZcdbeaMD/5kf8vwwyJ4InwWTLpEbeZQ33ha+QwJG64
	 bZXvnrD9pdQs8tDQkrFOywkFIJhT0rPu3CyBb8cER5gJDo+AbrVcc/j0JQPpvaOQII
	 p/XzxA2lc9Gl1jb9Cne4v3cRQ/5ELzhfTiuQjeqanBtS6SQjWxRs5opgLxxvodXI2y
	 a/umEjAjggZ/5OAJs3M0Xf8puXYNlPxw5SLDfZmPIghV7e1/TYJqZiApBCzN6w51/W
	 RFjNZXxDB8S4HEcUhDxu5Z+hjJl343RkLvPYZNup1SiDlkpeREKZRV1Si33IEF/xBM
	 b8oGY5+jm1GdQ==
Date: Thu, 5 Feb 2026 09:11:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 3/4] mptcp: fix kdoc warnings
Message-ID: <20260205091138.7b2884b6@kernel.org>
In-Reply-To: <e630bf98-05df-4809-9f78-d10abfd075d8@kernel.org>
References: <20260204-net-mptcp-misc-fixes-6-19-rc8-v1-0-cb559fb6b50a@kernel.org>
	<20260204-net-mptcp-misc-fixes-6-19-rc8-v1-3-cb559fb6b50a@kernel.org>
	<f2f5c43d-bf6d-4fe9-9062-1f649d5c276b@kernel.org>
	<20260205075606.5b94c492@kernel.org>
	<e630bf98-05df-4809-9f78-d10abfd075d8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257259-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 059E2F5B9E
X-Rspamd-Action: no action

On Thu, 5 Feb 2026 17:42:24 +0100 Matthieu Baerts wrote:
> >> I forgot that this file was auto-generated from a YAML file.
> >>
> >> Sorry for the noise, I will send a v2 also adapting the YAML file. =20
> >
> > Hm, do we need some clever way to teach the codegen about short
> > descriptions? =20
>=20
> In my case, there was no "doc" for this enum:
>=20
> =C2=A0 https://lore.kernel.org/20260205-mptcp-fix-kdoc-yml-v1-1-9858c4b7b=
af6@kernel.org
>=20
> Adding it fixes the kdoc warning.
>=20
> Do you mean that the codegen should add a short description even if
> "doc" is not set?

Ah, ignore me. I thought we did:

 /**
  * $type
  * @member: $member-doc
  * @member: $member-doc
  *
  * $type-doc
  */

But looks like we put the type doc upfront and wrap, so perhaps not
pretty but shouldn't run afoul of kdoc rules.

