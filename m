Return-Path: <netdev+bounces-90160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAC88ACE8D
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 15:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECFF8281742
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 13:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A766D14F9C5;
	Mon, 22 Apr 2024 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkxA/mBG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842BB5028B
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713793429; cv=none; b=E324D3r+gDC8xQBP3LMl+lMVydwXYHL+xmYsnwxPFddoYRQvcUoBGvskF1NYJpktEQf94DGdGTvd5/C5aHYe5LdgdpjZkW1c2XB+hDyVaRO5eiBHMFaR1a9HIwYLoWO1lj0nyh13y8eeG1T1g5ovts2spbNDUXt9O0J2hKRgvNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713793429; c=relaxed/simple;
	bh=VbX/CWak+f/znblvggqmEsaLUhXMK5f+MjExaZ91ujU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqcVnYmxZhBLXkLJcWx4wQ7HPL4nckOff9sPzDgqdasF9Sqlbeogw0nNSV1+iBt2r6dhP84uJKymzZi/4BWQ9k1e2ijB+Fgum4qPvpIAPeko6WHufsqTIVbh+mCkq0uNa2gvli1ZmHxVQhwfkwBpdiL//JsP/18boYvH5PKH4Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkxA/mBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7500BC113CC;
	Mon, 22 Apr 2024 13:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713793429;
	bh=VbX/CWak+f/znblvggqmEsaLUhXMK5f+MjExaZ91ujU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YkxA/mBGXx/vhG98dSobWf3z27+mSoWgtD+2lTr4zjDI8PZleqPgnNhIsL5j4hkck
	 he5Fw+p9Ce7wg5BfiqpyvZmOJfufYxYuFNapKlOAPqfsAKryVoIZePI/7zCVrz7nhd
	 vDu5MO73Rb3ea0g1d4jmyqQtiViXjReEZxOWUCN17xJnYa+PTCALDzCpaJj5hbPjya
	 f8SYJK0M4b6Bui5bHsFxYsZlDfw6hK9clRf1RG9YV8s9btX9A+317bXfb1Su9Rsy45
	 GqqMqMZ63O4Hlg8mOzmxpPYul0PkouL+xALGwQ3l54zASaa9G65WhbDxGYsLy/+dxK
	 ANoohquTcueOg==
Date: Mon, 22 Apr 2024 15:43:44 +0200
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Raju
 Lakkaraju <Raju.Lakkaraju@microchip.com>, Frank Wunderlich
 <frank-w@public-files.de>, Simon Horman <simon.horman@corigine.com>, Eric
 Woudstra <ericwouds@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next 2/2] net: sfp: enhance quirk for Fibrestore
 2.5G copper SFP module
Message-ID: <20240422154344.434df4ed@dellmb>
In-Reply-To: <4e07c66a-fd5d-4640-8a26-c64426aa3c7e@lunn.ch>
References: <20240422094435.25913-1-kabel@kernel.org>
	<20240422094435.25913-2-kabel@kernel.org>
	<4e07c66a-fd5d-4640-8a26-c64426aa3c7e@lunn.ch>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Apr 2024 15:12:55 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > The PHY inside the module is Realtek RTL8221B-VB-CG PHY, for which
> > the realtek driver we only recently gained support to set it up via
> > clause 45 accesses.  
> 
> This sentence does not parse very well.
> 
> The PHY inside the module is a Realtek RTL8221B-VB-CG. The realtek
> driver recently gained support to set it up via clause 45 accesses.
> 
> ???
> 
> 
>     Andrew
> 
> ---
> pw-bot: cr

Sorry about this, will send v2 :)

