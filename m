Return-Path: <netdev+bounces-182677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A622BA89A38
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFBE47AC1C5
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 10:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC39E28BAB9;
	Tue, 15 Apr 2025 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDdh1x2G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7608827FD68;
	Tue, 15 Apr 2025 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744712938; cv=none; b=OAMUdiLxRXqVJNp/nbs6TTMBy5VfrALDlKhNCJkUqXq9SV+6RAnOd7PjkXXA9ClCBD3jloqPCe4/CyDLasKUR0L8BxlLFt06sP/8ZemRkIMGairmLiQAdgLjOC0oGPWJCc7Qf+INrjb3J7D2mZ/1vCWjiZ0fPicJoicTDn9JBSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744712938; c=relaxed/simple;
	bh=TFPyhgsGRDnosn84OnM/M4JJ7OjbBdk0kl0ET0hNwlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIMyV6xH+8tX7hc983Gd+bhj7U6HUFruy6CtRKql059yKJR89W05AiQiTMuuWeszR6O9a/XARv1W6Ed60NDYrOpa1Yaz9X2FTvxhAo3mWxJZjtVgJLOQY+KIa7umhlwkjYrFY0iUa43ntBnRFwyxUDQkC3zk47RtnL9IiP0N8QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDdh1x2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60F5C4CEDD;
	Tue, 15 Apr 2025 10:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744712937;
	bh=TFPyhgsGRDnosn84OnM/M4JJ7OjbBdk0kl0ET0hNwlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QDdh1x2GaXZcRWhfFUJgobXVRR91PkRv0JBrfzGNzef3yJQXWgy2Ku7hsv8Tvz3JQ
	 dyB7GPPHuoy/ApxSZNNrBwpzYRVkUqJ0HWeiQBhfK01KtjYNG0JaoyhbJyHX0FTgp+
	 uUxiBOEGoIUg+rdZZ68zHDNeVcERNyTOU0mfjSZrLMSzHD12dVlWY0+D6l6Hk9on0V
	 qp4Po1G2TiUIozZUzy9xVYhClMNbkLl6QM9lpdemwio2UOxzPb3WUhzcaUhb/DMYSj
	 qxY84kVjtoR7wm82cCcYSBYvxPvlROPsWgnLAaU4ZHm0ErpaZTG9oA9cyhGb4hhB9p
	 yAAPjt9a7ovFw==
Date: Tue, 15 Apr 2025 11:28:51 +0100
From: Lee Jones <lee@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Michal Schmidt <mschmidt@redhat.com>, Ivan Vecera <ivecera@redhat.com>,
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
Message-ID: <20250415102851.GW372032@google.com>
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250411072616.GU372032@google.com>
 <CADEbmW1XBDT39Cs5WcAP_GHJ+4_CTdgFA4yoyiTTnJfC7M2YVQ@mail.gmail.com>
 <20250411155816.GA3300495-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250411155816.GA3300495-robh@kernel.org>

On Fri, 11 Apr 2025, Rob Herring wrote:

> On Fri, Apr 11, 2025 at 04:27:08PM +0200, Michal Schmidt wrote:
> > On Fri, Apr 11, 2025 at 9:26 AM Lee Jones <lee@kernel.org> wrote:
> > > On Wed, 09 Apr 2025, Ivan Vecera wrote:
> > > > Add support for Microchip Azurite DPLL/PTP/SyncE chip family that
> > > > provides DPLL and PTP functionality. This series bring first part
> > > > that adds the common MFD driver that provides an access to the bus
> > > > that can be either I2C or SPI.
> > > > [...]
> > >
> > > Not only are all of the added abstractions and ugly MACROs hard to read
> > > and troublesome to maintain, they're also completely unnecessary at this
> > > (driver) level.  Nicely authored, easy to read / maintain code wins over
> > > clever code 95% of the time.
> > 
> > Hello Lee,
> > 
> > IMHO defining the registers with the ZL3073X_REG*_DEF macros is both
> > clever and easy to read / maintain. On one line I can see the register
> > name, size and address. For the indexed registers also their count and
> > the stride. It's almost like looking at a datasheet. And the
> > type-checking for accessing the registers using the correct size is
> > nice. I even liked the paranoid WARN_ON for checking the index
> > overflows.
> 
> If this is much better, define (and upstream) something for everyone to 
> use rather than a one-off in some driver. It doesn't matter how great it 
> is if it is different from everyone else. The last thing I want to do is 
> figure out how register accesses work when looking at an unfamilar 
> driver.

Exactly right.  The issue isn't that defining register accesses using
MACROs is a bad idea generally.  I've seen it done before in downstream
BSPs and the like.  It's that this solution isn't following the
conventions already in carved for such things in the Mainline kernel.
To engineers already used to the current conventions, this is much
harder to follow and interact with.

As Rob says, if this is truly better, discuss the idea with a much
wider audience and have it applied broadly across all areas.  We shall
not be bucking the trend or trend setting here in MFD.

-- 
Lee Jones [李琼斯]

