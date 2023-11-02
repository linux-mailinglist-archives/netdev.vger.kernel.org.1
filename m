Return-Path: <netdev+bounces-45676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B817DEF66
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 11:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F00DEB20CF8
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 10:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9A9125CA;
	Thu,  2 Nov 2023 10:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvSg6j3f"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14DE12B60
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 10:05:00 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA47B13D;
	Thu,  2 Nov 2023 03:04:58 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507a5f2193bso812629e87.1;
        Thu, 02 Nov 2023 03:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698919497; x=1699524297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4hq29oAXI+WQ+QRQYNg3arnm1bj+T+CctuX6ztlKDPc=;
        b=gvSg6j3fAJitFBAJbvpr7szGe+8zZp68PxvSMHpRuesFuTyyv0ebNUcteYXrj5JPIm
         X6Y27E5vzpDkP1JZYcBJ2fKcqBz3CF8B7ehvvfb7Z8H44qKxl1t72ULcdj6/MJ/oj9hb
         9H3XqMOw17KDJ4oZp4yopelgEycwMd7KRYQTk57R5amAymPgBTUUkb7Ox9KsrhhKSWwM
         tt9YjN/KdlnBpedzfr8nhKVhAV0RUwzUjtafw0wtnuOC6R2KpuBYErrPNj3QDDRnhuTv
         /ch+IZvB8Kf4fAJ2Xg927J0je9AWdy/U75QDqOXPyTqLsYu7LP/gSgkqeJbPLLPiYZGo
         VfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698919497; x=1699524297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hq29oAXI+WQ+QRQYNg3arnm1bj+T+CctuX6ztlKDPc=;
        b=UzhgA5+O1FwpzOkA0o5V2fCDPwPiVofAMIAkUIVH9eS365pB7XIu4m3z9grgyTmYxe
         kpormWhOBoR8PdEhgk9JiB5/NgG9+edX4qZALY+djBkfTmGjH6sSf278oHJGmQhdWWnC
         wV8+Pdwb8sCKETqCX36HnUmIsUA4XXn85fy5Gs5HOw/vbu3aiBJHW/bUZtg3aGJwJlsm
         W50nquqxGB9KUgUzCtj68O65YQtOqofuXR5H+nCaVKCmhOTRXKBZ+JnDANMRKJf4qAb1
         CLVeFGYBaZzKW3w0/4ullil44luartR9rwPPmcT567ULdlDfArcqhZuGoK1DRz14Da2B
         iEBA==
X-Gm-Message-State: AOJu0YxDoed309NLwIJrHGJbExRtra/HJnh8P6rNILwdIsKwHuhWav8w
	UayEFVl/2SNADbjnzC2cvZo=
X-Google-Smtp-Source: AGHT+IEAzlrHwjbigmWLpJgHUlqixx1zUogak6aqGsXbWh6+UF5WMA818E2+f44HfoyPhESpjAIcmw==
X-Received: by 2002:ac2:4e0d:0:b0:4ff:839b:5355 with SMTP id e13-20020ac24e0d000000b004ff839b5355mr1652747lfr.18.1698919496681;
        Thu, 02 Nov 2023 03:04:56 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id k17-20020a0565123d9100b0050089b26ea1sm442247lfv.276.2023.11.02.03.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 03:04:56 -0700 (PDT)
Date: Thu, 2 Nov 2023 12:04:53 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
Message-ID: <20231102100453.dwnaxbdzf3j3ifrv@skbuf>
References: <20231030141623.ufzhb4ttvxi3ukbj@skbuf>
 <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
 <20231030222035.oqos7v7sdq5u6mti@skbuf>
 <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
 <20231030233334.jcd5dnojruo57hfk@skbuf>
 <CACRpkdbLTNVJusuCw2hrHDzx5odw8vw8hMWvvvvgEPsAFwB8hg@mail.gmail.com>
 <CAJq09z4+3g7-h5asYPs_3g4e9NbPnxZQK+NxggYXGGxO+oHU1g@mail.gmail.com>
 <CACRpkdZ-M5mSUeVNhdahQRpm+oA1zfFkq6kZEbpp=3sKjdV9jA@mail.gmail.com>
 <CAJq09z6QwLNEc5rEGvE3jujZ-vb+vtUQLS-fkOnrdnYqk5KvxA@mail.gmail.com>
 <CACRpkdaoBo0S0RgLhacObd3pbjtWAfr6s3oizQAHqdB76gaG5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdaoBo0S0RgLhacObd3pbjtWAfr6s3oizQAHqdB76gaG5A@mail.gmail.com>

On Wed, Nov 01, 2023 at 09:26:50PM +0100, Linus Walleij wrote:
> > [    3.967086] realtek-smi switch: set MAC: 42:E4:F5:XX:XX:XX
> 
> Unrelated: I have seen other DSA switches "inherit" the MAC of the
> conduit interface (BRCM). I wonder if we could do that too instead
> of this random MAC number. Usually the conduit interface has a
> properly configured MAC.

We need to know what is the MAC address from the RTL8366RB_SMAR
registers used for.

What you know about is that DSA user interfaces have their own MAC
address for packet termination (send/receive to/from the CPU). MAC
addresses for switch ports are an abstract concept, of course (switches
normally just forward packets, nothing is addressed *to* them), and so,
these addresses are not programmed per se to hardware unless the
prerequisites of dsa_switch_supports_uc_filtering() are implemented.
If they are, the MAC addresses of user ports are programmed as host FDB
entries (FDB entries towards the CPU port).

The rule for establishing the MAC address of each user port is as
follows: if of_get_mac_address() finds something valid for that port's
OF node - provided by the bootloader - ("address", "mac-address",
"local-mac-address", a nvmem provider etc), then that value is used.
Otherwise, the MAC address is inherited from the conduit interface.

Some switches also have a global MAC address register (used for all
ports) of their own, but it is switch-specific what this does. We look
at the functionality it offers when deciding what to program it to,
since it's of course not possible to sync a single hardware register to
the value of the MAC addresses of multiple user ports.

For KSZ switches - see ksz_switch_macaddr_get() - the global MAC address
register is used for HSR self-address filtering and for Wake on LAN.
We sync the value of this hardware register with the MAC address of the
first user port on which these optional features are enabled. Then, we
allow these optional features only on the other user ports which have
the same MAC address as the original one which enabled that feature.
On KSZ, the same switch MAC address is also used as MAC SA in generated
pause frames, but to our knowledge, that MAC address could be any
address (even 00:00:00:00:00:00), so we don't really care too much about
that and we let it fall to whatever value it may.

