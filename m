Return-Path: <netdev+bounces-271261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KKTOpDqwmnnnAQAu9opvQ
	(envelope-from <netdev+bounces-271261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:48:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5656231BD48
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23D5E3156EDD
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08B630EF8F;
	Tue, 24 Mar 2026 19:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeRcPEFk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FB43090CD
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 19:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381374; cv=pass; b=IiObUvf4FABwELMyVOx3WXYZ91/I6VRzduvgdaxpdQjepT57ewMx6uwVUlRjepXzO11xmoEBgXdLG2DUApX+EhApRqESthTDeNSXYEKBEgO0b88gUQlv1q3GbIqrqlHy1K4fiUIj+T4qrc7OeyrVgVxDWmnYBi0iVeKQvMX2xPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381374; c=relaxed/simple;
	bh=gUApP1/bO4cskC1otBU5J1CVYpx0KZXUXkn10ktK9T4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KYlMPR9gmD31Kd4/hhQ2St/Zda2D7Rsw4/DvqW7ilnt+8djCqV86joJED/nPZl6UPpwbUtmF5uWu12pclWSjqZkW2mOlhCfh7RdVbM7f8Rp2W5sNswD3d7+zY1KQ0mGsTd4MvF2Atc7ajcpShjhti2sUUyQZ6S3dbkaMSBhDtcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeRcPEFk; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so3208844a12.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 12:42:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774381372; cv=none;
        d=google.com; s=arc-20240605;
        b=A1BNOC4+HNFGvGblGgETI8NP6Z54tsD+ILkarx98W/hrfzbdy3YaH3vRfc6/FGLIxX
         Z5LODKVXlIO40Nf2P/rIHEFYhc4iP9LdYotNZ+VS6D2fwHxfdAIivXnidSSlQNlsTjdW
         cHcaCWuBplMtpeQHuifrdJSo81UEaTuXy99ka3lCTABKg8c62g/U+sDrj7h+wQ8Kjal8
         VxqedxLUtqe9fQtJ+KEYuDaBU1IEAxpakxo0iUQNfvLZsANvzcvO2H8wSxUVdbh1TviU
         pBRrRBUu+Nfu8g5FDj+cGwQaLtxsZIACgkz1AuRORAoxZekD/6NUUQm195B2ptDLjlLp
         KCSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gUApP1/bO4cskC1otBU5J1CVYpx0KZXUXkn10ktK9T4=;
        fh=cmXqdOjet/toHL9Eig8e7wcGoWhHUeG0R9oFD83GYHw=;
        b=gXoPmIRDO/8cEh0tCwkjkjbQHmgN7MkA/pMPIoJ9+F+/FqquzLS4vzfLltQrf7Dca5
         E+YoS3UhSCXGTICskSdckemrheU6yPb4RcOsE1HtLWnzdBhh3KkAMWqnU+0kh0JkCR2T
         a4DtSAZVJCIdGSiJKnfZxXxfsnMdRlhvLRa6zPSKNZE9zPf/A3X11Hak+szdEGFWnjmc
         Qh49o4NhLMY32E+HpHxn4yoGjoITG3HkmTy92xASwfmct/n0hSEMMAHfDr4b4gjkcxoG
         56C6PbVEjNmT6EOtPee9qRs9IotH05hZcONagES0oyvGnXYu9nJG7LuBkD/WfS9s3NO2
         rafg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774381372; x=1774986172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUApP1/bO4cskC1otBU5J1CVYpx0KZXUXkn10ktK9T4=;
        b=KeRcPEFkjGBJBG1RC6Cqaug265STW47FcuZPcuZuPNiPyhLO8mzMwLCdydKs3Z7uv0
         pU6zMWtzjNpMrJZpPkgxxOX2k/Fr+D9L3Q4Xx0YL0ZfggKfdNt2J9mbePjZMXWf6nJCN
         4UgTZWSsyhgdZpMPLeuZcBpAhLxXJW7e7LUP6oJNIFZLu23jgSE45UAuMX/2srmrVmXo
         9m2Q+VNRpho2i+AQ/OvOB6ciYdvXMC//uXRukCIOSHQTYz8yUFg9bIxzjdse6sdHVFtf
         LzNFOpburCb/cyTn1hsoTFFcy5mQA24khRLKNkBiCAPn5YpTEZtE23u72tRxP5iR+dOl
         P9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774381372; x=1774986172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gUApP1/bO4cskC1otBU5J1CVYpx0KZXUXkn10ktK9T4=;
        b=FMyOj7AtL0cAKBch/b/QDdtiFLBKckIXhW/cS5Yc0oJBjBS+hLOtX5Pu34cWTBM9CO
         GzwlYOmuMpIKhKJZ4RG/otHEiN77wuT/dDSQeB3mH9R7z8Dnza556cnWmN99ptZLjHlF
         q17icK4B0XmU8gr5U7x6YeEhZOi83BEmIocvFCJLmoaCIk/26PD4nlR7JCI8f1f50ukg
         +ltytTtnrMKtEJZFSF6Yg/ESEn+U9PnjLohUZ+9ehUpw0aa7ar+DMNSIhKHwIGQMkFb+
         H1qXQEXj/bHYgdlLnD1OZypscBB+/aT7db5GwQYsXAzRwUSsGesnjRS+ViSUWe8/Kzm9
         +I+w==
X-Forwarded-Encrypted: i=1; AJvYcCWjHl1J1mUnAIxp7lOYfLrEHVqG+NVDMlMPKQ5DQ7coSyxI0yLiGpU3LgIKavPKvsCE41z3oxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/v0nib2LBwjV1WKbQIasUP10RxKIDB/WGfhd+N/Ygrn62LbEb
	sRbBrbQrjJwjrP/HnKw0YlwYCcEhrPV7cQyfEQQPwwvAxhOZNSuKxL20W/2aWP8fTZo6ynUuUn8
	v4eCWYLo8+1okpkTi2YhBKSp1AHbUnNY=
X-Gm-Gg: ATEYQzwXU85xBV9ob6vLfomFjnycq9zmsoexcTzfN8j0BqCxJLa5VJMlhhe5+wFt/53
	pcKq3DwY8xYhXIQ09K//gA2/SR47mpjuQMCyYEdB/xpb6+v5RJNOxzcbyhdRumy3I8ri24A5lDX
	5LYxEf4JEFO8HPRH9qPTYfq7PVU2+c1KSuTfRjKNJNBi4z+WS5raiF8ySqteC539CBTf5w5Le22
	LLZEZpVbTew/eOIIcu6BgtO9XPI123B10EETB6KUUw6JFoTZ/YU9yo4SoXjPAlMQuUBPQjrIOJJ
	N5bnMh50s9ALnw==
X-Received: by 2002:a05:6402:460c:b0:667:f3dd:6062 with SMTP id
 4fb4d7f45d1cf-66a826a1726mr302599a12.17.1774381371484; Tue, 24 Mar 2026
 12:42:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324152503.1522071-2-wagner.daniel.t@gmail.com>
 <acKypS845fm_GB0o@shell.armlinux.org.uk> <CAMsLQxFnhPT5TLmwQS14rrgD8xmgs6ymH8Q3ee1KcSqm1XEstw@mail.gmail.com>
 <5ff11a7f-6f92-4488-8138-9f8d6210ae30@lunn.ch>
In-Reply-To: <5ff11a7f-6f92-4488-8138-9f8d6210ae30@lunn.ch>
From: Daniel Wagner <wagner.daniel.t@gmail.com>
Date: Tue, 24 Mar 2026 19:42:40 +0000
X-Gm-Features: AQROBzDmnCUqYgYi0IRapWqGoCJBFm3NdekPzSGKEw28MsAdENfZHC8thaWO-K8
Message-ID: <CAMsLQxGKonJAp2t-B9we27LibshPPpxBdJRFMxg9izxqhsG1PA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: phy: bcm84881: add BCM84891/BCM84892 support
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271261-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,vger.kernel.org,broadcom.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wagnerdanielt@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email,mail.gmail.com:mid,datasheet4u.com:url]
X-Rspamd-Queue-Id: 5656231BD48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 7:18=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
> What sort of bicolor LED is it? 2 legs or three? Are green and amber
> mutually exclusive, or can you control them independently? If they are
> independent, then you can represent it as two LEDs. If the colours are
> mutually exclusive its a different story.

Two legs, mutually exclusive.

> Oh, unusual, there is a datasheet:
>
> https://datasheet4u.com/pdf/1561522/BCM84891L.pdf
>
> That is not like Broadcom.

Thank you, this is a great find! I hadn't spotted this when I started
looking into the platform. I will digest a bit more but so far it
looks like the pins are independent but setting both wouldn't work
with a 2-pin LED.

Daniel

