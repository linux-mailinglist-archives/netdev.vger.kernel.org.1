Return-Path: <netdev+bounces-254548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNurOPTgemnN/AEAu9opvQ
	(envelope-from <netdev+bounces-254548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 05:24:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46816ABA9F
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 05:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F8D33017792
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 04:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A981F2D2397;
	Thu, 29 Jan 2026 04:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzU5WiYM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BBB2BEFFB
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 04:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769660648; cv=none; b=bn4mB7mNItaH8g9ovS0FevpaTVhlb8wSZlBLaZfwdQgDMGd+5aYhWbs9qD865lBRKWJcx7NElR/f8D3qtN9tOAIr1cehZT+U4EWof2zA06wPGz/cDDFISOdbJQ6szjqb0awGxrdsLEkVfV8lMdt1m8xEEJ43QpNiF2dRUOx09Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769660648; c=relaxed/simple;
	bh=cVBn1sfiReDhhbPykLUqdWFkzTtGqKnUCFPijvanHVo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tZtM761/zmhFRuvSDoIgSLal5bTaDX43EZ9JDMDVB7P8Z5wArv20ARjj5AFnAjA+yJDurqlC6XxaoaB6DNEkCx68f8tKGuq5XYQlPya7DJUm05riczSagL+/vCNezpW2j/pqFaP3H1hJ00jf/dvDV1LJ7e2MV30qvyuUtnHhsfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzU5WiYM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A849DC116D0;
	Thu, 29 Jan 2026 04:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769660648;
	bh=cVBn1sfiReDhhbPykLUqdWFkzTtGqKnUCFPijvanHVo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fzU5WiYMpMZIHKSadYsnRERZdv85PXeKpKYV26m77gDU1B+Wb4Tq5XpnxJaJxwQU8
	 JVDvvRp7ZTmT6l0I1ybV+SCB6i9xezI6H3uinw1Xe8Ch1pVZaDjAGeOkWc5sIGFHy6
	 TlcVgnvUy0cNSUmQQIemFZtw3HpTj2VrTZoWaPCDTH/7fBR6vcaXnL3UegBEH7pu0d
	 e0WQMeirPLvinz+PmHdMlU9k8OPsl7LDZRfSJ5xKPb6EOgapfWhHg0IM/dchvzp605
	 3H5SG79cfQiVnE7snxXgrfKJvfHYFJd5e9uHNKEIvaTjwdcQVHfEO+zTZs5wwwrJQp
	 TGtysmUJWxnOw==
Date: Wed, 28 Jan 2026 20:24:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Marc =?UTF-8?B?U3XDscOp?= <marcdevel@gmail.com>
Cc: willemdebruijn.kernel@gmail.com, pabeni@redhat.com,
 netdev@vger.kernel.org, dborkman@kernel.org, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net v2 0/4] discard ARP/NDP b/mcast/null announce
 (poison)
Message-ID: <20260128202406.69c1eef1@kernel.org>
In-Reply-To: <cover.1769464405.git.marcdevel@gmail.com>
References: <cover.1769464405.git.marcdevel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254548-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org,kernel.org,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 46816ABA9F
X-Rspamd-Action: no action

On Tue, 27 Jan 2026 00:53:01 +0100 Marc Su=C3=B1=C3=A9 wrote:
> The current ARP and NDP implementations accept announcements with
> multicast (broadcast incl.) and null MAC addresses as Sender HW Address
> (SHA) in ARP or src/target lladdr in NDP, and updates the cache
> for that neighbour.
>=20
> Multicast (incl. broadcast) and null MAC addresses shall never be
> associated with a unicast or a multicast IPv4/6 address (see RFC1812,
> section 3.3.2).
>=20
> ARP/NDP poisioning with a broadcast and certain multicast MAC addresses,
> especially when poisoning a Gateway IP, have some undesired implications
> compared to an ARP/NDP poisioning with a regular MAC (see commit message
> in patch 1 for more information).
>=20
> Worth mentioning that if an attacker is able to ARP/NDP poison in
> a L2 segment, that in itself is probably a bigger security threat
> (Man-in-middle etc., see Note2 in patch 1)
>=20
> Since these MACs should never be announced, this patch series discards/dr=
ops
> these packets, which prevents broadcast and multicast ARP/NDP poisoning
> vectors.
>=20
> This patchset only modifies the behaviour of the neighbouring subsystem
> when processing network packets. Static entries can still be added with
> mcast/bcast/null MACs.

Not a very strong opinion but my intuition would be to target=20
this to net-next. I read it as an improvement to RFC compliance
more than a solution.

