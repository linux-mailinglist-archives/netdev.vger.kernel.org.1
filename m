Return-Path: <netdev+bounces-44228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9505D7D7266
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 19:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69BF21C20E53
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 17:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D14030D0C;
	Wed, 25 Oct 2023 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cgOKSV4c"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975DA30D0A
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 17:34:53 +0000 (UTC)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F36B1BB
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 10:34:49 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-777745f1541so3929385a.0
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 10:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1698255288; x=1698860088; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkQVj+ohSvU7ZndpStLgdRxD2UAEprv6Wx2YjnFhCwA=;
        b=cgOKSV4cKIBPLMuHSNCbijMwtU1Ql8jgr8H5K8/chCPqyIQptRWSi0bLAO5mowmLqW
         yxDIKdkdHqqpf/9ipxw+D9MDsgu17oG4lPnni0a/GuYNxukW2X1KMu1g3Fm5AdicXn7+
         O18dU+j4PKNr5EgoIEqXAG+ijfrRyNJcwdFhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698255288; x=1698860088;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkQVj+ohSvU7ZndpStLgdRxD2UAEprv6Wx2YjnFhCwA=;
        b=OllfunTG/M5hwCyln17j0g7yvkIJyKHhWdFA2HFwwGSm9rEZC/1aJH2WAkMFPhPECV
         F9ej82W69yaVXdv3vsGTxhlkMUfDq5v7iRiDJty6C+7KTg8nQlnqTE2tO8BcovQR9dYH
         ZgwVML8q3/E4XVqFr03o02hQgDT6+FPDax0gwKfCNwyByGaeWw3QArNDWjdybDp6mBtE
         SrVymLj+mIm3RIJ/MQo5o67ON9dMsiH5zkOmzEeUrBhoWnFPA7aAD8XgU9u7cTKNRbpv
         u4O825lfwrbPzIUcXL2lTrhuNlx7SvJSvl2W2hBtky8i+vIx2O4QyzURk+lqMazfQPVr
         +FfQ==
X-Gm-Message-State: AOJu0YyzMmW/L9al+YEao+9SHJABcfhrtMHHnw6uwNxZca8UDuP+4msN
	AXRCqag0mz6Cm3DM24AlYosBsS13xziV17qHdY4H+JtoLiI+g+xvw+3QPFxVnYMR5/OnW57WAp4
	8k3EV4gXxCWoBGiVcYsgWZItD1lXeuYS821ed6l0BKPzL0l9cUOLWvtK2vUC4MxUns6NZfWMjr6
	JBz5f0oMmGr3nT
X-Google-Smtp-Source: AGHT+IEef6QF/8p68iyCZ9o8f0b0Gm4vRrfNv0vO7xt3hJm/S4UpLNGER58UumgewAJGcwWGxQM56g==
X-Received: by 2002:a05:620a:c4f:b0:775:687f:4c2b with SMTP id u15-20020a05620a0c4f00b00775687f4c2bmr17929165qki.44.1698255288271;
        Wed, 25 Oct 2023 10:34:48 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id bp37-20020a05620a45a500b00767dcf6f4adsm4332384qkb.51.2023.10.25.10.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 10:34:47 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Willem de Bruijn <willemb@google.com>,
	Daniil Tatianin <d-tatianin@yandex-team.ru>,
	Simon Horman <horms@kernel.org>,
	Justin Chen <justin.chen@broadcom.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Joe Damato <jdamato@fastly.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jiri Pirko <jiri@resnulli.us>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 5/5] net: bcmgenet: Interrogate PHY for WAKE_FILTER programming
Date: Wed, 25 Oct 2023 10:33:00 -0700
Message-Id: <20231025173300.1776832-6-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025173300.1776832-1-florian.fainelli@broadcom.com>
References: <20231025173300.1776832-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000372e8506088ddfe7"

--000000000000372e8506088ddfe7
Content-Transfer-Encoding: 8bit

Determine whether the PHY can support waking up from the user programmed
network filter, and if it can utilize it.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 16 ++++++++++++++++
 drivers/net/phy/bcm-phy-lib.c                  | 12 +++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 9282403d1bf6..9d01c13552eb 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1524,6 +1524,14 @@ static int bcmgenet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 	int err = 0;
 
