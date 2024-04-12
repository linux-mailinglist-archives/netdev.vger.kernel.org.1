Return-Path: <netdev+bounces-87391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855F08A2F48
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B65951C211B0
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 13:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5B383A1D;
	Fri, 12 Apr 2024 13:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXPEuMar"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BB1839E4;
	Fri, 12 Apr 2024 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928050; cv=none; b=nuK9VvA6QUBiqm+jETfCBdvR8QinNMQLOfZIiuHy3/Tk6BLqsUKSnUxV5mimaol7YMFf0QfVj3gqgJOD9ornelTt4HAzEjQCTrGjx9r3qLbw8CUIA6MGjrYnEkkP96AzYOSRY6MiJp9wQOqALF08Ef1gjCahU8FD31J38G/sYPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928050; c=relaxed/simple;
	bh=PQQpzC8aHtKvR7HTwtyF8FbW128SqKGMM542lazOo/Q=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=UBcHWPhMdFBTc5Q65oeLGZN7i58IeY+FqLs/MxMhIqvc66K06c5yiJKwiqGMd0byVAnPIc8xykLcIQ2adAbBQpsXCyyTWIu8pVveqaZ4QMyhZUUXxlyz7gCsBCMLAoMJ3u+zgxoFdE+7zMxbjKFZBlNCQ4Byqc401mxhNSRNKwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXPEuMar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15368C113CC;
	Fri, 12 Apr 2024 13:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712928049;
	bh=PQQpzC8aHtKvR7HTwtyF8FbW128SqKGMM542lazOo/Q=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=gXPEuMar9KadNdw2Nt9ANpGzPAoYAuCgC4JpO6unmTDSz9S+fC/cHa55zUKK7VY8s
	 T/sfC8Q+ynMmnfQJDIvsv5XNt6H2ilF7GSAqfA/3dVzq38IeARX5LZfCq8LZKIWN7X
	 MlOLUCLLe8Fb8m49SN6rTdJ5zymIdVvipaIxcHVGVA5pN6kEy5sPyz5pvGQvCzhA04
	 XuIIT6LT2iXEPVJFo9N95EMyf6einhJv+i4FZUYV9NrG88e1iV9lJIdvb8E+KgZVSW
	 hrnOZJk4Yiwnl14wogcLka9jRxCLRCqeLu8S/v3DGP/pnGyZUPUno5Iojwg/uEB1+p
	 NZdSEb2P2DEXw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240412151648.653d41be@device-28.home>
References: <20240412104615.3779632-1-maxime.chevallier@bootlin.com> <171292699033.4917.4025686054785818967@kwain> <20240412151648.653d41be@device-28.home>
Subject: Re: [PATCH net-next] net: phy: phy_link_topology: Handle NULL topologies
From: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, =?utf-8?q?K=C3=B6ry?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, Marek =?utf-8?q?Beh=C3=BAn?= <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>, =?utf-8?q?Nicol=C3=B2?= Veronese <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>, mwojtas@chromium.org, Nathan Chancellor <nathan@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Fri, 12 Apr 2024 15:20:46 +0200
Message-ID: <171292804624.4917.3749042257366624495@kwain>

Quoting Maxime Chevallier (2024-04-12 15:16:48)
> On Fri, 12 Apr 2024 15:03:10 +0200
> Antoine Tenart <atenart@kernel.org> wrote:
> > Quoting Maxime Chevallier (2024-04-12 12:46:14)
> > >=20
> > > This patch fixes a commit that is in net-next, hence the net-next tag=
 and the
> > > lack of "Fixes" tag. =20
> >=20
> > You can use Fixes: on net-next, that still helps to identify which
> > commit is being fixed (eg. for reviews, while looking at the history,
> > etc).
>=20
> Won't the tag become invalid when the commit gets merged into an -rc
> release then ?

If the commit is in net or net-next it should not, as it'll be pulled &
merged.

