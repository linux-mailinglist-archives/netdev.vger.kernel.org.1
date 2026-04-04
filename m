Return-Path: <netdev+bounces-275411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJT9NZWS0WmlLQcAu9opvQ
	(envelope-from <netdev+bounces-275411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 00:37:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C5339CC47
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 00:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB318300B132
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 22:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2922F6904;
	Sat,  4 Apr 2026 22:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRNmZDeL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75A5291864
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775342227; cv=none; b=WGK5txW63bNG9fPGebEpnFqAitI9Pon5pxNJTH3huIXviXPKi0YS4YO2Ag/wlT9nh601/JMl5N93wn3HRS5wTK0rSb9eEkEaPH6sJ10U4t4dUsHmtHSdnuw+v3tvR80V/NtJ8xM0haiM6oAA+jA09ViYG7t5pvPcoJb0ZRpxWTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775342227; c=relaxed/simple;
	bh=IbKWs0FRRSyvt8BvPbylLQ7uiD2KK/uG0ITeQhiLXWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzNxJar3/jLI4UjIpWX389UZhenk+y0wvkY7DXpu2zITXrC71/mRFdxKYIGFsX9uxyqRcDh/VuK7FdTXpg1bLo8nM8cRvTg3WKPFO28LSYsl5Hjt29YJcIexq1WGTjEoYpOsceZbDga+1BFM40M41oNBZIrVSZvapftcwEMszkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRNmZDeL; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488a29e6110so8578695e9.3
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 15:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775342224; x=1775947024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fY6Ig6Y0dfBXw64AbBiE+YxKcmOZephZVFw4+gdj224=;
        b=gRNmZDeLfIhktVKhAsVZhImq3bViFB7J3xtBC4/W9I3TUxsumGdKIHOEc+j22EbGnD
         v1loXf2iyDV2rD1t/HXZDRaQO1l4bfmlXsfwCo6YJZ9Tfv4RXPW1u6a/i5Eo3sIs906q
         jICmj1jpR+omHzwI5vMvXo6M93vaRGNLxw1Z1jWbpv7Ssx2mUDDa5HcAcbYppwS7z7V4
         iDjO6oHVnsjYEIKmvCkJohQDHO022fbSkYdQike4lYmqOHnNlLBv84P9VF9cHkBReXoL
         sBMRRrfGMYVbRlCvP6a0Nshi4echXN70KEOcbpZbD2CvCilT2nvR4eQrEXAWYRgKPj+O
         +dhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775342224; x=1775947024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fY6Ig6Y0dfBXw64AbBiE+YxKcmOZephZVFw4+gdj224=;
        b=piBjmajE9HQSaDHUKmZX8yI5+0Yoq/5IY85Afu+azHAyuInJV+v8hitZPEAGHwgGjr
         bNOD8X4IS/l1Z2W4J53VkW54hdNQp3FOvnLGcfWZd6CD28D1DH+geB6zoVWAU5ZhgplT
         gUGs2fR4jIRQI/cs/6FxxPTqcSpRJVmVWhwFTWVfOiDT+aVhofK4mUEqyW3IIi8quekK
         jxh6/5v3hfGm0r5GaR+H5HVLXnZaUWsGhvpGaWwi0IdPaU4FTjb9hGVIgunlpLo/Z3LR
         od5uM5FLJR0zGI1RlIZr9MyMxSVGe4HxvQlpVz5Hb+wGe+bHZPpNWfR6s+P2ztqPNuVQ
         dMNw==
X-Forwarded-Encrypted: i=1; AJvYcCXBEeelwNIuFiavLhnaiCaWuDmnQtL7i5vn71WXjoJOvS93o8lcAR8m3ezBwOGiNX7pjFsI5ng=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnr8LAgtgAC7oQ1HEsiR+HQ1GZB4xDXs5rgwNZZvqOl1HoMzO9
	z6V/J7cP++/S0kFgIaVqVic89Yxg7Y3pMwqhlJuSaXhumwMnLaW12jyq
X-Gm-Gg: AeBDievbLlPBr6pniYA/fgt7e+j6xhWuSgfYR5J67o0N7zgyO5iu5fbP/oedQtJH3+0
	kxa1jdbLnsWH3blD5W7WyliXvhcvltT7YvOgNNh+xoaJL+GMYWkGAorc3tEXglg8oeBNwUmv3fi
	vBjJsfaxsEwzZtORAlx5hN7CTK4h/2ms0YQx1FRx9EPzXdvYqJEihk3nOQ2d/0oOPWWEGlH3Kje
	4uH4RNl2IXqjd8YcYm4WlDJcL13yyP5QzOsVa675YMFlPaCcGF3Aj98qbrFGyRYiO7LwKecgybj
	A3jfTDQXK/YGfAWyMhxukyzINABFkinRFPdJ55n250x6MTqs5PMu8H4mE9yn7oy777ZMsRLSVrm
	smfhy70aLvr4L/TAHL4YqBEFjo2AMFCCmrxPP6pNkqCYxAdt2gFlatEqc2DOLgS9vUwUggetspi
	9dxEBI9Z6RWHLPk+5dTD/xLsXHicQ=
X-Received: by 2002:a05:600c:4593:b0:485:3b00:f93b with SMTP id 5b1f17b1804b1-488997e7b16mr126655695e9.31.1775342223961;
        Sat, 04 Apr 2026 15:37:03 -0700 (PDT)
Received: from google.com ([37.228.206.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a72baa8sm232711105e9.15.2026.04.04.15.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 15:37:03 -0700 (PDT)
Date: Sat, 4 Apr 2026 23:37:01 +0100
From: Fabio Baltieri <fabio.baltieri@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] r8169: implement get_module functions for
 rtl8127atf
Message-ID: <adGSjRScv9tcYRoU@google.com>
References: <20260404201333.2849-1-fabio.baltieri@gmail.com>
 <4f8310c2-07be-452a-84fa-0ec87d985651@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f8310c2-07be-452a-84fa-0ec87d985651@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275411-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fabiobaltieri@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41C5339CC47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 04, 2026 at 11:55:25PM +0200, Heiner Kallweit wrote:
> On 04.04.2026 22:13, Fabio Baltieri wrote:
> > Implement get_module_info and get_module_eeprom for supported devices,
> > right now that's the rtl8127atf.
> > 
> > This enables using ethtool to retrieve the transceiver identification
> > and diagnostic data.
> > 
> > Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>
> > ---
> > 
> > Hi,
> > 
> > Realtek released a new out of tree driver for the rtl8127 and it
> > includes some code that exposes the I2C controller connected to the SFP
> > port.
> > 
> > This patch implements get_module_info and get_module_eeprom based on the
> > information found on that driver, it allows ethtool to fetch the SFP
> > module information, which is useful both to identify the module and to
> > track the health of fiber optic transceivers.
> > 
> > The logic for the SFF standard and i2c address selection is borrowed
> > directly from the aquantia/atlantic driver, I don't have a lot of stuff
> > to test it but I was able to trigger all code paths from a fiber optic
> > transceiver and an SFP cable I have available.
> > 
> 
> Hi Fabio, thanks for the patch. Being able to access the SFP I2C bus is an
> important step towards future phylink/SFP support.
> 
> @Russell/@Andrew
> I'm not really familiar with the phylink and sfp code. And I would like to have
> the functionality being implemented here reusable once we do further steps
> towards phylink support in r8169. So how shall the code be modeled, which
> components are needed?
> - Shall the SFP I2C bus be modeled as a struct i2c_adapter?
> - Shall we (partially?) implement a struct sfp, so that functions like
>   sfp_module_eeprom() can be used (implicitly)?

Yeah happy to hear any input on it, the controller actually seems to be
a designware IP and there is some reusable code for it but what I've
seen done for other drivers for this functionality is to implement a
minimum i2c "read bulk" functionality in the driver itself, so that's
what I proposed here too, the code is fairly simple after all. However I
did borrow some logic much verbatim from the atlantis driver as I
mentioned, happy to hear if there's a path to reuse.

> 
> I assume this patch includes logic which duplicates what is available in
> phylink/sfp already. I'd a appreciate any hints you can provide.
> 
> Thanks, Heiner

