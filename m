Return-Path: <netdev+bounces-43577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF697D3EEE
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 20:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93B1B1C20B46
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 18:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A190021342;
	Mon, 23 Oct 2023 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CXofgFN6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BB221373
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 18:17:44 +0000 (UTC)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1455FC0
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 11:17:42 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-66d11fec9a5so19759846d6.1
        for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 11:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1698085061; x=1698689861; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qnh0bZ4bD46yOhvDYz4V1c/+yMA4eu35HIoxlUTRuHw=;
        b=CXofgFN6LXZQwSZkVenplYNAbN+aYlKRFYCqwu4+yoazGbV8sVGVxjJThhGBZRcAmB
         1pc3BojI8RlyeOOptefCkNYm0gVkZbkrtVUuhzMBEqMkGge5FGQrMol8YTeyGXGIzY1j
         5ohNjiUYNU3bxTwAkXY2EUOmr+LPnP8ZyfpVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698085061; x=1698689861;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qnh0bZ4bD46yOhvDYz4V1c/+yMA4eu35HIoxlUTRuHw=;
        b=BqHqyBZFXEwdFaxhCxuMNteq2M1OcaavJOK2a9hTGSBv+IeuXsAemXQjFMBHNxgq/Z
         ocMRPZGFK0DusYao1g7hxXpj3M4osuaFjGAouhZS8Q6MiiLVNYf+Ut9mXjp/2LDxOoAG
         3nkJj6hE49pKRftriKH37VbVXadHFPU6PptmTmYxNh0wzKwZDD7+X29RY0phbVM3/i+R
         nqwI3vEmbp82FyQC2q6ehuqCiA4VeVR9pyEnjlTJxxn51SnEYA61hmC4go2mkikmfNmk
         usMaHfSz2qnojBi9zb7fVW7OrEc+myobGMyCgEhZ5SIeNmDhvga4bpjwxf5lMO0ipL/m
         XW3g==
X-Gm-Message-State: AOJu0YzeItFciA9CYQWi81IdhEx4BCzUmaYV+al69Cuz525Nh0dByXs/
	I/ZGrweX/lwLXA1PDeSde2DchVbgJFui4f7UCcm7bPVzy8uMmgPEhvocZvDGBQ9Ik2bOZdtN7yq
	y1K/NPZRJa40/dpQ6y4C+k1drp+ix4fCqj+U+TGx1RKKP8O/9O/tkaMEeJL4xpyUGCjYXcMvuAK
	TZ5mI9ZyEuGCS+
X-Google-Smtp-Source: AGHT+IFbNgzw/LdqTbZCMzWjV/CEqLPu7Gbo1JwvZU6zqbd8WwOsA+ykzRpyU3SKIqW/Ml7zPRnbJw==
X-Received: by 2002:a05:6214:622:b0:66d:33c8:b83e with SMTP id a2-20020a056214062200b0066d33c8b83emr10827527qvx.26.1698085060627;
        Mon, 23 Oct 2023 11:17:40 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ej17-20020ad45a51000000b0065b17ec4b49sm3054269qvb.46.2023.10.23.11.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 11:17:39 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH net-next v7 2/2] net: dsa: Rename IFLA_DSA_MASTER to IFLA_DSA_CONDUIT
Date: Mon, 23 Oct 2023 11:17:29 -0700
Message-Id: <20231023181729.1191071-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181729.1191071-1-florian.fainelli@broadcom.com>
References: <20231023181729.1191071-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000dc41e70608663ce8"

--000000000000dc41e70608663ce8
Content-Transfer-Encoding: 8bit

This preserves the existing IFLA_DSA_MASTER which is part of the uAPI
and creates an alias named IFLA_DSA_CONDUIT.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 Documentation/networking/dsa/configuration.rst |  4 ++--
 include/uapi/linux/if_link.h                   |  4 +++-
 net/dsa/netlink.c                              | 10 +++++-----
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/dsa/configuration.rst b/Documentation/networking/dsa/configuration.rst
index e6c9719874b0..6cc4ded3cc23 100644
--- a/Documentation/networking/dsa/configuration.rst
+++ b/Documentation/networking/dsa/configuration.rst
@@ -393,7 +393,7 @@ description which has an ``ethernet`` property. It is up to the user to
 configure the system for the switch to use other conduits.
 
 DSA uses the ``rtnl_link_ops`` mechanism (with a "dsa" ``kind``) to allow
