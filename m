Return-Path: <netdev+bounces-97835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F4F8CD6DE
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 17:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A401C21A52
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 15:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E1D101CA;
	Thu, 23 May 2024 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b="AlnkmY12"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-in-1.gedalya.net (mail.gedalya.net [170.39.119.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD6E125AC
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 15:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.39.119.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716477477; cv=none; b=RSxVyMZLCEjrjWFLgrQW0VY8ltCurDOfIpJNLUMmSCJabMzGe3ZrgroxInWdz1u6g4hXyuCL2Zcxq2tUcKc9uLaITArWooCuqYvuXvXNz8D8eB5/zhV1rnCZOGgt+W2mssif4iUeacruasZk8jUYfq9Dva0OCqBVZiEPNYuaRUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716477477; c=relaxed/simple;
	bh=dw0GRxDMpwNNnRAXQSVKch6Bufz5DNxd7l8Af3GWA20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uy/oOThHCB8Y5mV2CVG8W0DBmAaa+bhCfXxJYCgYQBYsqkist2CeayND3xGVsBik9yTY1YeaNfBcm961mPsU5MnP+JyA+bVbxQaPR9VVlensqxOQy/eHRJ3Sjx4ujXcFS8QvigkQ6AnxtuYuwZbnjEUdA+6SJJiyAaki4AlYJSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net; spf=pass smtp.mailfrom=gedalya.net; dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b=AlnkmY12; arc=none smtp.client-ip=170.39.119.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gedalya.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gedalya.net
	; s=rsa1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description;
	bh=bEpX6LA+YlkrHvAzQ0I4cUTviWGDbs3dSlUJTOEl7Z4=; b=AlnkmY12r0hw/7O6XQ6bcbnBrZ
	PjXMsMueyEiZ2q4rz9SOcYYFJVHWhM1rD6/zU3biDPDjmZ7X6kET0cFcCl4iUkrY7Uj0AUK0DSkln
	bV66cXOm6wwwwZ65Ll7IcTTGcr5MvZt5C17ssLQLzOm8s1JJu+0a+wEE5gx1aR8fmfk+kP0MiarA3
	kvjrZRpHVAoDDa27gmIL9CJlEw+lHjfVNt2vICeJtBwBJ6etCMMlaVAmLby4TvyESvs+qB9WAeJEC
	Iy+J7X6iDafVvWnOYXPhW8gfhjzaiJi/sE4d42dVlkyQBhMjNOHNvt8UxZoqjcefjK9RSYZHsd2RC
	KAzTTR0A==;
Received: from [192.168.9.176]
	by smtp-in-1.gedalya.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gedalya@gedalya.net>)
	id 1sAACS-000gPz-1d;
	Thu, 23 May 2024 15:17:48 +0000
Message-ID: <8a1402f2-04bb-475f-a496-059470ce9bbd@gedalya.net>
Date: Thu, 23 May 2024 23:17:44 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iproute2: color output should assume dark background
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Dragan Simic <dsimic@manjaro.org>, Sirius <sirius@trudheim.com>,
 netdev@vger.kernel.org
References: <173e0ec8-583a-4d5a-931f-81d08e43fe2b@gedalya.net>
 <Zk7kiFLLcIM27bEi@photonic.trudheim.com>
 <96b17bae-47f7-4b2d-8874-7fb89ecc052a@gedalya.net>
 <Zk722SwDWVe35Ssu@photonic.trudheim.com>
 <e4695ecb95bbf76d8352378c1178624c@manjaro.org>
 <449db665-0285-4283-972f-1b6d5e6e71a1@gedalya.net>
 <7d67d9e72974472cc61dba6d8bdaf79a@manjaro.org>
 <1d0a0772-8b9a-48d6-a0f1-4b58abe62f5e@gedalya.net>
 <c6f8288c43666dc55a1b7de1b2eea56a@manjaro.org>
 <c535f22f-bdf6-446e-ba73-1df291a504f9@gedalya.net>
 <c41ee2a968d1b839b8b9c7a3571ad107@manjaro.org>
 <94d43b6d-74ae-4544-b443-32d8da044b75@gedalya.net>
 <20240523075904.16f3599b@hermes.local>
Content-Language: en-US
From: Gedalya <gedalya@gedalya.net>
In-Reply-To: <20240523075904.16f3599b@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/23/24 10:59 PM, Stephen Hemminger wrote:
> Fits perfect with "what color for the bike shed"

I'd love it if someone actually commented on my patch.

Currently, iproute2 does produce colored output when COLORFGBG is unset. 
If that remains unchanged:

         It selects a certain palette.

Does everyone here think that keeping the current selection best serves 
the majority of users?

It's a simple question.

It seems to me that it should revolve around a guesstimation of what 
background colors people are using. Or maybe I'm wrong.

No one is arguing here about what colors anyone _should_ be using. I 
also think it's misguided to regard an issue of unreadable output as 
trivial. Using a black background is something you can choose away from, 
except in an emergency, and not so much on vt. And navy blue on black is 
just hard to read. Poor contrast. If you can read that easier than 
others then fine, good for you, but this is about usability, it has 
literally nothing to do with personal taste.

-------

Alternative approaches: default to light bg, but select dark bg when 
TERM=linux (linux vt), I'd be happy to write the patch.

I'd like to try to alter the colors as suggested by Sirius, and if 
everyone agrees I'd like to also stick to defaulting to dark bg if not 
indicated otherwise.



