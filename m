Return-Path: <netdev+bounces-268552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0K+JI5YwuWn4uAEAu9opvQ
	(envelope-from <netdev+bounces-268552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:44:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AF02A82C8
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62A44304262D
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD143A7826;
	Tue, 17 Mar 2026 10:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+mRoSiX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0844B3A6F1E
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 10:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744270; cv=none; b=Xy3bHpcw0xgRA4FRlS2MciD0lNXZ2z7q7I0krx0UnrqOUdG/IEOZGrqj71bI89MwucIjaI5ylAjbhQ2/NS8r4fINWJAv3d0FypS/cSrbq7N/ovhCbBUqStVNzLstl7qYAsG3KDbdyhdLUa3ncB+9iz20cUy5MGQCKlSqmQd+CFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744270; c=relaxed/simple;
	bh=UQyonz/fROOd+E5ux5wnd2FwnDxCTcUUFUb5qdccPbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfYajtAupdjc2+iQVSUcv72KR7fducIjYW6qFfqMPNMHgIV4T9PzZd+F6Yohj7113XpEjVH3fPjnJIBB9m+bj49z4Q+sSk6TuvMX4p3f1K3qVCwSWyfhuO/zdzGKrATMRg2NFkR2uvz4cs9A0a2VYmYwlr7s/dVhbnPF5qMdp74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+mRoSiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94709C2BCC9
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 10:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773744269;
	bh=UQyonz/fROOd+E5ux5wnd2FwnDxCTcUUFUb5qdccPbk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A+mRoSiXRnP0rpmp94IIjRt+NqHylOr8sISWSQVsw6FsnP9W4Gy1oFyPwBK0+kEuq
	 YfLXzK/+3b1dFclBnrbc2ImOIsXdkanWgEHrSTR11nomzEdwbZ2MsrKnz7L0qjTSVw
	 PyQWSqVlidOEPJwz1i8qLiBH3MOkd1512mPLL7fdIyQ+0uombK85JScW2GEnHLEXq1
	 ii/+gSwQ7AZdwIxfJaD2EebjNRUlYfVnUmrBr5fCQAGacIXTgVxS9TELk6L6l2pg6K
	 F9OzwUfvdSlqSRKO0bcQ3m8PyQo3ZvX5dzdqs0+spfSqu35ViQI1qzscOxz9lkf0bc
	 GWJmm9fFt5Qdw==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-466f00535cfso3754433b6e.1
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 03:44:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYuCZPLTguiyJHcD43yu/FUVrNnXRv5NH7DPHnm9cAzWFdSusxHzk2Ou5fWG3FZzdbEwatB+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmxpZazgX9qLp6gblrOyD1rTwkPg27oHHRvosVdSXSakL1utLE
	ULl/rczG5a5BemvLIHfhAR9uoR5w+rS12QrvMtPjYUiDAo4cWfSM3furpOxasVUEbVkVRhsXaRd
	5bA5VLV7f21Tdg66FzpcNiVHdvX/v6sg=
X-Received: by 2002:a05:6808:66c1:b0:464:a1ee:c412 with SMTP id
 5614622812f47-4675754332emr7723340b6e.31.1773744268614; Tue, 17 Mar 2026
 03:44:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316154159.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
 <abkCPU3rxHI49N4_@shikoro> <abkD-VLprcbbEbB1@ashevche-desk.local>
 <abkF0GO01sMcOhvb@shikoro> <abkLEgrZbdb03VWg@ashevche-desk.local>
 <abkLY4AAQuFlTRC7@ashevche-desk.local> <abkT_jpjIki6pvX1@shikoro>
 <abkqEni3phP8dqqw@ashevche-desk.local> <abkuNpwmYGa6qJPZ@shikoro>
In-Reply-To: <abkuNpwmYGa6qJPZ@shikoro>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 17 Mar 2026 11:44:16 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g=_HW7i8-emNdTtw_0Kjqri8qTehHvms52u-w7jqG6bQ@mail.gmail.com>
X-Gm-Features: AaiRm51cRor4ZZDDr_mxj0wmImR4wUCy3F3N-SYcdW3xJYMr5MLA4gbqvDIFXzk
Message-ID: <CAJZ5v0g=_HW7i8-emNdTtw_0Kjqri8qTehHvms52u-w7jqG6bQ@mail.gmail.com>
Subject: Re: [PATCH] device property: Make modifications of fwnode "flags"
 thread safe
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Douglas Anderson <dianders@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org, 
	Andrew Lunn <andrew@lunn.ch>, Daniel Scally <djrscally@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	devicetree@vger.kernel.org, driver-core@lists.linux.dev, imx@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268552-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux.intel.com,chromium.org,linuxfoundation.org,kernel.org,vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,nxp.com,redhat.com,pengutronix.de,armlinux.org.uk,lists.linux.dev,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sang-engineering.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 07AF02A82C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 11:34=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > Like Danilo I am also not sure what lock protects fwnode accesses.
>
> This is basically the question I asked to Doug. If he also don't see
> one, let's take this patch as is.

I don't recall using any lock for this purpose.

IIRC, the original assumption was that device fwnodes wouldn't be
updated once set.

