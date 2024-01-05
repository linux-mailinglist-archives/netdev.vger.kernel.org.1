Return-Path: <netdev+bounces-61751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B13824CA3
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 02:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF41EB23D0B
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 01:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35AB186A;
	Fri,  5 Jan 2024 01:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="FoOHf+UX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F483C29
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 01:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 994523F2CD
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 01:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704418734;
	bh=ThE/iObI5dS3ufwJWrC/Dv1Bp4OAJFFio8SPXvJGsN4=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=FoOHf+UXo6GRLPrVxqyNtReGqrfNPahPA3hnimMiXHEFpKKoZX8Hl4BAJLEc/cWJd
	 xFcr6+iWPvHshbX5iITYnQEtBk8nv4tP0dnIIcq8YQ1w8fnQg3ybbyYbs2Ox885yDz
	 9B2D84BbpWRX35I4cyJdkvSqmZiC6C7/JJAO+OS0hMqy7d49UxQL3NC3WAjoGmlbBt
	 79UpGVAq6SXvpxiGHtZ1KEi3GZ8GmXNsFufN1bCwU/lE3E8ez/0gouhhcmdDMMyzf3
	 gTZrO9P6xb6w2u+CiWRtHkRkF+fBY9dA6tdqNwU/sfrVbX4gPvLZ5CUF7/GlMiWTBr
	 xuoVscipuePWA==
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6da83a2cf03so1008159b3a.2
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 17:38:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704418733; x=1705023533;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ThE/iObI5dS3ufwJWrC/Dv1Bp4OAJFFio8SPXvJGsN4=;
        b=TCMw6Ep9izZwjl8EKLWvL8GP4TmKf6yzukiKWMVGkFpXveFc8C76HIQ3CiAfqXA90b
         6+3VAzW/2O5j3TcGDyC6oBRFoUtzZKiO/hDnU8wfPPrvujEqW/K0HiqDmCB+gde0qFFW
         ba0VoaIeggodvpF6ZALJV9k7r1z1gi8rU8T8hclyta7uLegt+JCPAkF2dRVwdM661ARY
         HHwDSVd5kAZqtcB/0xFgZIoaubqSge4Lveyc9glwC4bQb+mxJey/BAk/OM6BVolSb3hO
         qdA9J0wHXu0njkVyqohXA+LZUE/bVoJ6MbcP5DZHigipoRaL9FMCFC8BfBMEuN1Gpt1X
         vm3Q==
X-Gm-Message-State: AOJu0Yx7zM5Z5lE36acUs6Zu8T+XZJ+KmRs1P65J9wtg35qPLn4OQ1Po
	/CcEjwcwmllNOnqaF50Mhe9lt0ZVeKulouTV/u1xPx8/EkDmrsZEhIADVHYfF43hKvrrUTEioyQ
	cOINX0IToSmNqpbXXCvQTbGC68FGa9z/tK/cd+H39
X-Received: by 2002:a05:6a20:3ca9:b0:199:2cf0:38bd with SMTP id b41-20020a056a203ca900b001992cf038bdmr766836pzj.97.1704418733180;
        Thu, 04 Jan 2024 17:38:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTsk5ZAdU8qBRWxiUKGZ26XwHbKyQoqFaehil/NWxAdB4zu2Qfj7gy51jtOhpTZPDrs9YgLQ==
X-Received: by 2002:a05:6a20:3ca9:b0:199:2cf0:38bd with SMTP id b41-20020a056a203ca900b001992cf038bdmr766819pzj.97.1704418732864;
        Thu, 04 Jan 2024 17:38:52 -0800 (PST)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id bx1-20020a17090af48100b0028cf569b58dsm8690pjb.0.2024.01.04.17.38.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jan 2024 17:38:52 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 2C2465FFF6; Thu,  4 Jan 2024 17:38:52 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 24D699F85F;
	Thu,  4 Jan 2024 17:38:52 -0800 (PST)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Aahil Awatramani <aahila@google.com>
cc: David Dillow <dave@thedillows.org>,
    Mahesh Bandewar <maheshb@google.com>,
    Andy Gospodarek <andy@greyhouse.net>,
    "David S . Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Martin KaFai Lau <martin.lau@kernel.org>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2 net-next v2] bonding: Extending LACP MUX State Machine to include a Collecting State.
In-reply-to: <20240105000632.2484182-1-aahila@google.com>
References: <20240105000632.2484182-1-aahila@google.com>
Comments: In-reply-to Aahil Awatramani <aahila@google.com>
   message dated "Fri, 05 Jan 2024 00:06:31 +0000."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11316.1704418732.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jan 2024 17:38:52 -0800
Message-ID: <11317.1704418732@famine>

Aahil Awatramani <aahila@google.com> wrote:

>Introduces two new states, AD_MUX_COLLECTING and AD_MUX_DISTRIBUTING in
>the LACP MUX state machine for separated handling of an initial
>Collecting state before the Collecting and Distributing state. This
>enables a port to be in a state where it can receive incoming packets
>while not still distributing. This is useful for reducing packet loss whe=
n
>a port begins distributing before its partner is able to collect.
>Additionally this also brings the 802.3ad bonding driver's implementation
>closer to the LACP specification which already predefined this behaviour,
>that is currently the implementation only supports coupled control.
>
>Added new functions such as bond_set_slave_tx_disabled_flags and
>bond_set_slave_rx_enabled_flags to precisely manage the port's collecting
>and distributing states. Previously, there was no dedicated method to
>disable TX while keeping RX enabled, which this patch addresses.
>
>Note that the regular flow process in the kernel's bonding driver remains
>unaffected by this patch. The extension requires explicit opt-in by the
>user (in order to ensure no disruptions for existing setups) via netlink
>support using the new bonding parameter coupled_control. The default valu=
e
>for coupled_control is set to 1 so as to preserve existing behaviour.
>
>Signed-off-by: Aahil Awatramani <aahila@google.com>
>---
> Documentation/networking/bonding.rst | 8 ++++++++
> 1 file changed, 8 insertions(+)
>
>diff --git a/Documentation/networking/bonding.rst b/Documentation/network=
ing/bonding.rst
>index f7a73421eb76..cb3e6013605d 100644
>--- a/Documentation/networking/bonding.rst
>+++ b/Documentation/networking/bonding.rst
>@@ -444,6 +444,14 @@ arp_missed_max
> =

> 	The default value is 2, and the allowable range is 1 - 255.
> =

>+coupled_control
>+
>+    Specifies whether the LACP state machine's MUX in the 802.3ad mode
>+    should have separate Collecting and Distributing states.
>+
>+    The default value is 1. This setting does not separate the Collectin=
g
>+    and Distributing states, maintaining the bond in coupled control.
>+

	Please reference the standard in the description; this is
implementing the independent control state machine per IEEE 802.1AX-2008
5.4.15 in addition to the existing coupled control state machine.

	-J

> downdelay
> =

> 	Specifies the time, in milliseconds, to wait before disabling
>-- =

>2.43.0.472.g3155946c3a-goog
>
>

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

