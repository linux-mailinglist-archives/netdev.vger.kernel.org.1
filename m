Return-Path: <netdev+bounces-293151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AjNG8atGWqFyQgAu9opvQ
	(envelope-from <netdev+bounces-293151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 17:16:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 192856046ED
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 17:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C32A2309F22D
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 15:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888693FDC0A;
	Fri, 29 May 2026 14:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdknypbD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC19C409E16
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066714; cv=pass; b=U2ZzQfiOkjNnt7teYaS199Otxiq/207BubOOSLUMLgN/YGHHIxPXGWYP0Z1Ek21vGeytEKnQyoi0D6WMBx2sVJgPCBp2SiiClk+h8Ds8z486GO3a1a/78Xa/bW99pc8EopNYEDyBmCYJuFLchsXeipj+YGF1in+M39IiasSLyOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066714; c=relaxed/simple;
	bh=Ahm7wwN7gT9Tdg7MhigiWgrVAwRBRLvlQpRrmshYWXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyktUXx3ntwczHYcZ7YdHKMUZm2a4djF7c/hmQbXIe1YaCs46TNFpRYyNDgY9vEU0dY3+atPFf/oU78dO+eQvGwZdmpmmeOWNPYuFDDKBCiIud74MISKXFUZrESPEXgIWxylw9LFn6Boj7xEVSqVnrHPCBwuS0UubuDpKXzUEwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdknypbD; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-304d555293aso974295eec.0
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 07:58:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780066712; cv=none;
        d=google.com; s=arc-20240605;
        b=HWSEeY9yVTXUVv+Tzlaar5WUNwWjCj7YGDRjK6H9EKdh5dRH4AMrW7g+bcYAp9WJ2Y
         E0Q47vSz+a2RPk7Tt/hObkitmgsJ6Aj7y/OTciw0F311YuHw946iheaSUsyDMmVGRuzs
         bCBi7V78Uid9tgNLte6AZgTPtxpuijUW2DfZmDZZBO8Soj5+hwXjsFNXblZbLZ97ONzT
         ZdbxwSnqQXMKSoK8C5UHuesyFXcQnQ4cyB+S9pnExnBt3ZcI4QP5FdgP9SxWrkTaLFX+
         9C8ksrlm5CIRfvX5W3VrY6TFKXXsLNhcxzXBT6W2MBFodfcGUmwQuI65iywUdn92Xhe9
         fQdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B2m5uck2ux9YJhiKWVIGIxilYfiZI8IMVJ+BiI1fBMk=;
        fh=wYQnrQnIJX7F/CqkuszoThmXvQGRAnNK3KeAaTaafog=;
        b=JKHLPTJjDGID83tVBmynjb1b0BQBtLck+F5KSwxfxg1FSKSLPmFtYYIYFmwChaodMa
         Z+h4WKQC47V1hGcpAxe5XL5NrN3UT5ouQsTrqDMqcI4xTcWnYjBwvI0wLQB8fs71pa3x
         AlmxIe6QPD4ZLUdJQJBSR25Ku/WyRGHa7MDQ4Xn05Qs9h4oPzgfxU06fsAMXZE3y2jmT
         7gi4Kn66M5eagpzIMgkNQEbJVOtvsov/+WF5Tb53lfUuOl06h4QG/XHXjobt4l1Btjx2
         eEnOMVw+51PivVT79j7r9WYRtadKbRq6G3AGUXL+BoBnuOvAUZFE0DNtgHApxN8Wpha+
         L1Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780066712; x=1780671512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2m5uck2ux9YJhiKWVIGIxilYfiZI8IMVJ+BiI1fBMk=;
        b=jdknypbDjlfMKAY9K7xQLWJHozqtvAqBjy30F2cUiT0FVlyDVnXb9Kna5Y8/l/svgM
         SON6T3tuCD5pQOTngygOEX84iSDwUTUGLVg5QF3h/Sj36N1WntvWnjWhd4Ca270pTPPI
         GB78CzV8lZYH/cdxtT6GGbi5Y6I/64JFDK5ACLjIVc99ZoHOhvaHzQth64RZxKelX3Tw
         oTXrphnDTF9nNJoxFama2xVOk6urTl52fh/mK+6ChEXMHs4MXDpNC8jqXw0hQpm5pL9w
         N0UapB6D3PMm1/1EcNNTk9tBzQHsNWnuHBBkI1Vl7xSU7GoIErs8nYrp6yC+l5R3RwGR
         MfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066712; x=1780671512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B2m5uck2ux9YJhiKWVIGIxilYfiZI8IMVJ+BiI1fBMk=;
        b=c4AIEVcWLtdpoXNtoU/MjSGQzb/mVCWgmxoMJ09Xi1sQq/pPlP0AO85mxveYKadGTE
         ddnSu8OqcBxZ2rQCODAX5QHYJt/3/CGoKcZkVd3FeasxTvexgsyP4tc+a6Z9eYzNPDO5
         k6IuQSU8gZrUqdhbGueKKhXIpZq6rDJAzLah/Ud8refoRfm9aX7LjFGPdb45N46PeOZH
         tk0kp1kKGodpHZj7P7+0hXqBZe3EWPcTlVVEcpF2GcfaMw6JRGhnx7M915npqqmGuvpa
         ncSnZhDXJCBXn7fGZwM3igqmWD9hptkIsc2irPau9jjtdXQPH+VrdcxjwbmkIxWlPJag
         SG3g==
X-Gm-Message-State: AOJu0Ywb0yvXZ5xntioJof55QNMpAMVixS4373JrS4KQw/zfHJ5o/NWa
	WIeEJVpISYKz8XxRhygvUMoh8VsRxhXch78qk55GTyQqiE3xddG0gmV6ytMZBnnWRYMJ6HAzLgs
	AXtbM2xBM83xZHsjLa0VjFJzl9BeTI7c=
X-Gm-Gg: Acq92OGVSMoOdFWY0lULMxfn5xSImFCdnQuw7Z2IqSKsNkjWmYNChnIaT47cOkQ7MJq
	/B6RySpZrOJHebO1eFpgtU5iNxWzXW+cu4u1k/lbz6GTrTF0vXof/3lUbFF9K1lhsQ4zg6uBzGU
	YQ4a2whWm5kJvp/gVIXiZenbQzFl+jxppCHZbEoB5ns8gvVAByqLFTkAs7hmwS9UURNS0986hq5
	R+WThyapIGYT2UsV22fpeS/i/ONBDkTpoo/OJiyUhoNLfjqQE6Bx/CsxAYw8gJ7Ie5EvkQPC68P
	JSeQnS80eAnKaodNZhI=
X-Received: by 2002:a05:7301:5803:b0:2d9:6373:ad22 with SMTP id
 5a478bee46e88-304fa4ff6ebmr84685eec.12.1780066711924; Fri, 29 May 2026
 07:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523084408.50346-1-clamor95@gmail.com>
In-Reply-To: <20260523084408.50346-1-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 29 May 2026 17:58:20 +0300
X-Gm-Features: AVHnY4K7CEePsHXKgJoKhVenrbgr-KoCglYNTN1RuRaSjnz6Zt-v8XpgPPiCcOo
Message-ID: <CAPVz0n3GAgR7N9kAJCN_ycsgFi3B92iz2thoYcwACpd4Y6K5Vg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add support for Infineon/Intel XMM6260 modem
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293151-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 192856046ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

=D1=81=D0=B1, 23 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 11:4=
4 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> The Infineon/Intel XMM6260 is a 3G-focused, slim modem platform designed
> for smartphones, data cards, and Machine-to-Machine (M2M) applications.
>
> The modem is typically connected via the application processor's USB line
> in HSIC mode. To function correctly, the modem must control this line, as
> it requires precise timing to initiate or de-initialize the USB connectio=
n.
> This control is necessary to successfully enumerate the next stage of the
> USB device loader (moving from firmware loading to the actual device
> interface for example).
>
> Patchset adds support for the generic portion of the Infineon XMM6260
> baseband modem, which was used in many Tegra-, OMAP-, and Exynos-based
> devices circa 2012. This driver provides generic power sequences,
> manages initial communication with the application processor, handles the
> SoC-specific modem powersequence, and verifies that the modem USB device
> appears correctly.
>
> While current support is relatively basic, this configuration already
> allows the modem device to appear in the dmesg of my device
> (LG Optimus Vu (P895)):
>
> [    9.427014] ci_hdrc ci_hdrc.1: EHCI Host Controller
> [    9.431488] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus nu=
mber 1
> [    9.457197] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
> [    9.460370] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.16
> [    9.468470] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
> [    9.475597] usb usb1: Product: EHCI Host Controller
> [    9.480508] usb usb1: Manufacturer: Linux 6.16.0+ ehci_hcd
> [    9.485913] usb usb1: SerialNumber: ci_hdrc.1
> [    9.490862] hub 1-0:1.0: USB hub found
> [    9.494005] hub 1-0:1.0: 1 port detected
> [    9.657191] usb 1-1: new high-speed USB device number 2 using ci_hdrc
> [    9.844726] usb 1-1: New USB device found, idVendor=3D1519, idProduct=
=3D0020, bcdDevice=3D12.74
> [    9.850530] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D3
> [    9.857594] usb 1-1: Product: HSIC Device
> [    9.861606] usb 1-1: Manufacturer: Comneon
> [    9.865627] usb 1-1: SerialNumber: 0123456789
> [    9.908739] cdc_acm 1-1:1.0: ttyACM0: USB ACM device
>
> This patchset is a part of larger series aiming to bring XMM6260 modem
> support for Tegra devices:
> https://lore.kernel.org/lkml/20260511135703.62470-1-clamor95@gmail.com/
>
> ---
> Changes in v2:
> - changed phy to pwrseq in schema
> - adjusted Kconfig dependencies
> - implemented bitmap for modem state tracking
> - switched from phy to power sequencing
> - in notifier added chech to filter only USB events
> - in notifier added USB_DEVICE_REMOVE
> - added tracking for regulator, rfkill access, usb device
>   presence and poweroff calls using bitops
> - moved pseq on call from work to irq handler
> - improved rfkill registration logic
> ---
>
> Svyatoslav Ryhel (2):
>   dt-bindings: net: Document Infineon/Intel XMM6260 modem
>   net: usb: Add Infineon XMM6260 Baseband modem support
>
>  .../bindings/net/infineon,xmm6260.yaml        |  74 ++++
>  drivers/net/usb/Kconfig                       |  15 +
>  drivers/net/usb/Makefile                      |   1 +
>  drivers/net/usb/baseband-xmm6260.c            | 378 ++++++++++++++++++
>  4 files changed, 468 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/infineon,xmm626=
0.yaml
>  create mode 100644 drivers/net/usb/baseband-xmm6260.c
>
> --
> 2.51.0
>

Hello there! There will be no v3. Sorry for disturbing LKML with 15
year old obsolete tech. My mistake.

