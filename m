Return-Path: <netdev+bounces-29530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D68B783A81
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 09:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EC5D1C20A44
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 07:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A516FAC;
	Tue, 22 Aug 2023 07:11:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC7F79CC
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 07:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2ACAC433C7;
	Tue, 22 Aug 2023 07:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1692688274;
	bh=5abBsOROkeket/n7uPinBiqxWhdIx3NpC4zEAOxIpxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oxLL2jmPdNfZmpr/pZgBbY4ebnfkLiqxLltvx4pgd8VIBLhzCsqNCXCdbl5WwM7i0
	 LmAiVPNrkDlX6AGpYnVGGykVbbevC7t4KMQoQr/LhORPt12Kegs5Je+RAkshwXxIDO
	 Krky6Q/HZHA5nGeRXupUSLJoFmNHVU2MPngpmjgY=
Date: Tue, 22 Aug 2023 09:10:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: stable@vger.kernel.org, Justin Chen <justin.chen@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:BROADCOM ETHERNET PHY DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 4.14] net: phy: broadcom: stub c45 read/write for
 54810
Message-ID: <2023082252-motor-grower-5621@gregkh>
References: <2023082134-chain-tubular-c681@gregkh>
 <20230821215410.3123513-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821215410.3123513-1-florian.fainelli@broadcom.com>

On Mon, Aug 21, 2023 at 02:54:10PM -0700, Florian Fainelli wrote:
> From: Justin Chen <justin.chen@broadcom.com>
> 
> commit 096516d092d54604d590827d05b1022c8f326639 upstream
> 
> The 54810 does not support c45. The mmd_phy_indirect accesses return
> arbirtary values leading to odd behavior like saying it supports EEE
> when it doesn't. We also see that reading/writing these non-existent
> MMD registers leads to phy instability in some cases.
> 
> Fixes: b14995ac2527 ("net: phy: broadcom: Add BCM54810 PHY entry")
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Link: https://lore.kernel.org/r/1691901708-28650-1-git-send-email-justin.chen@broadcom.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [florian: resolved conflicts in 4.14]
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Thanks for these, all now queued up.

greg k-h

