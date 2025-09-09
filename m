Return-Path: <netdev+bounces-221474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74480B50950
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 01:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E0E0542398
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125CF288C34;
	Tue,  9 Sep 2025 23:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iw79tJQu"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1C5225A24
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 23:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757461125; cv=none; b=q4r7xWUugaaWlTN1F11QXaBgsJVWCEBmc5WXUnhrzGB0RDPba8BSbkjMcbUGNzkhRN5x9HWGEbyX6i72aDwifnf+xA98/iUKIkcHwZgjmPtnpqDUyFMnbzFrCVwwOBZ3wrdSHPbNSzEkdBLY4ChLpPjJTUiK248ARKbIn5mx0g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757461125; c=relaxed/simple;
	bh=tcn0xtfFgnvAM98VZcDnSZTREC2fBxDUrNjd1HrQD3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDmHnw6LKugqk06bsLB3kLl10wRYFmXTACLY7i5uWNmQeHn7gWiAYl2NxmnMIybJEAGUT59Y+34urTBTeMDP8u2rLJsR/1xKXffIl/OzwM2jWU9R783Qqso8dlmYaX6z9Y6auVAkVJlKj9vhqgnpnq2GevFkyLAuGDz7+RwavCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iw79tJQu; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5a21bf14-4984-4fc3-bced-4d82e73eb9ac@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757461120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m3Rof7cQDdL6u7z56AByVFz0inSeR55dGnQF9DWwsi4=;
	b=iw79tJQu827AxJCAPsEmrZuRzi73D0gdvFLKi5oO+Dj+n4d5tydOY9db9UDDeHzX7tGW9f
	BWUqCxHgTJyEPmdE1GvHmVzqIhNyHw80oJm/xPWlFn9CePsibIzMk88n9X6A1SSgscO1SC
	DJPtaEvdL9ea/7P4mKMfyP6mFcf+smQ=
Date: Wed, 10 Sep 2025 00:38:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 4/4] net: dsa: mv88e6xxx: remove unused support
 for PPS event capture
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>
References: <aMBLorDdDmIn1gDP@shell.armlinux.org.uk>
 <E1uw0Xp-00000004IOI-1i7v@rmk-PC.armlinux.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <E1uw0Xp-00000004IOI-1i7v@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 09/09/2025 16:46, Russell King (Oracle) wrote:
> mv88e6352_config_eventcap() is documented as handling both EXTTS and
> PPS capture modes, but nothing ever calls it for PPS capture. Remove
> the unused PPS capture mode support.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>   drivers/net/dsa/mv88e6xxx/ptp.c | 21 +++------------------
>   1 file changed, 3 insertions(+), 18 deletions(-)

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

> 
> @@ -188,20 +185,8 @@ static int mv88e6352_config_eventcap(struct mv88e6xxx_chip *chip, int event,
>   	if (err)
>   		return err;
>   
> -	if (event == PTP_CLOCK_PPS) {
> -		cap_config = MV88E6XXX_TAI_EVENT_STATUS_CAP_TRIG;

nit: with this change MV88E6XXX_TAI_EVENT_STATUS_CAP_TRIG becomes unused
macro.



