Return-Path: <netdev+bounces-184220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 618B8A93EC4
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 22:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905E08A4C23
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 20:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB16238C09;
	Fri, 18 Apr 2025 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="C4Hwted9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7424F2A1C9;
	Fri, 18 Apr 2025 20:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745007521; cv=none; b=Qt20eBUowZvegcdjvyu2Hg8qNWZNr+BGyKHbgdjI08eGkYqjwZqZtHM+m6DRQ/8QQVh/p/Tcm7kBv1CQZYCDikCy3qv07jL+o2zLFhM24RhiElPGx24RQHHrBrGG2cIzGhZr8EpOHAUalhrHrPUT6QY40GaHfDh+4KsnUi5bHvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745007521; c=relaxed/simple;
	bh=c8nxojaQOgQcyXY1gD2OR0f7FP2pwNRSCMcMPyqrfEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLYDa6Bf4zkBDCABDSa+mEKd4Oc+0kpiDr+TLt6Q0JtjLKeXsnJd8soiv9lRozAZvXyGMn7rGxS0iAW7lLMiIME0ZIoskpBSrUSKAjniH9L/bsQkKceKYWAHol3+dValmWTM09Ic3b1TzNCBTjiZJXfDr/6ATLm7bDwm+KLBAnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=C4Hwted9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QwFKe2ISZRDD95Kaksh0NVFyftzgKAb4kAfOTZyXfEY=; b=C4Hwted9QqiCwBlRns8C6ZEFw/
	tIIAU0L98GYbB6GCZr21h9IL/Qwu0SLqQSVk2ZQa8OcCU7ugu5bcerksfMNb19KVO8uHnw3ZWNkYd
	hQIWV2G3n0bwhnJJMoreBk8hlXEd9WJV8kE5H6WAjPg063RVGpDIU5JZYkEFuBQ2gI94=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u5sAI-009w9h-4G; Fri, 18 Apr 2025 22:18:22 +0200
Date: Fri, 18 Apr 2025 22:18:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 net-next 3/8] mfd: Add Microchip ZL3073x support
Message-ID: <5a360c39-405c-4108-9800-0f71307804a0@lunn.ch>
References: <20250416162144.670760-1-ivecera@redhat.com>
 <20250416162144.670760-4-ivecera@redhat.com>
 <8fc9856a-f2be-4e14-ac15-d2d42efa9d5d@lunn.ch>
 <CAAVpwAsw4-7n_iV=8aXp7=X82Mj7M-vGAc3f-fVbxxg0qgAQQA@mail.gmail.com>
 <894d4209-4933-49bf-ae4c-34d6a5b1c9f1@lunn.ch>
 <03afdbe9-8f55-4e87-bec4-a0e69b0e0d86@redhat.com>
 <eb4b9a30-0527-4fa0-b3eb-c886da31cc80@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb4b9a30-0527-4fa0-b3eb-c886da31cc80@redhat.com>

> > > Anyway, look around. How many other MFD, well actually, any sort of
> > > driver at all, have a bunch of low level helpers as inline functions
> > > in a header? You are aiming to write a plain boring driver which looks
> > > like every other driver in Linux....
> > 
> > Well, I took inline functions approach as this is safer than macro usage
> > and each register have own very simple implementation with type and
> > range control (in case of indexed registers).

Sorry, i was a bit ambiguous. Why inline? Why not just plain
functions. Are there lots of other drivers with a large number of
inline functions? No. inline functions are typically only used for
stubs when code is not being built due to CONFIG_ settings.

	Andrew

