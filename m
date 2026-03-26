Return-Path: <netdev+bounces-272029-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMaBOE8qxWnb7gQAu9opvQ
	(envelope-from <netdev+bounces-272029-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:45:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 481813356B4
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3B3F30CEA47
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1573C8734;
	Thu, 26 Mar 2026 12:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="arTG7Anx"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32132347FCD;
	Thu, 26 Mar 2026 12:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528717; cv=none; b=LhPphDouB9B0STnovcz9eXXeT3DweqI/0dXh38CrqW8KJoN6qYU3+3wLf2DeVnkg5Un3WSMUQeb5nftrOW8OSTNon9T6x82TelJoQ9/fHFn/AOF4XxDlSQv9LwwKE6DMTjijE2qa4GlXS13Hr1Rabc8NL5s9XF0maD/06GhoLkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528717; c=relaxed/simple;
	bh=qjey+VcgjL3Yo7kDtwbvv9DRXVGVGoFZZTBZ+RV8oPQ=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=X115suvSZtdhLUJowtJuj5D88B1kBBOvykHrhA+quvA9rTmZt/IYHvt5rpAAzIp+2k5EnltJSjIPXVWK06sjSh1Qf3zANpCdVJQXFhpexGa2mUUbB6uWwbKtd+sU+MTZtjQ2n93cwXHPBlyaGeK1ivHjX+OYlzKeACVYugRfzog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=arTG7Anx; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8BAD310D9CF;
	Thu, 26 Mar 2026 13:38:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1774528712;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-language:in-reply-to:references;
	bh=2e3ZvnSQSPjVnerdWD41L2g+lwnYBfiJ/hW/bqpwyiE=;
	b=arTG7AnxuBGf+pMsv7Ed368ec04WzWtIOq9RToQKGosbUX5GL41iKwcxEY0LjLv6va4Nj0
	6s9V2/vHmGWG4UVE+w3eNRN+dW2itTTkExqbpaefyBL8CE/I0uiwWl9j+nVoOx1RZTSQBl
	AcEM1oXcKv0lmpOhbcEvri7ELybP8SFU1fnOe980uKWXsneDUV9QOYfeiLP9FGSu8Bh/fO
	3sKaGUY8poOkVGJLQoCgku2ZjSQxsy4SFRBp5Zm5ujcagTrbI1KAE4tMqNS59ui/mubJ8X
	UzFMmLYEx+UwyjPBbZijXnuMcb0OmlQopAwWWqpjblxqbK4AvsBKDzb33vPOGA==
Content-Type: multipart/mixed; boundary="------------MFz30WOzW5H8gEKjOl5rLerx"
Message-ID: <14d42756-8b97-40a5-ac1d-1d1a0dd3c87d@nabladev.com>
Date: Thu, 26 Mar 2026 13:38:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
To: Fidelio Lawson <lawson.fidelio@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260326-ksz87xx_errata_low_loss_connections-v1-0-79a698f43626@exotec.com>
 <20260326-ksz87xx_errata_low_loss_connections-v1-3-79a698f43626@exotec.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260326-ksz87xx_errata_low_loss_connections-v1-3-79a698f43626@exotec.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272029-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[nabladev.com:+];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,site.com:url,nabladev.com:dkim,nabladev.com:email,nabladev.com:mid]
X-Rspamd-Queue-Id: 481813356B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a multi-part message in MIME format.
--------------MFz30WOzW5H8gEKjOl5rLerx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/26 10:10 AM, Fidelio Lawson wrote:

