Return-Path: <netdev+bounces-261346-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDBMBCFMoGnvhwQAu9opvQ
	(envelope-from <netdev+bounces-261346-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:35:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD191A6A67
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F03463017BF4
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C30350A3D;
	Thu, 26 Feb 2026 13:30:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C308F34321F
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772112624; cv=none; b=uaPsax3FH0IRGVCCBT/dKOE182M+hYENeZYNpRhjGMiIS37rIpgRvgi1mdtN/RRiY3lU+EhHwJOsSjohT2gmYPCkmMiilj7bF9WJ9bNfdOt4DnX1sEEAVRzKrTr+0lhIswYeoimlHoJI5E2TzvY+skS+U9F3O6CzsJHRv4/RII4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772112624; c=relaxed/simple;
	bh=4R7hF+71pg82oS066LoRVZURzYUxKCGCri0Dd7HK3lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTM11wAb4Nsgn8tajQSPJ8Tab3ifjA/dD1FlpXiFHlDsQgO72uD8kW77DEMuEdY/vubx1zTjFAfi5jfaGw9ppGRtx6SdVj0+v1rpZLPMS0a1froN+BumptKlOateh0FLztUklIJAyy0zorQqxCu3M3DPb6K6ILeAh1eLnqMQfAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-503347dea84so9959701cf.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 05:30:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772112621; x=1772717421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5twdPm6qtk6BxBBh6eqwsmb5sfIcorWjwwVPoxGI8zc=;
        b=BzrRs6SXLsn4I276dfF+pVp5C1t3GX6vUjpSAUhEDsx7Uv0LVrMq37Sdnn7lRmWAfY
         icF+ArRQMMgQc2jpAjTOqvrj9PJedZfu7Gir1LQyghn4C5yYS3CFknfz0TVryNr4qZ3E
         wBEdEYBvQITmXxloWuDgjqD+vq2iJeVT4cim8KjaVR/FdZGkbsB3Km0i/E+XloewiV+i
         T4dyB/B2j2nAkkUAdcLdstoTdmXSTlIypyObcyKYfvOOGzX7kD0U2VJ3ImBEaBExxnTD
         NR8KsntkvoK1AJFKuQ2I1cY+ui1UWn0wGmD4+Xhz+oE4oVq13Urokf6NZcCR3vNUd2IU
         5eRA==
X-Gm-Message-State: AOJu0YwtSimIhyhExiSuJuVOtZ1dA+3gaUqnJU7vwUEYWRPA6C6wvHeQ
	1qyuj+Y0+y6kJ03bUjR1ulmHyWJBSEblLekHsrSU/fWenbdq97xn8AzjAwYWB4LW
X-Gm-Gg: ATEYQzyfFkauNwTcZwwUrvjLkezzdVCMGBOvkAI5sN+IlkKdgRxkuiiWo4vXFWFNK8o
	vAECLNwYcz3czCZLA5t2VuxG+WT+fCNOApWN/GE6zjBXgzye8VHNQhJG9x/riiLwAiK82MTtdlf
	6C3f9Zt8Q+exrcC2AtL0IkfyFhBckEhCRVFYWCUxI1K9r+cp2tD6+w29jJmyRtAlbMQ5g+AEhiK
	/6WspR9RSEM9PNVok2umMgwkPwCkeBJlQMqPTTfBqwHkLR523R9bogJcz6Tqb05IcHFVyaYgK/M
	ibm9CuUelh8uf+xaaweXBdjen1ibeJnuZ2O7I+OLwMhjn6Xi5V5FFzrTr1zcxDUiQMFFy/ncekX
	+4vbu3cyAiINnp+irTL8rnEpypYNWZR/nVJBra88igB/f2k9Xj6HYJwJs1aTmTsVrVTguybOm/h
	y7mCO+4yoZvtFf41tUhASUj8O2wICPLeoZH9xSXLeoj0OaP1BY5MqLJPmhPsVjfaZz
X-Received: by 2002:ac8:5f11:0:b0:501:4e87:70b7 with SMTP id d75a77b69052e-50741f0663dmr55380041cf.1.1772112621406;
        Thu, 26 Feb 2026 05:30:21 -0800 (PST)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com. [209.85.222.171])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744af0731sm23312241cf.31.2026.02.26.05.30.20
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 05:30:21 -0800 (PST)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cb38e6d164so104640785a.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 05:30:20 -0800 (PST)
X-Received: by 2002:a05:6102:ccf:b0:5fd:ed98:cf0f with SMTP id
 ada2fe7eead31-5ff14157fafmr2006779137.34.1772112160689; Thu, 26 Feb 2026
 05:22:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111093940.975359-1-vladimir.oltean@nxp.com> <20260111093940.975359-6-vladimir.oltean@nxp.com>
