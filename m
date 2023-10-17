Return-Path: <netdev+bounces-42046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842AA7CCC83
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 21:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 661C11C208CE
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 19:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0371D2DF96;
	Tue, 17 Oct 2023 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMZHGMBI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D782EAF7
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 19:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D31C433C8;
	Tue, 17 Oct 2023 19:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697571929;
	bh=Qf4xkuN06EFX0//n+z87j9jXE5pKm2Yh2AAgUDg38vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZMZHGMBInPRKKQMhDr7BadORk21RApp8NtvidBo7RL7fyKCJjqFoGcRcq0eBTijev
	 0nEUF19DiyamGjEx9lQ8W9B9fQuoNJ4vfvXV0CsHPnUbn+cCIL/0Vvc1Z58iKuEkXW
	 8z/7t8BcaiaZpQ7VMvvYt2tfujgr0F+Y2Zb+pjm8vxY55cr/6T+WNkGVAUKweLM9iz
	 oIaEdOLa3f7HQrheNJlCx40V7RiRs/99kLsMnQW89h+4HiiSO3NuLsqcXzJA/96JNv
	 N4DbC1waK12BcBV5RDYTpyUI4hV27UwS+TKO2ZGr/S57jCf22G4F4WNTqXnSC3rdQ7
	 HD0NNc4FxBvlg==
Date: Tue, 17 Oct 2023 21:45:24 +0200
From: Simon Horman <horms@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernek.org, Justin Chen <justin.chen@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:BROADCOM ETHERNET PHY DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: phy: bcm7xxx: Add missing 16nm EPHY statistics
Message-ID: <20231017194524.GA1940501@kernel.org>
References: <20231016184428.311983-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016184428.311983-1-florian.fainelli@broadcom.com>

On Mon, Oct 16, 2023 at 11:44:28AM -0700, Florian Fainelli wrote:
> The .probe() function would allocate the necessary space and ensure that
> the library call sizes the nunber of statistics but the callbacks
> necessary to fetch the name and values were not wired up.
> 
> Reported-by: Justin Chen <justin.chen@broadcom.com>
> Fixes: 1b89b3dce34c ("net: phy: bcm7xxx: Add EPHY entry for 72165")

Should the fixes tag be as follows?

Fixes: f68d08c437f9 ("net: phy: bcm7xxx: Add EPHY entry for 72165")

> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

...


