Return-Path: <netdev+bounces-44590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D4C7D8BE5
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 00:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30236B20FD0
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 22:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345F62F506;
	Thu, 26 Oct 2023 22:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DdBKAfVB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39058BFD
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 22:55:38 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C531BC
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 15:55:37 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c87a85332bso12708075ad.2
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 15:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1698360936; x=1698965736; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=//dKD4KvqTBXzSCDx8Qvfzi+xyEtiP4i2DsPcGJUks8=;
        b=DdBKAfVBnHXa+ImPjM1yFQ8ta6Ev6D+LJL1xMoXNNW8lsRPzq4AE9FFW6eiB5Izp0f
         XMMH8mw/qU3dURFa5Y7Pq0aTUOZv/h/PLEDwwCmyBGq67H0nn94BvAj8FO2Bm6tdHZNr
         GcAlap46PoAm3XRu+PYi15F61z31pI6set/5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698360936; x=1698965736;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=//dKD4KvqTBXzSCDx8Qvfzi+xyEtiP4i2DsPcGJUks8=;
        b=aRgsoE9G0Zg9C2YtyaQHVo1X/Bh3vak/4GbGJubVZtzDQbjn/BgU01rrkdTDUQC+ol
         hBERvzs3AOcSF6iyOehZg6pWrlI5C129yf+fCNgN5HxzlZWa8vpshgodSd6D8bcsjU52
         TE9J68EfriOfD0Lm5JKy2A/GKmhmcHAmedewfVt1XCD+LmDlixSH0zV2tzKH1776RlmY
         eoEuMmwUhw3oi+ksNab5PTp7ygZ9LD8wKjcg+iOTV2qWXlcW9dP7IqCBZG1nTGnZNkq6
         g55oBMYgPCODOFuQDAUzEtKtLbP+DrsPbRmGAzqd+C1MY3pSCBYQoQKdbRW3HN20yFo0
         CFwQ==
X-Gm-Message-State: AOJu0YxCptTNE3CDkOevmuytyV5V/Qh6mLK2EC6rIG45RWakfQOSytp6
	n7HPbb+OrQsJ21IOaqaohx3+aEs4vzvJRwFG8cnaKLC60g8BTpBxcSkv99JwsnEK72ixGKBOYdF
	AOtxGrAEQNPSZg8Txl07Uxhe0nZPcCAb842yOWPksMK0L44nFwug0kCSOoVgoGUcg55TLrsO/X1
	q7FX9ed5oNhSyE
X-Google-Smtp-Source: AGHT+IHbAbE0uvWV6QoIzGblKzN/iCV2i/8YEfc8RxoVyM3TQ5O/rl5wiLqo0kVYxsFR9Nq8Z8Lsjg==
X-Received: by 2002:a17:903:2a8f:b0:1cc:118d:980b with SMTP id lv15-20020a1709032a8f00b001cc118d980bmr1154917plb.51.1698360936002;
        Thu, 26 Oct 2023 15:55:36 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902d4c100b001c9b5b63e36sm206295plg.32.2023.10.26.15.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 15:55:35 -0700 (PDT)
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
Subject: [PATCH net-next v2 0/5] WAKE_FILTER for Broadcom PHY (v2)
Date: Thu, 26 Oct 2023 15:45:04 -0700
Message-Id: <20231026224509.112353-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000051e4590608a6787a"

--00000000000051e4590608a6787a
Content-Transfer-Encoding: 8bit

This is a re-submission of the series that was submitted before:

https://lore.kernel.org/all/20230516231713.2882879-1-florian.fainelli@broadcom.com/

A number of things have changed:

- there is proper fallback between the PHY and the MAC now, whereas
  before we would abort right away due to -EOPNOTSUPP

- added support for programming the Ethernet type for matching

- fixed reporting of masks via ethtool

- added proper validation of RX_CLS_LOC_ANY/RX_CLS_LOC_FIRST and
  location

- addressed feedback given by Andrew by validating that we have at least
  one RX_CLS_FLOW_WAKE filter programmed to allow enabling WAKE_FILTER
  via ethtool, otherwise we will not wake-up from WAKE_FILTER

- use a PHY register as a scratchpad to accurately report whether a
  custom filter was installed, before that we would falsely report
  WAKE_UCAST/BCAST/MCAST but not WAKE_FILTER upon cold boot

- corrected commit message to be accurate (MAC address did not match the
  IPv4 address in the example)

Changes in v2:

- corrected sparse annotationes for h_proto (Vincent)
- added 2 spaces for commands in commit messages (Vincent)
- added hunk in patch 5 back into patch 4 (self)

Florian Fainelli (5):
  net: ethtool: Make RXNFC walking code accept a callback
  net: ethtool: Add validation for WAKE_FILTER
  net: phy: Add pluming for ethtool_{get,set}_rxnfc
  net: phy: broadcom: Add support for WAKE_FILTER
  net: bcmgenet: Interrogate PHY for WAKE_FILTER programming

 .../net/ethernet/broadcom/genet/bcmgenet.c    |  16 ++
 drivers/net/phy/bcm-phy-lib.c                 | 205 +++++++++++++++++-
 drivers/net/phy/bcm-phy-lib.h                 |   5 +
 drivers/net/phy/broadcom.c                    |   2 +
 drivers/net/phy/phy.c                         |  19 ++
 include/linux/phy.h                           |   8 +
 net/ethtool/common.c                          |  96 +++++++-
 net/ethtool/common.h                          |   3 +
 net/ethtool/ioctl.c                           |   3 +
 net/ethtool/wol.c                             |   3 +
 10 files changed, 350 insertions(+), 10 deletions(-)

-- 
2.34.1


--00000000000051e4590608a6787a
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
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGBz8OyYVQb9T3NF
vKuJ+vR+9C7gTWD2oisgc2ryh/c0MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIzMTAyNjIyNTUzNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB1VhO1TBcXrgA8NebB8iZYYI94w9HUuHhf
Huucw88YQDszA37HzXIsuCTLcmbJ0pOF2k2gNalxP+5i2RnK5h5OV0p8q7nkVSZjJqG3SN1BAIMM
yr0s+Y0ggigxnX8aHLezfHe4zMH6DEMQ3ClGTOLZn83xh9JHfNDQww83OfLlN1VabOKhrdRCtQOR
uRvfLFKRoAMc0O883wAIA5ecTHdSPOiiHssFnJGPQbc79hG4KZ+2hcL5caonCK2xrnt/z75fCBqj
hsaMKxQO4T2yaPxr4qDuW2k6W+ak3+ZN4ghk5ziCyrQNFaxiajiYMgyqbd24fOg4Sx1nYVShBgsH
R/rY
--00000000000051e4590608a6787a--