-changing the DSA conduit of a user port. The ``IFLA_DSA_MASTER`` u32 netlink
+changing the DSA conduit of a user port. The ``IFLA_DSA_CONDUIT`` u32 netlink
 attribute contains the ifindex of the conduit device that handles each user
 device. The DSA conduit must be a valid candidate based on firmware node
 information, or a LAG interface which contains only slaves which are valid
@@ -435,7 +435,7 @@ Using iproute2, the following manipulations are possible:
         dsa master bond0
 
 Notice that in the case of CPU ports under a LAG, the use of the
-``IFLA_DSA_MASTER`` netlink attribute is not strictly needed, but rather, DSA
+``IFLA_DSA_CONDUIT`` netlink attribute is not strictly needed, but rather, DSA
 reacts to the ``IFLA_MASTER`` attribute change of its present conduit (``eth0``)
 and migrates all user ports to the new upper of ``eth0``, ``bond0``. Similarly,
 when ``bond0`` is destroyed using ``RTM_DELLINK``, DSA migrates the user ports
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 9f8a3da0f14f..f4191be137a4 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1394,7 +1394,9 @@ enum {
 
 enum {
 	IFLA_DSA_UNSPEC,
-	IFLA_DSA_MASTER,
+	IFLA_DSA_CONDUIT,
+	/* Deprecated, use IFLA_DSA_CONDUIT instead */
+	IFLA_DSA_MASTER = IFLA_DSA_CONDUIT,
 	__IFLA_DSA_MAX,
 };
 
diff --git a/net/dsa/netlink.c b/net/dsa/netlink.c
index f56f90a25b99..1332e56349e5 100644
--- a/net/dsa/netlink.c
+++ b/net/dsa/netlink.c
@@ -8,7 +8,7 @@
 #include "user.h"
 
 static const struct nla_policy dsa_policy[IFLA_DSA_MAX + 1] = {
-	[IFLA_DSA_MASTER]	= { .type = NLA_U32 },
+	[IFLA_DSA_CONDUIT]	= { .type = NLA_U32 },
 };
 
 static int dsa_changelink(struct net_device *dev, struct nlattr *tb[],
@@ -20,8 +20,8 @@ static int dsa_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (!data)
 		return 0;
 
-	if (data[IFLA_DSA_MASTER]) {
-		u32 ifindex = nla_get_u32(data[IFLA_DSA_MASTER]);
+	if (data[IFLA_DSA_CONDUIT]) {
+		u32 ifindex = nla_get_u32(data[IFLA_DSA_CONDUIT]);
 		struct net_device *conduit;
 
 		conduit = __dev_get_by_index(dev_net(dev), ifindex);
@@ -38,7 +38,7 @@ static int dsa_changelink(struct net_device *dev, struct nlattr *tb[],
 
 static size_t dsa_get_size(const struct net_device *dev)
 {
-	return nla_total_size(sizeof(u32)) +	/* IFLA_DSA_MASTER  */
+	return nla_total_size(sizeof(u32)) +	/* IFLA_DSA_CONDUIT  */
 	       0;
 }
 
@@ -46,7 +46,7 @@ static int dsa_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct net_device *conduit = dsa_user_to_conduit(dev);
 
-	if (nla_put_u32(skb, IFLA_DSA_MASTER, conduit->ifindex))
+	if (nla_put_u32(skb, IFLA_DSA_CONDUIT, conduit->ifindex))
 		return -EMSGSIZE;
 
 	return 0;
-- 
2.34.1


--000000000000dc41e70608663ce8
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
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMAQdcvUPuq8igma
EgOj22dYU8JxJwMMUUgicMp6GmHUMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIzMTAyMzE4MTc0MVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBN/7Phgxd7xOwD3D6v1JEtLghpirnK3q/p
osQvYvIBv7iI/bksWcdVHasc4zKKhdIhofp1KYVIOsT7YUYtIxKGMMnlWpl9vKMh6rLqAKEtvwu3
uAHt6zrnqP8cx124ssHp4EAInYaWdne5tsykgWActxXzwXXoo8qwb+bc3fdrZATgL4PJEPQJXMD4
+hT+orAM/BGYwKm5KyTuyd0AAs1n5Fx3B94jhPRGiyqSt8CTciE9xEawEYhiTyEVWkRJLYjTvY0B
c0doTEX2+fAwmGr0+x1EiBgQMFeC++NujuMDNbKPP8Rz/WPxgt+S3msQTZ5B90J+pRqazFrespVO
7ShY
--000000000000dc41e70608663ce8--

