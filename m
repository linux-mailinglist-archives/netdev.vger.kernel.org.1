Return-Path: <netdev+bounces-162619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A311A2764E
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 16:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE31D161DB4
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C7A208977;
	Tue,  4 Feb 2025 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2d3eqqW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC0B2144BF;
	Tue,  4 Feb 2025 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738683907; cv=none; b=lEd3dz2qu+Aq5gk6yuW/e3rn0PGGfT8rKEdB3PSQW8mFLoATzbXPVUYvBUsKXuIkUX/Jt3Jzppt/Ny4GiZIE/h+ORBT/v7IMR82IaSm5jSz+jtfOMJ5Mmjjrn+DWSVq9Es+bNcvJKjzjw/kQAaeaD/0z2+/ARIw3QenDPeKVXiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738683907; c=relaxed/simple;
	bh=k59Pucx7IO1kZ1ZApcZ/pGjKHb3nO0inGP7xta2Ya7c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jn6OwymwFT8tw1E6B1crYSKKiHVs3fnflhNhWYqdjra+kaKY4XKqzAZ3XKAZqZ4KrSon6KIJdCM5hx5ZMU4vxyka7yorE9LJxJPzy8WvBwyWFtzEK9yNCymyww8191p46riiuyXZ9mblfVT+gCsaXULxGuCO63PfTGOiv8Rqb54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2d3eqqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E1FC4CEDF;
	Tue,  4 Feb 2025 15:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738683906;
	bh=k59Pucx7IO1kZ1ZApcZ/pGjKHb3nO0inGP7xta2Ya7c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S2d3eqqWOYSC/iQNunwQhq9/m1sZnqUv+85VH1M/dqITUzIHsdRlvGy5fz3/aBHNn
	 WjGx5aHyXkw6L8iUb077zn7FhAK0urRIXEq/3jVuhLeAM7JKZDQshmOt7gizF/7r4a
	 /sg8dz4yaGTWy5++yiZeqQw8aWvkrxYwPOYval12vvIY1EKGC2xQr3gXzvdPwtcrIF
	 rv72rXYcFm43pXJMH1z2y7d067k33xCydXL8t37hsn5Mm9wlFo9rgJu8wMnqHo6IQZ
	 /D5cTtzlBWlvrApwi3W3B2qe7Av6xosLjuR3D8s2SuO1Eqpax3Liz4Ag3MoO5dAAT0
	 1Smypf/0ZpiTw==
Date: Tue, 4 Feb 2025 07:45:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "=?UTF-8?B?Q3PDs2vDoXMs?= Bence" <csokas.bence@prolan.hu>
Cc: Laurent Badel <laurentbadel@eaton.com>, Andrew Lunn <andrew@lunn.ch>,
 <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Simon Horman <horms@kernel.org>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Jacob Keller
 <jacob.e.keller@intel.com>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
 <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v3] net: fec: Refactor MAC reset to function
Message-ID: <20250204074504.523c794c@kernel.org>
In-Reply-To: <20250204093756.253642-2-csokas.bence@prolan.hu>
References: <20250122163935.213313-2-csokas.bence@prolan.hu>
	<20250204093756.253642-2-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Feb 2025 10:37:54 +0100 Cs=C3=B3k=C3=A1s, Bence wrote:
> For instance, as of now, `fec_stop()` does not check for
> `FEC_QUIRK_NO_HARD_RESET`, meaning the MII/RMII mode is cleared on eg.
> a PM power-down event; and `fec_restart()` missed the refactor renaming
> the "magic" constant `1` to `FEC_ECR_RESET`.

Laurent responded to v1 saying this was intentional. Please give more
details on how problem you're seeing and on what platforms. Otherwise
this is not a fix but refactoring.

Please don't post new versions in-reply-to, and add lore links to
the previous version in the changelog.
--=20
pw-bot: cr

