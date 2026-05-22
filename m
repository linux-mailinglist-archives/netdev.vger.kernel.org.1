Return-Path: <netdev+bounces-290860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IJLOS1tEGqgXAYAu9opvQ
	(envelope-from <netdev+bounces-290860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:50:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CF85B677C
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6E0131AEAA7
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 14:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D4947D92D;
	Fri, 22 May 2026 14:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geTgqib3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AB0451044
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 14:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459967; cv=none; b=Bi/u+spj6npufTTyODlUo5ss5ePqvvfxNLpQokEcuVcGXIdd293lrU8OqfSX9PS4FedIpUg8X550bXacHUrg8XWbniMmJdYp+dKO9Hml740s3tkGDAs/jvCVokHIevdpgiQBZCHOaYmOqHrsOmEPAQnQ5OrfZfymOSA77B/9qvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459967; c=relaxed/simple;
	bh=4pCNnTeqyzf6VEl2hNsKTbPGOcUh3+iSlo4UZVG5I34=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=T+Pg6Mbc3AP+/8HLDpy78JpeD32PoYwaaEUzYiyRM/1uLbC7SgdYx5ec5xQdz5ZWoC/qRIOhr3hQEvV/6TZEiQJqgLdshlOGkEMLZ+49rVOFRbwvqBBUXNcLfHDJYjvjToKmHoY7m1yTvWRFPXmGBsekdlevtkZy32NRB7a8SdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geTgqib3; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa2691db86so5517083e87.3
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 07:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779459964; x=1780064764; darn=vger.kernel.org;
        h=mime-version:references:subject:cc:to:from:date:user-agent
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MpQaY3we4xrhiPbOjmoJPTIny3UGycHksSQkshrzJus=;
        b=geTgqib3rQF8cnANmvbSzleLZ+Y0tOl+6aQbHDhmPbiO6YlqEtybjvErhCIBBfEt0K
         5KrzrhTCH4il5gfRCdZjugvUDligLxCDumvAlvy5Lny1aezhN1kNK+HIdI8qbO+v66+q
         Klmo0/+PfKsAAZt+gaj72mj9Xwbk5crFcfpSA/3ydb/rcPHIk30RUrQTxJYiq0dGzytD
         npBOS/3Cpq70NAtEsQsvtpcXwUNgKWCWujuCw6wJP2twtmdgHlFAVV95aO8cZ/NWIRpr
         a3BhJztc0y+DWDWS1QT1G+kWfqlTMWfoJ3GK0BJ1RJmx5uj0oAY9959UFz7CPW716BKN
         aGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779459964; x=1780064764;
        h=mime-version:references:subject:cc:to:from:date:user-agent
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpQaY3we4xrhiPbOjmoJPTIny3UGycHksSQkshrzJus=;
        b=mHJbKyKE7E+FU0xKoBxtDZKomHlK1dCJqJzIyeCWxbFcrsbTHnKX9c4mxzRMmtmetW
         CEbEh7POecrJDY8xSXJ3O3/rlFWIigKPuXhIme48K/QX0Z82Y8vMUnwGlqo8VgP0nS6U
         v5qDZOoC8p/NP579efK068gX9zNcwLgEoUnUSnZTMHxXz/XBFLyTuPBLQk8cQWzSKRZ+
         IZmiyrVY2NssL9KGKTXFBGkWvb8Tcobskr73IoqmZck1M8hl/3SxwVARPn9lFKRVgBY8
         BPA6T9dY7wUjglNRFlj5JhZFN0mK2HtOXjy4R9D1ZVrfqhoP+3RjpX4tgDmZZbW0v+fr
         I9SA==
X-Forwarded-Encrypted: i=1; AFNElJ/8WAqZEVyaCPlR0pI4QI/gEZhFXYsjaKDAUCzI6j0xmITIdFl+AsTQybGYv9cCCRJZnIF2PaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Sq1rUD39szomn/nCtFRQzi5DYmxWokT/6XQNvCMXAUxpO5Q8
	/XBW0pnm3TUSBpBJkDKUXjXzmbLuSDyqJfpuMHzX+SalFjx06lbsEv9X9hj3sg==
X-Gm-Gg: Acq92OHCqhDZlqANdXYnFPkPeL+K/i3/oWNXHStIc3DEX4xG423itT4eTSw4TJnCpWX
	OY25X1UPnvk6iOhKvbr4EC5tSlNt9eLjQwOnfavPx6qMVJtj5BA+WRy22CFU43LU2gPCz0VRTLS
	QkwTnBm0dx2eo26300iu4j+KLW1H9FEpZUHJiteJz4Xt/I2kgfiIAEShEqLH7j3CAoUARBStQvO
	COpa1h6QmWVcSqPunuEworrD3iYM0lfX3BKWRTihIPL7eRHRZGDUCNoOVMu+f2HOhNVt6EFJK/f
	5ffF7vdK8BZATetr8lFEOtT3eGz3JU17qPKbSXnxInRgUpCP1jZnClZM8w+LTRhiizpTvCOLLdj
	f3dr57UzM2HwhkPXMlbaf9l06iUBjxsvXmajSFtYGqGiMyoxTzYx6KIgIAu6usP6Y3sQTIkr2wk
	cVqIPH75WoaXOqiNk0GwFn/TCO
X-Received: by 2002:a05:6512:3b8a:b0:5a3:eb4b:37a7 with SMTP id 2adb3069b0e04-5aa3235d1abmr1336671e87.6.1779459964034;
        Fri, 22 May 2026 07:26:04 -0700 (PDT)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa32ceb267sm445082e87.51.2026.05.22.07.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 07:26:03 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 573E05A0048; Fri, 22 May 2026 17:25:17 +0300 (MSK)
Message-ID: <20260522142517.550660367@gmail.com>
User-Agent: quilt/0.69
Date: Fri, 22 May 2026 17:22:41 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
 anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com,
 Cyrill Gorcunov <gorcunov@gmail.com>
Subject: [patch 2/2] ice: Fix wrong dsn read in ice_adapter_put
References: <20260522142239.628965142@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-290860-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gorcunov@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 49CF85B677C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When registering an adapter instance, we read the PCI configuration
space to fetch the DSN and generate an adapter index for lookups.

However, if the adapter has been physically unplugged, the PCI space
is no longer accessible. Reading it returns a zero value, which results
in either an incorrect adapter instance being put or the proper instance
not being put at all. To fix this, we will use the previously known
index instead.

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---
 drivers/net/ethernet/intel/ice/ice_adapter.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

Index: linux-tip.git/drivers/net/ethernet/intel/ice/ice_adapter.c
===================================================================
--- linux-tip.git.orig/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ linux-tip.git/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -40,10 +40,8 @@ static u64 ice_adapter_index(struct pci_
 	}
 }
 
