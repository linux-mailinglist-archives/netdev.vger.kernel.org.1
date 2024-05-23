Return-Path: <netdev+bounces-97809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B34288CD571
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 16:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A931F2230A
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 14:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7968414A627;
	Thu, 23 May 2024 14:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b="RLCB5VpC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-in-1.gedalya.net (mail.gedalya.net [170.39.119.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8F613C68A
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.39.119.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716473630; cv=none; b=Vnqi2yG+2+S9vEy4CBTmBSvNp6yu0lwrc0LT57Qgl9ymfrDgKthhuVP/Q+WgpRmWguXaWTeYdkCEp2lqrrN8CtxMYpPzdf7V86Fvc+onfNZs30Badx8zVQrDklQOKY2UaNyyI9yr1jjd1TzSNcH9U8CsOkWLdbSbro27IaNgSSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716473630; c=relaxed/simple;
	bh=RVU35K+F06HhvEOYvYqs/+L957RxtCK7pbk0AtOcTC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2IQO0eROyFNAyLGNM/rwPpSnBGIM892bpnloNXhAzChwGfhmhPBjsldEdDq//3d0iMAEzUxQ48gkh0glH5CrSQcqTrsqP86t7RqnolE8SkZW6dkB6zbOphROr07kcY3bSCvhNgo39T+cAeWIdUQdqrF9spgNKVxX2FWWqW1N+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net; spf=pass smtp.mailfrom=gedalya.net; dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b=RLCB5VpC; arc=none smtp.client-ip=170.39.119.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gedalya.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gedalya.net
	; s=rsa1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description;
	bh=pFW0N8e/RhW7LDtu6in3zTyE6pOWXtEK79pByjPqM1I=; b=RLCB5VpCTqBfMR5PNSJX8lT3RE
	8zUlROcgmFOXwY2Q6zYXNPmH0vVvOTCozqGHdAqJ+RLv0H/0QZjJtb3VwvarvR+KIYdwIDdjZJTWn
	Qf62m1+0aFq3GdXfx0pcTcXMYdnOvJzGayp2jy8mY/XJKg1RFJVvLJxwuYrq2nKBnnzhLOWkLnXvy
	tbSlDGDFUixCh1R3HCwcv0SxoQbLtyGNOdoBFPx0sYn3A4O6LlsvY1gCirnej1zOdYFbGcbYOsezR
	ETTapB9OJtijFVvB/nrU0DjzHp4hMOrNrEhRFDAHd+28ipkp6Yft9CliTcCkGoJ1Lys7R7K1+Sz7M
	vXTNk2AA==;
Received: from [192.168.9.176]
	by smtp-in-1.gedalya.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gedalya@gedalya.net>)
	id 1sA9CU-000gJx-12;
	Thu, 23 May 2024 14:13:46 +0000
Message-ID: <1b404d0c-d807-4410-b028-f606d7182789@gedalya.net>
Date: Thu, 23 May 2024 22:13:43 +0800
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
 <7cfcca05-95d0-4be0-9b50-ec77bf3e766c@gedalya.net>
 <ef4f8fdb9f941be1213382d6aea35a46@manjaro.org>
Content-Language: en-US
From: Gedalya <gedalya@gedalya.net>
In-Reply-To: <ef4f8fdb9f941be1213382d6aea35a46@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/24 10:07 PM, Dragan Simic wrote:
> I think it would be best to start a gargantuan quest for having COLORFGBG
> set properly for all kinds of different terminal emulators. Including the
> Linux virtual console, which may come last. 

And you'll still need a default and the default will at all times be 
_something_, and it being that something would be justified by.. well.. 
something?