+	if (dev->phydev) {
+		err = phy_ethtool_set_rxnfc(dev->phydev, cmd);
+		if (err != -EOPNOTSUPP)
+			return err;
+
+		err = 0;
+	}
+
 	switch (cmd->cmd) {
 	case ETHTOOL_SRXCLSRLINS:
 		err = bcmgenet_insert_flow(dev, cmd);
@@ -1579,6 +1587,14 @@ static int bcmgenet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 	int err = 0;
 	int i = 0;
 
+	if (dev->phydev) {
+		err = phy_ethtool_get_rxnfc(dev->phydev, cmd, rule_locs);
+		if (err != -EOPNOTSUPP)
+			return err;
+
+		err = 0;
+	}
+
 	switch (cmd->cmd) {
 	case ETHTOOL_GRXRINGS:
 		cmd->data = priv->hw_params->rx_queues ?: 1;
diff --git a/drivers/net/phy/bcm-phy-lib.c b/drivers/net/phy/bcm-phy-lib.c
index cfbeedc5ee81..569aeab68f97 100644
--- a/drivers/net/phy/bcm-phy-lib.c
+++ b/drivers/net/phy/bcm-phy-lib.c
@@ -888,6 +888,15 @@ int bcm_phy_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
 	if (wol->wolopts & WAKE_FILTER)
 		goto program_ctl;
 
+	/* Enabling options other than WAKE_FILTER nullifies the one and only
+	 * network rule that we support.
+	 */
+	if (!(wol->wolopts & WAKE_FILTER)) {
+		ret = bcm_phy_write_exp(phydev, BCM54XX_WOL_SEC_KEY_8B, 0);
+		if (ret < 0)
+			return ret;
+	}
+
 	/* When using WAKE_MAGIC, we program the magic pattern filter to match
 	 * the device's MAC address and we accept any MAC DA in the Ethernet
 	 * frame.
@@ -1175,9 +1184,10 @@ static int bcm_phy_set_rule(struct phy_device *phydev,
 
 	da = nfc->fs.m_u.ether_spec.h_dest;
 	for (i = 0; i < ETH_ALEN / 2; i++) {
+		u16 mask = da[i * 2] << 8 | da[i * 2 + 1];
 		ret = bcm_phy_write_exp(phydev,
 					BCM54XX_WOL_MASK(2 - i),
-					da[i * 2] << 8 | da[i * 2 + 1]);
+					~mask);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.34.1


--000000000000372e8506088ddfe7
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDBP8P9hKRVySg3Qv5DANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE4MTFaFw0yNTA5MTAxMjE4MTFaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA+oi3jMmHltY4LMUy8Up5+1zjd1iSgUBXhwCJLj1GJQF+GwP8InemBbk5rjlC
UwbQDeIlOfb8xGqHoQFGSW8p9V1XUw+cthISLkycex0AJ09ufePshLZygRLREU0H4ecNPMejxCte
KdtB4COST4uhBkUCo9BSy1gkl8DJ8j/BQ1KNUx6oYe0CntRag+EnHv9TM9BeXBBLfmMRnWNhvOSk
nSmRX0J3d9/G2A3FIC6WY2XnLW7eAZCQPa1Tz3n2B5BGOxwqhwKLGLNu2SRCPHwOdD6e0drURF7/
Vax85/EqkVnFNlfxtZhS0ugx5gn2pta7bTdBm1IG4TX+A3B1G57rVwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUwwfJ6/F
KL0fRdVROal/Lp4lAF0wDQYJKoZIhvcNAQELBQADggEBAKBgfteDc1mChZjKBY4xAplC6uXGyBrZ
kNGap1mHJ+JngGzZCz+dDiHRQKGpXLxkHX0BvEDZLW6LGOJ83ImrW38YMOo3ZYnCYNHA9qDOakiw
2s1RH00JOkO5SkYdwCHj4DB9B7KEnLatJtD8MBorvt+QxTuSh4ze96Jz3kEIoHMvwGFkgObWblsc
3/YcLBmCgaWpZ3Ksev1vJPr5n8riG3/N4on8gO5qinmmr9Y7vGeuf5dmZrYMbnb+yCBalkUmZQwY
NxADYvcRBA0ySL6sZpj8BIIhWiXiuusuBmt2Mak2eEv0xDbovE6Z6hYyl/ZnRadbgK/ClgbY3w+O
AfUXEZ0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwT
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEINEIq8LqPch8Xffr
bZoTJ0lm4zePnY47vGXeL8RjuG3RMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIzMTAyNTE3MzQ0OFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCzamQQimzAyAtom/SF4L0h6mWIwv2F8lpC
ibHEw7ZdSFzeJfAPw0N4gYSqNCzwCNXg7OHgdtBlg/g8t1L3Q92pquJsc3g5aNPjlWLmspMBvilH
xXpRicu6qyN7ZGHOVgSl2Ja/ZPDnCo0/oN+UZ9RAgZ4dJD4EmFOuYsiOchyvkwdn1pwlk4IEimJQ
HQGF+eQGnbSgD/fo6K+PMUlODt1cDRWGSLqbQOiVW5nzHhLo/kNAtzW02WaDP9e0jsN3K1Ie4lg2
tXIZVAF1ceE9f/WQ14XICtwked3A5KjkioS/z1yt/JRNLFDUw9uNArv6WP+pmJGO3Jg7PqtaPc3Y
7JdD
--000000000000372e8506088ddfe7--

