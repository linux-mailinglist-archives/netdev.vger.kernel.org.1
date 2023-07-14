Return-Path: <netdev+bounces-17938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81434753A1D
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 13:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25DA1C21661
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 11:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267431372C;
	Fri, 14 Jul 2023 11:41:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8D613702
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 11:41:46 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586A63AA0;
	Fri, 14 Jul 2023 04:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=grQHzDJubJ94fj7savZaaiVNdiOToMwoMlE1X7yqRPI=; b=Isj9V7UtZ1k9h72NHpzwjL6R/4
	hm7cThoefqyGWrpfEhayTU27RdJf6FQshKkyRnJ92c91vsf9cGVG4mKTBu3FXVnPwYwVOEWwcz5fX
	hjAfx8a+rNZfenVTCgVBYvZSrJhoij89TQ3K1VZlbgaMFUTcMhX0UIgVbay/VHehpBr9QGBNgy10o
	DCARwudc4q7MhMjXNFrdrEXFNF4Bh6Y8rN5DXziszGHkVBqKBgYQZYNCk2rgReNKgWKX010rWUo5B
	C/Y3EhvVF1t/i2tAHO0npBwEt6usevsoLmW9ECX9/xGsCN+spRBcqhWi8YW3ns1YVZDdl55embhLj
	xrWNE3uw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44872)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qKHAV-0000cV-2l;
	Fri, 14 Jul 2023 12:41:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qKHAU-0007CD-NW; Fri, 14 Jul 2023 12:41:02 +0100
Date: Fri, 14 Jul 2023 12:41:02 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] net: phy: at803x: remove qca8081 1G fast retrain
 and slave seed config
Message-ID: <ZLE0Tr4Tn+C0fI+V@shell.armlinux.org.uk>
References: <20230714063136.21368-1-quic_luoj@quicinc.com>
 <20230714063136.21368-6-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714063136.21368-6-quic_luoj@quicinc.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 14, 2023 at 02:31:35PM +0800, Luo Jie wrote:
> The fast retrain and master slave seed configs are only applicable when
> the 2.5G capability is supported.

Probably worth a comment - or a helper function.

E.g.

static bool qca808x_has_fast_retrain(struct phy_device *phydev)
{
	return linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
				 phydev->supported);
}

Which then makes the code more self-documenting.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

