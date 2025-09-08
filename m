Return-Path: <netdev+bounces-220827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF90B48F4E
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 15:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6056C16BB2D
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 13:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46C130AAD7;
	Mon,  8 Sep 2025 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="faLSwB0l"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B354A06;
	Mon,  8 Sep 2025 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757337775; cv=none; b=LJqd6vHlWoi7uyOxITJxcqGhJJOnon6dg8ui5X7bnW9gfClDESQRuIxR47to8UUFE/CPHDvC/esyZa8yIlaY05z818KiEhE8umaNFGDqOXQyPGhMwDgABKpCoR/CEkgvKIdM0SzaMd5meAkK1aF9KyNG+o1VSQpJ4ySE6Ch8iho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757337775; c=relaxed/simple;
	bh=SuRVL9yTkDR5h545LQmg+jQK9v+68jYw4M9j0Cty4Qw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tNoYQhSode8UhPMvou0dolSgxNhRnk7UmpNane9UmLAsKiTT7mfjWUqKC8aQLyVrBwuNbxDk1p8x1+oBZNRifiIhg+GmWoOHHAopBGaLvIGi1jk1m1swe+UjZCTnIs04D8NdlRfXjOT5GDwEggwCeSuAcINHFoHw3Wjc6lyjWWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=faLSwB0l; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SuRVL9yTkDR5h545LQmg+jQK9v+68jYw4M9j0Cty4Qw=;
	t=1757337774; x=1758547374; b=faLSwB0ljv4aTnWIIxsKS2E7GrDYhBDVqPu0ebYzKjLXPQx
	XoHGzObf5BX7lI6EmZfXXoh83hVbvnCu3xfTr+zm/RMWvmkRLgZYg6KqRaT6LPgIRGfPwTtfUib+B
	M7jHW9kq+zo0qpwMYw24ENPZeOVsZ6QWXl4wsNrOV+buxYak3Yb6ZltP3sPrpPh6EQdH5lJgvxLSI
	PXNiqHpO5G3mAe2PRO8yt2PqSb+QKXW9N6eOM8z75mFFd6MhT6tjdtWJW4aScxJ2Tohvsu0/aVNhh
	KlaObe4QZCrXCR2syBGW9+zWXdf5v6f+rb58ryhqLz92OFNaFMsZt9Yd5Dkh3L9A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uvbpR-00000007biI-1yNJ;
	Mon, 08 Sep 2025 15:22:41 +0200
Message-ID: <4ef5406d68805d6b176a0078ed0bf21b00052264.camel@sipsolutions.net>
Subject: Re: [PATCH net-next 02/11] tools: ynl-gen: generate nested array
 policies
From: Johannes Berg <johannes@sipsolutions.net>
To: =?ISO-8859-1?Q?Asbj=F8rn?= Sloth =?ISO-8859-1?Q?T=F8nnesen?=	
 <ast@fiberby.net>, "Keller, Jacob E" <jacob.e.keller@intel.com>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski	 <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Simon Horman
 <horms@kernel.org>,  Andrew Lunn <andrew+netdev@lunn.ch>,
 "wireguard@lists.zx2c4.com" <wireguard@lists.zx2c4.com>, 
 "netdev@vger.kernel.org"	 <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>
Date: Mon, 08 Sep 2025 15:22:40 +0200
In-Reply-To: <f574e4b9-d0ea-46ef-bbed-8f607ab7276f@fiberby.net>
References: <20250904-wg-ynl-prep@fiberby.net>
	 <20250904220156.1006541-2-ast@fiberby.net>
	 <e24f5baf-7085-4db0-aaad-5318555988b3@intel.com>
	 <6e31a9e0-5450-4b45-a557-2aa08d23c25a@fiberby.net>
	 <c1a4da4cb54c0436d5f67efacf6866b4bc057b3e.camel@sipsolutions.net>
	 <f574e4b9-d0ea-46ef-bbed-8f607ab7276f@fiberby.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-09-08 at 09:08 +0000, Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
>=20
> Thank you for the consensus write up. Should we prohibit indexed-array wi=
th sub-type
> nest for families with a genetlink protocol?
>=20
> It is currently only used in families with a netlink-raw or genetlink-leg=
acy protocol.

I have no strong opinion on that, but I guess maybe so? At least print
out a warning for anyone who's trying to add such a new thing perhaps,
so that new stuff that isn't just a port (to ynl) or annotation of
existing APIs doesn't add it.

> > I can't get rid of the nested array types in nl80211 though, of course.
>=20
> Wireguard is already in the same boat. [...]

Oh, sorry. I didn't look at the linked patch and thought it was adding
such a new thing. Looking now, I see it just makes the policy validate
it instead of (only) doing it in the code. (FWIW, in the code you could
then also set the policy argument for nla_parse_nested() calls to NULL.)

> Given that, as Jacob pointed out, there are more families with nested arr=
ays in
> their YNL spec, than those using NLA_NESTED_ARRAY, then it appears that t=
here
> are more families already in the boat.

Right.

johannes

