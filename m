Return-Path: <netdev+bounces-53973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4688057B6
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 15:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8744281E98
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 14:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEFB5FF13;
	Tue,  5 Dec 2023 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuDUvihk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B2C1A2;
	Tue,  5 Dec 2023 06:46:00 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3333a3a599fso1758486f8f.0;
        Tue, 05 Dec 2023 06:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701787559; x=1702392359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=549C7ry2ZW74NfDv11ctp78V165R5495e8Dw+8gvNhQ=;
        b=HuDUvihk21HkuArCRUBz4Cznll2+lRG8cMtv5VASG9xzP6jx4M360VhdaLIvwVJgmc
         c6CdVKNLjeZCAYrMPZVva31jFt4vuc0WGjpoKfSDO0qI+uBP0SdysmCdJKweb0HHAo0s
         PlXhFg1TYPu5MiVRDlRGO9hMFyLnwpFDdM/ma1fTnwecUgDN/HDyTLgQ4h7UqFckOKlQ
         Hf/PlIPjlntIljJA7TAEwX6BuGh4DAUh3KKohqZ2+6+Fas3rzmTOJRmaqsBDtb2uNc8C
         wDSTai4+kicvpsH5i6nWICN/IpYCJDvXSM/o+lrZWzO9/x3cBkeSwvYlm6tuKj2Cbnnf
         pbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701787559; x=1702392359;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=549C7ry2ZW74NfDv11ctp78V165R5495e8Dw+8gvNhQ=;
        b=cwwg2F1hqm7/wmNZXORA3E4UsvUi0V0xIIBE9fAOjdY3TROUlib2WtazRmO7cfwvBm
         Mc77XgOyCseNZSnNyCplUAm90mlI9hNs9aFgbBhjMnitulVzfkWgxqQBuBmqG0FbviIG
         Jmr+r6zqB7Mnlz6I10S8Et0L4650ZHMUcSeRriOTm1NvLkfEYe8mL0srCFrJ7ZUgAwbj
         gP1XgawmhLeZuCtuktHkvoy6/RQPV8PLv/Fftv3YZ8W7vlb36GLhc2IFURWBa1IcUrL8
         EizpNc1p5cAbHoGklFRaOBg/3VfKTtW7vBW6UDbPqa2+heti69RLweZv6TSDsW3r76qL
         n1AQ==
X-Gm-Message-State: AOJu0YzhfW3dCb7yUAb+FcAL/iP02nNBOsHzZ5v1xq09kX6M8TiXtwun
	qKa/4xyuSXFbPaz2uD5waic=
X-Google-Smtp-Source: AGHT+IFugWjchLIK6skvtQeKDXXeFK41F71s0msB/0JJhTOkmc8EDAuTvm9N0KygNbCr7elw4QjU9Q==
X-Received: by 2002:a5d:4041:0:b0:333:2fd7:9607 with SMTP id w1-20020a5d4041000000b003332fd79607mr811779wrp.66.1701787559050;
        Tue, 05 Dec 2023 06:45:59 -0800 (PST)
Received: from Ansuel-xps. (host-87-1-181-21.retail.telecomitalia.it. [87.1.181.21])
        by smtp.gmail.com with ESMTPSA id l3-20020a5d5603000000b00333371c7382sm9992081wrv.72.2023.12.05.06.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 06:45:58 -0800 (PST)
Message-ID: <656f37a6.5d0a0220.96144.356f@mx.google.com>
X-Google-Original-Message-ID: <ZW83o_2GBjZR0gvV@Ansuel-xps.>
Date: Tue, 5 Dec 2023 15:45:55 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Epping <david.epping@missinglinkelectronics.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Harini Katakam <harini.katakam@amd.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v3 3/3] net: phy: add support for PHY package
 MMD read/write
References: <20231128133630.7829-1-ansuelsmth@gmail.com>
 <20231128133630.7829-3-ansuelsmth@gmail.com>
 <20231204181752.2be3fd68@kernel.org>
 <51aae9d0-5100-41af-ade0-ecebeccbc418@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51aae9d0-5100-41af-ade0-ecebeccbc418@lunn.ch>

On Tue, Dec 05, 2023 at 03:37:55AM +0100, Andrew Lunn wrote:
> On Mon, Dec 04, 2023 at 06:17:52PM -0800, Jakub Kicinski wrote:
> > On Tue, 28 Nov 2023 14:36:30 +0100 Christian Marangi wrote:
> > > +/**
> > > + * phy_package_write_mmd - Convenience function for writing a register
> > > + * on an MMD on a given PHY using the PHY package base addr, added of
> > > + * the addr_offset value.
> > > + * @phydev: The phy_device struct
> > > + * @addr_offset: The offset to be added to PHY package base_addr
> > > + * @devad: The MMD to read from
> > > + * @regnum: The register on the MMD to read
> > > + * @val: value to write to @regnum
> > > + *
> > > + * Same rules as for phy_write();
> > > + *
> > > + * NOTE: It's assumed that the entire PHY package is either C22 or C45.
> > > + */
> > 
> > > +/*
> > > + * phy_package_write_mmd - Convenience function for writing a register
> > > + * on an MMD on a given PHY using the PHY package base addr, added of
> > > + * the addr_offset value.
> > > + */
> > > +int phy_package_write_mmd(struct phy_device *phydev,
> > > +			  unsigned int addr_offset, int devad,
> > > +			  u32 regnum, u16 val);
> > 
> > Hm, I see there's some precedent here already for this duplicated
> > semi-kdoc. It seems a bit unusual. If I was looking for kdoc and 
> > found the header one I'd probably not look at the source file at all.
> > 
> > Andrew, WDYT?
> 
> I tend to agree. These functions should be documented once in kdoc,
> and only once. I don't really care if its in the header, or the C
> code, but not both.
>

Ok just to make sure, I should keep the kdoc in the .c and drop them in
.h ? (or should I move the more complete kdoc in .c to .h and remove
kdoc in .c?)

I followed the pattern for the other API but I get they are very old
code.

-- 
	Ansuel

