Return-Path: <netdev+bounces-275418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPyqK0yZ0WnILgcAu9opvQ
	(envelope-from <netdev+bounces-275418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 01:05:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B17339CD31
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 01:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD2203006793
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 23:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E583D35CB6F;
	Sat,  4 Apr 2026 23:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwFqL5MR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4553291C10
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 23:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775343940; cv=none; b=rrbekznob7Oqt+pg3CcE56Ap+uIi/xJ4t20GVD5ebOnJt05BrfzKs74S4u4Y82hFCS7mPylo6Lxen/h6Hf71sxXZ+PRomOR8TEZHBtXeZ0poRMzJ2o7U35VAPcPQGVuRQ5nNSYLuTJX9pvI27FgJ3YILiW82dMABxQjzupet628=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775343940; c=relaxed/simple;
	bh=OoE8Ic+95ti+1XKFSwr9PL5oGZ5/GrvMDw7LNSI0sCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEuYDy2Zg+VCXAhGsEcAnBdl1coFRko+3Zw/AvJCJMpaFtWY0ykLdR7e6z3C6yrYPBOUbCWsUsHvdYYQ/MvD4jXsBUd5674M/GMHuINmKoxDexTM3VZ9/dqRcbxnZAltr3TeZjBatYAZOWzHXlUtDJHGkDSFHFdZwU7HjbHq3nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwFqL5MR; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-604f1bfecf1so1999756137.3
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 16:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775343938; x=1775948738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KnWvq+ekRwXyxh93OD6cFf9y027NFZpXtafpwpiBOP4=;
        b=JwFqL5MR8ugJYJM3W5AehqLxIW9JpkRwPYCBldWRWGoqy2ePGcBLSVVc8LqCARzfL+
         SfRYPnH2tLp/RB/KnDNOlw57aHWJ4ElJnQ+BezdO5XeBDCOp/LNp4sE/smAGTqYO9cT+
         6tdJ7ZKVzHuEvk+3fEo5RATZ5WbUQ5cN0trEMgg5wS4lFt5Qngi+p3nCdouBXhuA6QkP
         NV9W53pdm4TBa6bpU3y4OxMofUc4kXxpRJBPIoDiZOp41OMddeAHMqfwzFYMj7VB6v/G
         rCkgCpYi3+yVBDmUlVexY57LjKIxaiPfl8Os9aj0FnodZmK/190N0tI1beejYsZAdbgh
         JQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775343938; x=1775948738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KnWvq+ekRwXyxh93OD6cFf9y027NFZpXtafpwpiBOP4=;
        b=Zaca55NnIUxLBcyV3bpq/zvzW2X3mbN8RXToHUswM+YTWk6zFaBIksP1wwL2cIyY0W
         xDgNzHJkXT//jszjbOSrX5iu2bz6L8/HeG0bM9sd5asNgR3cLaMbdsG5QHipwqPyitxa
         ltWedXy053YAZDjkvklQENtKNmY9ZesumYeWPECFu10gjZrZQ3Trb9wJMZe3tNPLBvFf
         /eixp+hcw5USPWhrIOn+Vj/ILOX7KpgrtGx7d1L4aaGJohzMDVLSpoJopw4Q6eHDNZ00
         sq4bJHhh2CPOVTAF8y/bi2Ek0Jxa/0Cohf8H3zaXgpD4kcgGuK9T8fz4lY0iFJdHWqK+
         V3HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEpwU4H2AjF7ft+wdw61oH6m1IzXRZlA5QQR4q0Kt4I60h192S0Ag6+opCp7ITKq1ya0ZayCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY0DVpMorU4fLm3I7zQrAixz8cTAS/qHyhOFwliQZnDK5I7WzW
	y+El0RRh5tUzSKePLlEpByQtO4udIqFxwgFRyxS25MFPVqQHOVMX1mkB
X-Gm-Gg: AeBDietYYbKoqcmthGWbA9bgWqeQjo5O2LkNwEIh57EgAlIEaUY+PbWkLlDVC50w0Xm
	rY0O2yUZpuZFRvHmn/UG3e0kYPRiAXGXOIN54VwMzGM5OR5sSu3W4PLbmgUkOF+pXzaUfDXGZR0
	KVr6Tu/ToY+OmtJ7eVShShs8v5snq0NRmFPHe+QHcoJ1x4yqZqH2Gh5rF7zy8UfiRkk4ZDl/yHf
	IF/Cb5K3WcIi4mlgIuUD2NvaZMnxs0Nf07qXaVXDLjmUJjOOSapkllqx+4Y8BjuQo9r/FNInnip
	iT9N0yrbIDuapbcLap/mpK8QhArz9rC3CIvcuiIVbd6c9+H39AEZ27bIoJAVEUhLFdwDMoBs6/u
	aEnKcr8wUEPFPuEP5Al6xdFkrOX1oaZ0ZIr9K9kgU5h1oh0D4tjWx9YGTNf3t+Uv3lffLV7fqOM
	gqEj6JANiHsnn0TOiYp5PGirt+Yiw=
X-Received: by 2002:a05:6102:6044:b0:605:38d2:26d4 with SMTP id ada2fe7eead31-605a50e32e4mr2632084137.25.1775343937583;
        Sat, 04 Apr 2026 16:05:37 -0700 (PDT)
Received: from google.com ([37.228.206.31])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-60583049c1esm12316939137.8.2026.04.04.16.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 16:05:37 -0700 (PDT)
Date: Sun, 5 Apr 2026 00:05:33 +0100
From: Fabio Baltieri <fabio.baltieri@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] r8169: implement get_module functions for
 rtl8127atf
