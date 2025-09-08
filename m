Return-Path: <netdev+bounces-220729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C63B48623
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 09:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 849CA3A994F
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 07:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA64A2E610F;
	Mon,  8 Sep 2025 07:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="N3V4OLCc"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4293E249F9;
	Mon,  8 Sep 2025 07:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757318143; cv=none; b=G1hVyqrVMBTH857661VdgbfLdNnnMGT9TrsdTREiBLtBog6WMTuMDyfBV7XL8Td0GexMO86hPSaXRCUVOJqYdT6vXD5vKN31QpFcvJ6yeSWK7KDwCfpplAKFUrjeblh1UtoxFR9irs+lhY3U3YB6R/j0Exlk6fyaGG7kDHed+28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757318143; c=relaxed/simple;
	bh=nhqRh9PPeHATPPUMi9j7S6OlMPAIqMETQQdLoQOlCxc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fowvPQqmxnPXEikioo9nqkFM2KtlBXDCKMKiaH/0QoXQ3CoPGHa//GlDtTc4uSgveFQo/abUm6eyOMLKCIaFWKB4Et6NxnBLrR7JqC0yovMGU34b3xLJkzT5iptXahxjSUq9rWRsOqGRKCMjCq1aIGKFMfOIoKRcb/cE0zFbNc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=N3V4OLCc; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nhqRh9PPeHATPPUMi9j7S6OlMPAIqMETQQdLoQOlCxc=;
	t=1757318142; x=1758527742; b=N3V4OLCc0gnKZtvC1LPDscwblSh8fXXZ14tusEd/coxKbyu
	misOGlPr0xPvw/1lTe4B58a9eZO5YihR79/Z2/VuyYbYUsBzcKaxa9zXVYgMOjsAKw04zVIcsVYvz
	IonVbVgoijYdr+dKhoKLIlkOn8q/OSlIsAhpvll2qSKGb46v9EO+lsVAvPGj0e8+SF5kkBjirljvx
	UYd5F9PRU3L43cZSiwAAunki3imXA9MAoNvjIsJZyNIXc+Ih57FKWxvhsW84sEqGilQcQTNATxGvp
	9K7ffbXA8zCzxZnyMWlO4GEF/vrE34qpJEQ95wJ/PJA67kCIsIGFrAkfwAeA5hdA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uvWir-00000006ziP-1450;
	Mon, 08 Sep 2025 09:55:33 +0200
Message-ID: <96db85326505785727bcfe45b99ae12fdbfb548a.camel@sipsolutions.net>
Subject: Re: [PATCH net-next 06/11] tools: ynl-gen: don't validate nested
 array attribute types
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
Date: Mon, 08 Sep 2025 09:55:31 +0200
In-Reply-To: <d612ce20-ae4a-4f6d-9d1b-a3d56f3d10a9@fiberby.net>
References: <20250904-wg-ynl-prep@fiberby.net>
	 <20250904220156.1006541-6-ast@fiberby.net>
	 <d2705570-7ad2-4771-af2a-4ba78393a8c4@intel.com>
	 <d612ce20-ae4a-4f6d-9d1b-a3d56f3d10a9@fiberby.net>
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

On Sat, 2025-09-06 at 15:10 +0000, Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
>=20
> For the other families, I don't know how well defined it is, Johannes hav=
e
> stated that nl80211 doesn't care which types are used, but I have no idea
> how consistent clients have abused that statement to send random data,
> or do they all just send zeros?

I think most clients probably send incrementing numbers (1, 2, 3, ...),
but maybe some start at 0, some sometimes might use band numbers and
thus have sparse values, etc.

But as I just wrote, I'm not really sure it should be used at all.

joahnnes