> +static int ksz8_handle_module3_errata(struct ksz_device *dev)
> +{
> +	int ret = 0;
> +	const u16 *regs = dev->info->regs;
> +	u16 indir_reg = 0x0000;
> +	u8 indir_val = 0x00;
> +
> +	switch (dev->low_loss_wa_mode) {
> +	case KSZ_LOW_LOSS_WA_1:
> +		indir_reg = 0x3C;
> +		indir_val = 0x15;
> +		break;
> +	case KSZ_LOW_LOSS_WA_2:
> +		indir_reg = 0x4C;
> +		indir_val = 0x40;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	mutex_lock(&dev->alu_mutex);
> +
> +	ret = ksz_write8(dev, regs[REG_IND_CTRL_0], 0xA0);
> +
> +	if (!ret)
> +		ret = ksz_write8(dev, 0x6F, indir_reg);
> +
> +	if (!ret)
> +		ret = ksz_write8(dev, regs[REG_IND_BYTE], indir_val);
> +
> +	mutex_unlock(&dev->alu_mutex);
> +
> +	return ret;
> +}
Since this is configurable from DT, please adjust the bindings and make 
the low pass filter bandwidth actually configurable according to the 
values supported by the hardware, see this article:

https://microchip.my.site.com/s/article/Solution-for-Using-CAT-5E-or-CAT-6-Short-Cable-with-a-Link-Issue-for-the-KSZ8795-Family

The indirect register (0x4C) is an 8-bit register. The bits [7:6] are 
described in the table below.

Low pass filter bandwidth
00 = 90MHz
01 = 62MHz
10 = 55MHz
11 = 44MHz

...

I had this attached patch in my tree for a while, I just never got 
around to finishing it, because even with this in place, there was some 
packet loss with short cables at low temperatures. Maybe it can help:

 From 937278ee6dc0aa46797cc4b2d53078f95b6557a9 Mon Sep 17 00:00:00 2001
From: Marek Vasut <marex@nabladev.com>
Date: Mon, 2 Jun 2025 01:42:17 +0200
Subject: [PATCH] net: dsa: microchip: Fix KSZ87xx high quality cable errata
  module 3

KSZ87xx may fail to establish link, or may take long time to
establish link, when using high quality > CAT-5 ethernet cables.
This is described in KSZ87xx Errata DS80000687C Module 3:

Module 3: Establishing a link through low loss connections.
   The receiver of the embedded PHYs is tuned by default to
   support long cable length applications. This was developed
   using low quality, high loss cables. Because of this, the
   equalizer in the PHY may amplify high amplitude receiver
   signals to the point that the signal is distorted internally,
   preventing a link from being established.

More detailed description and a more advanced fix is described in
"
Solution for Using CAT-5E or CAT-6 Short Cable with a Link Issue
for the KSZ8795 Family
"
https://microchip.my.site.com/s/article/Solution-for-Using-CAT-5E-or-CAT-6-Short-Cable-with-a-Link-Issue-for-the-KSZ8795-Family

The fix reduces low pass filter bandwidth from 90 MHz to 62 MHz
to block higher frequency components which make it through the
higher quality cables and saturate the receiver amplifier. In
case of even shorter cables, the link equalizer function has to
start from position 0 instead of the default position 0xf to
cater for those cables, configure the equalizer position as well.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
  drivers/net/dsa/microchip/ksz8.c     | 33 ++++++++++++++++++++++++++--
  drivers/net/dsa/microchip/ksz8_reg.h |  2 +-
  2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c 
b/drivers/net/dsa/microchip/ksz8.c
index 3309c2c172f02..f8716c8d0d375 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1891,10 +1891,39 @@ static int ksz8_handle_global_errata(struct 
dsa_switch *ds)
  	 *   KSZ879x/KSZ877x/KSZ876x and some EEE link partners may result in
  	 *   the link dropping.
  	 */
-	if (dev->info->ksz87xx_eee_link_erratum)
+	if (dev->info->ksz87xx_eee_link_erratum) {
  		ret = ksz8_ind_write8(dev, TABLE_EEE, REG_IND_EEE_GLOB2_HI, 0);
+		if (ret)
+			return ret;
+	}

-	return ret;
+	/*
+	 * Module 3: Establishing a link through low loss connections.
+	 *   The receiver of the embedded PHYs is tuned by default to
+	 *   support long cable length applications. This was developed
+	 *   using low quality, high loss cables. Because of this, the
+	 *   equalizer in the PHY may amplify high amplitude receiver
+	 *   signals to the point that the signal is distorted internally,
+	 *   preventing a link from being established.
+	 *
+	 * More detailed description and a more advanced fix is described in
+	 * "
+	 * Solution for Using CAT-5E or CAT-6 Short Cable with a Link Issue
+	 * for the KSZ8795 Family
+	 * "
+	 * 
https://microchip.my.site.com/s/article/Solution-for-Using-CAT-5E-or-CAT-6-Short-Cable-with-a-Link-Issue-for-the-KSZ8795-Family
+	 *
+	 * The following two magic writes are the implementation of the
+	 * aforementioned workaround.
+	 */
+
+	/* Force low pass filter bandwidth from 90 MHz to 62 MHz */
+	ret = ksz8_ind_write8(dev, TABLE_LINK_MD, 0x4c, 0x40);
+	if (ret)
+		return ret;
+
+	/* Force DSP EQ initial value to 0 */
+	return ksz8_ind_write8(dev, TABLE_LINK_MD, 0x08, 0);
  }

  int ksz8_enable_stp_addr(struct ksz_device *dev)
