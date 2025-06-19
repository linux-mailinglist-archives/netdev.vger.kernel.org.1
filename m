Return-Path: <netdev+bounces-199564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A21CAE0B7E
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 18:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FAF27A699E
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 16:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5F228A72D;
	Thu, 19 Jun 2025 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="HQ2jzHRs"
X-Original-To: netdev@vger.kernel.org
Received: from mta-101a.earthlink-vadesecure.net (mta-101a.earthlink-vadesecure.net [51.81.61.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A65511712;
	Thu, 19 Jun 2025 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.61.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750351812; cv=none; b=JR4sPaLIyYAmrvOsaoGFaKhXVFL9b+x4ikKSYz1brTOKUoVqUlx/BYNA9RlkeVQjjTwtL1kBz1FbussaSDbI9ySzi0d5X3WHa5+y5POW5Aho94jAAWUV7o2AyZlfYYo3vEfAHd+81JSp91iPaALJ5+Ao8JzrC9S2QN5eFtu+NjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750351812; c=relaxed/simple;
	bh=YTlcXr9OlGydD15/oYLK7Weyj63Pb2tsjIWoisxYE6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QghKN3MnSq8CnOx4Y+h4RSd7ZPMrjZ10oRioQxGFqta7pjyFcs3VDkEmYsq7wdMYXQqVPzJpXSpbpPbdje5Mw1TE+bJmdnpnqUbahA1R4TFG32ZyMFJCdrEo2XsikNu+m8Afc1diUm0O26ODDOymCWbQbpjxUtdtBAj6uMnpPpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onemain.com; spf=pass smtp.mailfrom=onemain.com; dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b=HQ2jzHRs; arc=none smtp.client-ip=51.81.61.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onemain.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onemain.com
Authentication-Results: earthlink-vadesecure.net;
 auth=pass smtp.auth=svnelson@teleport.com smtp.mailfrom=sln@onemain.com;
DKIM-Signature: v=1; a=rsa-sha256; bh=YTlcXr9OlGydD15/oYLK7Weyj63Pb2tsjIWois
 xYE6Q=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-unsubscribe-post:
 list-subscribe:list-post:list-owner:list-archive; q=dns/txt;
 s=dk12062016; t=1750351484; x=1750956284; b=HQ2jzHRspBIedcrbh3Xwu9ZlrqH
 w6Yb6hZ8q3mPiS1aXwM0srxcnpM0jPV8LwhcrRZfXWTiKIdGLhlt336KfL+vayjGGQ18Utu
 XJ9halFKOr/ZXQryj9GbuqlVI0vjLXt/LaTzzg3EANGLG4YdjHkJUHbmengleZExk8uvqgS
 iaGQzed+edFpNbz4Fp/gxwSEfcVPzXnzyruDBqN6mMTKpDgxayRRV9xmLTaKO4mfK0B05n/
 hyi1in4iClNIXdffstHf7fbR3jFt8ofZXQmrZ18CnqpzDLb54UaDJZJDxrNLUv062UPfqUF
 johVc98jsc4FdREd02yN9L+NN0mE2wQ==
Received: from [192.168.0.23] ([50.47.159.51])
 by vsel1nmtao01p.internal.vadesecure.com with ngmta
 id 5a8dfc70-184a7f663f8b4416; Thu, 19 Jun 2025 16:44:44 +0000
Message-ID: <8b18c015-3dbf-4c4d-a404-3831459c6326@onemain.com>
Date: Thu, 19 Jun 2025 09:44:41 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] mailmap: Update shannon.nelson emails
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250619010603.1173141-1-sln@onemain.com>
 <20250619082915.08a79e6b@kernel.org>
Content-Language: en-US
From: Shannon Nelson <sln@onemain.com>
In-Reply-To: <20250619082915.08a79e6b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/19/25 8:29 AM, Jakub Kicinski wrote:
> On Wed, 18 Jun 2025 18:06:03 -0700 Shannon Nelson wrote:
>> Retiring, so redirect things to a non-corporate account.
> I just so happened to be applying your MAITNAINERS update and this
> patch one after another, so I'm just gonna squash them. Hope you don't
> mind.

That works for me - thanks!
sln


