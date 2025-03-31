Return-Path: <netdev+bounces-178308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5CAA767E3
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52D38165F2C
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7D9211A0D;
	Mon, 31 Mar 2025 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPcGvZ+b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218863BBC9
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431479; cv=none; b=Stlawy0SRw3itqagFquJvRhV6kB+mx5noDLiA+kxXMsnxB+bFV8b5wXdLjOITAXHfeICgYL3i7dGQNRrkvWr3mHGhPTbgriHdmO27JGe49rPfTaAyVpIJMWnVCmtjfafVvzTTMvhYvM1nXVExaFIL2N3tS7oVvQlo5eTO8ojREE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431479; c=relaxed/simple;
	bh=3TbeNCFpbn4QG0k/6kKiio4kACCI00pvLEgMFQuv220=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HADmDlCs5XdEkwpfUzXHG0WB1WAk1xYu/uahg7W3i3LJFWMXILJCbwDbuoFjWHXrMPk1L9PEh/DsngQKBdIlgZcRokIdzM0eSg1AEyG9W36lyP2sTxcQnAOylpuVPHBh1OJf2j5C/l3CPr+yKujAhQg8XUpZc6ctaIME577DGlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPcGvZ+b; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cfe99f2a7so2675305e9.2
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 07:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743431476; x=1744036276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=09ZwxgBpbQt4WuSkNjWipIM+xFEeuwfyq1+W3IAqkhA=;
        b=RPcGvZ+bvGAAF/bptBKu0pt7QP/Tj0IH+8s4FWQws5s4uswLuV/UfknYdi5AeFCWDj
         /Cikr482OLslJi4DaKx7bL6HLC5pMGYNkRG1232lnf32C6EmtUmMjlBOg0ui0Evgt7p4
         eIwwbywrHCNYW6bU7/zDB/i4dPh0HCSTc1HsXeianTleJRT5PeV5IwRIE3MMyD+jmDpw
         EDI+orHqVCCU0Qevi4PeIuYlFtVW6J9fi6PJ1RASRyUYxdQTRmnGVyRuin3opLjl0R1c
         nWjBMUJ5sPGNcQVWn+5TLzv1yP/pX51Jaa605X0ALH07fLaiqZ9bJ5bWU+og2eAMEoKL
         aGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743431476; x=1744036276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09ZwxgBpbQt4WuSkNjWipIM+xFEeuwfyq1+W3IAqkhA=;
        b=gZpichhxN1itdGccquD0W8uedIBNFhTcTAF9+qoEcsilDWQWUO91PyIGkKLJzGX3uw
         9dsNhoX5XVXmjtvwT6e9sfbVPV3/He5nlVk3XZRS5yNeyC5Nl38+4Kia6riqk5U0/iGa
         iPXzpLVcBJD73Wv4j3zIJIHOpSsUpJ8uRtBBnF6kOMAB3DbqfMRVy7O8zUi7q7eFI2Cy
         uJ6u2CQabMRBKJK3dzbamOoDN7KwPfvW5EoWp5Oy6GOagfzvKa32sQzq6lCcXjz7wRhV
         IVHxtnX9JU2Vj6Xuuen/I92JXa2pJYsftcilF5a2GQr08mLnjWjY0O080Lo52jZZnGxf
         jxHA==
X-Forwarded-Encrypted: i=1; AJvYcCUSdFByG6eN/uQt4xtD7oWGNNCsrTt9paVCEyIIPDJk7d+hvjbtJW3z/F8L5+H4ziYRzWP17Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUS3ktBFp8UUwNfouuGLeICM8X3N4pd+Rx30C32QeLFt2Ig05E
	SnTeMw1oum6Ycf/XKM9OTlGjQ9qKBCn2SmrEcWVDhdvlJq9gZdFo
X-Gm-Gg: ASbGnctWsyimt63Te/cspAMeYjksxIVzQ305JrUqDUq3Kl9U1DqYq8T90ABBHVwZRhE
	mzOl3xTjl6xiZOWKCfkkhmPK/DoC90sIb8sU3yEhaTheoLd96Pan40ZlnVYsrYxxNC/vNHmXRQ9
	+8hJnU8C/Mm5KpkeKuTeihuHRg8ff5zEw76YfLBEAb+31c0qKPVapD70aGGb+Lco8Yh15kYKbdt
	P44ODAlALLvlbMbxKk9H8i2UhiZNtgYP52WlbNXBIcLU+jzNL0Vnaou8FRthDQBrg3EwyTNTNTJ
	8d0nNUu3QUqUaVABIWJWUNB+3/2ilxGr
