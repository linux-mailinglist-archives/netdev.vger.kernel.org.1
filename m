Return-Path: <netdev+bounces-187306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C248AA64E2
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 22:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539303BC629
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 20:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A561E8855;
	Thu,  1 May 2025 20:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fp3HaqMA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED657083A
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 20:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746132429; cv=none; b=u9fruW2QT1L2Md8zWI53pPshHna+6+inbGiXMFHCa8iKfHc9TXloqaUWF4y8dtQZ74K3RbKXGWQk3OP4EOl5PSg+WWhVwTZVRNe1kHpFbHjHjjampzRDwlzvuwPPuQJxeyL8OOWh7mLB2nADfPmobiaGtsGuR3ZuBf9wVpwXzZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746132429; c=relaxed/simple;
	bh=c09lk6K3YO8nS0KvYKheCXbPOVWu+SLwqbVSB6+4KRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLJAoYBWKdwe+prH9WI8pZyYClcyjxpPtaYUc9YA36R61L+VESmZNWr1n2zSSwCO1gPxuAHNQGSB4gDfF6cluFCcpdYIyrPR0gTMQD1QFdQXP+QW7flO0qoqrVPuFeQc5mUhnsSppORFqPhS/yeblSMzzrIsxKPHjX4qigMnBmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fp3HaqMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1810C4CEE3;
	Thu,  1 May 2025 20:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746132429;
	bh=c09lk6K3YO8nS0KvYKheCXbPOVWu+SLwqbVSB6+4KRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fp3HaqMAExVxltGru5F6kWIKHOkCmpTjE5vDVBR3Ikh8PxRnbdZIC7UL/Zti8QSF1
	 9VAyk02BUKwonpMZ9R0UTng8GGYTTwisl4CU4NINn5d8GuKVmmt82MxhyLCb+aW4H0
	 1SpofpnbopLtOnk7NKO1QT727/EVjVnOFaowCdxUOXG2eN+7IYprrWSrVoAvkHTrOE
	 FNZhoHI/fgLQ1t2EZbkHXU+PmeX/KVo9pWZxU/VUk0eYBwQ2EQ/YyQ9k5s3FOtpVJh
	 pNVSMhbCcNVi2bjRrmyh3ox0NGxZC3I1g1SiHlxppWpepDb/q41uZ0Gczz+a5xnAW1
	 1WdetZSt+VgkA==
Date: Thu, 1 May 2025 22:47:06 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net v4] net: airoha: Add missing filed to ppe_mbox_data
 struct
Message-ID: <aBPdyn580lxUMJKz@lore-desk>
References: <20250429-airoha-en7581-fix-ppe_mbox_data-v4-1-d2a8b901dad0@kernel.org>
 <20250501071518.50c92e8c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c1jF/W4ziIWJGsAB"
Content-Disposition: inline
In-Reply-To: <20250501071518.50c92e8c@kernel.org>


--c1jF/W4ziIWJGsAB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 01, Jakub Kicinski wrote:
> On Tue, 29 Apr 2025 16:17:41 +0200 Lorenzo Bianconi wrote:
> > Moreover, add __packed attribute to ppe_mbox_data struct definition and
> > make the fw layout padding explicit in init_info struct.
>=20
> Why? everything looks naturally packed now :(

What I mean here is the padding in the ppe_mbox_data struct used by the fw =
running
on the NPU, not in the version used by the airoha_eth driver, got my point?
Sorry, re-reading it, it was not so clear, I agree.

Regards,
Lorenzo

> __packed also forces the compiler to assume the data is unaligned AFAIU.
> The recommended way to ensure the compiler doesn't insert padding is
> to do a compile time assert.

--c1jF/W4ziIWJGsAB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaBPdygAKCRA6cBh0uS2t
rNmWAQDg2BUSYvHrs8L2q54TesvQyahWGkNZ9Gvtio431NOhFgD/Z4fFaMqjgP5E
FG9oyib06hjPa7jUUJ/4Q6ZzHA4RpAU=
=8BzH
-----END PGP SIGNATURE-----

--c1jF/W4ziIWJGsAB--

