Return-Path: <netdev+bounces-14432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6E47412E9
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 15:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 754641C204F9
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 13:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A83AC14C;
	Wed, 28 Jun 2023 13:46:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAD5C2C5
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 13:46:34 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B7B10D5;
	Wed, 28 Jun 2023 06:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bQkJYVeDv/7wJQlqy7XMfIPBUJwI5OjssWN0LH3XOfI=; b=m6/VpMu/7x+tQLnFaIilEkM9Ol
	iYZXDVd9OGol+Dqg2wqRlenJ7CqzfLyoGOmG8sxIsmMMzgMNwIwyUnQzDJXkGj4A4yM5Eb4kK8edo
	6hpLFlkTjXyCvqEvSwapWLejcvRDgIazN9DYqfaA51I7i/vraKsUmyD0utDHeEBx0fXtU0viUXSdn
	oLHohgV2NEZ6fWRdlmtxx+BsD7iWzVqfJIkg3ioOp28EwM4kfYiSKsUlke6I5pa6sakTMI7y4+caD
	9Ug5t0PCNWk4j9nGm9QYOr3qKaev9qmqJl6+jSkYHsNpOBh2PeclxjPkc9Wews5Uniye3RnSBaKf1
	jgtOu8/w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40202)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qEVV8-0007Yt-21;
	Wed, 28 Jun 2023 14:46:30 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qEVV7-0006ow-AX; Wed, 28 Jun 2023 14:46:29 +0100
Date: Wed, 28 Jun 2023 14:46:29 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Revanth Kumar Uppala <ruppala@nvidia.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, netdev@vger.kernel.org,
	linux-tegra@vger.kernel.org, Narayan Reddy <narayanr@nvidia.com>
Subject: Re: [PATCH 1/4] net: phy: aquantia: Enable Tx/Rx pause frame support
 in aquantia PHY
Message-ID: <ZJw5tcCVHVv5u0dz@shell.armlinux.org.uk>
References: <20230628124326.55732-1-ruppala@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628124326.55732-1-ruppala@nvidia.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Final comments on the series, posted here because there's no cover
message.

1. The series should include a cover message summarising the overall
   purpose of the series is, giving an overview of the changes, and a
   diffstat for the whole series.

2. The subject line should contain the tree that the patches are
   targetting, e.g. "[PATCH net-next 0/4] Add support for WoL to Aquantia
   PHY driver".

3. The tree should be identified in each patch mailed out.

4. The patches should be threaded to the cover message.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

