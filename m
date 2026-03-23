Return-Path: <netdev+bounces-270665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BofB7aNwWlxTwQAu9opvQ
	(envelope-from <netdev+bounces-270665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:00:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 584632FBBED
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD3B3301C6A2
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573482DB7BE;
	Mon, 23 Mar 2026 18:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tIw+qtLG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067D12D8795
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774290823; cv=none; b=nWtvwtjHpJJ118THuwaIY5n/W2l28Fr1Y0jRp2EOGo4NSdsnGvsRFi97KVsSyGNfM0uKzIutOJ7LnRH96OvjlpA5UeLViysqXH16TD9WayQD0frTSbnGDQ3vw+nuqr13RBED80zyE/R5LZSroCKZZZAwubV7uz7fn2my+uAiI1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774290823; c=relaxed/simple;
	bh=6I3TCajsnbPhvopolFVK3KO9pDXc1m1XrVrTJSIDMJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0cgJQvf4tHniACjE1NBr12Gan6asOQI4undIAaBhU3393ItA4ErALk9bmOXwBZxKHs1blF7lpVzWeGkxwf0mkHQXWWVH8HfABc9X7re+RIc5EpTYW4Tf6rhShO9x7v0sDeNh30qPyI1j97LqSNq8CTcgnJWmgpZxDSJ332L27s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tIw+qtLG; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1271257ae53so538757c88.1
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 11:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774290821; x=1774895621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VnYjc2faOHjkbaG+X0+KOSaQNDxXMdAftkLY6+CZb5k=;
        b=tIw+qtLG94A2vyctJ1nrIkpgQyY6GdyXSxudWeaEhia18nDKP7H2BlmAo+bzO1ezIi
         SZroA2JPns9tsiLeMtLDEP0iBAiDMhPuwY94Ch9vwu5Nb7kzxQKSjlDb4Uno3JOQoPva
         3p2OdOAudQkBOZaHWSaWAPNRZn/OsnD3dJKCN14jNHAD4DaXu3hF0f2dE6vn9ewGTpKy
         D711seWX5f00wu6/sVlnQL1F3p+/WbV/GJbZo+cZEXwy8JMK+t8PCfvRA9LLH51zU9st
         LzGjDoaxrG7NJQ86D9iUasPVzjiFa5zJR7vWcUGVKZIzLnsmNHxMwJgLz8UkPqUu8jAo
         9G9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774290821; x=1774895621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VnYjc2faOHjkbaG+X0+KOSaQNDxXMdAftkLY6+CZb5k=;
        b=GHt6P7O322YQmZ6JfCIRHcndw5aihcKQGsrlSZIX7FRejzw67Mn2TQGs8ncG0u4aKb
         7GN9TS5FeT19KPrb/jl8TYIn0GeiFFaFcNhguR/h82mNp3WvLC+TqZcsR2VawONTS0Nu
         QQUzz0VDhO7thLwdNA7ibeAKirSVc3QepgtZdy/LuFdyO0EuGbG74pk7ebZQeZg1pSm2
         cfSGbD95ckb3RJCJch34Qp8T5V7sj9YuWt/WuBE8iYbXdWj8MNiM7OJ+7c2FbbaXrfyH
         D1veE9fguviPsoOUKYUULtIFKpGhVptKc10A1fRBdQOUAOQNo/JKOI5wPUuWa6rRXVT4
         7/6g==
X-Forwarded-Encrypted: i=1; AJvYcCXWj+Z3YmWRQbTAS5IagiDEO/vpUq0xV/VPbQ0Fxj06MCMQ3zXv6AXwtpAZX8B/WaCUTnLcxRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGY1qqPiZpySeOcdyXEMpn6VPG/8qrFyT32RV/vHA2rNNzlS3S
	yrtdogIZq6GGpitSCQGCW7Syv6OghxGUVRXywpCN5vwKV2u6CI2Q7IcI
X-Gm-Gg: ATEYQzwktC05Qg5DyDbZDK1R4ekpMmJOGikrNPg/inhEK1Lgx5pQmhxmqzVPbXIH+0f
	Qzffcc/e9xgB6FFVelQIEct0M/Jl7Q/abc4Ncx14UOHf8e3xOSWlbIDWGc2P33q5I7772+sF8Ud
	cY5XXB/gDQrIuqk2PXRqmfGO+XFd1kiDlo99FfG3vHyS6+2p9i/0mNc2YJTsZ8Q9oCNo+i2v0aB
	bONN8ecQej1vsvLABTTFhMxvI+BMtZxWe+l/teAb5/r+tdr8OQ6OCWaIex8y3q4eZBn56ZpDZDT
	xzYZ+7unnq/W6BrSm+3hZVJb29/qBn3LUFKCGSufOc5/5Xrp7gbdpBAartMyVpRk7T7116mGyX4
	Ym7B+0jbb4zPF1vLtZUlAmaH41mLucbVOeFSO6kSzWyqvrjlvd4XsTd98FwonONBzz3HrVEXAlW
	7QdqazRAm3y3+WK4yl1Ro34/hSogpNW6gMdR+KpGVyNzoHT/qQr6MXTtJ2k6FFZL8j
X-Received: by 2002:a05:7022:4199:b0:12a:6c7e:bef2 with SMTP id a92af1059eb24-12a72671ad6mr6133919c88.7.1774290821078;
        Mon, 23 Mar 2026 11:33:41 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a296:1211:5ab0:bc95])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a733d199asm9391030c88.4.2026.03.23.11.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:33:40 -0700 (PDT)
