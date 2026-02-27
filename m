Return-Path: <netdev+bounces-261832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MOsKMWMoWnouAQAu9opvQ
	(envelope-from <netdev+bounces-261832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 13:23:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2D61B708B
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 13:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E0AA302E7EA
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 12:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B504D3603DE;
	Fri, 27 Feb 2026 12:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0ClH5g0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526E84A33
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 12:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195009; cv=pass; b=dxbvc8oC4SyaudCnaTkuE7LfJxn/RBx6bGbrMYwfePKcanQMEfQPvWQ3/EurCG2VQyaShAmAG43XK//XEBxh1D2IbhGXURfAI92vi4nC7h5pswGUkh3LSDqtJ6NIIuuNj6/A8PrEtUcJN7uNVdMlIfCHyTP28fVbTo09KpQtnKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195009; c=relaxed/simple;
	bh=3FcNW4rDQebMeZ/kMOHCoRzAVMvJPWXVFrCQEgc1T5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=afJhm9QDL49HCnlUFXgfh7EA2//cJk/XDpIeYmE89Y5r0gZ6cT3DtDdxZAsxASPFdKAWdRjJPteJGGmCdEc7mVi+XuiYyy2o/Djx9F9uw0N/g3rdJKN8SwVSDMevb/+FtneqNZ4YvVcXm6pwD3413cOB90BPt+qJWUzrcFboi5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0ClH5g0; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3870cbd6c40so21763801fa.0
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 04:23:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772195006; cv=none;
        d=google.com; s=arc-20240605;
        b=al/kDYKtCncpePclfIqY5nUcRlaTEfJadR2xW9OuYfwS08hlbOLxIwWEEyxxnntnsn
         y9jIVD/EDLaEKI6sUCanZ1XTwBp1QpzqYVzbmyJHgRrRbbvLmfHjiEKK6pQX3UkEp7H3
         Qg9YoV+xPOm6F77zFzuOsxmy2166r1/WB+n5Yjyp6ILn9KhlPgDz+MQORFkWEIlF2+PN
         nSa+08juqGzkh8Hnrxx6XOmM8i9xJyyZhMq0UK2nyWXC2Y0aFOoc8wIqnGgtEa3XVArd
         +Xnx/jYn7KC1cO22ti7SssaIFZ6sVAxrO2LRiFJX4CAFVv4n4dbwGupRNbN+4gbzfQvm
         opFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3FcNW4rDQebMeZ/kMOHCoRzAVMvJPWXVFrCQEgc1T5A=;
        fh=bz4GuN6e0Lsm0JjLQq2a0TbxYII1U6c0KF/m5J+vjpM=;
        b=MYkCX8Way9Nh/21+FESWaKuc6K+kfA7jHwaqkLZ968HpvAkUUa6ihYg6Kb5KqWiMLE
         11fUkthBK05oAHZmQ+vZPwatdMm8NxQURArVi2fhLHjLhSNo58IbQ7xyighcqukyB4Oj
         QlKyl4umMqfW0DL3PiUMOD5wzQrOz1wr8Q9+lxjfToE/R8AgsIqfRLNYdpYzPt/S32QK
         1NirOLGWfQ7pTBWPUEOwusy6cimKQvCYdd10RCfpTNPFMGIRYsME0qBMW6wiVd9tC0su
         CvWXLI/K4tcUp3ku9265w3sKPaLxUSXFGPO/6P/f4KAAVSLHpeJmUtVp4smyc56jjkpN
         C0XQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772195006; x=1772799806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FcNW4rDQebMeZ/kMOHCoRzAVMvJPWXVFrCQEgc1T5A=;
        b=d0ClH5g04ZuYq/kN2WHt6m/QDDcyTHPM4b6oA+YacPgP9mwThmm3yRFj86IrGM7N0A
         YwqMhzNZtrmjAQVVIAMRkMGTTDnibrBXz95iPIzW9jLx//pWbgqgfKxu4jJFArEG6CPl
         C2CaUZC2WjKgBg+Um6cCQNhGlXYvwmXej1IJIHDMlzEqGVOIXYStkaNSb+PsSbT70vbf
         8WQu6+TyPVnAfnh3WU96YZTaYH3V4LzoZQjflw7VPScbl+goytSVs0Dm+brOFoyZ5wiy
         8tM9o72juh/rCbzWJHZW1iWmY3U5R/qzuAi5xIZPzK1jBhu9RKHoVr3oLnsv3LPOKdVy
         lyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772195006; x=1772799806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3FcNW4rDQebMeZ/kMOHCoRzAVMvJPWXVFrCQEgc1T5A=;
        b=wFpDufLNUgFPP9sgZLqw5XMOfN7dLIC/gLB45VMb8iDYYKJMO3hjMnjDeNJ9cdjcvd
         G+FK1PvAeXQTsJXFatZnup8etxZmwu0runbwof1ZblwSyE+Y5HP5Zgt6qK4jL+liUWr6
         LETzCLYLmKEao3Wjm9ULyCcHbijZiujuKArUqCY96Dz7eXSlWUn45ceR87Dxys5PaiOi
         sw4e4PE9Ym76z4QF92TrMR+qP0OgeJRU224uK1zD8mGKYORfYwda++DS2Afy3NwglDab
         3mOQ068VM7tTxkRyvT9KLS9K/MK1LRbDqpRoLILu04KA9DLCg53jNFhfASofiodFUwJr
         ju3g==
X-Forwarded-Encrypted: i=1; AJvYcCUQTngzQj0QCXFzep9l470IV1Y+5rL2mJNZFOH7IKsLA3HHvlFMEA3cbGu30xB7wMhjb89dW9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2pHSkHSzNPsI1uP7tQkB3+84gsLMs8VRqcblJavXOnxIM+0ms
	PEjfKBnoZzAd8JVrtnlZBlQddLCqAKulKWQW2CGsrQMsPY8yKd5sYHNwLQj1m+TKfaKWCHiCh5/
	pjiKXeVV3TEsqCn9I6znyc3HoJ/oXYKg=
X-Gm-Gg: ATEYQzxvQPoxgi92quo6M8uHXUb4yY9JlYME9F5m21oWoTYW71DViVFyHHG6ejmT/e8
	QeL5ORuOs4Gc/erZIsbz4IFbl+ECyxrn4rao8DIFomjOPs8ZyR8oQBrcKgWMoOP5aMi+xpFvDOS
	ayyisGDOYKi6A9Q8+5wl7ZwDChDoFD6ApTQe+HMB4IH94oeCmKsZtLw5e+K7Y1E2Sd7XDoWCZN3
	w/QbcBfztCIido6vkbEz1P82mvtGCEBb07XgJAqNGOVXBrwf9fFID579IuAFWrJ7NUf/8bZ5API
	AbmJXCJKW6ZOX8CwQu5whGpvxhVbDi6H3uswNQ==
X-Received: by 2002:a05:651c:1613:b0:386:fe97:a538 with SMTP id
 38308e7fff4ca-389ff11b733mr18868171fa.9.1772195006192; Fri, 27 Feb 2026
 04:23:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508091424.26870-1-jonas.gorski@gmail.com>
 <ce4d9b7b-aaf6-4796-94fb-8c3d6a1dcd4d@gmail.com> <d7f9775e-0af6-4294-837b-47e31e0d30d7@broadcom.com>
In-Reply-To: <d7f9775e-0af6-4294-837b-47e31e0d30d7@broadcom.com>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date: Fri, 27 Feb 2026 13:23:14 +0100
X-Gm-Features: AaiRm50j5ltHbptrHGYO14Pl3bk1n8rq5AiUPBWA_FRRVyQqD8iL81ehshp9pmI
Message-ID: <CACna6rw1kF-r40dr-nxouV9E0AigmeVj9fxQm_Px34Z_n2up9g@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: b53: prevent standalone from trying to
 forward to other ports
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.10 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261832-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,hauke-m.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zajec5@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1E2D61B708B
X-Rspamd-Action: no action

czw., 26 lut 2026 o 22:26 Florian Fainelli
<florian.fainelli@broadcom.com> napisa=C5=82(a):
> On 2/26/26 12:24, Rafa=C5=82 Mi=C5=82ecki wrote:
> > W dniu 8.05.2025 o 11:14, Jonas Gorski pisze:
> >> When bridged ports and standalone ports share a VLAN, e.g. via VLAN
> >> uppers, or untagged traffic with a vlan unaware bridge, the ASIC will
> >> still try to forward traffic to known FDB entries on standalone ports.
> >> But since the port VLAN masks prevent forwarding to bridged ports, thi=
s
> >> traffic will be dropped.
> >>
> >> This e.g. can be observed in the bridge_vlan_unaware ping tests, where
> >> this breaks pinging with learning on.
> >>
> >> Work around this by enabling the simplified EAP mode on switches
> >> supporting it for standalone ports, which causes the ASIC to redirect
> >> traffic of unknown source MAC addresses to the CPU port.
> >>
> >> Since standalone ports do not learn, there are no known source MAC
> >> addresses, so effectively this redirects all incoming traffic to the C=
PU
> >> port.
> >
> > This change broke standalone ports (those not being part of bridge) on
> > Northstar (BCM5301X) devices. We got reports from users about WAN ports
> > on routers not working anymore:
> > https://github.com/openwrt/openwrt/issues/21187
> > https://github.com/openwrt/openwrt/issues/21349
> >
> > Can you take another look at those changes, see if something me be
> > wrong / missing?
>
> Checking the BCM5301X datasheet, the register definitions look correct.
>
> The first report appears to be for a Netgear R7000 which AFAICT would
> utilize port 8 of the switch as the CPU port, which would be correct.
>
> The other report is for a Netgear R6250 where port 5 would be acting as
> the CPU port, that could be an issue unless the switch is also
> programmed to use port 5 as the IMP port.
>
> Could you try to program GMNGCFG (page 0x02, offset 0) bits 7:6 to have
> the value 0b11 which is dual IMP port (IMPO is port 8 and IMP1 is port
> 5) and see if that helps?

On my Luxul XWR-3150 (it uses gmac0 and port 5) the value of
B53_MGMT_PAGE (0x02) / B53_GLOBAL_CONFIG (0x00) is 0xc2. Nothing to
set there I suppose?

--=20
Rafa=C5=82