-static unsigned long ice_adapter_xa_index(struct pci_dev *pdev)
+static unsigned long xa_index_mangle(u64 index)
 {
-	u64 index = ice_adapter_index(pdev);
-
 #if BITS_PER_LONG == 64
 	return index;
 #else
@@ -51,6 +49,11 @@ static unsigned long ice_adapter_xa_inde
 #endif
 }
 
+static unsigned long ice_adapter_xa_index(struct pci_dev *pdev)
+{
+	return xa_index_mangle(ice_adapter_index(pdev));
+}
+
 static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
 {
 	struct ice_adapter *adapter;
@@ -130,13 +133,17 @@ struct ice_adapter *ice_adapter_get(stru
  */
 void ice_adapter_put(struct pci_dev *pdev)
 {
+	const struct ice_pf *pf = pci_get_drvdata(pdev);
 	struct ice_adapter *adapter;
 	unsigned long index;
 
-	index = ice_adapter_xa_index(pdev);
+	if (WARN_ON(!pf->adapter))
+		return;
+
 	scoped_guard(mutex, &ice_adapters_mutex) {
+		index = xa_index_mangle(pf->adapter->index);
 		adapter = xa_load(&ice_adapters, index);
-		if (WARN_ON(!adapter))
+		if (WARN_ON(!adapter || adapter != pf->adapter))
 			return;
 		if (!refcount_dec_and_test(&adapter->refcount))
 			return;


