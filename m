Return-Path: <netdev+bounces-284143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJ8+CbdC+WmX7QIAu9opvQ
	(envelope-from <netdev+bounces-284143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 03:07:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D5E4C59BE
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 03:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CD5E301944B
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 01:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72959314B93;
	Tue,  5 May 2026 01:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7YOCbAN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E78C17B506;
	Tue,  5 May 2026 01:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777943218; cv=none; b=axGMukqg/EdoH7HR/5FpSMI7erXdDB++n4plQF2326eHsikrqtbaj8ktk9zcuYvyweuDqiGPz6FGlGQLe2iYiMQq7Xdb9sK2F2094MZf6JJLODAXmCosIlQwUGXODSGHUgHYgnoppXt55VrQFDunk+frvMpjvnaxjGNWH5ENX3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777943218; c=relaxed/simple;
	bh=vDzRQUtQY5hXU5GT6i6iXkmD1jjqB739UnVuZmiyxPg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nTMLOcm/PX/gj49ns0mz7xUQF6OFCuFEl5PscRXIftI/ogDOISsS4rHtAB7uOxX3IpOB+fFq9+IbdrtUYK5GdKatz2pWnqoTjfl80pkFme1b5NelrZVhjfdFtf/8/0JgZwOjowiYBP8c3bjSxn4DMUJmDGEVtd2w3jsOlT8yfH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7YOCbAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B3CC2BCB8;
	Tue,  5 May 2026 01:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777943218;
	bh=vDzRQUtQY5hXU5GT6i6iXkmD1jjqB739UnVuZmiyxPg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y7YOCbANmiTzgzwVh5CsBwJqMxSBFIEF19uMbHkfTbTSFh6pXOkCc8QMulXvESGVq
	 TELdt9oCfrAUVlT2jCjEeO9k34YYiojxVB8idaCdmgGAlCMarhaRyP8PR1BGmlOegO
	 IK8/lbqoW+4fZnlRMznT74MJPNJPcIgZDJbzVPj0M9nIK0N4lMj3khI9xuGhEe6WEj
	 NQDZU3+spz8fXrnpiMdKwpLqsB6k+zd/y2a178VBe4LgaGwUX73wB9xQo72vySPPMn
	 +h5Gs6X6MWas3GGfI2EgchB2RwtL0QCPgKEWI/gyrk1C3pDt87DnossRf2ijCM1jTb
	 P8Wy1OYnIhjMw==
Date: Mon, 4 May 2026 18:06:56 -0700
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
Message-ID: <20260504180656.62539d96@kernel.org>
In-Reply-To: <6F0C5872-0388-47AF-8CD9-1D116EA13224@nutanix.com>
References: <20260504154823.2535612-1-jon@nutanix.com>
	<20260504164901.7b3a737b@kernel.org>
	<6F0C5872-0388-47AF-8CD9-1D116EA13224@nutanix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 91D5E4C59BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284143-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
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
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, 5 May 2026 00:59:40 +0000 Jon Kohler wrote:
> > On May 4, 2026, at 7:49=E2=80=AFPM, Jakub Kicinski <kuba@kernel.org> wr=
ote:
> >> e1000e hardware supports a single RX/TX queue pair, add basic support
> >> for ethtool -l (i.e. get_channels), so that callers indeed see a single
> >> queue. =20
> >=20
> > Why? Isn't EOPNOTSUP from ethtool -l implicitly saying that there's
> > only one queue? =20
>=20
> Perhaps, but I=E2=80=99m not sure that is a guarantee. A good relevant ex=
ample
> is when I added get_channels support to enic, which supports all sorts
> of channels, so I don=E2=80=99t think EOPNOTSUP can be 100% consider reli=
able
> in that case. Meaning, if it just so happens that the original author(s)
> didn't put in get_channels, that doesn=E2=80=99t necessarily mean there i=
s only
> one queue.
>=20
> And in this case, there is an "other" queue as as well too, as far as
> I can tell, so the output is at least semi-interesting.

Sorry I wasn't clear enough - if you have an actual, real life use case
why you need queue count of 1 to be explicitly reported - please explain
it and put it in the commit message.

If you don't - please don't send patches for the sake of it.

