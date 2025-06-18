Return-Path: <netdev+bounces-198916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59912ADE4D1
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 09:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1963BC874
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 07:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18640253941;
	Wed, 18 Jun 2025 07:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FujFC+7A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F31944F
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750232994; cv=none; b=pxbWk/ptJ8gdSh0EQr8QCDQIFVjkaczsVSbOrwdex3xXpErtI0vdWtBKM12T+urfsDNa0iXrg0RTG7UOGwTJl/0Ck1zpmb1mffMW7Ag1RzsLeVf209mnwYbj5Y0rM7oSIJx/0+3YnCPBADJ4kE3+JOQi+4ggtOmrRqHWA+x3/Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750232994; c=relaxed/simple;
	bh=aC64CEq1Onwzg7hQyJBpP3n73y+2vG8xqxjywocSUUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQkard7TwbyYV+HrdDEJfYVjpBPNlcm4HW6UCfJ2AwlW6CE14bCNwwmI9J3Z+LjtFHI7TuDfDVbx0DwKWwXP7UEFY4CkjGgDV/uZhFBCyAS29GTkuSOBs7g/JLMjEslPLIHZJLH1TWvcmVCLRgca2ACpEI8/9Sisz4Q/V047y44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FujFC+7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9BBC4CEE7;
	Wed, 18 Jun 2025 07:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750232993;
	bh=aC64CEq1Onwzg7hQyJBpP3n73y+2vG8xqxjywocSUUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FujFC+7Ahq84E2eCe+Iiou4DRzWv2GhCOKy0IPaIsSQypsdcoCFpIHGUboR85UBkm
	 FvLILNyJOE7g/IDFE9scsVoaGTGPmbAYEHTLI0DDgydUhYlhYz8XNTmazgJGu6maGL
	 sLstO3vI5FXbowGzjg2IDWMa9cWPTFyOuT4blRD2K17dPJljo2l3JR02ksGjsWwvpw
	 dB8NXfC7BKglijPdr4A7aXSCdp9qLPZzk8O5WJwg/9KZJHO4/PG6I5EN22ral76jBS
	 JAN163WWy4+TW+4GlIraP6DyBcNaAerYnA2/kS1S7mRb4Q0BZtUL5iiSa6NXqIIfBC
	 1Xi8l+90P9WZg==
Date: Wed, 18 Jun 2025 09:49:51 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] net: airoha: Improve hwfd
 buffer/descriptor queues setup
Message-ID: <aFJvnxVVM_sdSpKX@lore-desk>
References: <20250616-airoha-hw-num-desc-v2-0-bb328c0b8603@kernel.org>
 <20250617183244.641d9cd3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v6JufC9cwr1xoEbW"
Content-Disposition: inline
In-Reply-To: <20250617183244.641d9cd3@kernel.org>


--v6JufC9cwr1xoEbW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 16 Jun 2025 15:45:39 +0200 Lorenzo Bianconi wrote:
> > Compute the number of hwfd buffers/descriptors according to the reserved
> > memory size if provided via DTS.
> > Reduce the required hwfd buffers queue size for QDMA1.
>=20
> Same question regarding target tree, FWIW

ack, fine. I will post v3 targeting net tree.

Regards,
Lorenzo

--v6JufC9cwr1xoEbW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaFJvnwAKCRA6cBh0uS2t
rHwQAQDRWhuDKkooK+3SdVhoIcSjVlWNQW9cx1j+py4qwhHrxwD/REl0bOTp+6/n
fZd/+nOnfqJphhHl2l5TM92s7tbawAI=
=pcct
-----END PGP SIGNATURE-----

--v6JufC9cwr1xoEbW--