diff --git a/drivers/net/dsa/microchip/ksz8_reg.h 
b/drivers/net/dsa/microchip/ksz8_reg.h
index 329688603a582..c4897f27c6d1c 100644
--- a/drivers/net/dsa/microchip/ksz8_reg.h
+++ b/drivers/net/dsa/microchip/ksz8_reg.h
@@ -342,7 +342,7 @@
  #define TABLE_EEE			(TABLE_EEE_V << TABLE_EXT_SELECT_S)
  #define TABLE_ACL			(TABLE_ACL_V << TABLE_EXT_SELECT_S)
  #define TABLE_PME			(TABLE_PME_V << TABLE_EXT_SELECT_S)
-#define TABLE_LINK_MD			(TABLE_LINK_MD << TABLE_EXT_SELECT_S)
+#define TABLE_LINK_MD			(TABLE_LINK_MD_V << TABLE_EXT_SELECT_S)
  #define TABLE_READ			BIT(4)
  #define TABLE_SELECT_S			2
  #define TABLE_STATIC_MAC_V		0
-- 
2.53.0

--------------MFz30WOzW5H8gEKjOl5rLerx
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-net-dsa-microchip-Fix-KSZ87xx-high-quality-cable-err.patch"
Content-Disposition: attachment;
 filename*0="0001-net-dsa-microchip-Fix-KSZ87xx-high-quality-cable-err.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA5MzcyNzhlZTZkYzBhYTQ2Nzk3Y2M0YjJkNTMwNzhmOTViNjU1N2E5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNYXJlayBWYXN1dCA8bWFyZXhAbmFibGFkZXYuY29t
