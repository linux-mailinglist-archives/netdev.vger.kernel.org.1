Return-Path: <netdev+bounces-291272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iE3RIUAbFGoGJwcAu9opvQ
	(envelope-from <netdev+bounces-291272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:49:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A19A85C8CC0
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E07C300CC26
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 09:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101FF35DA46;
	Mon, 25 May 2026 09:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="jHzoAyVU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C314E23E325
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 09:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779702559; cv=pass; b=LBxATci9bDdJEyi0dIJkZZdZqzuEEAl/i2p81D56ytcSD/7hKKHPkcwdvcw/YH8i7ogMgVFADU+KYS04UphETmbIU8v2DP6tXws8dwUlUgZfYwxsVW9lQnuesrQBhOH2GABJxSAv+/FQg42ho94aXdg/JwVGTVOklduu94cevlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779702559; c=relaxed/simple;
	bh=XUYsPYuEtgcbNqgabP8/NI595Lceo+HjypqozXcp/p0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=QyMT5L4qpva37WTuaymTJ6jCFrt7criga6POc97c8YQxWzFBwSjLCAvDV6jifgE18HVhOCsb+pcrPErYkkhouE+yFfw9VOigjdsymtvFdxMyM1Y0pzdNvTmDkKRwIGQ3tro1yvrsNtgF/TKaKMysVASW5H0M/EyP8qDIaxWE7jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=jHzoAyVU; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a8d1f43432so15130361e87.3
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 02:49:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779702556; cv=none;
        d=google.com; s=arc-20240605;
        b=juyT37X1H0pI7RX6iHMs+vsmUXOb+9cFUQxrFJa+nqruYxT1eG0bHzL6fptlM4LV4A
         NiG+BzLO4g4/25gAvkCNBe7dBrs+X3jWbtUe37uTljpWdRs7GAhJRDh/5esvEW0wD+G+
         5kmZnC4nKoRuctsOUloUOAW84AGV8pZRcchpXKrPJRYIZzEQTLGNZFkslOeTviw20ovq
         cljyVtC1ebEzGQDU+Das5Y+hu1gxTeIXfGyd0YJC8jx4NwTi/98QfSPsEwMfwyz/gIEq
         CeMUaE6H830//XXJFUzhqMJJDA6rPosMuBICnrQ1lcIxUXNwqoGHsAzgstL2Gv3i2H2M
         ZkXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=nl8gjzSMcK0ncvKIf7FJKv8fpIW2nt2TDnnsKu3pg48=;
        fh=/tZktQn8i3H6mcaZDr4D7jEHjFc/nMTSgdn0ZaycBCw=;
        b=hMolWAFI5zwhSuS7JL1i/sRaHkWFhhRheFi8YcRiCytEWt4FjadTGAPexPukiaXDrb
         m3IeBxJlZyZiZs5eLCKhn0gnU4BgkanyIlHQLl3PcuATpDUwYlPHZtIeBJK8QsE2X8Is
         S0MYVd8cZxHk8Uc7/oyIld8Rnb1PZpOCChigrscgyQWNEjAicomzWGRccAxQFhZvuD4k
         4o4FioQeeLzrBs7IvuRA7CW4ZxD6psD25oGOYIWPxRo68wGxAFM9Wzs+GTsew3FFnM9p
         4EnrgkI1SA8plAuICtLuxYsQSCR5vjsroyjvhSmZI8mwd/Ju7iLG3LD5oM0NkWKD1Mjn
         PipQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1779702556; x=1780307356; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nl8gjzSMcK0ncvKIf7FJKv8fpIW2nt2TDnnsKu3pg48=;
        b=jHzoAyVUBYobk1RljF/k93ekiZJBPK13yy1ObCNMW/M8M/89FF3P0HJzR032VelIVC
         JVSoLJA1tMMWDAqDpPP7ZnShrmHA37oEzWnrXvkts92Go28cZ4zHJZlUbafa/HYG3pCl
         MVpP8soj+PDNNvTrY53yi68Nql9QaQ9bMXYqt/ScICHZjlQgTXSj7geS+lyXu51u9yK8
         DDFZPC/nTwxPf41WCUvbcsNkYYEeLDu+F/aBq492aX2jEQ88+CcPf5S43DFsypLzWaZN
         s9RfWSGk7D5XelyaFO3hdtCUz66fCsoptOG8pNeJXUexmkmiy6O/eeOU3oROM6rRyFL6
         Ozkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779702556; x=1780307356;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nl8gjzSMcK0ncvKIf7FJKv8fpIW2nt2TDnnsKu3pg48=;
        b=db3gSnN7uzxreuiySrP/58y0DUdJO6ucADKLD3UoqALNCs0g8Uji9wL5Z3tGWxU9tp
         Tr290BxGFS786cCpc+vWM9qza1Upgp0ksA9qa78mhGPd8Tsi1ga9LgKjWnSldYJVFYVs
         OMomf0c/Ez6/KLxC1I4aAIwctnCJJ6LaZAEfXwt/8LxsO24RVuy3UFxM/CePrQcL1Asb
         3dUBUKCrlYbueaoDgy+/d0NR1dkRZxtifUGtNSXmbDzTxl7tDIYX0zBuKNSvy9L6JJmr
         DOBtp8gRat4glfDasksEMT6AognoqHnE4NN4n8jCuHIwXlIeh5Udnl085hPrjKH+v+yJ
         HqZA==
X-Forwarded-Encrypted: i=1; AFNElJ/eAdEZJ+g7USBnSTWBAuFA1htA3Wi6Mjt2DNGuKjROIzwPdEXlPgSSexW/2r1uNTJEISxlw7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlPFOgpyePTL7BSNcLk69OdL6g4+i0jwRToGB8quD6hcM1cIQf
	3bJ/MWkFb8EK0dIB+QWgEwpWEHK98kEvEg/KcS3NbCFifodsEMgeOmkhsSWnrG2b3OyEWJD0uhu
	KcEV1v7VQt6+vt49ODJjrO3jG/AJu8f0jak655prc
X-Gm-Gg: Acq92OEKZ/H+4lnUQrCc/a1QfsoOvaFhLtzOr8+mUYAZracMJyjdcqOapApCwYggDW3
	QZGIZp7c6/osKOM+gXQ36yVZnxTjLh3IVSsM75FSBR65a0BiacXvz2Ig2yYBobuYo5DoImG1sgD
	SILQ/0jGYmeBeFkbcLcSqe3WXk/WuMwmBxjsiVwIrFmViVMKHSgQKaeMayE0fZhLwzCvVImyxDJ
	TK1uJrZm66F2ppIiT22AIOmp14Sw3yKf4qmS8NVcYd0f0vRYQZJPwlL4dKqoMVxvP6g6DZqKiTd
	qsahkF5Dwqtt5elVBq0=
X-Received: by 2002:a05:6512:31c2:b0:5a2:874e:8a1e with SMTP id
 2adb3069b0e04-5aa323c56bbmr4180563e87.26.1779702555841; Mon, 25 May 2026
 02:49:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yury Murashka <yurypm@arista.com>
Date: Mon, 25 May 2026 10:49:03 +0100
X-Gm-Features: AVHnY4LCnuGEfwsBlq12wIIY9QZ6Ty1mVihVrqXdNhUZ5XhMZEDCZAaCV64FzkA
Message-ID: <CAPzpGcTMARhkcdt46bV=nWWx+AD5dX2ztWCEEx_4y2V=D-1THg@mail.gmail.com>
Subject: [PATCH net v3] net: tg3: guard napi_disable and pci_disable_device calls
To: Pavan Chebbi <pavan.chebbi@broadcom.com>, mchan@broadcom.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yury Murashka <yurypm@arista.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[arista.com,reject];
	R_DKIM_ALLOW(-0.20)[arista.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291272-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arista.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yurypm@arista.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A19A85C8CC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

During PCIe hot-plug events, uncorrectable errors can be reported and
AER recovery for the tg3 device is initiated by the AER kernel driver.
The tg3_io_error_detected function is the AER error recovery handler.

From tg3_io_error_detected, we call tg3_netif_stop->tg3_napi_disable->
napi_disable and return PCI_ERS_RESULT_NEED_RESET on non-fatal error.
We expect that during AER recovery tg3_io_slot_reset and tg3_io_resume
will be called. But AER error recovery can fail. For example, when one
of PCIe devices on the same bus reports PCI_ERS_RESULT_NO_AER_DRIVER.
As a result, tg3_io_slot_reset and tg3_io_resume are not called, PCIe
device is disabled and NAPI is disabled (pci_disable_device and
napi_disable are called from tg3_io_error_detected). Then we can try to
disable PCIe link and napi_disable will be called again:

  napi_disable+0x1b/0x1b0
  tg3_napi_disable+0x89/0xa0 [tg3]
  tg3_netif_stop+0x37/0xe3 [tg3]
  tg3_stop+0x30/0x160 [tg3]
  tg3_close+0x2a/0x60 [tg3]
  __dev_close_many+0xad/0x130
  dev_close_many+0xb2/0x190
  unregister_netdevice_many_notify+0x19d/0xa00
  unregister_netdevice_queue+0xf8/0x140
  unregister_netdev+0x1c/0x30
  tg3_remove_one+0xaa/0x150 [tg3]
  pci_device_remove+0x42/0xb0
  device_release_driver_internal+0x19c/0x200
  pci_stop_bus_device+0x85/0xb0
  pci_stop_bus_device+0x2c/0xb0
  pci_stop_bus_device+0x2c/0xb0
  pci_stop_and_remove_bus_device+0x12/0x20
  pciehp_unconfigure_device+0x9f/0x160
  pciehp_disable_slot+0x67/0x100
  pciehp_handle_presence_or_link_change+0x77/0x350

This is not expected by napi_disable and a thread can be locked in
napi_disable forever. We have pcierr_recovery to cover a similar issue,
but for fatal errors. We cannot reuse this flag because it is reset in
tg3_io_resume, but it is not called when AER recovery fails.

Similarly, if an AER error is reported and tg3_io_error_detected calls
pci_disable_device, a subsequent device removal via tg3_remove_one or
tg3_shutdown will call pci_disable_device again for the already-disabled
device.

Add a napi_enabled flag to struct tg3 to track whether napi_enable has
been called. Guard tg3_napi_disable() so it returns early if NAPI was
not previously enabled. Also guard pci_disable_device() calls in
tg3_remove_one() and tg3_shutdown() with pci_is_enabled() to avoid
disabling an already-disabled device.

Fixes: b45aa2f6192e ("tg3: Add EEH support")
Signed-off-by: Yury Murashka <yurypm@arista.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 14 ++++++++++++--
 drivers/net/ethernet/broadcom/tg3.h |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c
b/drivers/net/ethernet/broadcom/tg3.c
index 73a4b569b03e..86995e689519 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -7398,6 +7398,11 @@ static void tg3_napi_disable(struct tg3 *tp)
        struct tg3_napi *tnapi;
        int i;

+       if (!tp->napi_enabled)
+               return;
+
+       tp->napi_enabled = false;
+
        for (i = tp->irq_cnt - 1; i >= 0; i--) {
                tnapi = &tp->napi[i];
                if (tnapi->tx_buffers) {
@@ -7420,6 +7425,8 @@ static void tg3_napi_enable(struct tg3 *tp)
        struct tg3_napi *tnapi;
        int i;

+       tp->napi_enabled = true;
+
        for (i = 0; i < tp->irq_cnt; i++) {
                tnapi = &tp->napi[i];
                napi_enable_locked(&tnapi->napi);
@@ -17718,6 +17725,7 @@ static int tg3_init_one(struct pci_dev *pdev,
        tp->tx_mode = TG3_DEF_TX_MODE;
        tp->irq_sync = 1;
        tp->pcierr_recovery = false;
+       tp->napi_enabled = false;

        if (tg3_debug > 0)
                tp->msg_enable = tg3_debug;
@@ -18099,7 +18107,8 @@ static void tg3_remove_one(struct pci_dev *pdev)
                }
                free_netdev(dev);
                pci_release_regions(pdev);
-               pci_disable_device(pdev);
+               if (pci_is_enabled(pdev))
+                       pci_disable_device(pdev);
        }
 }

@@ -18257,7 +18266,8 @@ static void tg3_shutdown(struct pci_dev *pdev)

        rtnl_unlock();

-       pci_disable_device(pdev);
+       if (pci_is_enabled(pdev))
+               pci_disable_device(pdev);
 }

 /**
diff --git a/drivers/net/ethernet/broadcom/tg3.h
b/drivers/net/ethernet/broadcom/tg3.h
index a9e7f88fa26d..34fb771e8a86 100644
--- a/drivers/net/ethernet/broadcom/tg3.h
+++ b/drivers/net/ethernet/broadcom/tg3.h
@@ -3429,6 +3429,7 @@ struct tg3 {
        struct device                   *hwmon_dev;
        bool                            link_up;
        bool                            pcierr_recovery;
+       bool                            napi_enabled;

        u32                             ape_hb;
        unsigned long                   ape_hb_interval;
--
2.51.0

