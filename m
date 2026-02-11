Return-Path: <netdev+bounces-258228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ3hGHBKjGmukgAAu9opvQ
	(envelope-from <netdev+bounces-258228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:22:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A10AC122AE2
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DAC9303AF30
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16710355045;
	Wed, 11 Feb 2026 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="h+OIbq76"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6B2338581
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 09:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770801699; cv=pass; b=MPcvSy5PjYyTVHz+hufxaz/xZMhyzJSAMj74090NezqdKYv/ant47dWjuKJB1+5/TDUAKNnXOFn7rrjqd8qZ84DfdluGZcwcM+opRCJ/oj23WOnrYlh9Q1ftIBd+tASNMQE72GYxnvEHjsr9AOXLYEC1AzOucf8BtJ7RjOQJxa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770801699; c=relaxed/simple;
	bh=rwcYPbUyz95dte+r+KGmItRRNFe0wH+rzKz78J28p5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XT7xV/UGDJ1lv2fSy/O0mFvtiVyEt5r9pCcXYqQvCdxwZ6KjCQGs/bRBTNnTDs8k67B6ZWPCxZ+R4S/5R8/Sb3YWZycWJZKuXcT6M23WeNlQuNJMblM1rZDKWeQfgRDwdiDI+tk3XCMz6NzuY4XoPQTt8uKZIC/Iu6K/6o6LSas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=h+OIbq76; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b81ebac5d6so2355518eec.1
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 01:21:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770801697; cv=none;
        d=google.com; s=arc-20240605;
        b=WuCTeg8YoHtg8wRtr+pjSxtbrTvuOaQw2+roJobGhAmC/sGAQovIngzb6PBkL+Gkjj
         37InXAhqQRWkOtGSjkoSUmrlQq3OLmM2HM6m7kimvd7llsSEmLu+XFZtCTMSCn58BMTn
         rDu2mwyig1rTvjq27t7pUqvVo8F+4DAxO+fQeE7D4fK2FB3VOslQJr5wy5q6CsydgtiQ
         uiWQBLHe5ye+G7wH4z32YKbYEox2Ggr6kbZlypdniemgvKGB8dyD9hAkfJ5xcGql/qRg
         zNmcUDrN/zeYoiFuM7HQC/ZBYsMAIxku4hTt2P+r/3ZzJYM0T0IPXtiZWwgORnV/NP27
         6/ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rwcYPbUyz95dte+r+KGmItRRNFe0wH+rzKz78J28p5k=;
        fh=WjPONqiNkQdnF5CD5BJSNeU/YH1hcId1+IazzEx1Lhw=;
        b=LDvX41ihIis5lKY9wA3Yps3+HxPpF5gEuV8oJOnGjyoo+J9A7ZqND0eMJxyEKgEGyF
         WbOUtOT2/XDeV9DrSQz96gEWs/AoPmTMRdL4uhM8AbnCYxSalArs9WJ16gRIC5V/c6JN
         08Xex89mcAtAKf+K/vVt1/aM2kY2r+w+mOyEXunu1TcPF8i4oocpgoPjA1YDNVIy/LvS
         faoKV655OJwve04ZavFVeXiwpBR96sZ5yx7ojWxkw+Hcsfah7C/FQFy6jOjBFVwWeXx+
         iG4oDONIikK29wdtf+b6G8mWHeM1ZEbPuuD+agkiqSPJkJZraqQ3xLoOjS79fAq87lBl
         IS1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1770801697; x=1771406497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwcYPbUyz95dte+r+KGmItRRNFe0wH+rzKz78J28p5k=;
        b=h+OIbq766UBODZWKaycEn0qasZyxtXkd6QhNvoXCCO6ScW6PA9QLNpH0m+5R2zgCLW
         cAJPDIhyD33bfW7NpQVMaIWx1YJfZLNgeY4hRe4l8Lq1prf+dMqXxWlUjnoZ2c74lvch
         ACMDHihXsnDdHO+aHOTBZ8ZL4dqZmzWcIRKOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770801697; x=1771406497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rwcYPbUyz95dte+r+KGmItRRNFe0wH+rzKz78J28p5k=;
        b=PjVSPA/OqASb2gsuzpcrJnB6ndI3/1GPVwVgtnp/drdiVIBJdc2lds7OqnqSBiiE7e
         QclZ3dAoMsMp4OlPaIFl4u6PJ6ebF6K9QGqd6xUJjWP0LBsCDi1miHkMkQO3OOFBW2dE
         zWd6IEWTPl2vGp5bPmBaHvV2ThKl9zVctQoSZ1qbRkfSiayN+YibgXsyYs/wp+qvkYkU
         pdDNU6Z4kskZS3F158WXRTg6yfSgRJ6xj1Kd97c1iCgKWqSrrTs8n711zVLEh+ZvGFCD
         5L9/HMzWSS+YJx5/7W6KUO7jFfM5wt/YL17SBb2LsyGYu7Aktq5UoGWyFp81bCGGP7HW
         1jHg==
X-Forwarded-Encrypted: i=1; AJvYcCWA3+RsuaaF/EDw8MA/ZlaPWL/ljhw7PmwJebNUq/IgNFovUp4c971Z3ZWNmASlqqBaH8/uSTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzwVSk7GLUOCf2x+WPWfJnEqLnhmsR+HksjxkfWQebOrMgtU+O
	q+V2tLdIgtsotrYikwo2EwthJ4hIyVDPyCwY78Mm2OFcw9l23Id2jh7bIYIgbpLtt7D+J7gQgCJ
	UK4Pt6ZEMD+6K2byo3b2HZ3AdfZul8bOHyFZCYaCPsQ==
X-Gm-Gg: AZuq6aJymIQNcRdx/fQ35fLJ5Xgjh082FmPExrD6nPm0C8wivCCBeFJE1XRzq5IV7Qy
	4xxhiGVuxMczkxvEqcBQgX8UsVeMQFtz6iYYbmEjwK5OXsOlfJ4iM5fkERbqkLYEdjwzkr9S2pq
	6T4Nyjtk2ll6XzFge7YLEoJlk9MzR6NJFd+yAefepVMNZ1Nb0NASYVJPQtUfg2Y2VsemuAOwRQN
	titnou5sZSnC0AmVn+MeYnsp2IfMsUpijAyHx2vqu7TksR1NnGcDQM5w075l8xxmIbmR2TRenmy
	t3y3QNAbHA8mqJHwG+YEWurIqMc3AIyilisOOg==
X-Received: by 2002:a05:7301:9bc2:b0:2b7:32a6:82bc with SMTP id
 5a478bee46e88-2b85672111fmr6959767eec.26.1770801696866; Wed, 11 Feb 2026
 01:21:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128094644.302313-1-michael@amarulasolutions.com> <PAXPR04MB8510831BD69AA3BE71E03472889FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB8510831BD69AA3BE71E03472889FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 11 Feb 2026 10:21:25 +0100
X-Gm-Features: AZwV_Qh_NKulEX6GhO2VRR6DiP2mrrXV3YahSmTeMatE-BEs1pdfJLyj_QbD_lA
Message-ID: <CAOf5uwkrGhO22SU29m2aDX2cv2nt2xm_mcyE2GDwWnpa=-c7Zg@mail.gmail.com>
Subject: Re: [RFC PATCH] net: phy: integrate reset-after-clock quirk into phy_init_hw
To: Wei Fang <wei.fang@nxp.com>
Cc: "open list:FREESCALE IMX / MXC FEC DRIVER" <imx@lists.linux.dev>, 
	"open list:FREESCALE IMX / MXC FEC DRIVER" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[amarulasolutions.com,none];
	R_DKIM_ALLOW(-0.20)[amarulasolutions.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258228-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael@amarulasolutions.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amarulasolutions.com:+];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13]
