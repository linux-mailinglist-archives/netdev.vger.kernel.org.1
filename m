Return-Path: <netdev+bounces-159669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5773A16538
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 02:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1431884968
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 01:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F06182BC;
	Mon, 20 Jan 2025 01:52:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE1E2030A
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 01:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737337932; cv=none; b=FkRAbQUVgW7yq+H3QuGRBouCEgjSCACqp2SHb7r51C5eZLZ9xPMMqXL5Ixmn8AXH7s7rn5PVet2/n5VEqU7LvR2uw0x71PkA/Xsp7CFLgogc6M+sjzkBvk3AcHzP8YIJXrjUIxx8i0r66WiIgMV1XUI5DqzymD0GTitYLG7cyh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737337932; c=relaxed/simple;
	bh=boRo967MPiXQGIQxL6eYzse6DGPRzdiCA5NnG9VJUtY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=cmt+JUfpoG7AzpaHVQkHzGTLsX0n06Wk06pw/H/U9rYtt7Fj3q4J3Zat8Wq6BByqYlOGvaNLJSnv0WNHz2zxfMs6k47sPZ9DHY8Wn/0xTLXoyfCb5pFEZ79mIe636y6VrXH0jLWmfRsbL8akhZGP73HSx+mz86J07Qf9IGVvoUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas6t1737337890t616t23287
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.197.136.137])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 10819580745422252476
To: "'Russell King \(Oracle\)'" <linux@armlinux.org.uk>
Cc: "'Andrew Lunn'" <andrew@lunn.ch>,
	"'Heiner Kallweit'" <hkallweit1@gmail.com>,
	<mengyuanlou@net-swift.com>,
	"'Alexandre Torgue'" <alexandre.torgue@foss.st.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'Bryan Whitehead'" <bryan.whitehead@microchip.com>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	"'Marcin Wojtas'" <marcin.s.wojtas@gmail.com>,
	"'Maxime Coquelin'" <mcoquelin.stm32@gmail.com>,
	<netdev@vger.kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>
References: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk> <06d301db68bd$b59d3c90$20d7b5b0$@trustnetic.com> <Z4odUIWmYb8TelZS@shell.armlinux.org.uk> <06dc01db68c8$f5853fa0$e08fbee0$@trustnetic.com> <Z4pL3Mn6Qe7O45D7@shell.armlinux.org.uk>
In-Reply-To: <Z4pL3Mn6Qe7O45D7@shell.armlinux.org.uk>
Subject: RE: [PATCH net-next 0/9] net: add phylink managed EEE support
Date: Mon, 20 Jan 2025 09:51:29 +0800
Message-ID: <073a01db6add$d308af40$791a0dc0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQJuuL6961zeRYLpn6fcQniPsxo8VAIOTZqlAVk2sswCDJNSGAGgOtUSsb+m6+A=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NDu8aKWRFc7DX4UjHDeK70q1Lzxy/4FdZzPyqVSi0G/yodqUqrdkMUP5
	ecQym3DdmgC3UPCjejveJtSDnXFLK7zcA9iauZRd8MB0oqEW0ldHidWWDPvGHR1dBcRqmXE
	VGo+8qaBXMYlaCZEabmzL0dNZiclRfSuyZA3njogLnGDjfJNeNiBu4v+C7C7AUbgKxJjlK2
	CEm6NCbsQzi+qUXUMvJy2PmiJZ2MDfhXMbATGXDof6zrkwcas9bh2/pZJOp5L+IGG5o8sJj
	vP17x2Ob0Q3LYlbfqFq0+OxeTkAziKTIfKY9bakVzZSF0pIeu9X6ULpQzbA2hp9n3CMfQFr
	M5Hp1lAykD4j0Ex3hkpiMTaTLBX+dP7vfnDoeHY503EjHPxznD64mndxrhwpsYDfd/lqjS1
	NSoyQYt2JnDOdeerEFBrmL+pZbmKP8RIJsnZLC1UXCKHVziteV1YHZ8uamQ8fERgUbW9NpF
	hA6VMyP55b1rPFQawCwuIwiJCslsO163wGL+6nx0h64bqPIuE4bKpKK0QWtYnCdGiAYYshK
	/8Sa8Jje+HOLttAoSEjK1HjoidPTbiPj2Lyr9LMfUQR3DINA3Z796pmIkpUvSu52onVA01d
	QR+V72XIdLfRxfGIMG+oK80h/DZ4zdrWDoK0LL6GRg3O3G8e12+C6F7hW9uiWevbh7+BeCQ
	7vARbVewDaR/lme0XoeHCp9ODTK56TpYIAJKW/xSNv5nNhD67H+74VO6YulT/L6FxXGs6ZB
	cer0Y2zoLbmIX1NKaM8J6Zz637uxZ4BkWkgYTzUEB5Fn7oIBwiuwQzi1qjrVyQi6nOA+elk
	Z2Y4iVdqNO1a6CPnyT0g6WPM+zgsmiMEsFAP+a8F68ZvA3Mal3uQ79Z9w4xE6HwGzmOHGxj
	XUG7m8px7JCESjXE+h69kjFWW+oDPwqz0NxB/6vfq9+X6O8fhY9ea4b1HRNxGF/4aNsc2bD
	eT9hdxbwu6ZLMvcBmn5ti6vfnlFV78CyDN1Fr7TC3Fps3otenZss/A7yG
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Fri, Jan 17, 2025 8:24 PM, Russell King (Oracle) wrote:
> On Fri, Jan 17, 2025 at 06:17:05PM +0800, Jiawen Wu wrote:
> > > > Since merging these patches, phylink_connect_phy() can no longer be
> > > > invoked correctly in ngbe_open(). The error is returned from the function
> > > > phy_eee_rx_clock_stop(). Since EEE is not supported on our NGBE hardware.
> > >
> > > That would mean phy_modify_mmd() is failing, but the question is why
> > > that is. Please investigate. Thanks.
> >
> > Yes, phy_modify_mmd() returns -EOPNOTSUPP. Since .read/write_mmd are
> > implemented in the PHY driver, but it's not supported to read/write the
> > register field (devnum=MDIO_MMD_PCS, regnum= MDIO_CTRL1).
> >
> > So the error occurs on  __phy_read_mmd():
> > 	if (phydev->drv && phydev->drv->read_mmd)
> > 		return phydev->drv->read_mmd(phydev, devad, regnum);
> 
> Thanks. The patch below should fix it. Please test, meanwhile I'll
> prepare a proper patch.
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 66eea3f963d3..56d411bb2547 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -2268,7 +2268,11 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
>  	/* Explicitly configure whether the PHY is allowed to stop it's
>  	 * receive clock.
>  	 */
> -	return phy_eee_rx_clock_stop(phy, pl->config->eee_rx_clk_stop_enable);
> +	ret = phy_eee_rx_clock_stop(phy, pl->config->eee_rx_clk_stop_enable);
> +	if (ret == -EOPNOTSUPP)
> +		ret = 0;
> +
> +	return ret;
>  }
> 
>  static int phylink_attach_phy(struct phylink *pl, struct phy_device *phy,

Test pass.
Thanks.


