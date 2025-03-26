Return-Path: <netdev+bounces-177843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8945A720AF
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 22:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C0E1889659
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 21:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CB025EFAC;
	Wed, 26 Mar 2025 21:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="Cfd1elyL";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="52iAlqyY"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A8A19FA93;
	Wed, 26 Mar 2025 21:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743024100; cv=pass; b=UKnD+BsTOmTF/2SvJj2S+N2c16o2ymQcDTbQVnC2p+8e/c6zxmOFBvMNqbRgeNbH/d++80QVuhl07KX8bYOQz9vZMRLrsEeZbUn784WR66RK4SPK1GrstYmOhfx8wfjYV5zAAeEyg3C321Thwa7DYg9FJWknoJ/actsndK8I/UA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743024100; c=relaxed/simple;
	bh=F63fFdYs0fz6uWRNYJ3Ghsjh4HTrIv7hPfU0NUX/Dxg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NRjl6m7CysP8cdVZmvnJELE2GFtQKrZ//LZtB6BmZ6QVPvyjRSKlCmsnEU7DaFsWI6bYkV1Yyv7wvzxSfrRkkQ46jPE68nUXCXKoXHcUNdc0S4oVSrnE2MHBy1dX5kckoY7chgsEyfXghJjf7Hb7TMy1O1yRm3BYJJnLQEGVXJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=Cfd1elyL; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=52iAlqyY; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1743024088; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WxOaG+26Zz2If2HE16CEu3bdTZeElu/oDfVq7kaN6YgCKYOkFFs8hzTpyQ3/URBenL
    49sQuxAQzOGSJhbXZkhTQGtwLoa8r1FwjCjBnZ/AlspuERXErbriXVuj3dl9euNR/z+g
    KtpsfKQZkMTerxHrDDm4+6d/tqjVWmO66ADFjNNqVZN047zZa3aQLYCRwu/omlHwcuvo
    44NEb+zmTf9A7Gra0ZFps8WcWJOjbA9ECEeuzhncl36ngm2+DRVCzXg9Ko9t3UcrFIkQ
    6NRdNlJTFPAn2Fg0NZLPi84Vq/M5C+eyNXyxS9gF9BZUalNYdwzextyRkpT8skRWDsXv
    h86w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1743024088;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=yWEPi8jGfbaRWRhMdiXrLYQ+ysihTn9YVJHYg4hFbo0=;
    b=C5b9oSZ1ZJT0Atw30fWBGnJAews3tE+ufiW/t0nO6J3XQDT5StfkMdh3O+2jZvBy1T
    aZkjWtwkCfp+/K5kDGydkzMr/yhqNGGvtL1dHmHe4C5Q6UWwUQ27Djwp/m320v9/qDlM
    8atddEhLdLKsrdyTQgd8M3lq8l4+W4OM2v8ZXAPqWB4cZJI5AC59uXTjrBfBQsWS80cw
    5TeogOZ8qw1SQZtJ2zqOn+vIPDf0S8Rp5hQwwdOh1zRydyAbSnA1zJGbPhQZ3Cf6XQAU
    rK7f4TsPXlZ8zjh2lrDmQx/Pu1RuzJ5ruOQACiUizaKZQf3NBOKeooUJ3SLFAOBxwC5D
    QGjA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1743024088;
    s=strato-dkim-0002; d=fossekall.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=yWEPi8jGfbaRWRhMdiXrLYQ+ysihTn9YVJHYg4hFbo0=;
    b=Cfd1elyLX5xgWo/7G1nx79pjZ13UE3s1LrJvf1LW5Kyc4Hzk2TDS3nc6bva10s6Y1d
    Aln1RESfmiyZ/TVbAyrPt0OlYyWcH613SjQ1eMpIIHxNk3CemmEbP79YDLHdM0Aqjwg/
    15BPDO5ErJ6oOCI/Dn4Ynr0Tqe/RgcYZORPAlEZ5HuDBXx/GVqXlqPe2Gt15aAsOyAjs
    NQ6KFi9x+y7m4aBYIhNaL+QGhF1qfYyIf0/k5MvIVBGyJZrBxvOr1qSG/XGdREalzfxy
    0yFey1o6H4JcD2EUYFcItZdFCtc97bpdmroLSLrl3HNewlK8w3H03GdCz5C6vLVvzPB5
    1fGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1743024088;
    s=strato-dkim-0003; d=fossekall.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=yWEPi8jGfbaRWRhMdiXrLYQ+ysihTn9YVJHYg4hFbo0=;
    b=52iAlqyY+abRjJ/NJrkt5e0iruQpKnDRe8nPeD4Nl1gvt+x+MZJnBIaJTPo5eIH/m4
    xt9e0Ja7kmho47X7Z+AA==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b3512QLLS1Hx
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 26 Mar 2025 22:21:28 +0100 (CET)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1txYBj-0000hd-1Y;
	Wed, 26 Mar 2025 22:21:27 +0100
Received: (nullmailer pid 100253 invoked by uid 502);
	Wed, 26 Mar 2025 21:21:27 -0000
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Klein <michael@fossekall.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next v5 0/4] net: phy: realtek: Add support for PHY LEDs on
Date: Wed, 26 Mar 2025 22:21:21 +0100
Message-Id: <20250326212125.100218-1-michael@fossekall.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Changes in V5:
- Split cleanup patch and improve code formatting

Changes in V4:
- Change (!ret) to (ret == 0)
- Replace set_bit() by __set_bit()

Changes in V3:
- move definition of rtl8211e_read_ext_page() to patch 2
- Wrap overlong lines

Changes in V2:
- Designate to net-next
- Add ExtPage access cleanup patch as suggested by Andrew Lunn

Michael Klein (4):
  net: phy: realtek: Group RTL82* macro definitions
  net: phy: realtek: Clean up RTL8211E ExtPage access
  net: phy: realtek: use __set_bit() in rtl8211f_led_hw_control_get()
  net: phy: realtek: Add support for PHY LEDs on RTL8211E

 drivers/net/phy/realtek/realtek_main.c | 201 ++++++++++++++++++++-----
 1 file changed, 160 insertions(+), 41 deletions(-)

-- 
2.39.5

