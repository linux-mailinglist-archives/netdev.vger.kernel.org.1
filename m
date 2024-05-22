Return-Path: <netdev+bounces-97640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF8F8CC7E2
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 23:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8411B20EE3
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 21:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF0D78C6E;
	Wed, 22 May 2024 21:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b="NCpLKFlY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-in-1.gedalya.net (mail.gedalya.net [170.39.119.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CD31CAA6
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 21:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.39.119.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716411694; cv=none; b=RJlJhmIN2hdRMHXO66vIcE+ARVPTop05Py1Z0KRpETiIjfiqDxh71DDMkWcD4tWx4RuQqihhDO+GxA0p9NTB62fnKR7Ln5UHu0XTQyRvMZpQHLIjuhK34TdJL4wbGLG1XBRR1Z+VT+Jx30DaCIy//aTzwIFseV3hLiAvpUGigY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716411694; c=relaxed/simple;
	bh=2b+s1uE7tm6nGqGA3dqkgXw2mUr32BDMW7LKykPr5HI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fWld58yJHfyT8E93YzMgFKFKfrSHYMZaTHjOUAFFIpb7Znfjj325E623/mV2gBGUNC3CMg1eZ3nQsaqILLRDKF/iXuVKMz9UDVv5JHu1HkLKgrykrPLtu65x9QorY02bqr2QpnIZFLIctzFjCUjVcH3JEQJTM3g7wXFiiTOrrAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net; spf=pass smtp.mailfrom=gedalya.net; dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b=NCpLKFlY; arc=none smtp.client-ip=170.39.119.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gedalya.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gedalya.net
	; s=rsa1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description;
	bh=2b+s1uE7tm6nGqGA3dqkgXw2mUr32BDMW7LKykPr5HI=; b=NCpLKFlYk49Nh6VF//pJeFVc4w
	TRBnfMKns36NDHMMv0433sefVy22s5w5GvP1WBARxs/KJGqFhK7p6t/4ddyxtsOfSUFX5Q1wWlffY
	iKD0nSpej//90xQfNFd16CqhE2zdtzHZDVBTRJaDildu/7v+qlKd2/8Eq2UWuV5t91zflhe8cGPWs
	7F/VwoUMJRKZ0u8jKYQ6g8xPtvgj/xO/di4ydIk5yIdT07ZI6ot+LKOLq4OLdeIIL2gGM6q79bdux
	zkIc7NHiSR0ZUzdcymdWZN57+5kWnUhA67qxiYx32OqHpPiWseR/0xQpXjwEwl9EEZ01ms4ANcXum
	Yi0ZoIuA==;
Received: from [192.168.9.10]
	by smtp-in-1.gedalya.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gedalya@gedalya.net>)
	id 1s9t5W-000enD-32;
	Wed, 22 May 2024 21:01:31 +0000
Message-ID: <67841f35-a2bb-49a5-becd-db2defe4e4fa@gedalya.net>
Date: Thu, 23 May 2024 05:01:28 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [resend] color: default to dark background
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
References: <E1s9rpA-00000006Jy7-18Q5@ws2.gedalya.net>
 <20240522135721.7da9b30c@hermes.local>
Content-Language: en-US
From: Gedalya <gedalya@gedalya.net>
In-Reply-To: <20240522135721.7da9b30c@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/23/24 4:57 AM, Stephen Hemminger wrote:
> Why? What other utilities do the same thin?

I'm truly sorry, I don't understand the question



