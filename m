Return-Path: <netdev+bounces-44825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4123B7DA083
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 20:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B751C210CD
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 18:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3A13984C;
	Fri, 27 Oct 2023 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iClpXEym"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1285D3D3A0
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 18:32:06 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7AC30F3;
	Fri, 27 Oct 2023 11:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YAfUWxLC1GUf2fMq8BZjyh6NawC+UIiZZsgihycoOF8=; b=iClpXEymV0uPqKDpSL6LJaRvLT
	czGTYAl1cxP2ielr6UGJSBLC/dKdvju8+FslemWkqy6SdQHYMnWNyqqdLxi7/m+EP2NSIKTcNZwjG
	HXLE6EV2HSMFLwJ1aLOE1ZFP57R3gnMORBlbLEg4G55xfouAz66ufGyoAk7nq5YkxueE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qwRbq-000MPT-PO; Fri, 27 Oct 2023 20:31:02 +0200
Date: Fri, 27 Oct 2023 20:31:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Willem de Bruijn <willemb@google.com>,
	Daniil Tatianin <d-tatianin@yandex-team.ru>,
	Simon Horman <horms@kernel.org>,
	Justin Chen <justin.chen@broadcom.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Joe Damato <jdamato@fastly.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jiri Pirko <jiri@resnulli.us>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 5/5] net: bcmgenet: Interrogate PHY for
 WAKE_FILTER programming
Message-ID: <47ed806c-69b9-401b-81ee-ec88235092a6@lunn.ch>
References: <20231026224509.112353-1-florian.fainelli@broadcom.com>
 <20231026224509.112353-6-florian.fainelli@broadcom.com>
 <0a164b9b-4f9b-4886-b19e-48298cdcff8d@intel.com>
 <2eeb8e24-4122-450b-adf5-8c8a746db518@broadcom.com>
 <6456509b-9df7-47e3-b941-c307594a80d2@intel.com>
 <93abb8d0-40c6-4758-a8de-c79d7acce6bc@broadcom.com>
 <2ad82651-8e52-47ea-a567-2382b26f3c71@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ad82651-8e52-47ea-a567-2382b26f3c71@intel.com>

> It does seem like an acceptable compromise here, and perhaps being
> driver specific is ok, since this does depend a lot on the individual
> device support, thus broadly applying this across all drivers could be
> problematic.

The Marvell PHYs have a similar capability. Its actually more feature
rich. It allows upto 8 matches, each being of up to 128 bytes, and you
can enable/disable each byte within the 128 bytes. This would in fact
be better for Florian's use case, since it could match deeper into the
frame and reduce the false positive. But its a Marvell device...

My real point is, other hardware does have similar capabilities. Its
unclear if anybody else will ever actually need it, but we should try
to avoid a one device solution.

   Andrew

