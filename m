Return-Path: <netdev+bounces-17937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20122753A1B
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 13:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF706282347
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 11:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6337013721;
	Fri, 14 Jul 2023 11:38:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B0213702
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 11:38:18 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F203BE65;
	Fri, 14 Jul 2023 04:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=etB5FWqkDs6X4Rn7GAXNm/T16rPDkssdK4DTMsJ6/0U=; b=yYZTIDMkPB4zqMlV1JflC3bRv0
	BV/aoI2LdSbXrjLYdVS1CRn0EbSk++8xyNY8hwnvZwCrdhVowfvLh3z2878vmC4Dg+h7+oR5ENSKf
	Rk4FRaZFv6Rsu7EUGXoOrLSgLyGkHKgTc1VrleTJjiCfkILp2myFLNsJcd7IS/yJWk1HFhBNxWG3M
	X0dx11polYnNtxAJzhWUqAGFNl1s5kl4P5xZdKPHBwpZYbvaFQnuW45K4dq9wKXUKVfo2EOgFRh9J
	KO6oBooeHIwIsYMh3R0d+Np9q4wtv6pV0Z56gkcqwFEtOksRk8Ame31K6PvgV3V4Fciekjyh1uxrC
	z7hNldSQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47964)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qKH7k-0000bd-1b;
	Fri, 14 Jul 2023 12:38:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qKH7j-0007BH-20; Fri, 14 Jul 2023 12:38:11 +0100
Date: Fri, 14 Jul 2023 12:38:11 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] net: phy: at803x: support qca8081 1G chip type
Message-ID: <ZLEzo4jGGSXxFdVp@shell.armlinux.org.uk>
References: <20230714063136.21368-1-quic_luoj@quicinc.com>
 <20230714063136.21368-5-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714063136.21368-5-quic_luoj@quicinc.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 14, 2023 at 02:31:34PM +0800, Luo Jie wrote:
> The qca8081 1G chip version does not support 2.5 capability, which
> is distinguished from qca8081 2.5G chip according to the bit0 of
> register mmd7.0x901d, the 1G version chip also has the same PHY ID
> as the normal qca8081 2.5G chip.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

