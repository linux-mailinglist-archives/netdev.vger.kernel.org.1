Return-Path: <netdev+bounces-289301-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBlqA3ISDGoZVQUAu9opvQ
	(envelope-from <netdev+bounces-289301-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:34:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 665C3579299
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B03D3084129
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 07:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56913D5227;
	Tue, 19 May 2026 07:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENwAfkcN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E22E3D47BD
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 07:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779175707; cv=pass; b=B6mMcHHacFk2RKlkSqort0sKTS/IWACiLvVaPlFdP+qAo8gP6ZVoaPm97Gu1sMeUTWRdP2Lu9WxTG6/fC8KeCxg8iCkQj88JxeNvIcs78fCeWiCZWy2l49elnS+d1Hf964YNx3CF3myyC7rbRzJgC7FMV0/72RZQym3z4Y9MagE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779175707; c=relaxed/simple;
	bh=bu8+8++W0thPa+EvMJjVRJPXFzR/ng7fO3IX1U0JNOg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=E+fF1Np1Nt/c2YxOKApLNKLLP0m06mygnFe2hJwTtLPa/HPASgak0RWhk8HCbmcpJBL+IYMgUTL8ZcfhNndAGz70R7h3Giv7lUyKzm94M+zPOQVeJO7yi8WOm+97dNLHMjUDTJwYud68Hzj/8VukFoFlgO24izzG4nMbgaInCdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENwAfkcN; arc=pass smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-651c7ddf514so2915631d50.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 00:28:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779175705; cv=none;
        d=google.com; s=arc-20240605;
        b=Q4VFcMy3vOsQtbm+sJTUeH8fDRwVxoerqsmk0jcJUty9X94yMdDM4s+v2eo5V4hVCS
         1iJnO+vCIXZpjnsEnHLwgnC3VrfpCV7s78oOovA48mhGIJsiYSgh1u/NuoiEEBn84+Kr
         BzC0M8AV5K+O5u4/bUb/WRrYkQRjgR4NQkfojj5SvehyGJSm/OaNtJUdhG56B6Lc49zT
         NJlm3HrjaR9nWImgd2wE3QvMkYcVbF0F0lU7Yu2BrtiB1SV8otlIBi9mGGeIOQZd4tZ+
         EioagNB3XaR0a9I2BCGaZptEXXfEIZvHpaivBg3veJnQoo+ueLK54QyBsrxi3XIRJqxy
         CHVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=bu8+8++W0thPa+EvMJjVRJPXFzR/ng7fO3IX1U0JNOg=;
        fh=8QorTJEWWUncUeOtjLcY3LTgAP16fzz8OHLDsk6bJZ0=;
        b=I6reT7gvMCljUwdaQ7eBlYJEqM2H9NVgqNodZFqmeyook78RdSdacBDJIFp7CSYpID
         oc5b7yRc6A/wBM1q0XkHOuhQtm5KuApQ+95EzGSw2tKyE49MohzXKQHXNE5JjIwd2WK7
         5EJOjcGTHbuMLSJYBS5zqaPVIYAyJWAOVvig8Ez7cRcJCVlcatBe9gT2T5U8C/09sFAP
         dyub7aFg+f34Co0GmmbmmtEyLpVrpXjks3Al8sFEMzYbJMKRc9fvGDY75ZVQqBivVS0W
         1L6bmS5X5+En9hnrgcKhv51kZsCH8px+XaufwgMsmNH5edgDIEhEykThd2AHv9iSHLWv
         eCIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779175705; x=1779780505; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bu8+8++W0thPa+EvMJjVRJPXFzR/ng7fO3IX1U0JNOg=;
        b=ENwAfkcN4OtlquDJoYgfeOHCAYKCkJ5zgHSdd7L/sIjB2OVOJK3zr/aSBuqED+54u2
         XMeQn7iwlZ/Q627BxERXfieQfYcgYUnHdFz/DxiFP/GdumhJGjIwP7pTpoiKqLjvZZ2P
         GKSUDFi76N8NxwhsoURx9POrsRQ1LBjoLPrc4wOtP/B4KWWzGd+jX3EtdGl1vxs5IxGX
         pe/TJZihnMztRjGX0b6Mx54eLehtaaS6TnssKyyHXNrSg0tqqXD4dJuH+3L1vG58SEUZ
         lsokb4J1Q/BQ2WXxmP8YKcFRAmap+UNTB3MEEngIVSVM6uj9Rg7lWkDXDrvngq1iAIpJ
         mthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779175705; x=1779780505;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bu8+8++W0thPa+EvMJjVRJPXFzR/ng7fO3IX1U0JNOg=;
        b=kGVDcti5urMgX3K8g8h9btfHG9QSm5RpCkfRkHPyeWb/XVdUATBFa1kU05PGQ76wGb
         3g2Wq5J/ipvh34Twg2GBsZC1oDSNwo4oUiYtnLtrG/WRwJ7abwJQTMrh/ouAWu8ZCKfH
         qteyn0WQJtp/tzBBj2x1p9oIE2OfSehJYjyn2LPl6R6og13dcxiavA62Z7kes9K46R2c
         6I0hgsG6lCg27JRAXBlQM67EVbgQQ9b/qHy+/ecbPfPqNDSGSw6+m+DS/+LwsH7OUvMD
         6li5NEUr6sLQgoX4c4r2OcbWwrdEpFJ3Kp7IaLtEcBoe9hqDycBFf127JpSVNJRHdX1k
         JL3w==
X-Forwarded-Encrypted: i=1; AFNElJ8rsHca2eWE68FjWgBTioydgvnW8Xp0KKVImnwrlZblSggtQAqhNxwffzbvQxR9mQ4AugP+0r4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF3q4BzZeHzA2HcUOnu/pQWtzVRJAuYcZeRbvxjNpEQaPeLL/w
	FDWIiOUf+8+nYQhGMeWB9HMXsJNkr1DzUn3ph37GpeFl9wnLQjrR2//atAvaOGYdhuli2MbEV2/
	axX63DhdO7WPCYSEaOk20PCqRFhJa8CU=
X-Gm-Gg: Acq92OGwrB8QKGNAU82Npbb9F/dZwClrK8zKtgwCuRvl26UebkPjE6welqS6g56eOZB
	Bhz7A1s53yfKT4ZB4Y0jbbizWHg4Djef66ag93tIk6tD4WukbQJmEqaN10IrKWPpsouJDRDexNU
	9ckkO6fA/ELM6QAfLIuPlXjCsBdPVoHr6ROXLeuHsUnEnnyZ6Z3Jsi6cA4jdrs5EPiRL8gsVaeT
	fLadB5REkwrQ7PQfhiLFRffGJLAfXOnX7iK2n30CWU3h4FUjHzk9iY7cHgUnR1XDaRa3ppdh5GH
	f4CzH6qK9AK3+LSR7Zw=
X-Received: by 2002:a05:690e:12c7:b0:65e:55bb:d5e8 with SMTP id
 956f58d0204a3-65e55bbff6cmr7067567d50.64.1779175705266; Tue, 19 May 2026
 00:28:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ivanl S <shaoxul@gmail.com>
Date: Tue, 19 May 2026 15:28:14 +0800
X-Gm-Features: AVHnY4IMoy0BWe_phiQP8JauzMmWHHN0vkroO6OQSlOs3l8UCBvV4zvpwcRc3sc
Message-ID: <CANwjiYaL1WLBoPxy6QrhpXOUef_P6q-RHwE5EvFHU0AdPUs+cA@mail.gmail.com>
Subject: [PATCH] Add power management op for RNDIS host
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: "GitAuthor: Shaoxu Liu" <shaoxul@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289301-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaoxul@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 665C3579299
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From bf417c9c1c22f8d335ec361d6fb5759fd167733a Mon Sep 17 00:00:00 2001
From bf417c9c1c22f8d335ec361d6fb5759fd167733a Mon Sep 17 00:00:00 2001
From: Shaoxu Liu <shaoxu.liu@telit.com> Date: Tue, 19 May 2026
13:49:06 +0800 Subject: [PATCH] Add power management op for RNDIS host
RNDIS host does not manage the USB power, and it will cause more power
consumption even when no data transferring. Adding the power
management operator will make the USB enter suspend mode when no data
transferring. --- drivers/net/usb/rndis_host.c | 16 ++++++++++++++++ 1
file changed, 16 insertions(+) diff --git
a/drivers/net/usb/rndis_host.c b/drivers/net/usb/rndis_host.c index
7b3739b29..76eb65fd5 100644 --- a/drivers/net/usb/rndis_host.c +++
b/drivers/net/usb/rndis_host.c @@ -630,6 +630,17 @@ static const
struct driver_info zte_rndis_info = { .tx_fixup = rndis_tx_fixup, };
+static const struct driver_info rndis_info_lowpower = { +
.description = "RNDIS device", + .flags = FLAG_ETHER |
FLAG_POINTTOPOINT | FLAG_FRAMING_RN | FLAG_NO_SETINT, + .bind =
rndis_bind, + .unbind = rndis_unbind, + .status = rndis_status, +
.rx_fixup = rndis_rx_fixup, + .tx_fixup = rndis_tx_fixup, +
.manage_power = usbnet_manage_power, +}; +
/*-------------------------------------------------------------------------*/
static const struct usb_device_id products [] = { @@ -657,6 +668,11 @@
static const struct usb_device_id products [] = { /* RNDIS is MSFT's
un-official variant of CDC ACM */ USB_INTERFACE_INFO(USB_CLASS_COMM, 2
/* ACM */, 0x0ff), .driver_info = (unsigned long) &rndis_info, +}, { +
/* RNDIS for Telit Cinterion low power LTE cat1biz modules LE310X1*/ +
USB_DEVICE_AND_INTERFACE_INFO(0x1bc7, 0x7030, +
USB_CLASS_WIRELESS_CONTROLLER, 1, 3), + .driver_info = (unsigned
long)&rndis_info_lowpower, }, { /* "ActiveSync" is an undocumented
variant of RNDIS, used in WM5 */ USB_INTERFACE_INFO(USB_CLASS_MISC, 1,
1), -- 2.25.1 Signed-off-by: Shaoxu Liu <shaoxul@gmail.com>

