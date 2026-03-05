Return-Path: <netdev+bounces-264386-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IK7GBux+qWlB9QAAu9opvQ
	(envelope-from <netdev+bounces-264386-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 14:02:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE7C2124CB
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 14:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D5863053C14
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 13:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F543A1CEB;
	Thu,  5 Mar 2026 13:01:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8076839E6C5
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715714; cv=none; b=bcDly5ONJm2idy9HR1DsdC+z1Rw/NFwh9FgSGYNIrz5fIxpIGIkHDhQ6bJC0hOGrhMfMktl83hwuajUVUCQc/RlZsAhEELkbOdZbGnriIC8/0s98L+gaNzH/uqKKuWraYYU3YvmbpToAdZrC6Z7ajPNbPfR2hLj0N673MwibP4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715714; c=relaxed/simple;
	bh=mzxuHFEBJ8rIbeR5gmZexUBLMULkEpRVqRmwwCFyU/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htrkm7Rh2SjVBdpLtkUzohfD5uLM+ksyoLffbaPN8wlOJ0uFGnwa/M0RX5ajy9uFcq9Aok/6BYP9Eim3RF0gZnOPrBZfM3hVjwt/hrE/diL4hUeQ/6PgqdRym+MqoISxjzt6vZ7XDewDAcXcP3tBKwnoAaJEbjId5wNXUuR9w6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ae43042ea7so53424935ad.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 05:01:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772715712; x=1773320512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IxpxVkGnClS/pzWnTPcTEx+bl+pPZR21vGpLksfVXc=;
        b=Z8/WSBVKM1Gz6N3PGexC3GMYP6GUx8jNqvMm8zS4ojHqKq5kW+B5Xnft4QZ+fd1vA0
         AQkhPxfYY1Y5LQIc02ABj8GHoEQgf8UXyi7EuvTqbq6LIwkLfrAFpVHmtFSClSZ+75D6
         0BnQ0962aroc0g98lkyRj4cbOeA0wQ/aR5cSykzmtuqdA7awdPIFoQeKUPtuwv8R0ODK
         33FPGexmory0TyfXnPLAkPp9FHfv5N/rpfmefNnaxCrpuDx7eap1ky3D74X8k54/EamM
         4I6QHsbS31n02GSgPAuK0+9f+Q9GpjaO+wZMmOVvMs6+raoUdzQManNdfyundoXYpsmT
         m6EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOoOCT77rK1voGeE62Or0JoZjtXgXZGK8xg5r+Og/mBgZo1f1LEgHCnakAEjEnWiubbhQ1TCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh1vVyM6V0epvLjfWs68ScsGif0Cu87h0fW6Y4S+E1GNsvdISk
	q0fLmeJrf6mVaaLw7um4MCuR/s9ZB1jdaLkWmq9CxFUeczdOGyDJ1E0R
X-Gm-Gg: ATEYQzwE9Nocj6yfc2uVWasdc3GFwgglEM688V3wVZpVFLjP1gkSZZkfxINLSrEsXaq
	XdCzZr14Hsp5DVa2wp8lQ1nBFSj1269o2q876z5mSWjsEsR/YKjwHiwEDZohpXWLHyGebBSSsIA
	8CPpHswDjieKiaA7IhGDXfv9OmutfzLPgRn3fvB+kqilr2nQJgZzMyk74rWY5kMumGAPSsPrQGa
	uvFT15srAKcmH3ebgabWunzKFBVUsMsiZ42dqEFWbmRzBeLFaS986ga3DogT7hQwXEN4TxsScLg
	U1RZ0igUNjyjB654debwkgmVZ3eQostWLRi2nzgAOMntB4KZpzIcLgNPtfawDYoaixl8Fufg/xT
	BmGQYi6GWPE7RVlrFiQwh8iXoDoLir++sl5v3pvRy3vz6lrGup3Yij8bdO8bMHJlMTq9Prwpgyi
	qHF/93FJx+g7/URGsYN2SZir3d/5K4TcO4OcYS3Lr9G4AsjqHAXhZlgyjBto7tdrQd6i8YYKijq
	cAXhY95WqlsFNk3fuXItbyLx5483lHtB5SmpjbpYkcuCqQnzl1EeN9r+gkdQw==
X-Received: by 2002:a17:902:ce03:b0:2ae:5b52:3818 with SMTP id d9443c01a7336-2ae6a9deb2amr60551085ad.8.1772715711782;
        Thu, 05 Mar 2026 05:01:51 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae54136b28sm115696425ad.73.2026.03.05.05.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 05:01:50 -0800 (PST)
Date: Thu, 5 Mar 2026 22:01:49 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Joe Perches <joe@perches.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH phy-next 22/22] MAINTAINERS: add regex for linux-phy
Message-ID: <20260305130149.GA1659133@rocinante>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-23-vladimir.oltean@nxp.com>
 <a8fee1cd-1e69-4a9e-8533-c0988c480fb9@oss.qualcomm.com>
 <20260305085148.7cwo3yflp7vcfldf@skbuf>
 <f3a5aa3df78553ffc0fd0024f5fd36a4e2158c88.camel@perches.com>
 <20260305114352.2f7btqixg4tu5bzl@skbuf>
 <20260305121532.GA1649635@rocinante>
 <20260305122957.GA1652563@rocinante>
 <20260305123956.ojkt4k3ly64xz7fu@skbuf>
 <aal6kWDx_3XRGB4K@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aal6kWDx_3XRGB4K@shell.armlinux.org.uk>
X-Rspamd-Queue-Id: 7CE7C2124CB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[linux.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264386-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.7.a.0.0.1.0.0.e.9.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kw@linux.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello,

> > > For content match, it could also be:
> > > 
> > >   K:    phy
> > > 
> > > I believe this would match everything of interest?
> > 
> > Yeah, and way more. Think USB PHY, network PHY, etc. Don't want to drown
> > the linux-phy mailing list in unrelated patches, either.
> 
> Also phylink, any memory management / DMA stuff that happens to mention
> "physical", and probably numerous other examples.

Makes sense!  Sorry for the commotion here, then. :)

	Krzysztof

