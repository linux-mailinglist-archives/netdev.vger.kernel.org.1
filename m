Return-Path: <netdev+bounces-273762-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPj5Lr0+zGkHRwYAu9opvQ
	(envelope-from <netdev+bounces-273762-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:38:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CE3371FE9
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68D6130892C1
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 21:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E418F44B67E;
	Tue, 31 Mar 2026 21:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="CErz9Zt8"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B4A2D1F64
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 21:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774992451; cv=none; b=KBLEezXTMZ7qw33K8YA8fI5mhPfS9hYlYQZucKUPiCoU/4CoYEEcIT+zPeZQHTr/+dffTxivDCrKFWQ7GoU1+U4fOBMUIBdfFx65kGNfdAO0OQP6GMsarIs5oma9YMin9h5pMUIg13EFM+eBoailJJSRHsVG9iQeYE+HjgVCsdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774992451; c=relaxed/simple;
	bh=CIMPmsWWWwKokFRQ9eznnv6HEEIWuG/7/NwyRC94jVc=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type; b=c4eonSZcmZNam0SPmHYp8N0Rva5UQwGzxZQqtXQFwRVznuWP9pp9wvcUZtm4gpPdzN4+2UM5KoZqlK2beOUCd6hscUPqVA6kb4w5nGyFMK0Su+oBsu9dCcf2hVLoWz/LhYX2kWNODue9lCtDYWzkeh3aqe93K2OuyPsry/sDduY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=CErz9Zt8; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6EE37A5870;
	Tue, 31 Mar 2026 23:27:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1774992441; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=FqQ5RDAKPNqWaVl0P1Tajn8xNmLrsJbtzQL1cFotTHI=;
	b=CErz9Zt87xk5FlDGzma0mVmU89xOdcUcm33E4nK0/UPRv+ZXyhcFXk2oXFxWvxSVcQJCTq
	g5mTxVKUot2STPUX5ikaGeV/3PKcvUxoJdKh6dLKWZfwT+ek+ZwQRZv8QVYbhXa/0knx6P
	P1eyPNHyZ2ujRUtZzYptUpBLjHcsL7YQdMyJ9um6vhlx5GwRu/27BbtNysisL3dxElV4j5
	Q8MSdcwIvT3WMuOOoqh8ZlUaifJTNIDhIOqvV9ck3mqfL/iunDLEVLJ6MOrSLmRzxR/4zY
	22XdyoJ8y4bTe+6MHFUOQgGCgq2KhePh2I+717oP9iTo6AuLyYlUSpeB3NVPGQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 31 Mar 2026 23:27:20 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>
Subject: RFC: phylink: disable PHY autonomous EEE when MAC manages LPI
Message-ID: <d86c53213a6328b701b8aabbde5d1c83@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273762-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:dkim,tipi-net.de:mid]
X-Rspamd-Queue-Id: 37CE3371FE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi

Some PHYs (e.g. Broadcom BCM54xx "AutogrEEEn") manage EEE LPI
autonomously without forwarding LPI signaling to the MAC. This works
fine when the MAC doesn't support EEE, but conflicts with MACs that
implement their own LPI control via phylink's mac_enable_tx_lpi /
mac_disable_tx_lpi.

When the MAC has lpi_capabilities set, the PHY should use Native EEE
mode so the MAC can control LPI entry/exit and observe RX LPI
transitions.

I'm thinking of a flag on phy_device (similar to mac_managed_pm) that
phylink sets when the MAC has lpi_capabilities, and that PHY drivers
check in config_init to disable their autonomous EEE mode:

   /* set by phylink when MAC manages LPI */
   phydev->mac_managed_lpi = true;

   /* in bcm54xx_config_init: */
   if (phydev->mac_managed_lpi)
       bcm_phy_modify_exp(phydev, MII_BUF_CNTL0,
                          AUTOGREEEN_EN, 0);

This came up while adding EEE support to the Cadence macb driver (used
on Raspberry Pi 5 with a BCM54210PE PHY). The PHY's AutogrEEEn mode
prevented the MAC from tracking LPI state. As a workaround, the
Raspberry Pi tree currently carries a downstream patch that
unconditionally disables AutogrEEEn for all BCM54xx PHYs, since both
genet and macb now support EEE properly. That's obviously not suitable
for upstream where other MACs paired with BCM54xx may not have LPI
support.

Does this seem like a reasonable approach, or is there a better way to
handle PHY autonomous EEE within phylink?

Thanks

Nicolai

