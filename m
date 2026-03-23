Return-Path: <netdev+bounces-270748-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6L5NKXuzwWnlUgQAu9opvQ
	(envelope-from <netdev+bounces-270748-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:41:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A552FDDD0
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6580302BDE8
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67D937F8A6;
	Mon, 23 Mar 2026 21:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeNeGaUF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA57372ECA
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774301981; cv=none; b=ITMtRBs5xMl3jz0FmVrKkW6EyGrlHSr4Ufih7JfxKJ9Z8qDlo1gnF3lTdxTABYQ8N0yAu2y3DNyXzncHJr6t8v+TpPbkv2kLTRC5CikjyCoCl2ULfm1KpIUYOo2r9xeEY09zDA5vh69tHMX2rHyaLnwIqhNlYAcc9+HaLSK0SAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774301981; c=relaxed/simple;
	bh=4+vcXD+1P3FXjL2Owm4YaNBB0CpFOHixgkjfmiDa1M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6qNIfPuRVyB8mAr+hy8MCqFU3rjF3SNQZN94IAosHLAy14OH2vB49IEev8uFRYWhONJRa47MN+wjIfeGZl4WzgqQQOrX+Fr9QBUPILoTue9AEycgIgzgXQ4DfodZ12J0txr58+Ygq7t4BIoBbE0fUcCM6YCpjh3wC/nIykEtrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AeNeGaUF; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2c0f754e756so767840eec.1
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 14:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774301979; x=1774906779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yGHdDoGsiDtOdNrXq7SHzA/I1zh7boK5LF3ZF/OlV0U=;
        b=AeNeGaUFszrAZvUITkXt+7jwmEyvbJP7L5B0IEN/cIaMLG/q2bDeugKMm94lpxWzJU
         76V4lZmGn/sGj3IzxII/0CasDRfOtuEAhcRUrbWjtT3GoriS2yeejerlXaViFZmvDipR
         5KLUp5XGEvBEpdiNjU7v59yq9EPgYnByC5/FnpkmSNU3vnuk3iC1g26p/W+U1gLrmsh7
         hOlTuPsHhb4kW12/ibKRjgusWntF01dxbjmDE6RDAsB2z8K/rlHJdj4wvpM0K+BQtn5W
         VB9PMmm2b5K8dVBM78T/Lo9er9li/jc37aPPElbxi3KAGtX0dJTDyyM8cKjOoLC3SX9G
         I7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774301979; x=1774906779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGHdDoGsiDtOdNrXq7SHzA/I1zh7boK5LF3ZF/OlV0U=;
        b=o1YRw0SnqhsEsSql+csGmoaOmphSqct12pyUyXrJsJILS8qOrm3feFxqje3+sdDQ2+
         WbTb4N+SEUPGPZ8fz/U3z+tBCsc8zb4JnX3ZGjHlJnh3z7deEiILAZwEFyh8CH1Ge5Q/
         9X1SW1fwEBCY0km14mOJ+C7oGDb2ZFs2+AkXGR5U2cwW51Ba0y63WceQH7+rf9zriTHq
         7yGGf1qfqcdJMADv+Pe63jTQfwzhfnyIcSWpY/KteWOXfLkzEUxZcoxjHURY1kfOGgUV
         iY+5pnToZDiSn5AeDIZZ91+dQHR6PjnZiSB9/5MsuRmqfBrDIO4JPFnTcrk4WDhoRbjp
         ef/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVX929BY2q+N6cmpD/7r74+THeKRRq3SbrHorKkK96htCS0zNxTQzGc/6LAJa9iz9SgrEOZgRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRSLfVirzd++WAYV6WFzcEymz77Z+48TLT3SHRWSLhVkaPTQEY
	PsHkG//TFz3U6GamesI5ZTgYSfx1eu1s3m9E+Cdw/YdYjiUtKmdFUKxV
X-Gm-Gg: ATEYQzzRgqREyhQZAyVpTilRVD4b+guJivif2kA/xNHpXOkwCdyK4yED9JJORGP78mS
	tHBwUpf1RVC12uz2Dn8aff8ohbnsMjIAYOBFlYOFNOVbJWVDtzE9cshp+Q3gpRz4UNyjSLCXAl+
	H1mol8hIgVUfBogfp4cnkK8k+7xuoF0Hel2ceylbvDUeK8BBNb/F6vOxbhGJvZU8cHL6CLrEEuB
	mlU5hZi9U79djOkdqgIwSHxiAFsFV7ovvj7JFTq8O+95Y59u3iyoitfYJ192xYOgNLSGgegnCoC
	frJoOvRZaktWO2R2d+BDHqY/W6k2Ipr9o8LXis+PTOoNBU56thaKO7oNyy+Zd4JScZO/CLnmkif
	7TCSYwksik0k3pERnJtzu3UK05lKodiftCjH5QxYnmzi4NbOe+ZmdJqCEGjs1WHxbM9Zf2vlLjh
	DJZNdhnMjMyVQof1m3+8v+oZpPk/r15pSBx5t7XdyrJ10NU5P7JzfgLfFVXVjloydA
X-Received: by 2002:a05:7300:dc94:b0:2ba:6819:2e9b with SMTP id 5a478bee46e88-2c1095a5302mr6126697eec.3.1774301979400;
        Mon, 23 Mar 2026 14:39:39 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a296:1211:5ab0:bc95])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2d01f7sm13145631eec.23.2026.03.23.14.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 14:39:38 -0700 (PDT)
