Return-Path: <netdev+bounces-161909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCCDA24917
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 13:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7456C164A04
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 12:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC8B1A0BD7;
	Sat,  1 Feb 2025 12:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUHGXSUg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798A9AD39
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 12:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738413897; cv=none; b=RGfoY37CYYNWdTE9/dY0HdGIHLsR6TQ42rn5mjmpnvo/dKKRCnbtr6Yzk3syWWOLTExbA3VN2MFQbRTGo3vHrQeFsKXIv3HyYHFWJrM61rvaVJTPsb5tnQx4oO/gq3eHf9/us3syh6TCGR19ls1OIsoNFl8KJnncDORlG9SRrA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738413897; c=relaxed/simple;
	bh=F3ApAeqg339eIORFEKv4vbxJZoN0G29PE0LG7Q7G4WI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZIRdxYun/xdjvxsYaFNsYAacf6HUATL68AKNV/wkOcothxL64ZGIbiey/yVsf7pfyxjs9zictSP0K9VXQlgzJeetNrw1xKIYATfCUp6X0z6u2UxeiTx+Mpy1nU89LmU51Ek9d+2lcZedIZCuQM6mOi+xB2/NxrQHpc6+3nePijM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUHGXSUg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5562FC4CED3;
	Sat,  1 Feb 2025 12:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738413896;
	bh=F3ApAeqg339eIORFEKv4vbxJZoN0G29PE0LG7Q7G4WI=;
	h=Date:From:To:Cc:Subject:From;
	b=pUHGXSUgx0seC9HGSX4dcVbiR0XPD5vsody43LMned4Hc8L4l3lMBJ+oEkJpiFDF2
	 S8z9du3GvdEd4h6dQPJIWZcZhilKJhg2TxriiTNe7wP88axx6whFO/MbD4227RFZMF
	 UuLnHGAolUyEM5E+FHdi+hcohxCFLTuiV6NFsZPJSONRC0vZiKIZNdRKZVZ4jV6yuR
	 4fXihG2a+m8mDcXCxPo6aI69pKxb+cGvGJzNtq4QaiCRMxF1FiAdjKu14qvn9wiYiZ
	 wF5jcDi7FVbj3bK8naV4cGNc5pmeVh+WUwiOwEZ94tZxPuF0WpDDSVfRhz+mClVJKX
	 oUuqdIGB+0i6A==
Date: Sat, 1 Feb 2025 13:44:53 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, nbd@nbd.name,
	sean.wang@mediatek.com, ansuelsmth@gmail.com, upstream@airoha.com
Subject: Move airoha in a dedicated folder
Message-ID: <Z54XRR9DE7MIc0Sk@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fmBdONZK6mCy/V3M"
Content-Disposition: inline


--fmBdONZK6mCy/V3M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

Since more features are on the way for airoha_eth driver (support for flowtable
hw offloading, 10g phy support, ..), I was wondering if it is neater to move
the driver in a dedicated folder (e.g. drivers/net/ethernet/airoha or
drivers/net/ethernet/mediatek/airoha) or if you prefer to keep current
approach. Thanks.

Regards,
Lorenzo

--fmBdONZK6mCy/V3M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ54XRQAKCRA6cBh0uS2t
rIe6AQC5b8LSPRCxESajU35EMzmKb67EwyFfPnqbZpWxBc8JmwD/drNuMMbktDig
FGU+os15opWOE8gdkqyHSNIeigVr4w4=
=hq9i
-----END PGP SIGNATURE-----

--fmBdONZK6mCy/V3M--

