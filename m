Return-Path: <netdev+bounces-40013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B32E7C5633
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 16:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 064CE282715
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 14:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9614B200D8;
	Wed, 11 Oct 2023 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oK3IFg/p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7333B200C8;
	Wed, 11 Oct 2023 14:03:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CB3C433CC;
	Wed, 11 Oct 2023 14:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697032989;
	bh=k4v64vdXlavEo9kLUWLKxx3pHDNDWQxvczexvxtQbZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oK3IFg/pFE4zGL1/r/Ct+4u3hGS8StfN/uiWbC/n8TvbMVsHb3gKi7yzdteb91f67
	 Y8an+OreGiSvHgVCR6ykm3uODlHrl+zH57eCRnNVH2CQxUpRnLDHrjJX5l2p3pwcZ1
	 OEBucTPuvF9Pghus2KylDa9kV73fRw8MPf1naZO2zJXHC6IqVh5vwkV+kmLHGRZQeX
	 7hgEq0saCgubgmTWXvUedHbYkjt1In2YhFtgSUY8/iOfHfcaP2KBkU1mSXsrEZpBk/
	 0KP9LX610aszxOye0d+NVcSLirMxUDPRPYgSakwWC7hGkR+o+ddsMgjMsBiEyw7r7m
	 RbWV4f5ADf8qA==
From: Arnd Bergmann <arnd@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wpan@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Rodolfo Zitellini <rwz@xhero.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 06/10] staging: rtl8712: remove unused legacy ioctl handlers
Date: Wed, 11 Oct 2023 16:02:21 +0200
Message-Id: <20231011140225.253106-6-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011140225.253106-1-arnd@kernel.org>
References: <20231011140225.253106-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The .ndo_do_ioctl functions are never called, and can just be removed,
especially since this is a staging driver.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/rtl8712/os_intfs.c            |   1 -
 drivers/staging/rtl8712/osdep_intf.h          |   2 -
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 124 ------------------
 3 files changed, 127 deletions(-)

diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index b18e6d9c832b8..121edffbd2507 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -191,7 +191,6 @@ static const struct net_device_ops rtl8712_netdev_ops = {
 	.ndo_start_xmit = r8712_xmit_entry,
 	.ndo_set_mac_address = r871x_net_set_mac_address,
 	.ndo_get_stats = r871x_net_get_stats,
-	.ndo_do_ioctl = r871x_ioctl,
 };
 
 struct net_device *r8712_init_netdev(void)
diff --git a/drivers/staging/rtl8712/osdep_intf.h b/drivers/staging/rtl8712/osdep_intf.h
index 9e75116c987ec..ce823030bfec2 100644
--- a/drivers/staging/rtl8712/osdep_intf.h
+++ b/drivers/staging/rtl8712/osdep_intf.h
@@ -27,6 +27,4 @@ struct intf_priv {
 	struct completion io_retevt_comp;
 };
 
-int r871x_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
-
 #endif	/*_OSDEP_INTF_H_*/
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
index 36f6904d25abc..a4a34c9f00b84 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
@@ -36,8 +36,6 @@
 #include <linux/if_arp.h>
 #include <linux/etherdevice.h>
 
-#define RTL_IOCTL_WPA_SUPPLICANT	(SIOCIWFIRSTPRIV + 0x1E)
-
 #define SCAN_ITEM_SIZE 768
 #define MAX_CUSTOM_LEN 64
 #define RATE_COUNT 4
@@ -2066,128 +2064,6 @@ static int r871x_wps_start(struct net_device *dev,
 	return 0;
 }
 
