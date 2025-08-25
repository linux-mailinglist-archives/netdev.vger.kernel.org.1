Return-Path: <netdev+bounces-216571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C1DB34960
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 19:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 539DD2A5CA0
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 17:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C0F304BB9;
	Mon, 25 Aug 2025 17:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SH3ZDv1T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E23275852;
	Mon, 25 Aug 2025 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144439; cv=none; b=NBMZbY0n91ytc0WSEg8o0tWN54iEeJlY7CGHXGdkiqqeGtrTXH0VfgSszii7ZWS8rqsYHjaMpKfeeZbXA/UEBux5Thd9aTjRFF78r+AaDrCxpY5p/j8OyIkSCMyQll8rpZ15ycLb4Ptl3ao2GBu4NDmKIZLC1fJWN6x8sLFAlFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144439; c=relaxed/simple;
	bh=4E38rh8V+YWymzDS50dp0trntWS2F93DOOwUMD6WkEk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RRZMnZyLY2VSggUjATy4xsx1MbZw4u5hdzNx61uaaoGxBF3nLgpz4+i9MQYoghiiWkCG94T/TNRb68R2FgIPd1W5xEzYJhIJ9uCZJVNh5ke6XPAFEYNPITricC/lL8i5NCitWL4njgvOtXUZvsb+0TTaUhfY6T6DIpm/YQ+vqQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SH3ZDv1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F360EC4CEED;
	Mon, 25 Aug 2025 17:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756144438;
	bh=4E38rh8V+YWymzDS50dp0trntWS2F93DOOwUMD6WkEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SH3ZDv1Trryjz3KmgfUEJ6maJIFebAbQGQnJ/GU83floZOXtIv0IYlblilStHqa6K
	 85wc0En3k2vy3uDYfHzBtkLGAg57o//e3IDKAh7Ai1HeAFwliawSVuqOXunJrwTXU+
	 iMglzZxhp7BdKzWq/BsnCjcvlmpv85M0DWdfOaSPLdqoxq63rSjVPWVAagd9kpZ1Jt
	 GYjx0Zn9X7s6tfSY7TsEIGudKw2an0P6MWfxxablqUcRO/3Rf0UgmH7Efec8Kf4ZAJ
	 lgS3jRskISu/kNwkVNidckmsYymRTAor62V+g0JxlKXcsZRaGXrOYbCI6SmALow7aC
	 N34frzobTCkwA==
Date: Mon, 25 Aug 2025 10:53:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Daniel Golle <daniel@makrotopia.org>,
 linux-kernel@vger.kernel.org, Nikita Yushchenko
 <nikita.yoush@cogentembedded.com>, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>, Robert Marko <robimarko@gmail.com>,
 =?UTF-8?B?UGF3ZcWC?= Owoc <frut3k7@gmail.com>, Sean Anderson
 <sean.anderson@seco.com>, Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH net-next 00/15] Aquantia PHY driver consolidation - part
 1
Message-ID: <20250825105357.678b163c@kernel.org>
In-Reply-To: <20250821152022.1065237-1-vladimir.oltean@nxp.com>
References: <20250821152022.1065237-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Aug 2025 18:20:07 +0300 Vladimir Oltean wrote:
> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Cc: Robert Marko <robimarko@gmail.com>
> Cc: Pawe=C5=82 Owoc <frut3k7@gmail.com>
> Cc: Sean Anderson <sean.anderson@seco.com>

I feel like the chances of getting this properly tested are slim.
Let's apply and find out..

