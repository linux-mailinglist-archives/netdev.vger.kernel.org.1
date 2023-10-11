Return-Path: <netdev+bounces-40154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8887C6031
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 00:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998521C20993
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 22:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAC03FB2B;
	Wed, 11 Oct 2023 22:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cDKtwPei"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006721BDE9
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 22:13:12 +0000 (UTC)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7EB9E
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 15:13:10 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-66d12b3b479so1333886d6.1
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 15:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1697062389; x=1697667189; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TuQT+hGCez7jADGaOaH4ry97NpRylWXT5puGO0C1Kl0=;
        b=cDKtwPeipob11dRpu8ELJEkOXP7/ji1eqpMkWOPdpl+ciKk37nHDEKaQ1w2Ylxh6I5
         W79NnT2qeIV3MZbq1dq6Nx3TuN05aDxZJNCVyTQ7SWnLAgjfUGR8TEkkvQwtoZ2EAcpn
         KbGQ1eEXbOE3nmUV5+0zYZl/9quIFdh9lR2dI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697062389; x=1697667189;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TuQT+hGCez7jADGaOaH4ry97NpRylWXT5puGO0C1Kl0=;
        b=Fft++eKtwjuNdKWK38xln0hY15iXb3pSqk/qCr8eGQG1dv8j7HIIE2ng++VzUAJMR8
         /Dee+QkquI0lfY5GOuiv9nrANMS4gB4nqVXs+SblwIrsBYz0fNeH1z/q6/37G1IWHC/B
         /8gZmrs+B0t61W0zE3rImQF0vMjC3ySJV1x+7PiJPiDaPN07j4zykqw6pe2Dt76T6A3X
         tF2Oqj9Y0U5/K9/9z5OLQGOiXfSkK11O5Up1trDczG5EbX59yaA566IiHN3WXfG0M7mN
         3RUY8xLOF3gZLfCHlT4HHxu7hdVR7iqvjkdGEXkvjAzUdINL4x1FBxknBTtiEeS/7HGg
         ZLEQ==
X-Gm-Message-State: AOJu0YwuaXdbz5Oc0sX03pEMbBBPCqwmrymWC8nkmHq9jh+w+NFQYBHn
	iW3QmGA300TFsg8ku7ZYjsWWYpDAbA5qI2Ru51b+DHIGl/jGmW09RIz8k7mbNNvb9jOM6tkMaXS
	g3kosymEll4WxXvAnj5ezIgS/2mYzOSf+JbpT6t5R1Rr9o2V/iTua4PxVmY+4sz/w8fetXPEVL5
	Pq46K0Z837xQ==
X-Google-Smtp-Source: AGHT+IEleTCIrSHNHiOtDYMF1Y9WlcRYPdTrmfR8RQgHptKrIMCtm5TMGmexSbcYJOcgxHvgGiZhwQ==
X-Received: by 2002:a0c:f250:0:b0:656:528f:4f00 with SMTP id z16-20020a0cf250000000b00656528f4f00mr23517804qvl.49.1697062388907;
        Wed, 11 Oct 2023 15:13:08 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a12-20020a05620a102c00b007759a81d88esm5505705qkk.50.2023.10.11.15.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 15:13:08 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	opendmb@gmail.com,
	justin.chen@broadcom.com,
	Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH net-next 1/2] ethtool: Introduce WAKE_MDA
Date: Wed, 11 Oct 2023 15:12:39 -0700
Message-Id: <20231011221242.4180589-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011221242.4180589-1-florian.fainelli@broadcom.com>
References: <20231011221242.4180589-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e0cce506077820e4"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--000000000000e0cce506077820e4
Content-Transfer-Encoding: 8bit

Allow Ethernet PHY and MAC drivers with simplified matching logic to be
waking-up on a custom MAC destination address. This is particularly
useful for Ethernet PHYs which have limited amounts of buffering but can
still wake-up on a custom MAC destination address.

When WAKE_MDA is specified, the "sopass" field in the existing struct
ethtool_wolinfo is re-purposed to hold a custom MAC destination address
to match against.

Example:
	ethtool -s eth0 wol e mac-da 01:00:5e:00:00:fb

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 Documentation/networking/ethtool-netlink.rst |  7 ++++++-
 include/uapi/linux/ethtool.h                 | 10 ++++++++--
 include/uapi/linux/ethtool_netlink.h         |  1 +
 net/ethtool/common.c                         |  1 +
 net/ethtool/netlink.h                        |  2 +-
 net/ethtool/wol.c                            | 21 ++++++++++++++++++++
 6 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 2540c70952ff..b2b1191d5cec 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -708,11 +708,13 @@ Kernel response contents:
   ``ETHTOOL_A_WOL_HEADER``              nested  reply header
   ``ETHTOOL_A_WOL_MODES``               bitset  mask of enabled WoL modes
   ``ETHTOOL_A_WOL_SOPASS``              binary  SecureOn(tm) password
