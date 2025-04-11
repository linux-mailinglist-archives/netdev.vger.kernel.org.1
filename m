Return-Path: <netdev+bounces-181690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBAAA8628B
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 17:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050428A58C5
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 15:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98CE21ADC7;
	Fri, 11 Apr 2025 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIfTOfxv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A2C219A6B;
	Fri, 11 Apr 2025 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744387098; cv=none; b=niemOvWViFdPwNb0V+Rfiiv+wObPI3d9vhJrL4taqL5+P6RNzuD7RriAxlr8baC4flNHLbhiX3rvyRb8Xt1RZU6UmWXxWlhrG9XlyphyKDGIrM+ruvgexYaj7iFLvSx6wZeUyuMqvtMJ5zTL0cVPvomodEZ0q12nO2najsATDTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744387098; c=relaxed/simple;
	bh=OhOHmS6oEpl2rCpCbTcrVIGxyXbOWYR16l3MT2Mp0Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtlskoTe201ziX1Ukd1fM9YItdkDseY01mY/uU5HY6X74LOQRNDWf2UQJ50ysmRBPBjwpnVHSz8SAYb/dGklVvhGPFMPlcaN6KaFDyc099aqZKiIRI1Wj9imPhirOGN3vtwQfqtE98ilOTJBm53AeSdLXXRSPoZ5CatOZxYKGhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIfTOfxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41D9C4CEE2;
	Fri, 11 Apr 2025 15:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744387098;
	bh=OhOHmS6oEpl2rCpCbTcrVIGxyXbOWYR16l3MT2Mp0Bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MIfTOfxvt6QZ5jsaMnHOu2eOmn+ZqPBEOHoN2qNiYv4PW003U2EsKw8qlDT8GTfiN
	 SKX89snH9AmjI8H6EO2RqSlC4Kha5LvQwP7PkCoYnhYlli9Ecj369vWptN7ChI0pRl
	 CCmv7AWbCAu1PXRciiIo9OINGB04DLWIJRvNLXNzGVsPQcQAHCLGmbga7+qfih8EAu
	 OSDpeGf7GqvPc6SBz6w12MbhTZUL3d/zynNdwPkteCsQ93dyVlPF9w+6Eeux8tYscp
	 LjjmfPr0LNsSb0fTfRm6+OvmaIh10z7q7xGwW64E5RefN4JO3isPMap+R5Tap87M6A
	 sXXk+2xzta3lA==
Date: Fri, 11 Apr 2025 10:58:16 -0500
From: Rob Herring <robh@kernel.org>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: Lee Jones <lee@kernel.org>, Ivan Vecera <ivecera@redhat.com>,
	netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 00/14] Add Microchip ZL3073x support (part 1)
Message-ID: <20250411155816.GA3300495-robh@kernel.org>
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250411072616.GU372032@google.com>
 <CADEbmW1XBDT39Cs5WcAP_GHJ+4_CTdgFA4yoyiTTnJfC7M2YVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADEbmW1XBDT39Cs5WcAP_GHJ+4_CTdgFA4yoyiTTnJfC7M2YVQ@mail.gmail.com>

On Fri, Apr 11, 2025 at 04:27:08PM +0200, Michal Schmidt wrote:
> On Fri, Apr 11, 2025 at 9:26 AM Lee Jones <lee@kernel.org> wrote:
> > On Wed, 09 Apr 2025, Ivan Vecera wrote:
> > > Add support for Microchip Azurite DPLL/PTP/SyncE chip family that
> > > provides DPLL and PTP functionality. This series bring first part
> > > that adds the common MFD driver that provides an access to the bus
> > > that can be either I2C or SPI.
> > > [...]
> >
> > Not only are all of the added abstractions and ugly MACROs hard to read
> > and troublesome to maintain, they're also completely unnecessary at this
> > (driver) level.  Nicely authored, easy to read / maintain code wins over
> > clever code 95% of the time.
> 
> Hello Lee,
> 
> IMHO defining the registers with the ZL3073X_REG*_DEF macros is both
> clever and easy to read / maintain. On one line I can see the register
> name, size and address. For the indexed registers also their count and
> the stride. It's almost like looking at a datasheet. And the
> type-checking for accessing the registers using the correct size is
> nice. I even liked the paranoid WARN_ON for checking the index
> overflows.

If this is much better, define (and upstream) something for everyone to 
use rather than a one-off in some driver. It doesn't matter how great it 
is if it is different from everyone else. The last thing I want to do is 
figure out how register accesses work when looking at an unfamilar 
driver.

> The weak point is the non-obvious usage in call sites. Seeing:
>   rc = zl3073x_read_id(zldev, &id);
> can be confusing. One will not find the function with cscope or grep.

Exactly.

> Nothing immediately suggests that there's macro magic behind it.
> What if usage had to be just slightly more explicit?:
>   rc = ZL3073X_READ(id, zldev, &id);
> 
> I could immediately see that ZL3073X_READ is a macro. Its definition
> would be near the definitions of the ZL3073X_REG*_DEF macros, so I
> could correctly guess these things are related.
> The 1st argument of the ZL3073X_READ macro is the register name.
> (There would be a ZL3073X_READ_IDX with one more argument for indexed
> registers.)
> In vim, having the cursor on the 1st argument (id) and pressing gD
> takes me to the corresponding ZL3073X_REG16_DEF line.
> 
> Would it still be too ugly in your view?

If you have opinions on how register accesses should look, how to do 
them in rust is being defined now.

Rob

