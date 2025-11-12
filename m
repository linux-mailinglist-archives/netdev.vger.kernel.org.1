Return-Path: <netdev+bounces-237961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EADC5209F
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 12:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2AB61885319
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 11:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ED1312830;
	Wed, 12 Nov 2025 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="sc54x3Mk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B0D31282E
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762947750; cv=none; b=gdHzS9qmPjJAHjwKhLunLFCZWJQIUM8OV+WaqUfGhuX4Xv50eCDeK0JJCV1vq5j5oycTr6tYnK4W53WvJ1FBCXvhJNf+zXuIneM9C7XPl8o7WnOI/5CjuFAlVQ3TcuB8HAgIhoJCP1fL6fanTCD8Uvpstzu+MyeupmTdQ3So/V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762947750; c=relaxed/simple;
	bh=3ez1pFRwtvu6sbZUW1s8KM2i32OeRf3RRHffDNGCt0s=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bebjEn/UaDlw1y5QNZlFsdqP7Tv7TEVkB+DWExEM+v0z8P9iWyAwmva/7fJZZJNEioQWoEQDNluAEI5DCJg2Mih7EDQOiHIrf/ZdVvp6758zFO1/i7UPsWjlG2wytFCNfDeGdhsN+GsD3vE2JDL9OP2YdvQB+gh/P8K369UbEgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=sc54x3Mk; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DA2C83F881
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 11:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1762947743;
	bh=3ez1pFRwtvu6sbZUW1s8KM2i32OeRf3RRHffDNGCt0s=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=sc54x3MkVSwGkLeHcjTfQKQAl4yX/22bViLmjlrrKR7MDOe3OvBzquhZdJ3h6LeCY
	 mE/T26W31wjoaCwPV8g8KXf+IX+vjY98qTgwm1xD62Kz6yAesy6LC97JnGC/g0XIhU
	 1bopwFkOOY68Lo4eWC3KPner2GAadJZ/4gZ1tuOfppsNk9XQ4Uy2ZxvJbBn0VZhSCF
	 E+4mpxb8a05FOw4Xg2rY+ibCt30nvfsnfuxiLWOXEqWDD+lyIE3J3LIov4I5/wf9zd
	 eaaByaAA+FuWrOb/aSoZ4jzqkHqpMfnIOuWcRHoN0U3EpRm+QjNr2HFgq6o8TEEO3q
	 TKsO0LXQbm7OvmCjbihq3zXPqi2sAj932qC+C8bZeRCa/kTliqSAU/HVnKs0jZp6tH
	 p8AJ8AppXnImo9osI/r4IY2/qhTv8rHSoJZTjQ6q/CYLpxv6UxxnCtJgAZREm4AcM0
	 ymJz6gZRkKx+QtTAYdctU3xQROFCwfQAbuTUScpSvK1M5s5UP+dxdiGMPXZj4UXrgQ
	 SxPvQsQiBYwjnSAxg9einIDfbcgvyYk464NFCimsX1acRRvzGvqeoqevJ+j1AfDhEK
	 J27UDzQDJTgY1/6jZG+IClmiVIMAJZTqg3y5OgoITM6rr0o2lmF4uuKiKdfCwOgGOS
	 62hQZOhIi13WJLbRKsx5rN8E=
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b70b21e6cdbso68142566b.1
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 03:42:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762947741; x=1763552541;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ez1pFRwtvu6sbZUW1s8KM2i32OeRf3RRHffDNGCt0s=;
        b=wGOmDVMTzNOi4zz+l6svwI+IaU2JqcZOyF5bTKb+6m76JBEw88ScdqsiiwiISmf5Iu
         m1xJNfxTPiF6DE4UoFuUo22Q+vobfZLyhpWu3N+s8us/Aeb5vYyYCULAr9YYDxC7LZ+H
         a4ht0FN2TrZ9ao8cv5jS57zHEYUDYVo0z2H5+IM8K9NzgkF+wyQtRoFXiaQKPrNo0eb6
         QMHFi/WLPmptJ268yWqz7oCi6d8KLj/T7cslskfb0izXG3D8lCmAwdL22uFVyJ0OLrOb
         tBjlMs49h/LrK9zvSmJZaZGJEf/1yXIAGXwLiT9k9aKCf236dOM9rz8nu0n15DcgGNxM
         t5jw==
X-Forwarded-Encrypted: i=1; AJvYcCXKI1g8z2yvZEL1NWwgtjPQJmL2jXY2SnCE38sTdcHrhaE+JdMvoQkK+dnQ//K9cb4NanUvzRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMav15881P7hq6NfZzmqCZ7HZ3wv2wq/PkZyy/4pW2nl2y81dq
	qrK/xrpl585bj+CM+mGNK0FQTStOlNqEEPXap0Ak1iJlRb/7bivA64g2lmh0lPeFY/wbvgg1s/q
	dBEkkEpFumqGHuKD1ymd8IcDpDDkcSAMapT1IrpOIE7TRnN44Wf8A1+5TkX0vNIIn14+SULWrz3
	2YoG1ZsWsG0hxpuY9h5LiJSIJBd32W36ajeBRhRrZDysfIJA09
X-Gm-Gg: ASbGncs/qS/Mtq8rXnXOyGyDpWziq4v0CK/Oudv1G7H83cFKc+xT3+63q18sbCX5rZa
	m9tmv56jklws8x8gTEAPyih9ezV1e8caPHey24wzO1+a2AyqMLOhXSBuiMA1+6lDYUwemkt729i
	xXOUb3uQ4xc0z8CHJURYPrsdoQNBZ+EIGUl7O3Lsb02WbyU5m8XvNcUE+rLOpXgZpHF284BZc/c
	iXpGSxXl0MZ
X-Received: by 2002:a17:907:720a:b0:b6d:f416:2f3 with SMTP id a640c23a62f3a-b731d591ea2mr705786466b.19.1762947741624;
        Wed, 12 Nov 2025 03:42:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+3IO/2NlBrJx08X6rQMz6PNqtbjwKXovV+gvszbh/YA3hqiRZ0MYX2aiKQ9RBTBWOP5/34tQ/P9NV3zbKqZg=
X-Received: by 2002:a17:907:720a:b0:b6d:f416:2f3 with SMTP id
 a640c23a62f3a-b731d591ea2mr705783766b.19.1762947741276; Wed, 12 Nov 2025
 03:42:21 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Nov 2025 03:42:20 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Nov 2025 03:42:20 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <E1vIjUA-0000000Dqtb-0AfP@rmk-PC.armlinux.org.uk>
References: <aRLvrfx6tOa-RhrY@shell.armlinux.org.uk> <E1vIjUA-0000000Dqtb-0AfP@rmk-PC.armlinux.org.uk>
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
User-Agent: alot/0.0.0
Date: Wed, 12 Nov 2025 03:42:20 -0800
X-Gm-Features: AWmQ_bnZR2XzkbNxNxbSAGVNFuRIk1DnPVqrA09Ovj5R5d5xHcMFQU01wJP-xi8
Message-ID: <CAJM55Z91wvTonahi=8SaGcHAXVrYEpQCzsH0qfecSoFeiBoZCg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 07/13] net: stmmac: starfive: use
 PHY_INTF_SEL_x to select PHY interface
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Keguang Zhang <keguang.zhang@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-mips@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	Matthias Brugger <matthias.bgg@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Minda Chen <minda.chen@starfivetech.com>, netdev@vger.kernel.org, 
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Quoting Russell King (Oracle) (2025-11-11 09:12:18)
> Use the common dwmac definitions for the PHY interface selection field.
>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

