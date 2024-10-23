Return-Path: <netdev+bounces-138135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0C39AC171
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 10:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C112CB227FB
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 08:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF34158D87;
	Wed, 23 Oct 2024 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="VV0LO198"
X-Original-To: netdev@vger.kernel.org
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net [178.154.239.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4905C487BE
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 08:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671891; cv=none; b=rQB0vJSJbtOWZwcjGv3eYbD1iHbkdD3mWtZShY7c6zH/MudWR2PV0qrQH/DFa/nTMd+yDC7QezqxaBpx/q9ShmaN62eTRZwoe/FvjiKzfASb8etO5cDC/jO/Ff3BWHNXxiDWiUFkkvCDTVgGN1TjHSd7tyhLj8+AACDzSSORl5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671891; c=relaxed/simple;
	bh=eQvFEoxoprbAR1mw+V5fFlL2XFa0vBgG14fS/7BFopY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=aNGRSvG1mYDQ/R4OFVXodu14/eF6rUU3980MMPPrArBq01Qwl+JPzR8rAlyEHLU6L7NsIDp2iaiQEyj8WY1GAzrIjK9WvVSUF5HDWM1dT8b8Uw062RShhNPf3IwelR5szVL5f+GgOoZEiIayONiOshvYHRyFRmv+bqrj/A/VyAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=VV0LO198; arc=none smtp.client-ip=178.154.239.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-39.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:96c7:0:640:6549:0])
	by forward501d.mail.yandex.net (Yandex) with ESMTPS id C37AA61263;
	Wed, 23 Oct 2024 11:18:14 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id BIOTSP7oISw0-3awu1jnT;
	Wed, 23 Oct 2024 11:18:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1729671494; bh=9Rab33vo+0+GxIxz7NyxCnVeZihF9agVXxx9izSyxlY=;
	h=In-Reply-To:To:From:Cc:Date:References:Subject:Message-ID;
	b=VV0LO198OOCnE71EuwCSt8L0SO73OmULZxegM5Jy2C3gaY/XIhZ7CbimiNzDL1obd
	 2aTfxdXav8zetnxVmgpEJHbyqQVdgS9wEgzSsORKAdkyltRqXFLFSZ7e2HNlbUH8KD
	 o+2hIrlvoFvAfvMRk5x5u9sHPDk+0eQEWPY8jCvU=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <c91441ec-11d3-4580-b51d-8b1bbdb58172@yandex.ru>
Date: Wed, 23 Oct 2024 11:18:10 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RTNL: assertion failed at net/core/dev.c
To: Joe Damato <jdamato@fastly.com>, Simon Horman <horms@kernel.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
References: <8cf62307-1965-46a0-a411-ff0080090ff9@yandex.ru>
 <ZxgDaBPGQrwEo0RR@LQ3V64L9R2>
Content-Language: en-US
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Dmitry Antipov <dmantipov@yandex.ru>
Autocrypt: addr=dmantipov@yandex.ru; keydata=
 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
 A/UwwXBRuvydGV0=
In-Reply-To: <ZxgDaBPGQrwEo0RR@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/24 10:56 PM, Joe Damato wrote:

> Intends to fix the bug you hit. If you do test this patch and it
> works for you, please let me know.

Well, the following patch (over net-next at least) fixes the reboot issue for me:

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 4de9b156b2be..1cae92f136e5 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -3509,7 +3509,9 @@ static void e1000_reset_task(struct work_struct *work)
  		container_of(work, struct e1000_adapter, reset_task);

  	e_err(drv, "Reset adapter\n");
+	rtnl_lock();
  	e1000_reinit_locked(adapter);
+	rtnl_unlock();
  }

  /**
@@ -5074,7 +5076,9 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool *enable_wake)
  			usleep_range(10000, 20000);

  		WARN_ON(test_bit(__E1000_RESETTING, &adapter->flags));
+		rtnl_lock();
  		e1000_down(adapter);
+		rtnl_unlock();
  	}

  	status = er32(STATUS);
@@ -5240,8 +5244,11 @@ static pci_ers_result_t e1000_io_error_detected(struct pci_dev *pdev,
  	if (state == pci_channel_io_perm_failure)
  		return PCI_ERS_RESULT_DISCONNECT;

-	if (netif_running(netdev))
+	if (netif_running(netdev)) {
+		rtnl_lock();
  		e1000_down(adapter);
+		rtnl_unlock();
+	}

  	if (!test_and_set_bit(__E1000_DISABLED, &adapter->flags))
  		pci_disable_device(pdev);

OTOH I would refrain from Tested-by: just because I'm running an emulated environment
generated by syzbot, and this thing is definitely better to be tested by more people
with real e1000 hardware.

Thanks,
Dmitry