In-Reply-To: <20260111093940.975359-6-vladimir.oltean@nxp.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Feb 2026 14:22:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUBaoYKNj52gn8DQeZFZ42Cvm6xT6fvo0-_twNv1k3Jhg@mail.gmail.com>
X-Gm-Features: AaiRm523jRWdOCfOPJhqksDewbEoHD_GTMJ0xjyZsvboq3n-XWtXIhj4iGm1B4M
Message-ID: <CAMuHMdUBaoYKNj52gn8DQeZFZ42Cvm6xT6fvo0-_twNv1k3Jhg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 05/10] phy: add phy_get_rx_polarity() and phy_get_tx_polarity()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Daniel Golle <daniel@makrotopia.org>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	=?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Eric Woudstra <ericwouds@gmail.com>, =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
	Lee Jones <lee@kernel.org>, Patrice Chotard <patrice.chotard@foss.st.com>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,makrotopia.org,microchip.com,mork.no,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,linaro.org,collabora.com,foss.st.com,googlegroups.com];
	TAGGED_FROM(0.00)[bounces-261346-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.985];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mork.no:email,linux-m68k.org:email,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7BD191A6A67
X-Rspamd-Action: no action

Hi Vladimir,

CC kunit

On Sun, 11 Jan 2026 at 10:44, Vladimir Oltean <vladimir.oltean@nxp.com> wro=
te:
> Add helpers in the generic PHY folder which can be used using 'select
> GENERIC_PHY_COMMON_PROPS' from Kconfig, without otherwise needing to
> enable GENERIC_PHY.
>
> These helpers need to deal with the slight messiness of the fact that
> the polarity properties are arrays per protocol, and with the fact that
> there is no default value mandated by the standard properties, all
> default values depend on driver and protocol (PHY_POL_NORMAL may be a
> good default for SGMII, whereas PHY_POL_AUTO may be a good default for
> PCIe).
>
> Push the supported mask of polarities to these helpers, to simplify
> drivers such that they don't need to validate what's in the device tree
> (or other firmware description).
>
> Add a KUnit test suite to make sure that the API produces the expected
> results. The fact that we use fwnode structures means we can validate
> with software nodes, and as opposed to the device_property API, we can
> bypass the need to have a device structure.
>
> Co-developed-by: Bj=C3=B8rn Mork <bjorn@mork.no>
> Signed-off-by: Bj=C3=B8rn Mork <bjorn@mork.no>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Thanks for your patch, which is now commit e7556b59ba651796
("phy: add phy_get_rx_polarity() and phy_get_tx_polarity()") in
v7.0-rc1.

> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -5,6 +5,28 @@
>
>  menu "PHY Subsystem"
>
> +config PHY_COMMON_PROPS
> +       bool
> +       help
> +         This parses properties common between generic PHYs and Ethernet=
 PHYs.
> +
> +         Select this from consumer drivers to gain access to helpers for
> +         parsing properties from the
> +         Documentation/devicetree/bindings/phy/phy-common-props.yaml sch=
ema.
> +
> +config PHY_COMMON_PROPS_TEST
> +       tristate "KUnit tests for PHY common props" if !KUNIT_ALL_TESTS
> +       select PHY_COMMON_PROPS

This select means that enabling KUNIT_ALL_TESTS also enables extra
functionality, which may not be desirable in a production system.
As PHY_COMMON_PROPS is bool, this extra functionality is even part of
the base kernel if KUNIT_ALL_TESTS=3Dm.  Unfortunately PHY_COMMON_PROPS is
invisible, so this cannot just be changed from "select" to "depends on".
But perhaps PHY_COMMON_PROPS can be made visible if KUNIT_ALL_TESTS,
so the select can be turned into a dependency?

> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         This builds KUnit tests for the PHY common property API.
> +
> +         For more information on KUnit and unit tests in general,
> +         please refer to the KUnit documentation in Documentation/dev-to=
ols/kunit/.
> +
> +         When in doubt, say N.
> +
>  config GENERIC_PHY
>         bool "PHY Core"
>         help

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