PgpEYXRlOiBNb24sIDIgSnVuIDIwMjUgMDE6NDI6MTcgKzAyMDAKU3ViamVjdDogW1BBVENI
XSBuZXQ6IGRzYTogbWljcm9jaGlwOiBGaXggS1NaODd4eCBoaWdoIHF1YWxpdHkgY2FibGUg
ZXJyYXRhCiBtb2R1bGUgMwoKS1NaODd4eCBtYXkgZmFpbCB0byBlc3RhYmxpc2ggbGluaywg
b3IgbWF5IHRha2UgbG9uZyB0aW1lIHRvCmVzdGFibGlzaCBsaW5rLCB3aGVuIHVzaW5nIGhp
Z2ggcXVhbGl0eSA+IENBVC01IGV0aGVybmV0IGNhYmxlcy4KVGhpcyBpcyBkZXNjcmliZWQg
aW4gS1NaODd4eCBFcnJhdGEgRFM4MDAwMDY4N0MgTW9kdWxlIDM6CgpNb2R1bGUgMzogRXN0
YWJsaXNoaW5nIGEgbGluayB0aHJvdWdoIGxvdyBsb3NzIGNvbm5lY3Rpb25zLgogIFRoZSBy
ZWNlaXZlciBvZiB0aGUgZW1iZWRkZWQgUEhZcyBpcyB0dW5lZCBieSBkZWZhdWx0IHRvCiAg
c3VwcG9ydCBsb25nIGNhYmxlIGxlbmd0aCBhcHBsaWNhdGlvbnMuIFRoaXMgd2FzIGRldmVs
b3BlZAogIHVzaW5nIGxvdyBxdWFsaXR5LCBoaWdoIGxvc3MgY2FibGVzLiBCZWNhdXNlIG9m
IHRoaXMsIHRoZQogIGVxdWFsaXplciBpbiB0aGUgUEhZIG1heSBhbXBsaWZ5IGhpZ2ggYW1w
bGl0dWRlIHJlY2VpdmVyCiAgc2lnbmFscyB0byB0aGUgcG9pbnQgdGhhdCB0aGUgc2lnbmFs
IGlzIGRpc3RvcnRlZCBpbnRlcm5hbGx5LAogIHByZXZlbnRpbmcgYSBsaW5rIGZyb20gYmVp
bmcgZXN0YWJsaXNoZWQuCgpNb3JlIGRldGFpbGVkIGRlc2NyaXB0aW9uIGFuZCBhIG1vcmUg
YWR2YW5jZWQgZml4IGlzIGRlc2NyaWJlZCBpbgoiClNvbHV0aW9uIGZvciBVc2luZyBDQVQt
NUUgb3IgQ0FULTYgU2hvcnQgQ2FibGUgd2l0aCBhIExpbmsgSXNzdWUKZm9yIHRoZSBLU1o4
Nzk1IEZhbWlseQoiCmh0dHBzOi8vbWljcm9jaGlwLm15LnNpdGUuY29tL3MvYXJ0aWNsZS9T
b2x1dGlvbi1mb3ItVXNpbmctQ0FULTVFLW9yLUNBVC02LVNob3J0LUNhYmxlLXdpdGgtYS1M
aW5rLUlzc3VlLWZvci10aGUtS1NaODc5NS1GYW1pbHkKClRoZSBmaXggcmVkdWNlcyBsb3cg
cGFzcyBmaWx0ZXIgYmFuZHdpZHRoIGZyb20gOTAgTUh6IHRvIDYyIE1Iegp0byBibG9jayBo
aWdoZXIgZnJlcXVlbmN5IGNvbXBvbmVudHMgd2hpY2ggbWFrZSBpdCB0aHJvdWdoIHRoZQpo
aWdoZXIgcXVhbGl0eSBjYWJsZXMgYW5kIHNhdHVyYXRlIHRoZSByZWNlaXZlciBhbXBsaWZp
ZXIuIEluCmNhc2Ugb2YgZXZlbiBzaG9ydGVyIGNhYmxlcywgdGhlIGxpbmsgZXF1YWxpemVy
IGZ1bmN0aW9uIGhhcyB0bwpzdGFydCBmcm9tIHBvc2l0aW9uIDAgaW5zdGVhZCBvZiB0aGUg
ZGVmYXVsdCBwb3NpdGlvbiAweGYgdG8KY2F0ZXIgZm9yIHRob3NlIGNhYmxlcywgY29uZmln
dXJlIHRoZSBlcXVhbGl6ZXIgcG9zaXRpb24gYXMgd2VsbC4KClNpZ25lZC1vZmYtYnk6IE1h
cmVrIFZhc3V0IDxtYXJleEBuYWJsYWRldi5jb20+Ci0tLQogZHJpdmVycy9uZXQvZHNhL21p
Y3JvY2hpcC9rc3o4LmMgICAgIHwgMzMgKysrKysrKysrKysrKysrKysrKysrKysrKystLQog
ZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3o4X3JlZy5oIHwgIDIgKy0KIDIgZmlsZXMg
Y2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tzejguYyBiL2RyaXZlcnMvbmV0L2RzYS9t
aWNyb2NoaXAva3N6OC5jCmluZGV4IDMzMDljMmMxNzJmMDIuLmY4NzE2YzhkMGQzNzUgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAva3N6OC5jCisrKyBiL2RyaXZl
cnMvbmV0L2RzYS9taWNyb2NoaXAva3N6OC5jCkBAIC0xODkxLDEwICsxODkxLDM5IEBAIHN0
YXRpYyBpbnQga3N6OF9oYW5kbGVfZ2xvYmFsX2VycmF0YShzdHJ1Y3QgZHNhX3N3aXRjaCAq
ZHMpCiAJICogICBLU1o4Nzl4L0tTWjg3N3gvS1NaODc2eCBhbmQgc29tZSBFRUUgbGluayBw
YXJ0bmVycyBtYXkgcmVzdWx0IGluCiAJICogICB0aGUgbGluayBkcm9wcGluZy4KIAkgKi8K
LQlpZiAoZGV2LT5pbmZvLT5rc3o4N3h4X2VlZV9saW5rX2VycmF0dW0pCisJaWYgKGRldi0+
aW5mby0+a3N6ODd4eF9lZWVfbGlua19lcnJhdHVtKSB7CiAJCXJldCA9IGtzejhfaW5kX3dy
aXRlOChkZXYsIFRBQkxFX0VFRSwgUkVHX0lORF9FRUVfR0xPQjJfSEksIDApOworCQlpZiAo
cmV0KQorCQkJcmV0dXJuIHJldDsKKwl9CiAKLQlyZXR1cm4gcmV0OworCS8qCisJICogTW9k
dWxlIDM6IEVzdGFibGlzaGluZyBhIGxpbmsgdGhyb3VnaCBsb3cgbG9zcyBjb25uZWN0aW9u
cy4KKwkgKiAgIFRoZSByZWNlaXZlciBvZiB0aGUgZW1iZWRkZWQgUEhZcyBpcyB0dW5lZCBi
eSBkZWZhdWx0IHRvCisJICogICBzdXBwb3J0IGxvbmcgY2FibGUgbGVuZ3RoIGFwcGxpY2F0
aW9ucy4gVGhpcyB3YXMgZGV2ZWxvcGVkCisJICogICB1c2luZyBsb3cgcXVhbGl0eSwgaGln
aCBsb3NzIGNhYmxlcy4gQmVjYXVzZSBvZiB0aGlzLCB0aGUKKwkgKiAgIGVxdWFsaXplciBp
biB0aGUgUEhZIG1heSBhbXBsaWZ5IGhpZ2ggYW1wbGl0dWRlIHJlY2VpdmVyCisJICogICBz
aWduYWxzIHRvIHRoZSBwb2ludCB0aGF0IHRoZSBzaWduYWwgaXMgZGlzdG9ydGVkIGludGVy
bmFsbHksCisJICogICBwcmV2ZW50aW5nIGEgbGluayBmcm9tIGJlaW5nIGVzdGFibGlzaGVk
LgorCSAqCisJICogTW9yZSBkZXRhaWxlZCBkZXNjcmlwdGlvbiBhbmQgYSBtb3JlIGFkdmFu
Y2VkIGZpeCBpcyBkZXNjcmliZWQgaW4KKwkgKiAiCisJICogU29sdXRpb24gZm9yIFVzaW5n
IENBVC01RSBvciBDQVQtNiBTaG9ydCBDYWJsZSB3aXRoIGEgTGluayBJc3N1ZQorCSAqIGZv
ciB0aGUgS1NaODc5NSBGYW1pbHkKKwkgKiAiCisJICogaHR0cHM6Ly9taWNyb2NoaXAubXku
c2l0ZS5jb20vcy9hcnRpY2xlL1NvbHV0aW9uLWZvci1Vc2luZy1DQVQtNUUtb3ItQ0FULTYt
U2hvcnQtQ2FibGUtd2l0aC1hLUxpbmstSXNzdWUtZm9yLXRoZS1LU1o4Nzk1LUZhbWlseQor
CSAqCisJICogVGhlIGZvbGxvd2luZyB0d28gbWFnaWMgd3JpdGVzIGFyZSB0aGUgaW1wbGVt
ZW50YXRpb24gb2YgdGhlCisJICogYWZvcmVtZW50aW9uZWQgd29ya2Fyb3VuZC4KKwkgKi8K
KworCS8qIEZvcmNlIGxvdyBwYXNzIGZpbHRlciBiYW5kd2lkdGggZnJvbSA5MCBNSHogdG8g
NjIgTUh6ICovCisJcmV0ID0ga3N6OF9pbmRfd3JpdGU4KGRldiwgVEFCTEVfTElOS19NRCwg
MHg0YywgMHg0MCk7CisJaWYgKHJldCkKKwkJcmV0dXJuIHJldDsKKworCS8qIEZvcmNlIERT
UCBFUSBpbml0aWFsIHZhbHVlIHRvIDAgKi8KKwlyZXR1cm4ga3N6OF9pbmRfd3JpdGU4KGRl
diwgVEFCTEVfTElOS19NRCwgMHgwOCwgMCk7CiB9CiAKIGludCBrc3o4X2VuYWJsZV9zdHBf
YWRkcihzdHJ1Y3Qga3N6X2RldmljZSAqZGV2KQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
ZHNhL21pY3JvY2hpcC9rc3o4X3JlZy5oIGIvZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9r
c3o4X3JlZy5oCmluZGV4IDMyOTY4ODYwM2E1ODIuLmM0ODk3ZjI3YzZkMWMgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAva3N6OF9yZWcuaAorKysgYi9kcml2ZXJz
L25ldC9kc2EvbWljcm9jaGlwL2tzejhfcmVnLmgKQEAgLTM0Miw3ICszNDIsNyBAQAogI2Rl
ZmluZSBUQUJMRV9FRUUJCQkoVEFCTEVfRUVFX1YgPDwgVEFCTEVfRVhUX1NFTEVDVF9TKQog
I2RlZmluZSBUQUJMRV9BQ0wJCQkoVEFCTEVfQUNMX1YgPDwgVEFCTEVfRVhUX1NFTEVDVF9T
KQogI2RlZmluZSBUQUJMRV9QTUUJCQkoVEFCTEVfUE1FX1YgPDwgVEFCTEVfRVhUX1NFTEVD
VF9TKQotI2RlZmluZSBUQUJMRV9MSU5LX01ECQkJKFRBQkxFX0xJTktfTUQgPDwgVEFCTEVf
RVhUX1NFTEVDVF9TKQorI2RlZmluZSBUQUJMRV9MSU5LX01ECQkJKFRBQkxFX0xJTktfTURf
ViA8PCBUQUJMRV9FWFRfU0VMRUNUX1MpCiAjZGVmaW5lIFRBQkxFX1JFQUQJCQlCSVQoNCkK
ICNkZWZpbmUgVEFCTEVfU0VMRUNUX1MJCQkyCiAjZGVmaW5lIFRBQkxFX1NUQVRJQ19NQUNf
VgkJMAotLSAKMi41My4wCgo=

--------------MFz30WOzW5H8gEKjOl5rLerx--