Date: Mon, 23 Mar 2026 11:33:36 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Mark Brown <broonie@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Peter Rosin <peda@axentia.se>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-spi@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-fpga@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH net-next 07/10] net: phy: switch to using
 class_find_device_by_fwnode()
Message-ID: <acGGWTmSMuc5h3Od@google.com>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
 <20260322-remove-device-find-by-of-node-v1-7-b72eb22a1215@gmail.com>
 <32679fc0-c388-4cd7-a030-5f5ed5abab78@lunn.ch>
 <acDLzK8vpptTUMf1@google.com>
 <acEBCBgMV3RrGKiU@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acEBCBgMV3RrGKiU@shell.armlinux.org.uk>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270665-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linaro.org,gmail.com,axentia.se,intel.com,linuxfoundation.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 584632FBBED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 08:59:52AM +0000, Russell King (Oracle) wrote:
> On Sun, Mar 22, 2026 at 10:17:15PM -0700, Dmitry Torokhov wrote:
> > On Mon, Mar 23, 2026 at 03:54:09AM +0100, Andrew Lunn wrote:
> > > > -	d = class_find_device_by_of_node(&mdio_bus_class, mdio_bus_np);
> > > > +	d = class_find_device_by_fwnode(&mdio_bus_class,
> > > > +					of_fwnode_handle(mdio_bus_np));
> > > 
> > > When you look at this, why is it better?
> > 
> > I think we should move as much as possible towards firmware-agnostic
> > APIs and use fwnode_handle instead of device_node or software_node or
> > ACPI companion. To discourage this I think we better remove
> > firmware-specific APIs where we have firmware-agnostic ones and
> > eventually clean up drivers that use OF- or ACPI-specific APIs.
> 
> Basically, no. This is wrong.
> 
> It may sound like a good goal, but there's an underlying issue. This
> goal assumes that the firmware description in OF and ACPI are
> indentical.

If they are different then drivers will make allowance for this, like
I2C core or SPI core does. But most of the modern drivers use
firmware-agnostic APIs (device_property_*()).

ACPI has allowance for device tree properties (via PRP0001 HID
entries), and drivers should work with them.

> 
> Sure, looking up devices by fwnode handle makes sense, but looking up
> anything that is described in firmware is not suitable for this kind
> of conversion, because in doing so, you effectively "port" the DT
> bindings to ACPI, and it may not be suitable for ACPI.
> 
> So, please don't make wholesale changes that transfer the DT bindings
> into ACPI.
> 

I am not "transferring" anything, but I want to make sure the code works
even if we augment OF with software nodes or if DT properties are used
in ACPI.

Thanks.

-- 
Dmitry