+  ``ETHTOOL_A_WOL_MAC_DA``              binary  Destination matching MAC address
   ====================================  ======  ==========================
 
 In reply, ``ETHTOOL_A_WOL_MODES`` mask consists of modes supported by the
 device, value of modes which are enabled. ``ETHTOOL_A_WOL_SOPASS`` is only
-included in reply if ``WAKE_MAGICSECURE`` mode is supported.
+included in reply if ``WAKE_MAGICSECURE`` mode is supported. ``ETHTOOL_A_WOL_MAC_DA``
+is only included in reply if ``WAKE_MDA`` mode is supported.
 
 
 WOL_SET
@@ -726,10 +728,13 @@ Request contents:
   ``ETHTOOL_A_WOL_HEADER``              nested  request header
   ``ETHTOOL_A_WOL_MODES``               bitset  enabled WoL modes
   ``ETHTOOL_A_WOL_SOPASS``              binary  SecureOn(tm) password
+  ``ETHTOOL_A_WOL_MAC_DA``              binary  Destination matching MAC address
   ====================================  ======  ==========================
 
 ``ETHTOOL_A_WOL_SOPASS`` is only allowed for devices supporting
 ``WAKE_MAGICSECURE`` mode.
+``ETHTOOL_A_WOL_MAC_DA`` is only allowed for devices supporting
+``WAKE_MDA`` mode.
 
 
 FEATURES_GET
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index f7fba0dc87e5..8134ac8870bd 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -207,12 +207,17 @@ struct ethtool_drvinfo {
  * @wolopts: Bitmask of %WAKE_* flags for enabled Wake-On-Lan modes.
  * @sopass: SecureOn(tm) password; meaningful only if %WAKE_MAGICSECURE
  *	is set in @wolopts.
+ * @mac_da: Destination MAC address to match; meaningful only if
+ *	%WAKE_MDA is set in @wolopts.
  */
 struct ethtool_wolinfo {
 	__u32	cmd;
 	__u32	supported;
 	__u32	wolopts;
-	__u8	sopass[SOPASS_MAX];
+	union {
+		__u8	sopass[SOPASS_MAX];
+		__u8	mac_da[ETH_ALEN];
+	};
 };
 
 /* for passing single values */
@@ -1989,8 +1994,9 @@ static inline int ethtool_validate_duplex(__u8 duplex)
 #define WAKE_MAGIC		(1 << 5)
 #define WAKE_MAGICSECURE	(1 << 6) /* only meaningful if WAKE_MAGIC */
 #define WAKE_FILTER		(1 << 7)
+#define WAKE_MDA		(1 << 8)
 
-#define WOL_MODE_COUNT		8
+#define WOL_MODE_COUNT		9
 
 /* L2-L4 network traffic flow types */
 #define	TCP_V4_FLOW	0x01	/* hash or spec (tcp_ip4_spec) */
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 73e2c10dc2cc..237a0fc68997 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -300,6 +300,7 @@ enum {
 	ETHTOOL_A_WOL_HEADER,			/* nest - _A_HEADER_* */
 	ETHTOOL_A_WOL_MODES,			/* bitset */
 	ETHTOOL_A_WOL_SOPASS,			/* binary */
+	ETHTOOL_A_WOL_MAC_DA,			/* binary */
 
 	/* add new constants above here */
 	__ETHTOOL_A_WOL_CNT,
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index f5598c5f50de..d1c837f6094c 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -405,6 +405,7 @@ const char wol_mode_names[][ETH_GSTRING_LEN] = {
 	[const_ilog2(WAKE_MAGIC)]	= "magic",
 	[const_ilog2(WAKE_MAGICSECURE)]	= "magicsecure",
 	[const_ilog2(WAKE_FILTER)]	= "filter",
+	[const_ilog2(WAKE_MDA)]		= "mac-da",
 };
 static_assert(ARRAY_SIZE(wol_mode_names) == WOL_MODE_COUNT);
 
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 9a333a8d04c1..5958e4483ced 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -407,7 +407,7 @@ extern const struct nla_policy ethnl_linkstate_get_policy[ETHTOOL_A_LINKSTATE_HE
 extern const struct nla_policy ethnl_debug_get_policy[ETHTOOL_A_DEBUG_HEADER + 1];
 extern const struct nla_policy ethnl_debug_set_policy[ETHTOOL_A_DEBUG_MSGMASK + 1];
 extern const struct nla_policy ethnl_wol_get_policy[ETHTOOL_A_WOL_HEADER + 1];
-extern const struct nla_policy ethnl_wol_set_policy[ETHTOOL_A_WOL_SOPASS + 1];
+extern const struct nla_policy ethnl_wol_set_policy[ETHTOOL_A_WOL_MAC_DA + 1];
 extern const struct nla_policy ethnl_features_get_policy[ETHTOOL_A_FEATURES_HEADER + 1];
 extern const struct nla_policy ethnl_features_set_policy[ETHTOOL_A_FEATURES_WANTED + 1];
 extern const struct nla_policy ethnl_privflags_get_policy[ETHTOOL_A_PRIVFLAGS_HEADER + 1];
diff --git a/net/ethtool/wol.c b/net/ethtool/wol.c
index 0ed56c9ac1bc..13dfcc9bb1e5 100644
--- a/net/ethtool/wol.c
+++ b/net/ethtool/wol.c
@@ -12,6 +12,7 @@ struct wol_reply_data {
 	struct ethnl_reply_data		base;
 	struct ethtool_wolinfo		wol;
 	bool				show_sopass;
+	bool				show_mac_da;
 };
 
 #define WOL_REPDATA(__reply_base) \
@@ -41,6 +42,8 @@ static int wol_prepare_data(const struct ethnl_req_info *req_base,
 	/* do not include password in notifications */
 	data->show_sopass = !genl_info_is_ntf(info) &&
 		(data->wol.supported & WAKE_MAGICSECURE);
+	data->show_mac_da = !genl_info_is_ntf(info) &&
+		(data->wol.supported & WAKE_MDA);
 
 	return 0;
 }
@@ -58,6 +61,8 @@ static int wol_reply_size(const struct ethnl_req_info *req_base,
 		return len;
 	if (data->show_sopass)
 		len += nla_total_size(sizeof(data->wol.sopass));
+	if (data->show_mac_da)
+		len += nla_total_size(sizeof(data->wol.mac_da));
 
 	return len;
 }
@@ -79,6 +84,10 @@ static int wol_fill_reply(struct sk_buff *skb,
 	    nla_put(skb, ETHTOOL_A_WOL_SOPASS, sizeof(data->wol.sopass),
 		    data->wol.sopass))
 		return -EMSGSIZE;
+	if (data->show_mac_da &&
+	    nla_put(skb, ETHTOOL_A_WOL_MAC_DA, sizeof(data->wol.mac_da),
+		    data->wol.mac_da))
+		return -EMSGSIZE;
 
 	return 0;
 }
@@ -91,6 +100,8 @@ const struct nla_policy ethnl_wol_set_policy[] = {
 	[ETHTOOL_A_WOL_MODES]		= { .type = NLA_NESTED },
 	[ETHTOOL_A_WOL_SOPASS]		= { .type = NLA_BINARY,
 					    .len = SOPASS_MAX },
+	[ETHTOOL_A_WOL_MAC_DA]		= { .type = NLA_BINARY,
+					    .len = ETH_ALEN }
 };
 
 static int
@@ -131,6 +142,16 @@ ethnl_set_wol(struct ethnl_req_info *req_info, struct genl_info *info)
 		ethnl_update_binary(wol.sopass, sizeof(wol.sopass),
 				    tb[ETHTOOL_A_WOL_SOPASS], &mod);
 	}
+	if (tb[ETHTOOL_A_WOL_MAC_DA]) {
+		if (!(wol.supported & WAKE_MDA)) {
+			NL_SET_ERR_MSG_ATTR(info->extack,
+					    tb[ETHTOOL_A_WOL_MAC_DA],
+					    "mac-da not supported, cannot set MAC");
+			return -EINVAL;
+		}
+		ethnl_update_binary(wol.mac_da, sizeof(wol.mac_da),
+				    tb[ETHTOOL_A_WOL_MAC_DA], &mod);
+	}
 
 	if (!mod)
 		return 0;
-- 
2.34.1


--000000000000e0cce506077820e4
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
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPD2U8veSxhysJrQ
+1Q7Gwfu8M3LmQSPQDrH06FMqfudMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIzMTAxMTIyMTMwOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQD1rSmGBRx7ab0iV6KN30SB9S9xP+0Twefg
aF7Fc6aRZqnu06G1UlSOc2tMt1wRhyd4VExLgy4ANQ0T9LigvFK8KLziNXGRgl6IGu5c9HsYlhA4
rAHfOt3Ne1xkgiFqip01mEjgh6+Io57P9qUQyG++lXzTl3f1CfihPobQtUkcXMIm0qzJ0FQxwgYK
VHYH9p+Rq6bRHKRlsPlRkJXrjL4aVMqXlYK1yAGmjVeSYgwgrUjwpgZcB2GUoKr8GcNvq3jBytGs
2YB0rOcnNm/snVoSjlE7xR0y0YqOQbcvngObVA9w0sz2eUcaCimfzpduNV9d+nsJJnES/SQWsqjs
9tLC
--000000000000e0cce506077820e4--