-static int wpa_set_param(struct net_device *dev, u8 name, u32 value)
-{
-	struct _adapter *padapter = netdev_priv(dev);
-
-	switch (name) {
-	case IEEE_PARAM_WPA_ENABLED:
-		padapter->securitypriv.AuthAlgrthm = 2; /* 802.1x */
-		switch ((value) & 0xff) {
-		case 1: /* WPA */
-			padapter->securitypriv.ndisauthtype =
-				Ndis802_11AuthModeWPAPSK; /* WPA_PSK */
-			padapter->securitypriv.ndisencryptstatus =
-				Ndis802_11Encryption2Enabled;
-			break;
-		case 2: /* WPA2 */
-			padapter->securitypriv.ndisauthtype =
-				Ndis802_11AuthModeWPA2PSK; /* WPA2_PSK */
-			padapter->securitypriv.ndisencryptstatus =
-				Ndis802_11Encryption3Enabled;
-			break;
-		}
-		break;
-	case IEEE_PARAM_TKIP_COUNTERMEASURES:
-		break;
-	case IEEE_PARAM_DROP_UNENCRYPTED:
-		/* HACK:
-		 *
-		 * wpa_supplicant calls set_wpa_enabled when the driver
-		 * is loaded and unloaded, regardless of if WPA is being
-		 * used.  No other calls are made which can be used to
-		 * determine if encryption will be used or not prior to
-		 * association being expected.  If encryption is not being
-		 * used, drop_unencrypted is set to false, else true -- we
-		 * can use this to determine if the CAP_PRIVACY_ON bit should
-		 * be set.
-		 */
-		break;
-	case IEEE_PARAM_PRIVACY_INVOKED:
-		break;
-	case IEEE_PARAM_AUTH_ALGS:
-		return wpa_set_auth_algs(dev, value);
-	case IEEE_PARAM_IEEE_802_1X:
-		break;
-	case IEEE_PARAM_WPAX_SELECT:
-		/* added for WPA2 mixed mode */
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-	return 0;
-}
-
-static int wpa_mlme(struct net_device *dev, u32 command, u32 reason)
-{
-	struct _adapter *padapter = netdev_priv(dev);
-
-	switch (command) {
-	case IEEE_MLME_STA_DEAUTH:
-		if (!r8712_set_802_11_disassociate(padapter))
-			return -1;
-		break;
-	case IEEE_MLME_STA_DISASSOC:
-		if (!r8712_set_802_11_disassociate(padapter))
-			return -1;
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-	return 0;
-}
-
-static int wpa_supplicant_ioctl(struct net_device *dev, struct iw_point *p)
-{
-	struct ieee_param *param;
-	int ret = 0;
-	struct _adapter *padapter = netdev_priv(dev);
-
-	if (p->length < sizeof(struct ieee_param) || !p->pointer)
-		return -EINVAL;
-	param = memdup_user(p->pointer, p->length);
-	if (IS_ERR(param))
-		return PTR_ERR(param);
-	switch (param->cmd) {
-	case IEEE_CMD_SET_WPA_PARAM:
-		ret = wpa_set_param(dev, param->u.wpa_param.name,
-		      param->u.wpa_param.value);
-		break;
-	case IEEE_CMD_SET_WPA_IE:
-		ret =  r871x_set_wpa_ie(padapter, (char *)param->u.wpa_ie.data,
-		       (u16)param->u.wpa_ie.len);
-		break;
-	case IEEE_CMD_SET_ENCRYPTION:
-		ret = wpa_set_encryption(dev, param, p->length);
-		break;
-	case IEEE_CMD_MLME:
-		ret = wpa_mlme(dev, param->u.mlme.command,
-		      param->u.mlme.reason_code);
-		break;
-	default:
-		ret = -EOPNOTSUPP;
-		break;
-	}
-	if (ret == 0 && copy_to_user(p->pointer, param, p->length))
-		ret = -EFAULT;
-	kfree(param);
-	return ret;
-}
-
-/* based on "driver_ipw" and for hostapd */
-int r871x_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
-{
-	struct iwreq *wrq = (struct iwreq *)rq;
-
-	switch (cmd) {
-	case RTL_IOCTL_WPA_SUPPLICANT:
-		return wpa_supplicant_ioctl(dev, &wrq->u.data);
-	default:
-		return -EOPNOTSUPP;
-	}
-	return 0;
-}
-
 static iw_handler r8711_handlers[] = {
 	NULL,				/* SIOCSIWCOMMIT */
 	r8711_wx_get_name,		/* SIOCGIWNAME */
-- 
2.39.2


