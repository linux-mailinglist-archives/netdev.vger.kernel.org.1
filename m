Return-Path: <netdev+bounces-54535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CFB80767B
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 18:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355AC281E2B
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C87675BF;
	Wed,  6 Dec 2023 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f/qmW/7y"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FB9D4B;
	Wed,  6 Dec 2023 09:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6X7O5epCsOfTjuHXsOxezweSc/fmC/ho/w3obkk2LE0=; b=f/qmW/7yq7sQKXOTiF9UOa+QOy
	dOJQV1xUYV5OP+GuhlyrpZ/XRu+TcCNxbz5BgZVbciClcXU9652paW7DVYo5EZd94U7OioRz6HYGg
	Oi02Pa6khDuxGoDouBZ9ZgqahyedfF9zVyndJr4vocne97mOmqKk+xsYFmoJq4vBVYD8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rAvcg-002EYs-Lj; Wed, 06 Dec 2023 18:23:46 +0100
Date: Wed, 6 Dec 2023 18:23:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 10/12] net: phy: at803x: make at8031 related
 DT functions name more specific
Message-ID: <b91641a7-4a0c-485b-a678-d6bcd32dab25@lunn.ch>
References: <20231201001423.20989-1-ansuelsmth@gmail.com>
 <20231201001423.20989-11-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201001423.20989-11-ansuelsmth@gmail.com>

On Fri, Dec 01, 2023 at 01:14:20AM +0100, Christian Marangi wrote:
> Rename at8031 related DT function name to a more specific name
> referencing they are only related to at8031 and not to the generic
> at803x PHY family.

Its not clear that this simply renames things because it also moves
it. You cannot see the rename in the diff.

Please first rename, and then move. Two patches.

       Andrew

