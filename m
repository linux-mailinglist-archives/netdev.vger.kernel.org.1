Return-Path: <netdev+bounces-120298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4783958E07
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 20:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2548BB210D0
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 18:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CAEEAC5;
	Tue, 20 Aug 2024 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGVUmM50"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCEC28F0;
	Tue, 20 Aug 2024 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724178637; cv=none; b=KvqTR3HkzKClBiXpSE8s3SbdCVqeVdd7whdM26RhfO3WSVK1sVynrJH/VQX8ZzuFFs59zJ03Y1JAk1e4kMrUsJ1V4Foof7NsuNKsmlOj4zji/eqwzEoRlBUz9+cSKeIo2Fsj5Y3IYYzp4zQEeCIxp0BMZeYo5gyBRq9eF58hgeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724178637; c=relaxed/simple;
	bh=dn831CvReeE95oeyJnj7kcLxps/9Y9GiSL2V6cuxAZI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=H+u2jq8OsCaU/4JRaHuS4GhtVPqISB6Pqk413bLwOTj4DzJU7dozS219Y7ItTTdQ6orcf/0nPDa4n02SrpdJVty/7vtuMbjO2sSM9QVR+lReHQs43kMVtd4TI4tYRG79lCIUEKVz5uy7szFiw8dOGqVLyHiwhBlxbk8N3fTapCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGVUmM50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC91C4AF0F;
	Tue, 20 Aug 2024 18:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724178636;
	bh=dn831CvReeE95oeyJnj7kcLxps/9Y9GiSL2V6cuxAZI=;
	h=Date:From:To:Cc:Subject:From;
	b=vGVUmM50fyG1MRa0QI7uq18I0ljXIZCF0G53FR8Ut3WgCtv9vW1mn56/QbGFuXBId
	 k1fi4NxlGLAjpp8kBe+DTTSVhwjawRkkC6p5SxeBudRfUMSf/ZZagmQbUWg5k+vNwK
	 L6EbT5u3inGGIs9savRifLmwydBRxxOiJei8p0A7AbhSRGxVtN7rsQEXpd2c9UlRkW
	 fH+rNbO1X53xf7zkng1ULNr2dSXU6j6CppMAB9KASbyGTlPn5oNKeYcq+hDNO7iefN
	 uegS+Tr0wEMtRftGoHTljyozAK0UWDUm+YsNExT+9QtrlYGRBNyBVIj03/lIu3WXKY
	 p8LMZ+Zl76Kfg==
Date: Tue, 20 Aug 2024 11:30:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>, Kalle Valo <kvalo@kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>, Pablo Neira Ayuso
 <pablo@netfilter.org>, Steffen Klassert <steffen.klassert@secunet.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Matthieu
 Baerts <matttbe@kernel.org>
Subject: [ANN] net-next shutdown plans around LPC
Message-ID: <20240820113034.73448a88@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

LPC 2024 will begin less than a month from now, on Sept 18th.

The conference will take place very close to the merge window 
(either during the first week of the merge window, or the week
before it). Since a lot of the maintainers and reviewers will 
be attending LPC, netconf, maintainer summit etc. - we plan 
to shut down net-next on Sept 13th (end of the week before LPC).

If Linus cuts final 6.11 on the 15th - this will be a non-event.
If he doesn't - we will operate for a week with 2 trees in 
"fixes only mode", with net-next only accepting fixes for
code already in it (and net operating as usual).

For sub-trees which feed net-next, we would appreciate if
the PRs were posted by Sept 12th. We may still pull extra
stuff the week of LPC if merge window doesn't open, but
would prefer not to :)

 - netdev maintainers

