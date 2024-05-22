Return-Path: <netdev+bounces-97666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788818CC9CB
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 01:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5D21C22035
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 23:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB7B14C581;
	Wed, 22 May 2024 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b="QL0Xv6GT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-in-1.gedalya.net (mail.gedalya.net [170.39.119.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8B4824B1
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 23:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.39.119.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716421279; cv=none; b=oFEW3mEpldVanA35++GqtTwmfOXbppTT6Uxr/w9FQ23gYOFpt3i362QTAu9yov2A8Y+W/dZzhunyOWIrRBZPNlRXRuwE5obyQm+bOfuxGxVvwST8ESaRXvSnqBq5oa/tnBZqsiufqO1JEL3o7rqntz5f6BzT8u18Wgv37K0wV0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716421279; c=relaxed/simple;
	bh=OyIdjUelfmGCAdSbzaBcEYqhlgWPpApheE180PQKsb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TcRs9dMoJS8jVVtEPN60vgteBAMfRrg2DMNuz9ubA0WUgZCRbHur2Ro5zpk5ZKC4KEd3nFEIWWVpFRkRv0NiYsG6zCa0Rn79eHSkXbwhcCg7ok8ZdrZKEJWr9VT7wr5i+SeuvBGNxSGJRTaf8Nkccizj/OcegSixqLk+7jwXSmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net; spf=pass smtp.mailfrom=gedalya.net; dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b=QL0Xv6GT; arc=none smtp.client-ip=170.39.119.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gedalya.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gedalya.net
	; s=rsa1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description;
	bh=OyIdjUelfmGCAdSbzaBcEYqhlgWPpApheE180PQKsb0=; b=QL0Xv6GT3FDCmYj4W7aLX8joN0
	XEs0SlcefjcB/+Zg+tCw1sNAdRuzJCXRpw1ciUvPLbLHBb6Il/cvvTpkXFldUsMLNvRv7sdDVXT4q
	Eluu44tUWADbN68AKQ35/Ic4JStFQfZkyOvXxkcGnCAQJaxvj+exziW1REzeLC1AcF8ekscNM63u+
	3lPx7lH4OYgSMQSHFJcYnTWV5s79X/cHumS/X+N2C6zc/3HeHHtr5xq78AU90FnuujpDOrOUUZUow
	dEe6pR9o6+oLFFnPp3oYz6KPx33hhcbD5iCaT9GRnGgqCX3+XCa/OUaGxhX4K47Xzu3zXEzD/+Hzn
	uhEmei0w==;
Received: from [192.168.9.10]
	by smtp-in-1.gedalya.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gedalya@gedalya.net>)
	id 1s9va7-000f3F-0K;
	Wed, 22 May 2024 23:41:15 +0000
Message-ID: <005513fa-85ce-4e9f-a357-e1d42944410d@gedalya.net>
Date: Thu, 23 May 2024 07:41:12 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [resend] color: default to dark background
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Dragan Simic <dsimic@manjaro.org>, netdev@vger.kernel.org
References: <E1s9rpA-00000006Jy7-18Q5@ws2.gedalya.net>
 <20240522135721.7da9b30c@hermes.local>
 <67841f35-a2bb-49a5-becd-db2defe4e4fa@gedalya.net>
 <2866a9935b3fa3eafe51625b5bdfaa30@manjaro.org>
 <20240522143354.0214e054@hermes.local>
 <5b8dfe40-e72e-4310-85b5-aa607bad1638@gedalya.net>
 <20240522155234.6180d92d@hermes.local>
Content-Language: en-US
From: Gedalya <gedalya@gedalya.net>
In-Reply-To: <20240522155234.6180d92d@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/23/24 6:52 AM, Stephen Hemminger wrote:

> Overall, I am concerned that changing this will upset existing users.
> Not that it is impossible, just need more consensus and testing.

Turns out people were complaining about it years ago, not realizing that
the color scheme they were looking at was actually not meant for dark backgrounds:

https://www.reddit.com/r/linux/comments/kae9qa/comment/gfgew0x/


