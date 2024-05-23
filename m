Return-Path: <netdev+bounces-97813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4448CD587
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 16:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6425280BEB
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 14:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8773B14A62B;
	Thu, 23 May 2024 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b="K1EC2Sa1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-in-1.gedalya.net (mail.gedalya.net [170.39.119.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DF1433C4
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.39.119.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474004; cv=none; b=ngYb0MXCQ9TUCSfEkNx+agrcrD6ONdkY3nz3iENFCcRLeR9uBS9LMU78PE/fMhh22Wn4FKkaq+ldbciiLafj/1RJPfXy0THzYz4zThHBXN0wC+QT3m87WxC/kbf0XRTxLkdNqTWT0SHCfgloqZVuegJRCTUulsvufstrIfcQxxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474004; c=relaxed/simple;
	bh=61iSz9AdPqUrcve27DP4ORRIOvOMxBq5WfLJMUVzKZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K798nYpD3vvyOsQSzDMpmDMEiqaVm5bMKmFn3Jj+xiF7oXfOidZQaI/BhQwhNvGxyuBpKx1evCrP84sKxA7CgT231QmcvLe9/hD9XYfrXGxVhgkQw4JFlQ5BLkqXhbXjq+Dc5l5YeZNA2kAbiUoONCkBN2GV3cGQUavlc4EUjvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net; spf=pass smtp.mailfrom=gedalya.net; dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b=K1EC2Sa1; arc=none smtp.client-ip=170.39.119.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gedalya.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gedalya.net
	; s=rsa1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description;
	bh=t5nBOYIMKEgTyTIpmk0KZlDqpPSlis6GbMbUUqsmWsE=; b=K1EC2Sa1oXQEWIVoFS5YBVkBZt
	b69ZW635YVHAv7pgdjnF3rubcXt2TxWmTr5ZbUAxcVPgmPGWuR6vSPqfmLiqFuSuRRrQHjtVZMbGF
	SueohYWb1diKqwzVB8zSYHm9+zilkVYzXTf0vQpO+6/9Tjr2bB5TpV8jca0UbV3ZqSDo7hB9Z8jtZ
	7BhKqMJfg8CJ050hxzOheZDbkZBWUXMK6R4MDPEwF3WMsereAu07vNEW1f4AgnqISH0QZd0ynVCIM
	O1VidKzbpFymc4bvMB74bdBTec5zrwyiOslFOthltXyTupXIEO7O4wstTkTQh/CZ/XTZkB6KO5Ogq
	RLv4mW7Q==;
Received: from [192.168.9.176]
	by smtp-in-1.gedalya.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gedalya@gedalya.net>)
	id 1sA9IW-000gKW-2a;
	Thu, 23 May 2024 14:20:01 +0000
Message-ID: <90bf7f9a-a409-4390-9c4e-af4c90549768@gedalya.net>
Date: Thu, 23 May 2024 22:19:57 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iproute2: color output should assume dark background
To: Sirius <sirius@trudheim.com>
Cc: Dragan Simic <dsimic@manjaro.org>, netdev@vger.kernel.org
References: <173e0ec8-583a-4d5a-931f-81d08e43fe2b@gedalya.net>
 <Zk7kiFLLcIM27bEi@photonic.trudheim.com>
 <96b17bae-47f7-4b2d-8874-7fb89ecc052a@gedalya.net>
 <Zk722SwDWVe35Ssu@photonic.trudheim.com>
 <e4695ecb95bbf76d8352378c1178624c@manjaro.org>
 <449db665-0285-4283-972f-1b6d5e6e71a1@gedalya.net>
 <7d67d9e72974472cc61dba6d8bdaf79a@manjaro.org>
 <7cfcca05-95d0-4be0-9b50-ec77bf3e766c@gedalya.net>
 <Zk9OmHeaX1UC8Cxf@photonic.trudheim.com>
Content-Language: en-US
From: Gedalya <gedalya@gedalya.net>
In-Reply-To: <Zk9OmHeaX1UC8Cxf@photonic.trudheim.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/24 10:11 PM, Sirius wrote:
> For the colours like blue and magenta, using \e[34;1m and \e[35;1m would
> make it more readable against dark background. And testing with a dark
> background right now, that would suffice the other colours are not
> problematic to read. (It uses the "bright" version of the two colours
> rather than the usual.)
>
> That would be a miniscule change to iproute2 and would resolve the
> problem no matter what background is used. I need to test with schemas
> like solarized light and dark as well, as they are finicky.

I find this constructive.

BTW I find that both current iproute2 palettes work with a light gray 
background.

It stands to reason that foreground colors could be chosen such that 
they work with black, several dark and several light background colors.

And yes please iproute2 should not be built with colors default-enabled!



