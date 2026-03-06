Return-Path: <netdev+bounces-264962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LpbGVtkq2kfcwEAu9opvQ
	(envelope-from <netdev+bounces-264962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 00:33:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1EE228BDA
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 00:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3E19305C6FA
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 23:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA37B37E316;
	Fri,  6 Mar 2026 23:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/wZENZC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8632437C11B
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 23:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772840019; cv=none; b=i0BmeRn6Ofgm0lGMYQ3HFWk9jqQFk0PVJZxqF4YEzbparYBw8xTkC+lCRUGPJkCGht/OeNXBy3J8TXvlJA4WWn4aNReUI933VoZViQs9AdF09TDqGGBeAPLuIO2Yt1Z7TjyUI/hMeAgm80P4BOwuQZVJVSwscpmbWlqvDn98h9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772840019; c=relaxed/simple;
	bh=plzyiDYL13gMDVwQr9Dj9f8cir0m0t5cKB6vFZUg2cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuEi0i166b9jt/89/fKAOEPLAW1bJ1/H7zL1b3/nRfiK3Q7Xu56OMzNWIyEM8XCaRj6cdVi2ipKB1a47SkOcYQ6jqz+mhQc3kkJjp2xrYR41NrbKnpSsKaRWiu1oghBvx4iOTz6Ng+mMgpoyfiF2FaSUbll4mrru1IglLflaZq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/wZENZC; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3597df496f6so3989439a91.1
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 15:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772840018; x=1773444818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3n1MjNRco+xhIuiD22YqqFeZmP/U2HpmvCL9DYQOmg=;
        b=N/wZENZCtnWx8XFZ0kyLD+P1jMXI1eOOU4pu38Tub9fp/sFNmGx7bJ6qd13qqxBcd+
         9FxIPe26xE++UcdJThW6DFIdREb7TCRSAGOjb6V8a0HCiCpU70tT95TNpuRqal93lshz
         5vU67DX3D6ChDH+R/zzpwpvbFk9gPuz7Wg+Km8g8Aon1r5rnFJ+/xXlE6pXG9Qg34Thq
         pZBOW1J0CnrWpASKBSjPOtVzyascg0vhc/yEqdDpDvuXRBOa5tzst5rcOBdoft+lriaU
         kTtCKnDMNFjElDDX52pUfaqOQSWk4znRHWesOW63O4+fQLkSSIyQFUsNy094v+Vog9su
         GUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772840018; x=1773444818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A3n1MjNRco+xhIuiD22YqqFeZmP/U2HpmvCL9DYQOmg=;
        b=kGKiiEmPCnBQyfDtgLFVuehjdW4xKN/CJultbiPKZ77N0QchyIsjoIyID+tUh2bUJY
         RPXEZM2CMa4bZp9x22T9p2zMFGfK1bjmSrlZgn6ex/aa7YfaaCmrMzNfS7hNljn/ClkJ
         GZVtjEfaYljuKkTkZpy2LeY4YzPOcyeQ1e1b+Ngnvi34PW3vSE91ysSicgOn3w4DAo8m
         p4nN/UsJDZr39OVWOCXBXbvt6pEzSrlh0JE6f6mP898UFRJOD4FzPqyq8aext0zo7Oke
         8bVZRd1l5421Ps76GgCuXIWa6AqBIxMbGmeJoxFNVou0Yb/XBYyM2nSd19vdiYrW75fZ
         baqA==
X-Forwarded-Encrypted: i=1; AJvYcCUpvC2WTQtys9P4LokSQfJuv7Ios8BRzsvGVeCTdu+ZLSlkHTe18v/vUiVl9EVpZXqyQy6wt5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKQRgflVQuT3HI+O6xdULyCq/cA9ay42XfWDyybk+I1p4ZaBTB
	R5CL/dYZDnH61nsH0NqCod3UJtOGW1VjlpvWcuVAzncvPaQlBnBYKKdO
X-Gm-Gg: ATEYQzySgzFqstMIHypoQvxlVdJHFi4+HID3SlRs1ClXZuDHaAXdkMP1DEi0E3Vjdy/
	04ymcRE+bqk1Qn05VxQPFST9GweLEOURzFd6bl/fskniIpVVgM1h8g323XSE2QbOKv6nhpeNhw7
	sW6/lEqFcDJ2+7+DpcETzdPKz9P4JzjMMlkktxYX9lBdx2Eon4hlotFEaUTH4Tbcama6fM3jcBX
	fV/YJ5q0BcKb+FPMVmAr7s1USHxwApUPYbFDURbZaiJXCuGoIRbU55NiMb6KWRioqf16+DAMPRf
	dLe9p3NfhkcdLchAlWSZqgebMr5DCnoS/BD/i8QSsR7rtajE1oE2Vhl7YpuB3nmL53AOa5IMaBG
	0SvbosjmynArGAN7JIM4X/rrUuFk0gx6kZB3vf7YeReK2nLPAS1HbCKzGvwW4Z/VaR5G1sFgUrL
	Quxd35NHkUAKFk/4/UvNyVojGPMLzhib4GAtBn
X-Received: by 2002:a17:90b:38c4:b0:32e:528c:60ee with SMTP id 98e67ed59e1d1-359be31746amr3476775a91.24.1772840017833;
        Fri, 06 Mar 2026 15:33:37 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2de79f6sm6579296a91.9.2026.03.06.15.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:33:37 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 6 Mar 2026 15:33:36 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Alexey Brodkin <abrodkin@synopsys.com>,
	Vineet Gupta <vgupta@kernel.org>, Scott Wood <oss@buserror.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Dvorkin Dmitry <dvorkin@tibbo.com>, Wells Lu <wellslutw@gmail.com>,
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-amlogic@lists.infradead.org, linux-leds@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 10/14] watchdog: convert the Kconfig dependency on
 OF_GPIO to OF
Message-ID: <07aa5d40-96b6-41a1-b8ce-22f2c2c94aed@roeck-us.net>
References: <20260304-gpio-of-kconfig-v1-0-d597916e79e7@oss.qualcomm.com>
 <20260304-gpio-of-kconfig-v1-10-d597916e79e7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304-gpio-of-kconfig-v1-10-d597916e79e7@oss.qualcomm.com>
X-Rspamd-Queue-Id: 0C1EE228BDA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-264962-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,synopsys.com,buserror.net,linux.ibm.com,ellerman.id.au,gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,baylibre.com,googlemail.com,tibbo.com,linux-watchdog.org,linuxfoundation.org,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[46];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 10:02:31AM +0100, Bartosz Golaszewski wrote:
> OF_GPIO is selected automatically on all OF systems. Any symbols it

Actually, that isn't really true.

if GPIOLIB
...
config OF_GPIO
        def_bool y
        depends on OF
        depends on HAS_IOMEM

OF_GPIO also depends on GPIOLIB and HAS_IOMEM. I don't know why it needs
to depend on HAS_IOMEM, but the GPIOLIB dependency is real.

Guenter

> controls also provide stubs so there's really no reason to select it
> explicitly. We could simply remove the dependency but in order to avoid
> a new symbol popping up for everyone in make config - just convert it to
> requiring CONFIG_OF.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index dc78729ba2a5d6e035ed3cbe5c2b631d11b76b20..ef200339a22a6f9c51a46c9c0b8466add74313e2 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -250,7 +250,7 @@ config DA9062_WATCHDOG
>  
>  config GPIO_WATCHDOG
>  	tristate "Watchdog device controlled through GPIO-line"
> -	depends on OF_GPIO
> +	depends on OF
>  	select WATCHDOG_CORE
>  	help
>  	  If you say yes here you get support for watchdog device

