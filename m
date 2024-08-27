Return-Path: <netdev+bounces-122191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CB79604DD
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 10:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BEACB23FAC
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 08:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02E919DF9E;
	Tue, 27 Aug 2024 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RYaxzkwg"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C201319D06C;
	Tue, 27 Aug 2024 08:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748512; cv=none; b=XAQC86ynG2GUXy0ZwzpDC4deDFYFVtzQ2VDXO2p+D2MyPoQrfKel2jTonRAOvo3g1AgFWuQPkCRgi3SCCoPacQTagcs0I2XQRWpZh2dcKCaai0tIDwY2P1hjNivqpzA8+owmE6oBrX1xEW3nw5XCjBEyyCjblAmv4Dt4lDko/tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748512; c=relaxed/simple;
	bh=MP2fugfol8ynhnMrcyf0In9mn3dW/xM1Q/E1PtVnEUY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j+Wrm+PDyIAw+fEQSqTx+Fp+sp5d3mEU5ztZOaJP1wpYGhChVDsrw4qBPhWRnHs7Uro8RfklhXtFydw6pI6G/bayHsp1zFnCrlk5N4B2jNLpoEOvXW6Fq1OC8i0DPGQmhr4smb4aDi+2oFEo+eIZ/nnYuvGVd9WdBNQtj/5F+Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RYaxzkwg; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 61CF41C0005;
	Tue, 27 Aug 2024 08:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724748509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2UUzozClc1g/4wJHL7AZEfKpZ+z049vTa6KhZnn20Z8=;
	b=RYaxzkwgyvA0kHKjcM0ddbBmpvVD9HrE+anbiBb+fKay0rhCN0u1RFwDaklS20Ghx4FlRE
	JEpTZueS3BbpQeJogXXfAtmLTAmI5DEhXwKbpoLHeQ8wBODAs9uyAvLERMElM+TTNOBs9T
	mJ6ysxcTXN5lg7ULV0F87ayOpogBLhj9B+SeXKvJxUWnt3rsXobvaRYodgCfq1i3/HmGW2
	G0VAJ2khJzte84kaHaXyaS502p/GZVIv8sOS0jI1XEIxSV9Irx0lAVeueDPxOqk8r7jQw4
	GXfdi3WAfrcK8WWIBs4Jyv+2RjWIR/zBaJH8F300HG50wRH3Z7dymRfEB+p9Ww==
Date: Tue, 27 Aug 2024 10:48:25 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Pengfei Xu <pengfei.xu@intel.com>, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Nathan Chancellor <nathan@kernel.org>, Antoine Tenart
 <atenart@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Romain
 Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next v17 11/14] net: ethtool: cable-test: Target the
 command to the requested PHY
Message-ID: <20240827104825.5cbe0602@fedora-3.home>
In-Reply-To: <a1642517-366a-4943-a55d-e86155f51310@stanley.mountain>
References: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
	<20240709063039.2909536-12-maxime.chevallier@bootlin.com>
	<Zs1jYMAtYj95XuE4@xpf.sh.intel.com>
	<20240827073359.5d47c077@fedora-3.home>
	<a1642517-366a-4943-a55d-e86155f51310@stanley.mountain>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi again Dan,

On Tue, 27 Aug 2024 11:27:48 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:


> Could you add some comments to ethnl_req_get_phydev() what the NULL return
> means vs the error pointers?  I figured it out because the callers have comments
> but it should be next to ethnl_req_get_phydev() as well.

Actually I replied a bit too fast, this is already documented :
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/net/ethtool/netlink.h#n284

Is this doc clear enough or should I still add some more explicit
comments ?

Thanks,

Maxime

