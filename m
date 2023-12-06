Return-Path: <netdev+bounces-54315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E65B8068DE
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 08:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5AD1F21131
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 07:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3EB182A9;
	Wed,  6 Dec 2023 07:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OmiIjAUj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XocsBJtO"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DAAD64
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 23:45:31 -0800 (PST)
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1701848729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ImhXRekMt9cpk9pa5eRkug265vOwXJJZo8PjBv7kvSc=;
	b=OmiIjAUjzpev8U2QenKKINXXUwLhpWdHhPCs+grA7h1zn6LmJsx/+y3rjqUNwbXKL1tvzy
	7GSIk4FdUzcQ+xWYgMWV/JPXdYQzOE2yH8C40s+sHZCxYfpk0yxc5rG29qXd2/KVMKcSd2
	AUFHGFNVKotMFdqXqaWp5rmUA+7jSAv5rMFNhV1ssjFiXt5Ge+zAWj5WgjjnQ+ro5ksnfT
	teMU1EbE4TPO8GmeJn80VpHn4NVT0hfwCvYikSQr/dJGQ29HihhisJzsw7il5e4Zh7qBf1
	jUXbubMoTRms3taATI5f1uxckRfcwFdBO+kEHENM/xly2IGWUWdR8RlrjXqhuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1701848729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ImhXRekMt9cpk9pa5eRkug265vOwXJJZo8PjBv7kvSc=;
	b=XocsBJtOsyFe7bmwsS2rY1ZAtoS6fEAEOgUn0zN/i21hFtGJjibhpbfYhA70AyFnJCnSEs
	avBgJfcjwTM51UBA==
To: Suman Ghosh <sumang@marvell.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [EXT] [PATCH iwl-net v2 1/2] igc: Report VLAN EtherType
 matching back to user
In-Reply-To: <SJ0PR18MB5216C33138C7067A24BD4DE4DB81A@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20231201075043.7822-1-kurt@linutronix.de>
 <20231201075043.7822-2-kurt@linutronix.de>
 <SJ0PR18MB52163CF3D9F88A96707B0708DB81A@SJ0PR18MB5216.namprd18.prod.outlook.com>
 <SJ0PR18MB5216C33138C7067A24BD4DE4DB81A@SJ0PR18MB5216.namprd18.prod.outlook.com>
Date: Wed, 06 Dec 2023 08:45:28 +0100
Message-ID: <87y1e7g4fb.fsf@kurt>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

> [Suman] It is up to you. But I feel, in that case we should have some
> checks to reject the ntuple rule if user is providing some valid mask
> value.

Sure. That's another issue and deserves a separate patch.

> Otherwise, there will be mismatch between user expectation and
> driver functionality.

Yeah, it's the whole point of series to improve the user experience.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmVwJpgTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgtN/D/9OpJAxmYmQzh1XXLo79q59WnuLxMVj
GWR+kMdX9mxkRWjBuFO3pBeje2HA18FnusgUBF0y8b3UrTSq3u5DHGV9ZqBTsn8V
uT0kHNjTLQMMe8+k5WsUztjvc8bOffohyp0M8odNYU7Xgvv2o9980XJ3a64rGsWi
WnsEgrYAS/6I7r5A7WKOMqqZ4tjTI1n2IWTSuD1SubQHtaWvaWdGneit+eCkBQ4Z
li21m57qZfdzjZwxQ7ASBQlnUCcU07ryfHsz3146Gj+/pazafMnWyfgD3wZewJMw
FpJD0UpjidHGyjj+CTmWdppgq5p+LvgdRZiA1vwpX+JjKk/Fhwee8SKIizd3bb73
2IgJ4j9SS4xZSM9fFfBrRoFQGS6l3rE4hzk352N7FojC5q3FSIfgpCqA825Oa6XP
KazJbBPnXbCTusaAo/SpsNpSKBtMCphHiFhf+A+8KxeG70MKaLN7Je0hh/IpLIwo
Z+KHlWKsf2HyLs2rrxy5Q0EfbBjHSkujJL1qIhswZO1AWHDD/xh13Lsy7vnACD59
J1PGeCHIsHDlP/L/F7eXzrvwbVauw4zwNs40xJzCa2MUEhNN2roz9XA0f+mflNFR
W2RHa6V0TyDnj/uGO4WLK5GwTCii5/d2cigpWtsaA86NEPH01ZhcSFvkmXl69Un5
BQt8v5rtIxv1BQ==
=StnT
-----END PGP SIGNATURE-----
--=-=-=--

