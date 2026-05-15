Return-Path: <netdev+bounces-288282-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ELPLt4EB2pNqwIAu9opvQ
	(envelope-from <netdev+bounces-288282-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 13:34:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C5054E8D4
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 13:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5FB3A318F07A
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2531C477E22;
	Fri, 15 May 2026 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="hlPx8Z8P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA66472794
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778842727; cv=pass; b=kSsdr7pbWKgvsozUorfD3OeFdEXwMGTbK9oNVTL6X+mKQkv1MrMSIMTby5XoHxar1iP2gfhjYbpXuJ2BqtO1TMj8FLtZr9lTC0eNoTMryATouYCOrPrKowxjcvFdVV5gDOjbnlt1vSh78JdrzNevAIGl41ssf2nqEHbzItPoc10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778842727; c=relaxed/simple;
	bh=AAbUjliyAApEpHTyBu3KhdiYUWKCsEyoXejhYgUSv/M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IwUzngc8L2sXrn5Pg81pQRyf4FA6OX9cLq1+1aozpkf80ApyHmislcgUXwYbYXDT8j88geRiN/slEsXacAsmKdOwDu8BU6z7RmS58an7Cm5Wm0On+0ztAu3oHcClLYRTE7gHkW2MGukk4bGDAQjebuQ8sKmPhRR261nVa0vEleA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=hlPx8Z8P; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a8e33556c0so956349e87.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 03:58:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778842723; cv=none;
        d=google.com; s=arc-20240605;
        b=e1E8sh1BlOIhZJcanV0N+8pczRzMNPRcciYNmN7mihE+sozcka6dk7mscxhV2zRUxv
         fdV13GVSyqTiiqif2yxM4aSvkr3sTgh3xQyllsAfrpq7Po/eYXYKkZ+pi3AbuMmN4/i8
         HQ6qnVtWaIMYksJfNmFru583bl+ysmD/+QGwPLIwCTevycmxqkuDskXJp/z1KSHux62B
         6lWA0vrkCwNnrtvIcRcECUJZr314By0e7hyUSDzaTEWPxlgWyKd6ef/42Rtq2YsSkqph
         huLt4r2c57W768wpMNxV9jVdxzxTt28c0WveLXiYtfUQLRjLl2Oq79+71hxEQ63X7WdH
         xtqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=AzDqfCr4N4AKnnxYYn6PoqjpxURuHA7u+KZ59qCQ7gI=;
        fh=CIq6smdSk5IBQ6UPRfXZYEoxMMGNuS0nZhjKdQfDYyY=;
        b=Sq4kTipeoMN/nquZ2A0J4iorrzCdMwixqtr8ikVqBAuVoxoQUOTyKU/dIO6nXS2Ycc
         gaE+GvFboT2U+YPNYtxoqkitAqzbB3Y2gvc2lfIjmnpbC3zCjq3Y9yyj18tF0syV1Jm8
         6ziQRIF8sOPS/j/SHHAdANPYvrLEDwN5wEuJFBKy0sd/lXI11GCVj4CREDaVpNRGSp8p
         lqM9Bd1j5PIhAh9uE+GeZMiBRxg/xv7ECZ0tbacdPKgBcPu2E/PEZVxMKcl3t5YEm19Z
         9eyhHk/jCM+unECsWXIp5W0bJLmM3bm9KpmRm1Mn8w6j0EaZyd75U04ShO0er+qlWrcL
         1Ulg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1778842723; x=1779447523; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AzDqfCr4N4AKnnxYYn6PoqjpxURuHA7u+KZ59qCQ7gI=;
        b=hlPx8Z8PFShiey6Unc6iEr7nubgvx9diIsraOCtkUeZ15ot/3YdhfHlb0oiAf+g2lI
         q+JJucomkqOyHUwDrHqGJ+lThIZ+el7QbwyCgisaloXrsMCgR2GpqUVPN/3mn7mkHVr4
         xOM9vY274xXc8U6zOEzB3/c/NosPmF77HIBrHRqW2g/hNmcD/hO4jaJTwRwyUdSlRSS2
         9yCBANWj0o8Q+H0I74UaxTpuu52FBby+ZtHamSbMNGTsksxx7e4S+eoUUauGEpD+kV4F
         ikIQs2uHdunW7e5CznsHR7Iqv/uwragkzMvYyxtuLQzfnsyjbtQudapJWpZ7084OYk3E
         q8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778842723; x=1779447523;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AzDqfCr4N4AKnnxYYn6PoqjpxURuHA7u+KZ59qCQ7gI=;
        b=oKdk+W95c81VEBZm4Fo4U6KeezgeiVe9s50yAayht+Az1jdmRLkDtmQUNniRxqwzof
         YKA7QP6vHIq7DWmkA2Cf6uPulQJx+Ybm5KtHsmAS4vFjfOXbRlvK67igkzVLE+k2+StK
         Wh0Dw9oQXOx0iWkwhrGISbRNVzrYH7IOCCM/MH7O+vL2NI5Cz4fbiX+8m19g4R4mU1VS
         aNc3PD9LPH9e4uxDU59G48/zky3FIBRYrxrrs8/JddZcrl4T9kwXHwtu1hF3Lr/jHz2Z
         03Jpp54lBKNacnkvKHFXvh/ZQ8s1dFYjY2TVMG/ditQAGMa+IirbHMu/iqx/+qwzlf54
         7ynw==
X-Forwarded-Encrypted: i=1; AFNElJ826K+aO1m5tt0weM1UdVnaNnprjEjVBidHHZZh63GUvvz2A1ZkU9zE5jXF4d5D90MPj84Gd68=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfBkyQ0vjsAoOLrgsmevlVus9aWAADPqOokBYOGdAngllxqLPN
	QjdUamadqLDKMBNVqH/fRWk8sn+d4CRrPhzVfgO9BU3mmL0DNV4os8W5+0E77AxpDrWfYVNlcBJ
	/zhgvdujLMoWdXVKVnCuKztaa+0gYV3bBVdsQWs7Z
X-Gm-Gg: Acq92OE0VkuWamHlyiUuD6ZuMTz36yKcEVNv6E8ZIlYssqaPDnsrnWblNNqjeL0ZuxC
	Kjv1Amdk28qgp4rKtJiXlCQy7lheK5E+SW7mecUS7ynZx6G99mFkSvy8kz2E83zae2+EwtlRyWn
	ZohyCr2K7ZzvE6Rtx4D4unpifhOWjYI65jGdVujmOi53PibaTkLFN7X4tirt5a8VCPsH+wsU4ad
	oelETiuKpzrWDMrDxjshHF9Y3FEW7c8QOPG/vmu0FiGXogdFAxAo3WZyPjzpRq+HziIp5i6CZNT
	j2RhWjcY
X-Received: by 2002:a05:6512:1301:b0:5a8:6f3f:488b with SMTP id
 2adb3069b0e04-5aa0de739b4mr1041985e87.3.1778842723193; Fri, 15 May 2026
 03:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yury Murashka <yurypm@arista.com>
Date: Fri, 15 May 2026 11:58:30 +0100
X-Gm-Features: AVHnY4L8iv7vaR2dfYqxJinabkOD4edHpu2nHTXkEJql9zdlch9HlGI-Kelz3lI
Message-ID: <CAPzpGcTtw+ou+8jid_qE9w96UWt+4KUZXN-aC=44Oqkk=qdERg@mail.gmail.com>
Subject: [PATCH] tg3: guard napi_disable and pci_disable_device calls
To: pavan.chebbi@broadcom.com, mchan@broadcom.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	Yury Murashka <yurypm@arista.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C5C5054E8D4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[arista.com,reject];
	R_DKIM_ALLOW(-0.20)[arista.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288282-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arista.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yurypm@arista.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,arista.com:email,arista.com:dkim,mail.gmail.com:mid]
X-Rspamd-Action: no action

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
been called. Guard tg3_napi_disable() against being called before
tg3_napi_enable(), logging an error if that happens. Also guard
pci_disable_device() calls in tg3_remove_one() and tg3_shutdown() with
pci_is_enabled() to avoid disabling an already-disabled device.

Signed-off-by: Yury Murashka <yurypm@arista.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 19 +++++++++++++++++--
 drivers/net/ethernet/broadcom/tg3.h |  1 +
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c
b/drivers/net/ethernet/broadcom/tg3.c
index 73a4b569b..500b6f7fa 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -7396,8 +7396,18 @@ static void tg3_napi_disable(struct tg3 *tp)
        int txq_idx = tp->txq_cnt - 1;
        int rxq_idx = tp->rxq_cnt - 1;
        struct tg3_napi *tnapi;
+       struct net_device *netdev = tp->dev;
        int i;

+       if (!tp->napi_enabled) {
+               netdev_err(netdev, "%s() called when napi_enable
wasn't called before, netif_running=%d, pci_enabled=%d\n",
+                          __func__, netif_running(netdev),
+                          pci_is_enabled(tp->pdev));
+               return;
+       }
+
+       tp->napi_enabled = false;
+
        for (i = tp->irq_cnt - 1; i >= 0; i--) {
                tnapi = &tp->napi[i];
                if (tnapi->tx_buffers) {
@@ -7420,6 +7430,8 @@ static void tg3_napi_enable(struct tg3 *tp)
        struct tg3_napi *tnapi;
        int i;

+       tp->napi_enabled = true;
+
        for (i = 0; i < tp->irq_cnt; i++) {
                tnapi = &tp->napi[i];
                napi_enable_locked(&tnapi->napi);
@@ -17718,6 +17730,7 @@ static int tg3_init_one(struct pci_dev *pdev,
        tp->tx_mode = TG3_DEF_TX_MODE;
        tp->irq_sync = 1;
        tp->pcierr_recovery = false;
+       tp->napi_enabled = false;

        if (tg3_debug > 0)
                tp->msg_enable = tg3_debug;
@@ -18099,7 +18112,8 @@ static void tg3_remove_one(struct pci_dev *pdev)
                }
                free_netdev(dev);
                pci_release_regions(pdev);
-               pci_disable_device(pdev);
+               if (pci_is_enabled(pdev))
+                       pci_disable_device(pdev);
        }
 }

@@ -18257,7 +18271,8 @@ static void tg3_shutdown(struct pci_dev *pdev)

        rtnl_unlock();

-       pci_disable_device(pdev);
+       if (pci_is_enabled(pdev))
+               pci_disable_device(pdev);
 }

 /**
diff --git a/drivers/net/ethernet/broadcom/tg3.h
b/drivers/net/ethernet/broadcom/tg3.h
index a9e7f88fa..34fb771e8 100644
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