Date: Mon, 23 Mar 2026 14:39:35 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-spi@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-fpga@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH 04/10] regulator: of: switch to using
 class_find_device_by_fwnode()
Message-ID: <acGxgkWiPLy8XePz@google.com>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
 <20260322-remove-device-find-by-of-node-v1-4-b72eb22a1215@gmail.com>
 <360a8b4a-6507-417a-9fc1-c53b14868657@sirena.org.uk>
 <acGFksyx3SA0kJ5b@google.com>
 <7d46803e-b285-4e9c-8856-10100fa0ea85@sirena.org.uk>
 <acGWJf1AGXT1xduM@google.com>
 <55abcc68-747a-468a-abdf-b6340d658c4f@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55abcc68-747a-468a-abdf-b6340d658c4f@sirena.org.uk>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270748-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linaro.org,gmail.com,axentia.se,armlinux.org.uk,intel.com,linuxfoundation.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 27A552FDDD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 07:58:14PM +0000, Mark Brown wrote:
> On Mon, Mar 23, 2026 at 12:41:59PM -0700, Dmitry Torokhov wrote:
> > On Mon, Mar 23, 2026 at 07:05:13PM +0000, Mark Brown wrote:
> 
> > > I think this is a worrying idea for core code like this, we have
> > > specific firmware bindings for specific firmware interfaces with the
> > > different interfaces having very different ideas of how things should be
> > > modelled.  The chances that firmware agnostic code is going to do the
> > > right thing seem low, and encouraging the use of generic APIs that might
> > > happen to run OK raises the risk that we'll get firmware vendors relying
> > > on them and leaving us with a conceptual mishmash to sort through.
> 
> > Firmware vendors can introduce incompatible DT bindings and have them in
> > their devices too and we have to deal with that... 
> 
> The case that's worrying me is mixing the ACPI and DT design models in
> one system, and especially having that happen to actually work without
> modification purely by luck rather than by design.
> 
> > I think if this pushes closer ACPI and OF schemas for at least some
> > subsystems closer to each other it would not be a bad thing.
> 
> I think we shouldn't be encouraging people to just throw random stuff at
> the wall and see if it happens to run OK with whatever OS they tried
> booting.  The differences between ACPI and DT in areas like the
> regulator bindings are fundamental conceptual ones.  There's some areas
> where things are closer and it winds up being fine actually, especially
> for leaf devices, but there's others where that's less likely.

Maybe we should just have explicit checks with nice comments at the
beginning of the schema parsing stating that this schema is
intentionally restricted to OF (or ACPI) in cases where we ave distinct
schemas? This way it is explicit that it is a thought out decision and
not simply a legacy artefact.

I think we want to hanel software nodes because they do not
form their own schemas, they follow the existing ones (DT usually).

-- 
Dmitry

