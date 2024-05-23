Return-Path: <netdev+bounces-97803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC368CD509
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 15:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC82BB22AB2
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 13:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ABD14A08F;
	Thu, 23 May 2024 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b="jiLkt1B9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-in-1.gedalya.net (mail.gedalya.net [170.39.119.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9E61482F9
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.39.119.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716472246; cv=none; b=MRY7hgR4bq75ExpjVpJk8UOPp3osa3XLT4tkdPfAvdj6kow7XC1sG56zon7dR6uOyQFAXXoAllKCBiTsZOedD9r9eZIhh1L0jx83vA3EqakOWJIDrXvrkDnE+z5zry1dn/sdtnL9xbfnNptS1osy3LOl5WyCujoT/uIKzRJ1bqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716472246; c=relaxed/simple;
	bh=C8lxaj7mvYkvQkjrTFO1bC8I3nONBbXxa5nriwUsiMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TqTOnwUxnA3mhnNqot/EPV0QXLBF8MuYVHi0dey5Xicxxs2e15mXeeuXGituwj1MdkCDTIzk72qNEiEArDMZgdtcBYZMfVdX5mJk+alsZ4FDgiN65B7ZNMV1HtMxCYvRQ2RK2VsZaEUXMDsr1I40diZmVTzcXreRlS+gI1IB4vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net; spf=pass smtp.mailfrom=gedalya.net; dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b=jiLkt1B9; arc=none smtp.client-ip=170.39.119.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gedalya.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gedalya.net
	; s=rsa1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description;
	bh=BdwlC9epp1dmbhO0ZvwJj8S81/14cxa37dIDymUcbZk=; b=jiLkt1B9o36zuqA2yW5yvQD9sH
	DVik20+EyngSs1LtVCg++hmMUK0/EUHfNZ8ZLQ2SMVfq0g9cLOklIQCaWTj2f3phiG++sB1XyWih8
	ryYeH4Tlca8OAPDqqEZanFQHEUnMq7glVQuYWkVD2I3k2uYj2jTsP5UW8hDlVQAOPgPjI8ggwDsLH
	sNmPEP71D0n5j4NmZBpcuTDWf7OH9KfVFkjj005fi0Cp4xKZF6OBMydORDSYaa66Q4Uh9lTn4j/hz
	lZjZxXW+aVnGp5yoc5PY22jaqc5Aeanl2L5xJPaYrBbRxdAyDz6IAwj3uaU1H3hQ4ujd8ak1Lvxt4
	MMzRYBiw==;
Received: from [192.168.9.176]
	by smtp-in-1.gedalya.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gedalya@gedalya.net>)
	id 1sA8q9-000gHQ-2K;
	Thu, 23 May 2024 13:50:41 +0000
Message-ID: <7cfcca05-95d0-4be0-9b50-ec77bf3e766c@gedalya.net>
Date: Thu, 23 May 2024 21:50:38 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iproute2: color output should assume dark background
To: Dragan Simic <dsimic@manjaro.org>
Cc: Sirius <sirius@trudheim.com>, netdev@vger.kernel.org
References: <173e0ec8-583a-4d5a-931f-81d08e43fe2b@gedalya.net>
 <Zk7kiFLLcIM27bEi@photonic.trudheim.com>
 <96b17bae-47f7-4b2d-8874-7fb89ecc052a@gedalya.net>
 <Zk722SwDWVe35Ssu@photonic.trudheim.com>
 <e4695ecb95bbf76d8352378c1178624c@manjaro.org>
 <449db665-0285-4283-972f-1b6d5e6e71a1@gedalya.net>
 <7d67d9e72974472cc61dba6d8bdaf79a@manjaro.org>
Content-Language: en-US
From: Gedalya <gedalya@gedalya.net>
In-Reply-To: <7d67d9e72974472cc61dba6d8bdaf79a@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/24 9:23 PM, Dragan Simic wrote:
>> And what about linux virtual terminals (a.k.a non-graphical consoles)?
>
> In my 25+ years of Linux experience, I've never seen one with a 
> background
> color other than black. 

You kind of missed my question: Do we make a new rule where a correctly 
set COLORFGBG is mandatory for linux vt?

That's what I meant. The fact that both vt and graphical terminal 
emulators tend to be dark is another point.

My point is you can't rely on COLORFGBG. You can only use it if/when set.

A reasonable default is needed.



