Return-Path: <netdev+bounces-51125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC7E7F9418
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 17:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804541C20ACB
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 16:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDB3D300;
	Sun, 26 Nov 2023 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="56++GXxv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EF39C;
	Sun, 26 Nov 2023 08:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=j2jPT/9rr9kXvPsTQ11nJwwxmOX/0wSB95nubK+OrHc=; b=56
	++GXxvk0aycH3l+IA1TCnmFUQtlOctVh1L+hFZhIePl6+oxXNV8sbIcBwNipOqqaKfHBNfQ6Gj3vU
	IPDQFgHwbRIKCY9CJ1v5t5qUWDqmphWDvf7a8S/F+S+8Gpre76Q/+TBabmvea6DcgqU0t7w06ebRq
	eVm5PwlyUY8u2tU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r7IGB-001G8A-Mb; Sun, 26 Nov 2023 17:45:31 +0100
Date: Sun, 26 Nov 2023 17:45:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Tim Harvey <tharvey@gateworks.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC] net: dsa: mv88e6xxx: Support LED control
Message-ID: <4bd8642c-988f-4b99-944a-da573d0ef2c3@lunn.ch>
References: <20231123-mv88e6xxx-leds-v1-1-3c379b3d23fb@linaro.org>
 <c8c821f8-e170-44b3-a3f9-207cf7cb70e2@lunn.ch>
 <CACRpkdY+T8Rqg_irkLNvAC+o_QfwO2N+eB9X-y24t34_9Rg3ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdY+T8Rqg_irkLNvAC+o_QfwO2N+eB9X-y24t34_9Rg3ww@mail.gmail.com>

On Sun, Nov 26, 2023 at 12:46:03AM +0100, Linus Walleij wrote:
> On Thu, Nov 23, 2023 at 5:13 PM Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > What i would really like to see happen is that the DSA core handles
> > the registration of the LEDs, similar to how phylib does. The DT
> > binding should be identical for all DSA devices, so there is no need
> > for each driver to do its own parsing.
> >
> > There are some WIP patches at
> >
> > https://github.com/lunn/linux.git leds-offload-support-reduced-auto-netdev
> >
> > which implement this. Feel free to make use of them.
> 
> Oh it's quite a lot of patches, I really cannot drive that because there are
> so many things about them that I don't understand the thinking behind...
> But I like what I see!

O.K. Let me dust them off, rebase them on net-next and see what is
missing. You have some fibre things i don't have. I don't have a
machine with fibre so i cannot test that.

	Andrew