X-Google-Smtp-Source: AGHT+IFFfA+Vt2QBhZXLGuLUrj7a7dTtK84plP4GbhyYEhwpV7F5JdJblctpcvZ4C3Oa3yRjkTXX0g==
X-Received: by 2002:a05:600c:3ac4:b0:439:9a40:aa1a with SMTP id 5b1f17b1804b1-43db852727bmr32803495e9.6.1743431476065;
        Mon, 31 Mar 2025 07:31:16 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a4498sm11707285f8f.99.2025.03.31.07.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 07:31:15 -0700 (PDT)
Date: Mon, 31 Mar 2025 17:31:13 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Tristram.Ha@microchip.com
Cc: linux@armlinux.org.uk, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, hkallweit1@gmail.com, kuba@kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	UNGLinuxDriver@microchip.com, Woojung.Huh@microchip.com
Subject: Re: [PATCH RFC net-next 0/4] net: xpcs: cleanups and partial support
 for KSZ9477
Message-ID: <20250331143113.r6t5we52wp77qqjr@skbuf>
References: <Z6NnPm13D1n5-Qlw@shell.armlinux.org.uk>
 <Z6dHo0DFWUiMMUyN@shell.armlinux.org.uk>
 <Z6NnPm13D1n5-Qlw@shell.armlinux.org.uk>
 <Z6dHo0DFWUiMMUyN@shell.armlinux.org.uk>
 <DM3PR11MB8736D45A311DA7C448825BABECDE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <DM3PR11MB8736D45A311DA7C448825BABECDE2@DM3PR11MB8736.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PR11MB8736D45A311DA7C448825BABECDE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <DM3PR11MB8736D45A311DA7C448825BABECDE2@DM3PR11MB8736.namprd11.prod.outlook.com>

Hi Tristram,

On Tue, Mar 18, 2025 at 07:59:07PM +0000, Tristram.Ha@microchip.com wrote:
> Sorry for the long delay.  After discussing with the Microchip design
> team we come up with this explanation for setting the
> DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII (bit 3) of DW_VR_MII_AN_CTRL (0x8001)
> register in 1000Base-X mode to make it work with AN on.
> 
> KSZ9477 has the older version of 1000Base-X Synopsys IP which works in
> 1000Base-X mode without AN.

I was unaware of the existence of such Synopsys IP. In which relevant
way is it "older"? Does it specifically claim it supports 1000Base-X,
but only without AN? Or if not, is it an SGMII-only base IP, then? The
two are compatible when AN is disabled and the SGMII IP is configured
for 1Gbps, and can be mistaken for one another.

You're making it sound as if "1000Base-X" support was patched by the
Microchip integration over a base PCS IP which did not support it.

> When AN is on the port does not pass traffic because it does not
> detect a link.

Which port does not detect a link? The KSZ9477 port or its link partner?

> Setting DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII allows the link to be
> turned on by either setting DW_VR_MII_SGMII_LINK_STS (bit 4) or
> DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL (bit 0) in DW_VR_MII_DIG_CTRL1
> (0x8000) register.  After that the port can pass traffic.

Can you comment on whether Microchip has given these bits some
integration-specific meaning, or whether their meaning from the base IP,
summarized by me in this table taken from the XPCS data book, has been
preserved unchanged?
https://lore.kernel.org/netdev/20250128152324.3p2ccnxoz5xta7ct@skbuf/

So far, the only noted fact is that they take effect also for
PCS_MODE=0b00 (1000Base-X), and not just for PCS_MODE=0b10 (SGMII),
as originally intended in the base IP. But we don't exactly know what
they do. Just that the Microchip IP wants them set to one.

If their meaning is otherwise the same, all data available to me points
to the conclusion that the "1000Base-X with autoneg on" mode in KSZ9477
is actually SGMII with a config word customized by software, and with
some conditions commented out from the base IP, to allow the code word
to be customizable even in PCS_MODE=0b00.

If the above conclusion is true, I think we need to pay more attention
at whether the transmitted config word is truly 1000Base-X compatible,
as Russell pointed out here:
https://lore.kernel.org/netdev/Z5iiXWkhm2OvbjOx@shell.armlinux.org.uk/#t
The discussion there got pretty involved and branched out into other
topics, but I couldn't find a response from you on that specific second
paragraph.

> This is still a specific KSZ9477 problem so it may be safer to put this
> code under "if (xpcs->info.pma == MICROCHIP_KSZ9477_PMD_ID)" check.

If the meaning of these fields was not kept 100% intact by Microchip
during their integration, including the context in which they are valid,
then I 100% agree. But I would still like an answer to the questions above.

