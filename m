Return-Path: <netdev+bounces-63023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9EC82ACC4
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 12:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849161F22F29
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 11:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834D414F7B;
	Thu, 11 Jan 2024 11:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P25cJYRu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAA114F6F;
	Thu, 11 Jan 2024 11:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404F4C433F1;
	Thu, 11 Jan 2024 11:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704970975;
	bh=pJz6MwE2zBPVI4q4f57nWgVYzmFvUxMHAkevW/NMbk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P25cJYRuVtBiv+DEUg07HRqzlxooGGBwT0C1UQXWoXFpMqMPtpvsSSkZl3QAMIa7Y
	 wl1XaVbkO+mQmy9J7YFpLi2eB0Df2wX4FCuOEoG7BO58k3YTMXLxL1OaZhWGxFwdqw
	 gPpLcT9RUjEfXlEJFI7PfZ0FWLfvdgsz/gZzGUOhzxQcnO94f1JLzl4n9XbBHDRtI3
	 d7nQI/zjftRZKQ2y3z2fIQXDDjKf0VEHIHA+SZcxFCsveIuuOgBhcbsvmCARDTBcao
	 ZP5JKO9UNurGvzFzxX4SW9zNkPrV509nTZOWyRl+NG0+MVPc8Mx2PtZXrtcajAPUz6
	 oGlJQMV6RZ1TA==
Date: Thu, 11 Jan 2024 11:02:47 +0000
From: Lee Jones <lee@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Pavel Machek <pavel@ucw.cz>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	=?iso-8859-1?Q?Fern=E1ndez?= Rojas <noltari@gmail.com>,
	Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Subject: Re: [net-next PATCH v9 2/5] dt-bindings: net: phy: Document LED
 inactive high impedance mode
Message-ID: <20240111110247.GD1678981@google.com>
References: <20240105142719.11042-1-ansuelsmth@gmail.com>
 <20240105142719.11042-3-ansuelsmth@gmail.com>
 <37668408-9930-4984-8182-fc315e506211@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37668408-9930-4984-8182-fc315e506211@lunn.ch>

On Tue, 09 Jan 2024, Andrew Lunn wrote:

> On Fri, Jan 05, 2024 at 03:27:14PM +0100, Christian Marangi wrote:
> > Document LED inactive high impedance mode to set the LED to require high
> > impedance configuration to be turned OFF.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

If the DT Maintainers are happy, so am I.

Acked-by: Lee Jones <lee@kernel.org>


-- 
Lee Jones [李琼斯]