X-Rspamd-Queue-Id: A10AC122AE2
X-Rspamd-Action: no action

Hi

On Fri, Jan 30, 2026 at 3:25=E2=80=AFAM Wei Fang <wei.fang@nxp.com> wrote:
>
> > The current implementation of phy_reset_after_clk_enable requires MAC
> > drivers
> > (like fec_main.c) to manually track PHY probing states and trigger rese=
ts
> > at specific points in their clock management flow and was created just =
for a SoC
> > vendor. This leads to fragile code in the Ethernet driver, involving co=
mplex
> > checks to see if the PHY device is bound.
> >
> > This patch proposes moving the handling of the PHY_RST_AFTER_CLK_EN fla=
g
> > directly
> > into the generic phy_init_hw() function.
> >
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > ---
> >
> > I need to test better some boards that need this reset, but
> > I need to confirm if the general approach is ok
>
> This patch looks good to me, it is more generic than the previous
> solution. I do not have a board that uses SMSC LAN8710/LAN8720
> or other PHYs, so I can not help verify the solution, but I think it
> should fix the issue that reported on the i.MX platform. Thanks.
>
> Acked-by: Wei Fang <wei.fang@nxp.com>
>

Let me re-test and try to get rid of this flag totally. According to
the discussion seems
that should not be needed

Michael

