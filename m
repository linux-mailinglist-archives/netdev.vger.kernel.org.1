Return-Path: <netdev+bounces-54076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 746F5805F22
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 21:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998811C20B7B
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 20:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1D66DCF5;
	Tue,  5 Dec 2023 20:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="K2GrCTqP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58884183;
	Tue,  5 Dec 2023 12:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jJ9sUxistCYfXxn3AjS422gVO2JAhtrQB/n0qsuzpCI=; b=K2GrCTqPGZyOyLOd4c8Hy7pukH
	2n1l946J8qDLN59IrvFOKa//pddhem8F/rnq0m1bdxy6du0518ZbcAAbucA6svtLRytGX82xdSBsG
	oQEyIxyG7c54gl1NOemmR7yL2PFEtvzWqV518z6YtG6koHC9QdVC26wGREVOo1Fzx3YE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rAbky-0028ZN-Ig; Tue, 05 Dec 2023 21:11:00 +0100
Date: Tue, 5 Dec 2023 21:11:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Epping <david.epping@missinglinkelectronics.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Harini Katakam <harini.katakam@amd.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Subject: Re: [net-next PATCH v3 3/3] net: phy: add support for PHY package
 MMD read/write
Message-ID: <a3572abc-b49a-44e7-b36c-cf462bcc09ac@lunn.ch>
References: <20231204181752.2be3fd68@kernel.org>
 <51aae9d0-5100-41af-ade0-ecebeccbc418@lunn.ch>
 <656f37a6.5d0a0220.96144.356f@mx.google.com>
 <adbe5299-de4a-4ac1-90d0-f7ae537287d0@lunn.ch>
 <ZW89errbJWUt33vz@shell.armlinux.org.uk>
 <20231205072912.2d79a1d5@kernel.org>
 <ZW9LroqqugXzqAY9@shell.armlinux.org.uk>
 <d2762241-f60a-4d61-babe-ce9535d9adde@quicinc.com>
 <ZW9oc9TO93kOq20s@shell.armlinux.org.uk>
 <91dcd8c3-ae86-4350-838d-62ddb62fa2bb@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91dcd8c3-ae86-4350-838d-62ddb62fa2bb@quicinc.com>

> Having worked with closed-source systems, especially VxWorks, for many
> years (where the header files contain all the documentation), it just
> seems strange to embed the documentation in the .c files.

The key words here might be closed-source. With such black boxes, you
don't have access the sources. You cannot look at the source to
understand how a function works. In the open source world, the
comments partially function as an introduction to reading the code and
understanding what it does. You are also encouraged to change the code
if needed, which in the closed source world you cannot do.

Given this discussion, i now think putting the documentation in the .c
file makes more sense. For the generated documentation it does not
matter, but for the reader of the code, having it in the .c files does
seem to make sense.

     Andrew

