Return-Path: <netdev+bounces-291596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBYsEcxiFWo9UwcAu9opvQ
	(envelope-from <netdev+bounces-291596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:07:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B71FC5D2F9E
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0B693164E1C
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CD13D1CAF;
	Tue, 26 May 2026 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Mxc9qFap"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5176F3D1CC0
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 08:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779785907; cv=none; b=eag0dKdv58w8tOFfhQAkQFjUmrhbtAZ/J5SPGCogW1xPOKBaUiEczzJVyGd/HNLFHJ25LZm7qQnHF2mglPvP5hUgZD8TWB9CWrKhgLldF3VqHqRYXdYyB5mIQ8O1QbtdYSprCgr5V0d8krLmtJtEdVylEMvSwGGJLHEDGW+5IjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779785907; c=relaxed/simple;
	bh=DQFgSpPgAFcOHXNaxmi7sBNaKa6mQZdlpdUGvF+EE68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZrdpCwoou4zv0067jfIbKKn5QZF5eba+8I9lQygIDr48XwqI6946IhZiIA4v3v7G1JX0oWkdMmzeV190318WSLd4a4/wplcZodsf1xyHmhha9wMbtNjo0izPQFntvXDjrTrjbw86DMKqEAnSKfeFdS2/s1k1RWA+rQ4BqPyReA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Mxc9qFap; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2b4650d5f5cso42886675ad.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 01:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779785900; x=1780390700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oC0RkVqgpHR5pJcgP4v2NyxyVrKJ8POMcc0DCFeSbJ4=;
        b=go/D0vKaonJnAhwA+37jJIFqLfmrfXdhgn+x8+z+fqs7+aCTuvqI5dL5UkRYEN/XvD
         kAIS0+dAofxzrs4+bbxGWKI5KKdFCRUtMeIoiQNV16c1GRFmO4UtZxFV2L8hDsBrMamw
         Itn4pCVocT6gLVvMW/VmCKNXG3NtZl0ZHrpKEaau059MndbletOCazQ7u74rdqifOEWe
         DQgFhWvi8S3HuszcrgXNeXe93DbUbEkgrUc4ihVFFeX24M9fL71J9XdJw/A3tOJDptRx
         EyTE8d/6PrG5BDkwZhYo+cepq8PagojWxXNq0QzS93NjTnvP1QfLa9V/1AEVBVxcmxXN
         tk9A==
X-Forwarded-Encrypted: i=1; AFNElJ8EyNYgeRm+e7iy/HSo17TX54Cwx5Vb/RfDtfQR5Y0oDRudSsovGg/6P6NkMZ3XS5ljUa0eFI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp9sKiv9hCt7EFYZ6LB/MpCRvPcUGBt204RXlM19zQr5VIWB6x
	AgNZhENp2/7Q3A4EarqL2nHmGLQ/ShvynmC613a1ll2hfi3ZA4yX2G9VJDFZjEMVThu6rFR81rY
	Mw6zNl2MEoZpiL3gcxzgbSeKnZFSHU8A4T6uaHi8a3mpk6Ml0/ZxGwMkqTkh4B8+WOT4rOkP0U7
	bnUHO2Cbr5Y9SSruGR9A5EkEZKfJe94KsAMDAMX3SkOH3Yw0UE1EGBPMBngxc5JQW/kT2HNEJn/
	PK1dDmPvOxlPQ==
X-Gm-Gg: Acq92OEbUQlPQIJHVBy76P2jL+CArOmEipo3Z6woHY98M/MJr1PMmTuWKptbV9BdKHT
	1ju3pW+8JrY/uyMLNDt6ym9s0NOAMJDhCVXhwB2dmWFzprZK7dOgAnXADkGbMeIGlAEwd7ItfXP
	JGbENfS7E9pOGv0YWCsgzwGq0fXGP8ehx/WDOroMdBTfSb96ksPo6Ofo4dyy1d2/eotUkkhIeRm
	ud0MYDpILEP1sWqE+G2A2/4IV0e24t44JZQcuQhrxLs+hkeVMLk3qZNl6Nvs5jyEm1As2OrAuDo
	ORnsmOPE+VBEKpQNMHw1NPGu11E9hATro1ZhJu3sUASB2N2mSnXTRqqN2QOWslfGDfIzxPPP262
	oowRF7PC/eGCjabKOSVrIrHH3Ou7sEIU5sbHZtGP2WFIJ5DKKRGV4xHTL3N86JG5zteZh20twdI
	yGBt0ot9q/OqCIGMT9QU6jjDl2KkDRlL4MVGaiBQTgMc4Kk/lBOVliVBbwd4w=
X-Received: by 2002:a17:902:ef10:b0:2b2:4ffc:a7c4 with SMTP id d9443c01a7336-2beb05e8628mr185506855ad.24.1779785900134;
        Tue, 26 May 2026 01:58:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2beb559422fsm9720305ad.3.2026.05.26.01.58.19
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2026 01:58:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c82c477290bso5658953a12.3
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 01:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779785898; x=1780390698; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oC0RkVqgpHR5pJcgP4v2NyxyVrKJ8POMcc0DCFeSbJ4=;
        b=Mxc9qFapHOQLdjHG2t0s5zJDDmHzbljV7y8eATFTht7jgs5iQhuqDMvi4IE0Dn9VkE
         HKSXRHkFr0M3xnh6tkhhHSlIzQ9+j0RNw/8eA2Z4gx8hh5vCEqjmK88I6ZXsfATbF+Rw
         5nqO4iiCo5UwaL8841Y0j7+g83yV4xk7BNliQ=
X-Forwarded-Encrypted: i=1; AFNElJ+Imv+l0jKOepyYheVWPKtsIJOgj7dqdEtUCGmUgrMxgKbBGCxwhzSUjCfKkAD495mrbterWGM=@vger.kernel.org
X-Received: by 2002:a05:6a20:d491:b0:3b2:8677:813e with SMTP id adf61e73a8af0-3b328ec5909mr18356577637.42.1779785898432;
        Tue, 26 May 2026 01:58:18 -0700 (PDT)
X-Received: by 2002:a05:6a20:d491:b0:3b2:8677:813e with SMTP id
 adf61e73a8af0-3b328ec5909mr18356545637.42.1779785897969; Tue, 26 May 2026
 01:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPzpGcTMARhkcdt46bV=nWWx+AD5dX2ztWCEEx_4y2V=D-1THg@mail.gmail.com>
 <CALs4sv3D5n7pciO_1G+XjxNi-YSdM98t2hTHVM7b=c4Dpa06ng@mail.gmail.com> <1db5457b-53db-425d-b001-f3fa93a763ea@oracle.com>
In-Reply-To: <1db5457b-53db-425d-b001-f3fa93a763ea@oracle.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Tue, 26 May 2026 14:28:06 +0530
X-Gm-Features: AVHnY4JWTLMa_N4lkeecxezRXSv8e_qj8cbK6HxwDouGDdkBZNklBxsI0Tb9JV8
Message-ID: <CALs4sv2j0i=VNSqiQ2vxdy8TnarCaX=dzEDQ-t7bHQd=zvAGdA@mail.gmail.com>
Subject: Re: [PATCH net v3] net: tg3: guard napi_disable and
 pci_disable_device calls
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Yury Murashka <yurypm@arista.com>, mchan@broadcom.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000465b350652b4b251"
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
	TAGGED_FROM(0.00)[bounces-291596-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arista.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B71FC5D2F9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000465b350652b4b251
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 12:39=E2=80=AFPM ALOK TIWARI <alok.a.tiwari@oracle.=
com> wrote:
>
>
>
> On 5/26/2026 9:07 AM, Pavan Chebbi wrote:
> > On Mon, May 25, 2026 at 3:19=E2=80=AFPM Yury Murashka <yurypm@arista.co=
m> wrote:
> >>
> >> During PCIe hot-plug events, uncorrectable errors can be reported and
> >> AER recovery for the tg3 device is initiated by the AER kernel driver.
> >> The tg3_io_error_detected function is the AER error recovery handler.
> >>
> >>  From tg3_io_error_detected, we call tg3_netif_stop->tg3_napi_disable-=
>
> >> napi_disable and return PCI_ERS_RESULT_NEED_RESET on non-fatal error.
> >> We expect that during AER recovery tg3_io_slot_reset and tg3_io_resume
> >> will be called. But AER error recovery can fail. For example, when one
> >> of PCIe devices on the same bus reports PCI_ERS_RESULT_NO_AER_DRIVER.
> >> As a result, tg3_io_slot_reset and tg3_io_resume are not called, PCIe
> >> device is disabled and NAPI is disabled (pci_disable_device and
> >> napi_disable are called from tg3_io_error_detected). Then we can try t=
o
> >> disable PCIe link and napi_disable will be called again:
> >>
> >>    napi_disable+0x1b/0x1b0
> >>    tg3_napi_disable+0x89/0xa0 [tg3]
> >>    tg3_netif_stop+0x37/0xe3 [tg3]
> >>    tg3_stop+0x30/0x160 [tg3]
> >>    tg3_close+0x2a/0x60 [tg3]
> >>    __dev_close_many+0xad/0x130
> >>    dev_close_many+0xb2/0x190
> >>    unregister_netdevice_many_notify+0x19d/0xa00
> >>    unregister_netdevice_queue+0xf8/0x140
> >>    unregister_netdev+0x1c/0x30
> >>    tg3_remove_one+0xaa/0x150 [tg3]
> >>    pci_device_remove+0x42/0xb0
> >>    device_release_driver_internal+0x19c/0x200
> >>    pci_stop_bus_device+0x85/0xb0
> >>    pci_stop_bus_device+0x2c/0xb0
> >>    pci_stop_bus_device+0x2c/0xb0
> >>    pci_stop_and_remove_bus_device+0x12/0x20
> >>    pciehp_unconfigure_device+0x9f/0x160
> >>    pciehp_disable_slot+0x67/0x100
> >>    pciehp_handle_presence_or_link_change+0x77/0x350
> >>
> >> This is not expected by napi_disable and a thread can be locked in
> >> napi_disable forever. We have pcierr_recovery to cover a similar issue=
,
> >> but for fatal errors. We cannot reuse this flag because it is reset in
> >> tg3_io_resume, but it is not called when AER recovery fails.
> >>
> >> Similarly, if an AER error is reported and tg3_io_error_detected calls
> >> pci_disable_device, a subsequent device removal via tg3_remove_one or
> >> tg3_shutdown will call pci_disable_device again for the already-disabl=
ed
> >> device.
> >>
> >> Add a napi_enabled flag to struct tg3 to track whether napi_enable has
> >> been called. Guard tg3_napi_disable() so it returns early if NAPI was
> >> not previously enabled. Also guard pci_disable_device() calls in
> >> tg3_remove_one() and tg3_shutdown() with pci_is_enabled() to avoid
> >> disabling an already-disabled device.
> >>
> >> Fixes: b45aa2f6192e ("tg3: Add EEH support")
> >> Signed-off-by: Yury Murashka <yurypm@arista.com>
> >> ---
> >>   drivers/net/ethernet/broadcom/tg3.c | 14 ++++++++++++--
> >>   drivers/net/ethernet/broadcom/tg3.h |  1 +
> >>   2 files changed, 13 insertions(+), 2 deletions(-)
> >>
> >
> > LGTM.
> > Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> > nit: The revision-change log for the patch is missing..
>
> It seems this patch addresses two separate issues in the AER recovery flo=
w:
>
> NAPI enable/disable state handling
> PCI device enabled/disabled state handling
>
> Would it make sense to split this into two patches?

I am fine with a single patch, both guards together make the solution
complete which has a single root case.

--000000000000465b350652b4b251
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDbbk4S
QwfXXxEWUOnPD4ufjo6jrxmZHtBkAIVCsQzihDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA1MjYwODU4MThaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBhpG+usOkPwjxzYwEZN0uJoQwpUSXyLFAl1I/b9lmL
X5WCI5uRfmVDHiMEK+5a1ddN8TwBetLoSNc1IpiGYepE8oDN/9yodiryxAL2NNFu+vTUf9YqqZUT
+W0PuNceOSDIg4XJyc71EvjprDdBJU+AGh1ozXUS5mqcGh3vlHZU8YmzspAJsmAaXsdTRZNgPj58
fCA89/QD4TrwizPnxEd3wePuH9EiApoZ8CTMOsz3xKBGGdb8vEiYnovn3A/AnOUVl5FsC82icU9Q
X9uCb1R5xq4eJ3OjO7HZKl1z9B46tlyqVtGuwLXKAQpk9MI+lPbVfu9CGEN36Hgsfr1hC3kj
--000000000000465b350652b4b251--

