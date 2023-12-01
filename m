Return-Path: <netdev+bounces-52925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BF1800C27
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 14:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87F6DB20F5A
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 13:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E0633998;
	Fri,  1 Dec 2023 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nHLOwjK6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7o4X1CAC"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6AA13E
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 05:31:49 -0800 (PST)
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1701437507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UPBgS6HkYRkOkv21t9MfxwD13qsaPAeJ9zmSlmunmb4=;
	b=nHLOwjK6VqSE6j91L4KEZqxKl/P4Wu8TNhM5ZWgCihkFT9MGhkiuJRZji8e9B489+jkma4
	yYTSFXhEF3xMzpRAhm2Noy9EbTbthBVzGYgrt+gtN+KSf9F7WBLWBKTqBBbjhSsUtSXKhV
	Ci7cjxcifQzxDf3RhqCQoOdfg5dsHYKIEIl2tAxdXZtSUrVPPgw7iF0Igl8npmadtCNFxx
	nkaHUHwz9c0I9nwgMfORElqfP0lSwf6XBxtSglfb3L8pdvJpjEC+cqeWk1hHUOIfqY0D0P
	19oL9D0cTO/J+1D/G/zYbTzHOQ84a8PYhbwfOhxk9ji2IX6W0ghmBH9DSi1T5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1701437507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UPBgS6HkYRkOkv21t9MfxwD13qsaPAeJ9zmSlmunmb4=;
	b=7o4X1CACoAzwuWvHTrfkLltCTGL/Mq9vwEQevdUG3xY1yDVmpJC8Y5J/lhndAtpT5GsQS2
	a+vODSD9H8qbSCBg==
To: Suman Ghosh <sumang@marvell.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: RE: [EXT] [PATCH iwl-net v2 1/2] igc: Report VLAN EtherType
 matching back to user
In-Reply-To: <SJ0PR18MB52163CF3D9F88A96707B0708DB81A@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20231201075043.7822-1-kurt@linutronix.de>
 <20231201075043.7822-2-kurt@linutronix.de>
 <SJ0PR18MB52163CF3D9F88A96707B0708DB81A@SJ0PR18MB5216.namprd18.prod.outlook.com>
Date: Fri, 01 Dec 2023 14:31:45 +0100
Message-ID: <87fs0m2gn2.fsf@kurt>
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

Hi Suman,

On Fri Dec 01 2023, Suman Ghosh wrote:
> Hi Kurt,
>
>
>>+	if (rule->filter.match_flags & IGC_FILTER_FLAG_VLAN_ETYPE) {
>>+		fsp->flow_type |= FLOW_EXT;
>>+		fsp->h_ext.vlan_etype = rule->filter.vlan_etype;
>>+		fsp->m_ext.vlan_etype = ETHER_TYPE_FULL_MASK;
> [Suman] User can provide mask for vlan-etype as well. Why not take
> that rather than hard coding it? I checked you are already doing the
> same for TCI in the other patch.

Currently the driver allows/supports to match the VLAN EtherType only by
full mask. That is different from TCI, where two different mask values
are possible.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmVp4EETHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgiT6D/sGHAgkvZqoH10WUoVnaxUvE7W0RoEN
h6+7WS0BMVPOWK6dvsvP8QMm9ECJrGpI+BrA4StfbyJci/n2anUeYDPf67ozlInJ
Cw106cjEsIVMxQumY5YJKm/1/Hg3o2aZ1XzVRG5WIjDHJxn7A0qXSZ4FjWZxXEtu
QJ4JsfY7w7A7YAXJHOqXebqlc36OMdxtCjRufH7GDNT0aZHK1JXovOW8/nf70/7+
zz/3ygJvu7691hr+mUazQ0DB6FXFol41EjlITxumdqhdFYYF1Fts0uZ+g0wGdOVn
lAVZ5ss62dTQ3tnedxrADoU65U5LXqiGWg2Zp+R2mwvoUoyzRSmiwG1kq4VF5hWW
fV4xtxLNEUCW1ebQ5OLwYgIBrzGpaOrhnvW1IwRHR9OPa+qyTL8ENd6oMCfQICP2
aA0yrzGhNSy4Ew0P8XFFTfN21+FzziarG8iCtg5TYl6ev4hIfPSdLAKtEC8MbNZD
qB7c10GgGigEQIoPrtFrqSkd1LN/0hFUzPWJTWx/4RSNa18nZrHSHA5JxgsLX0Pp
l/qZChqVWrgphTRCjWvMysVF1DUPa3tkLlRqotACau0AxTXk2eZwFflmVK8AmQoN
Zx2Z3yNpvku3X8GvLHbTcSGqiicEgzCOMGAj/gU+jFvJ1fmx4JVkpwcDoHB0KTsV
E623CKidIznuOg==
=aGjs
-----END PGP SIGNATURE-----
--=-=-=--

