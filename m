Return-Path: <netdev+bounces-12762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E710738D17
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 19:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 290C7280ECB
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 17:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4149519BC6;
	Wed, 21 Jun 2023 17:30:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360FD19BAC
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 17:30:14 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23DCDD;
	Wed, 21 Jun 2023 10:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CcrAj+Sil5cBMVcsMbx9etmraWtKjeOsT+7Pyy14Euw=; b=RBZaTUEqKllJ/kHRR1oQ8E6V7i
	W2F44C7alaPuSQ1buRGMmzWyOBXtqwdpFz4V6bGVL6k9Edc9yjrHUleMHPg0iqEjarLXLVR/w1I5h
	HQZJXLnSdMQBrAuUXS/F4cb552qvy7WPxMx3YjWzydRp0wp0Ifl02beDPauLTVHhSUG4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qC1em-00HAcZ-6q; Wed, 21 Jun 2023 19:30:12 +0200
Date: Wed, 21 Jun 2023 19:30:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Revanth Kumar Uppala <ruppala@nvidia.com>
Cc: hkallweit1@gmail.com, netdev@vger.kernel.org,
	linux-tegra@vger.kernel.org, Narayan Reddy <narayanr@nvidia.com>
Subject: Re: [PATCH] net: phy: Enhance fixed PHY to support 10G and 5G
Message-ID: <f6e20ec1-37a7-4aae-8c9b-3c82590678f6@lunn.ch>
References: <20230621165853.52273-1-ruppala@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621165853.52273-1-ruppala@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 10:28:53PM +0530, Revanth Kumar Uppala wrote:
> Add 10G and 5G speed entries for fixed PHY
> framework.These are needed for the platforms which
> doesn't have a PHY driver.
> 
> Signed-off-by: Revanth Kumar Uppala <ruppala@nvidia.com>
> Signed-off-by: Narayan Reddy <narayanr@nvidia.com>

This is the second time you have sent me this patch. You have failed
to answer the questions i asked you the last time.....

    Andrew

---
pw-bot: cr

