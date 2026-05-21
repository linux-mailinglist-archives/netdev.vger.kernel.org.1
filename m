Return-Path: <netdev+bounces-290332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBG5Ip7cDmrmCgYAu9opvQ
	(envelope-from <netdev+bounces-290332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:21:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A43F35A32DF
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86FD032C558F
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AEC387588;
	Thu, 21 May 2026 10:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZpIaWTgS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1386F388E69
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357656; cv=none; b=GmnP/1g1paBydcZkXtLn0m4WPJAL2Xu4bl9zw1LGKqsfYM/jYoK54ZYj1Qzq1GaS676HvGQLrgv6zG7iAP+4gzZIf0/Uzl57pUSon3qEDlQF3KUhGNPP1NELFMQ0Bva6kn5aGVhovSHUjrtvpbaDDHwfw7fjNR4MZbyV2+pTEOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357656; c=relaxed/simple;
	bh=jMgmvQXItn8wsRqMxol30CAmpsOY8S8dYYI0rvc5YEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8H4fRiDV0FCenLFsKFQ+T6dbaXbqyaRJc2/ZRxHkyII3gDkI0dRR02AbNEgemzShOen3Y/14RN9EDII+otUKrNOtz6hqCFCxvePxWF5u5pFiHPzLekLu/yc88nTa2dlqGUjZV+8TtWSGeerY9qqJfJU1FBS6Rduytw4e7CY8Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZpIaWTgS; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-8bb4e8a5240so76211286d6.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 03:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779357651; x=1779962451;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zK2VEeW+Skhe3CohG0HZeyAmU9ISRRMJjX/V8d4TZV8=;
        b=r5mN3Mni8/tLJSiSDJQQ87dJgerThXtTR7ydJHMTpXC+NsFU2RESqtVgmbKKA4bjjx
         PU1EWg39uMMX1mTb1aH4x2cDg6CDSbRkeufZvvf6OPvmqzPiI22UKOfvC8e8NQdRDW3F
         GFsLTNIB8ylxB2xIWzkTq/hWQ1Hz8pcl5e61Kw4SgB+djpPD0JfQK6DpJh5mVXDsVaq9
         wgwY4b849yB1iwKuFf4WSAk37vGOAy3lUbRC6qX4tLeEivN3AyAeL9s5iujQIZsw9vtZ
         OqDMnFU31aaYDQYEgXzTZsFs70zYwTSLQRPm9U+lmR2XUy46zhTWRR+fEq5kQLnyzb17
         wMcg==
X-Forwarded-Encrypted: i=1; AFNElJ/YXyfRDoeFJVlYnPMU5qmsMAC6FTs7AXcLz8t6fv3MlO8j44wgSkktb7sHAWXpmQSfY18l0S4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr/vohBaqFq3RMi+Jb8DxEjG0wmIflE4jRDlmbtBDz7Lj38EW7
	+wR6KgfVpu6F0R3Mdcx9A2UMKv8GGzbxhWcEOMfS4Sp0bCaqIyFK7hDovBdGJBCSKxVll5JED04
	1WLXV52Rzqzf0QA26AcKoaJuuJSX1yUhg6WvuQvzpLmwvfTdsLbnpFbEwEuX5dfh7dsFi8YPeSg
	tZAskYK+XsOzTHZq5r3qhMsoOrnvE3nmRBERpWIWf8veZ/mAD05YHtUBhyJ9BJKTw5vgaYBdtRl
	E3P7uVw79nZrw==
X-Gm-Gg: Acq92OGpVDf6VYx141/n9XCbccDE6hMoRZp5NSo2BLczZD7OzduqfKHy8487SoTv8Nu
	enyHO2DqYiLFNut0dmCx/Tj+Wc0pNw/X5ELG6cWVPLynj4MMtNQgTOvDad4ihNhHF2r9UUYxRe0
	lRXNdJipvMF0XjQVGxRqc+tY9O1r9KxPgKpvfjpdehqu3hgyXpLxXij7Eitx1Bw69+ggXkTU+CY
	05gFJlQql6SMuw3kAr44RUvNq0jE9M+geGnh1+XmAx6ltAc8ku4yBxeNav67Vf2dosD/Aa9se9R
	zlb3VamHCSiMDcXweJQEedmNNEZ+Ecn5ECaySyQDyzkKhMclGOUXo1v/wJ21+Gxf2A+AAoNbXh/
	YqmxGzfrkRU/9Ugxp8dcMLzSueT68dM2toYag05eyAWIkPwb6Ff/75EZ0Rc0UYd28sMUEVNJYBA
	DMmwVuNb/0pS+Pbi9peRInCXqnRuS8GbytCD9spE9LOpM8Ebv2ZT4k4a7SzCs=
X-Received: by 2002:a05:6214:3c8c:b0:89c:ac72:2f6e with SMTP id 6a1803df08f44-8cc6e47ca3amr34576956d6.43.1779357635947;
        Thu, 21 May 2026 03:00:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8cc768089afsm81616d6.0.2026.05.21.03.00.35
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2026 03:00:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c828f0f5c23so2837550a12.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 03:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779357635; x=1779962435; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zK2VEeW+Skhe3CohG0HZeyAmU9ISRRMJjX/V8d4TZV8=;
        b=ZpIaWTgS9OZMXtX3rU6gfYK2SROSsWUzdbPWFNAubG++XehzJbA3PzPaOFDFM/kTwh
         tkLxSb6Yo2dQoXMeOSr8kcCTEQRYCkOB0LaI9AVjK4nd6cPSxojHTzhKynHzyzm63ptW
         5DGbqqknmT7iYjTcmr+JYkhoE5bYqAmTxtk9Q=
X-Forwarded-Encrypted: i=1; AFNElJ88tjgIpRxjAnSje4WJdAn67EwT6EG9+qQvr4ckbf9e5o8UwA4mNABSWrnXNVHkKwSPrXLQldQ=@vger.kernel.org
X-Received: by 2002:a05:6a21:338d:b0:3a0:b781:4c80 with SMTP id adf61e73a8af0-3b308691010mr2699253637.4.1779357634463;
        Thu, 21 May 2026 03:00:34 -0700 (PDT)
X-Received: by 2002:a05:6a21:338d:b0:3a0:b781:4c80 with SMTP id
 adf61e73a8af0-3b308691010mr2699150637.4.1779357633733; Thu, 21 May 2026
 03:00:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <591b66a1-4b20-40d5-b454-9eecbabfc832@arista.com>
In-Reply-To: <591b66a1-4b20-40d5-b454-9eecbabfc832@arista.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Thu, 21 May 2026 15:30:21 +0530
X-Gm-Features: AVHnY4I_cxdFBxqTZsGHSBwWz3f9motOWRDJKdTziwTvS5VOIz00hCvY17d_BEg
Message-ID: <CALs4sv0FH102qY9QD-4n8zMZTtEpmS_EiS9+QxS9L6Pv2+y-ZQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: tg3: guard napi_disable and
 pci_disable_device calls
To: "Yury M." <yurypm@arista.com>
Cc: mchan@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c335bc065250fb73"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290332-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,broadcom.com:dkim]
X-Rspamd-Queue-Id: A43F35A32DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000c335bc065250fb73
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 10:05=E2=80=AFPM Yury M. <yurypm@arista.com> wrote:
>
> During PCIe hot-plug events, uncorrectable errors can be reported and
> AER recovery for the tg3 device is initiated by the AER kernel driver.
> The tg3_io_error_detected function is the AER error recovery handler.
>
>  From tg3_io_error_detected, we call tg3_netif_stop->tg3_napi_disable->
> napi_disable and return PCI_ERS_RESULT_NEED_RESET on non-fatal error.
> We expect that during AER recovery tg3_io_slot_reset and tg3_io_resume
> will be called. But AER error recovery can fail. For example, when one
> of PCIe devices on the same bus reports PCI_ERS_RESULT_NO_AER_DRIVER.
> As a result, tg3_io_slot_reset and tg3_io_resume are not called, PCIe
> device is disabled and NAPI is disabled (pci_disable_device and
> napi_disable are called from tg3_io_error_detected). Then we can try to
> disable PCIe link and napi_disable will be called again:
>
>    napi_disable+0x1b/0x1b0
>    tg3_napi_disable+0x89/0xa0 [tg3]
>    tg3_netif_stop+0x37/0xe3 [tg3]
>    tg3_stop+0x30/0x160 [tg3]
>    tg3_close+0x2a/0x60 [tg3]
>    __dev_close_many+0xad/0x130
>    dev_close_many+0xb2/0x190
>    unregister_netdevice_many_notify+0x19d/0xa00
>    unregister_netdevice_queue+0xf8/0x140
>    unregister_netdev+0x1c/0x30
>    tg3_remove_one+0xaa/0x150 [tg3]
>    pci_device_remove+0x42/0xb0
>    device_release_driver_internal+0x19c/0x200
>    pci_stop_bus_device+0x85/0xb0
>    pci_stop_bus_device+0x2c/0xb0
>    pci_stop_bus_device+0x2c/0xb0
>    pci_stop_and_remove_bus_device+0x12/0x20
>    pciehp_unconfigure_device+0x9f/0x160
>    pciehp_disable_slot+0x67/0x100
>    pciehp_handle_presence_or_link_change+0x77/0x350
>
> This is not expected by napi_disable and a thread can be locked in
> napi_disable forever. We have pcierr_recovery to cover a similar issue,
> but for fatal errors. We cannot reuse this flag because it is reset in
> tg3_io_resume, but it is not called when AER recovery fails.
>
> Similarly, if an AER error is reported and tg3_io_error_detected calls
> pci_disable_device, a subsequent device removal via tg3_remove_one or
> tg3_shutdown will call pci_disable_device again for the already-disabled
> device.
>
> Add a napi_enabled flag to struct tg3 to track whether napi_enable has
> been called. Guard tg3_napi_disable() against being called before
> tg3_napi_enable(), logging an error if that happens. Also guard
> pci_disable_device() calls in tg3_remove_one() and tg3_shutdown() with
> pci_is_enabled() to avoid disabling an already-disabled device.
>
> Fixes: b45aa2f6192e ("tg3: Add EEH support")
> Signed-off-by: Yury Murashka <yurypm@arista.com>
> ---

For some reason I cannot see this patch in the patchwork.

>   drivers/net/ethernet/broadcom/tg3.c | 19 +++++++++++++++++--
>   drivers/net/ethernet/broadcom/tg3.h |  1 +
>   2 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/tg3.c
> b/drivers/net/ethernet/broadcom/tg3.c
> index 73a4b569b..500b6f7fa 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -7396,8 +7396,18 @@ static void tg3_napi_disable(struct tg3 *tp)
>         int txq_idx =3D tp->txq_cnt - 1;
>         int rxq_idx =3D tp->rxq_cnt - 1;
>         struct tg3_napi *tnapi;
> +       struct net_device *netdev =3D tp->dev;

Should maintain reverse-xmas tree for declarations.
(Sorry I was focused more on the need for the patch than the actual
changes during v1. I could have given these comments then itself but
anyway here they are)

>         int i;
>   +     if (!tp->napi_enabled) {
> +               netdev_err(netdev, "%s() called when napi_enable wasn't c=
alled
> before, netif_running=3D%d, pci_enabled=3D%d\n",
> +                          __func__, netif_running(netdev),
> +                          pci_is_enabled(tp->pdev));

This trace looks more like a debug print. Can be removed.

> +               return;
> +       }
> +
> +       tp->napi_enabled =3D false;
> +
>         for (i =3D tp->irq_cnt - 1; i >=3D 0; i--) {
>                 tnapi =3D &tp->napi[i];
>                 if (tnapi->tx_buffers) {
> @@ -7420,6 +7430,8 @@ static void tg3_napi_enable(struct tg3 *tp)
>         struct tg3_napi *tnapi;
>         int i;

Leave a line. Please checkpatch.pl once before sending.

>   +     tp->napi_enabled =3D true;
> +
>         for (i =3D 0; i < tp->irq_cnt; i++) {
>                 tnapi =3D &tp->napi[i];
>                 napi_enable_locked(&tnapi->napi);
> @@ -17718,6 +17730,7 @@ static int tg3_init_one(struct pci_dev *pdev,
>         tp->tx_mode =3D TG3_DEF_TX_MODE;
>         tp->irq_sync =3D 1;
>         tp->pcierr_recovery =3D false;
> +       tp->napi_enabled =3D false;
>         if (tg3_debug > 0)
>                 tp->msg_enable =3D tg3_debug;
> @@ -18099,7 +18112,8 @@ static void tg3_remove_one(struct pci_dev *pdev)
>                 }
>                 free_netdev(dev);
>                 pci_release_regions(pdev);
> -               pci_disable_device(pdev);
> +               if (pci_is_enabled(pdev))
> +                       pci_disable_device(pdev);
>         }
>   }
>   @@ -18257,7 +18271,8 @@ static void tg3_shutdown(struct pci_dev *pdev)
>         rtnl_unlock();
>   -     pci_disable_device(pdev);
> +       if (pci_is_enabled(pdev))
> +               pci_disable_device(pdev);
>   }
>    /**
> diff --git a/drivers/net/ethernet/broadcom/tg3.h
> b/drivers/net/ethernet/broadcom/tg3.h
> index a9e7f88fa..34fb771e8 100644
> --- a/drivers/net/ethernet/broadcom/tg3.h
> +++ b/drivers/net/ethernet/broadcom/tg3.h
> @@ -3429,6 +3429,7 @@ struct tg3 {
>         struct device                   *hwmon_dev;
>         bool                            link_up;
>         bool                            pcierr_recovery;
> +       bool                            napi_enabled;
>         u32                             ape_hb;
>         unsigned long                   ape_hb_interval;
> --
> 2.51.0
>

--000000000000c335bc065250fb73
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
/HTPxpDrr4vzZL0yoc9XefyCbdiwfyFl99oBekp+1ZxXc5bZsVhRPVyEWFtCys66nqu5cU2GPT3a
ySQEHOtIKyGGgzMVvitOzO2suQkoMvu/swsftfgCY/PObdlBZhv0BD97+WwR6CQJh/YEuDDEHYCy
NDeiVtF3/jwT04bHB7lR9n+AiCSLr9wlgBHGdBFIOmT/XMX3K8fuMMGLq9PpGQEMvYa9QTkE9+zc
MddiNNh1xtCTG0+kC7KIttdXTnffisXKsX44B8ECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUxJ6fps/yOGneJRYDWUKPuLPk
miYwDQYJKoZIhvcNAQELBQADggIBAI2j2qBMKYV8SLK1ysjOOS54Lpm3geezjBYrWor/BAKGP7kT
QN61VWg3QlZqiX21KLNeBWzJH7r+zWiS8ykHApTnBlTjfNGF8ihZz7GkpBTa3xDW5rT/oLfyVQ5k
Wr2OZ268FfZPyAgHYnrfhmojupPS4c7bT9fQyep3P0sAm6TQxmhLDh/HcsloIn7w1QywGRyesbRw
CFkRbTnhhTS9Tz3pYs5kHbphHY5oF3HNdKgFPrfpF9ei6dL4LlwvQgNlRB6PhdUBL80CJ0UlY2Oz
jIAKPusiSluFH+NvwqsI8VuId34ug+B5VOM2dWXR/jY0as0Va5Fpjpn1G+jG2pzr1FQu2OHR5GAh
6Uw50Yh3H77mYK67fCzQVcHrl0qdOLSZVsz/T3qjRGjAZlIDyFRjewxLNunJl/TGtu1jk1ij7Uzh
PtF4nfZaVnWJowp/gE+Hr21BXA1nj+wBINHA0eufDHd/Y0/MLK+++i3gPTermGBIfadXUj8NGCGe
eIj4fd2b29HwMCvfX78QR4JQM9dkDoD1ZFClV17bxRPtxhwEU8DzzcGlLfKJhj8IxkLoww9hqNul
Md+LwA5kUTLPBBl9irP7Rn3jfftdK1MgrNyomyZUZSI1pisbv0Zn/ru3KD3QZLE17esvHAqCfXAZ
a2vE+o+ZbomB5XkihtQpb/DYrfjAMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDdsx0w
Hl48LpfMH2Y/ZlhrKfWm3Hgvyl8A5SnbTdpf1jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA1MjExMDAwMzRaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAX7+6EWh4DGsNdCHQfP7qIWZtfep6kmCXoMOWDxyzS
CimcpND20r8BJyQ98n2vO6VVzcrTI6RItFmztOLcgrRkPvnmshzxklpWm3HQ8prk1HjkxuVGqpvu
482V/DA9rBQM+I/yvdobkGMXyt2h9Yl4GC7nUo0HoY66Vj8lyYkon4VZO+fvZU+jYYaAeHN9ih2C
SLTTIlDWLi/87Wgn3Fp28VTp2gIQDUpii6aESQ4JG6UM2+yIJfqRgHlBWfLWCsxy7mUWQZiFWcil
HlB3RZwUjyRVwevOaeargUo8z+q8NMrSwacc7AT47durHUEgOiyqvOqns54jDMg80V7s0Wsf
--000000000000c335bc065250fb73--