Message-ID: <adGZPQUMVoRcQqWu@google.com>
References: <20260404201333.2849-1-fabio.baltieri@gmail.com>
 <4f8310c2-07be-452a-84fa-0ec87d985651@gmail.com>
 <368d3f30-b4af-4548-a4b9-f8e4e4f9a4cb@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <368d3f30-b4af-4548-a4b9-f8e4e4f9a4cb@lunn.ch>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-275418-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
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
X-Rspamd-Queue-Id: 5B17339CD31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 05, 2026 at 12:46:41AM +0200, Andrew Lunn wrote:
> On Sat, Apr 04, 2026 at 11:55:25PM +0200, Heiner Kallweit wrote:
> > On 04.04.2026 22:13, Fabio Baltieri wrote:
> > > Implement get_module_info and get_module_eeprom for supported devices,
> > > right now that's the rtl8127atf.
> > > 
> > > This enables using ethtool to retrieve the transceiver identification
> > > and diagnostic data.
> > > 
> > > Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>
> > > ---
> > > 
> > > Hi,
> > > 
> > > Realtek released a new out of tree driver for the rtl8127 and it
> > > includes some code that exposes the I2C controller connected to the SFP
> > > port.
> > > 
> > > This patch implements get_module_info and get_module_eeprom based on the
> > > information found on that driver, it allows ethtool to fetch the SFP
> > > module information, which is useful both to identify the module and to
> > > track the health of fiber optic transceivers.
> > > 
> > > The logic for the SFF standard and i2c address selection is borrowed
> > > directly from the aquantia/atlantic driver, I don't have a lot of stuff
> > > to test it but I was able to trigger all code paths from a fiber optic
> > > transceiver and an SFP cable I have available.
> > > 
> > 
> > Hi Fabio, thanks for the patch. Being able to access the SFP I2C bus is an
> > important step towards future phylink/SFP support.
> > 
> > @Russell/@Andrew
> > I'm not really familiar with the phylink and sfp code. And I would like to have
> > the functionality being implemented here reusable once we do further steps
> > towards phylink support in r8169. So how shall the code be modeled, which
> > components are needed?
> > - Shall the SFP I2C bus be modeled as a struct i2c_adapter?
> 
> Yes, that would be best. Call i2c_add_adapter() to add it to the I2C
> core. The SFP code in drivers/net/phy can then make use of it.
> 
> > - Shall we (partially?) implement a struct sfp, so that functions like
> >   sfp_module_eeprom() can be used (implicitly)?
> > 
> > I assume this patch includes logic which duplicates what is available in
> > phylink/sfp already. I'd a appreciate any hints you can provide.
> 
> No. phylink etc will end up populating netdev->sfp_bus, and then
> get_module_eeprom_by_page() should then just make the module work in
> ethtool.
> 
> The interesting bit if gluing it all together, without DT. But
> txgbe_phy.c should be something you can copy from.
> 
> Does the out of tree driver give access to GPIOs connected to the SFP
> cage pins? Ideally you want those as well, for loss of signal,
> transmitter disable, knowing when a module has been inserted into the
> cage, etc.

The current version does not seem to do that, maybe the Realtek folks
can chime in about it.

I'll look into the dw driver, thanks for the pointer.

> And you will need a PCS driver.
> 
> But first step is probably to work with the existing Base-T devices
> and convert the driver to phylink.

