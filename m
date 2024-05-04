Return-Path: <netdev+bounces-93418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DB18BBA26
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 10:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A6F283118
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 08:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AE6125DE;
	Sat,  4 May 2024 08:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMEWKLz2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962BBF4E7;
	Sat,  4 May 2024 08:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714812576; cv=none; b=mefMYNqPqMHXWxX+bM9SMiXhCBVrNjkN9qK2U0bQUg2WhiwaZtZX7+8v3016rY5y/d1+pz2yElQ9H6CRMnXScp29dZCmxcAoR5C8BIcL6gMzhCKwA3V45uV7kRFbp/ULjtcPXXOVf4NwWtx3WUPgZGYWYzF849mUMgXI5tl4Cec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714812576; c=relaxed/simple;
	bh=0gJFi+kIDeGMpOWnhH/p/VLDwq/nOlBo/W46WN3ey2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/Sz2IkpB+c6CpptULI1RsyKoyeci+SHm2NkkjABuo8nqQD9u7cOynnqxSzjQCu6ETgv08UUgVAF6SSoD71dorbsKwzvPRMIn1LYy9eMQfHUobDQvyV9WUl/AoxHlcR3lQz18SAs5I0J3gxG3zPZ1CnXxY8hGYM5wyLozpmH0V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMEWKLz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE5BC072AA;
	Sat,  4 May 2024 08:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714812576;
	bh=0gJFi+kIDeGMpOWnhH/p/VLDwq/nOlBo/W46WN3ey2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tMEWKLz2fYRGkpBEDAoxXAy/2t+FgUK5mr2FUtsTW0saOxl77nprEO9qZeUTdTbwm
	 1b0hSwkqdaulpByawb7e9cmgEB+cmxnLnI1Ti4XPJlR6ccyLHRow5Gc284TZGdhhx9
	 qYpI7T4K7h1FBTVEl5Lf/S0lrzBZVlSzDKKbwK0ATAetxbnJKnVRmPNerV4zuISM1+
	 pAZs+yoM/sIlEfhaKfgkLeeUfYqD5viqn49SyusS7wAvSqYHcrmFlXK/PoBb3tAXVv
	 rTe6HV5Dji/g0PAqQOoc7bENSDpmNzvG/O3iGOq/OjMH2b5GWy8NtTfxkakhPKCV2/
	 O4xrgOxNxtF2Q==
Date: Sat, 4 May 2024 09:49:31 +0100
From: Simon Horman <horms@kernel.org>
To: Rengarajan S <rengarajan.s@microchip.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] lan78xx: Enable 125 MHz CLK and Auto Speed
 configuration for LAN7801 if NO EEPROM is detected
Message-ID: <20240504084931.GA3167983@kernel.org>
References: <20240502045503.36298-1-rengarajan.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502045503.36298-1-rengarajan.s@microchip.com>

On Thu, May 02, 2024 at 10:25:03AM +0530, Rengarajan S wrote:
> The 125MHz and 25MHz clock configurations are done in the initialization
> regardless of EEPROM (125MHz is needed for RGMII 1000Mbps operation). After
> a lite reset (lan78xx_reset), these contents go back to defaults(all 0, so
> no 125MHz or 25MHz clock and no ASD/ADD). Also, after the lite reset, the
> LAN7800 enables the ASD/ADD in the absence of EEPROM. There is no such
> check for LAN7801.
> 
> Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>

Hi Rengarajan,

This patch seems address two issues.
So I think it would be best to split it into two patches.

Also, are these problems bugs - do they have adverse effect visible by
users? If so perhaps they should be targeted at 'net' rather than
'net-next', and an appropriate Fixes tag should appear just above
the Signed-off-by line (no blank line in between).

...

-- 
pw-bot: under-review

