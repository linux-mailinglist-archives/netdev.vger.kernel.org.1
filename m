Return-Path: <netdev+bounces-190233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ACFAB5CF8
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 21:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2E64C0CC1
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 19:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6C61E8328;
	Tue, 13 May 2025 19:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="eAeYGpkF"
X-Original-To: netdev@vger.kernel.org
Received: from mx15lb.world4you.com (mx15lb.world4you.com [81.19.149.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99302AD25
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 19:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747163333; cv=none; b=Hj/AlRY8MejhBiRzm4OZOXevs8DVIG1/qez+893eP1+X4pBrCZ7aGZuHgtOit7rd+nC766YZrnelirpAnbAOjcC/fG8VlpI2Q/ew1oC90u7q/vhm9OijaFhnXNEcNJq8OaD783lzWNR4bE46iL2uzWOO+8csa0YqQvh+3WPKB5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747163333; c=relaxed/simple;
	bh=Y77Ch5gJBWARlZpuN7JiywKqUn77ZHEoCje4u6QKo9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hkrf4cYo1S8sfyYPjlc1gfD7/nW/U+rw31nIoUlsaxD2NyAetYxlIaKxnkdC/3hTjX40w7maXsC6fU2m8J7jRFoTEbUOm53qwN/+bnRqw2oPZuPsEjHa0wrfRs2rSN7jfmOhDpGm9YMXf8YfU+7OOgZs5N1JphRiMR9f7i0FbKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=eAeYGpkF; arc=none smtp.client-ip=81.19.149.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QwKiAsvBNO+ur4LN1x15YNADNv3e3e+AJkXa7zTapUs=; b=eAeYGpkFVyGeCWIPsNK4uBqlOo
	DIIlHji1Cp742XwloUoW1cOe9sDigRJ5vEoh9zg2LRFX/zDLpkAoIMXz1s71PaE4AloNaj91A7LP3
	uWNLpok7grajCCX2bUD6BcfF2xwT+yIHyv3XrrgpGHOE57BrpJCgRe0MHyGRyJ/8S9XA=;
Received: from [188.22.4.212] (helo=[10.0.0.160])
	by mx15lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1uEuSJ-000000003qY-0oJc;
	Tue, 13 May 2025 20:34:20 +0200
Message-ID: <76ce9b02-d809-4ccb-8f59-cb8f201e4496@engleder-embedded.com>
Date: Tue, 13 May 2025 20:34:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: tsnep: fix timestamping with a stacked DSA
 driver
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
References: <20250512132430.344473-1-vladimir.oltean@nxp.com>
 <532276c5-0c5f-41dd-add9-487f39ec1b3a@engleder-embedded.com>
 <20250512210942.2bvv466abjdswhay@skbuf>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20250512210942.2bvv466abjdswhay@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 12.05.25 23:09, Vladimir Oltean wrote:
> On Mon, May 12, 2025 at 10:07:52PM +0200, Gerhard Engleder wrote:
>> On 12.05.25 15:24, Vladimir Oltean wrote:
>>> This driver seems susceptible to a form of the bug explained in commit
>>> c26a2c2ddc01 ("gianfar: Fix TX timestamping with a stacked DSA driver")
>>> and in Documentation/networking/timestamping.rst section "Other caveats
>>> for MAC drivers", specifically it timestamps any skb which has
>>> SKBTX_HW_TSTAMP, and does not consider adapter->hwtstamp_config.tx_type.
>>
>> Is it necessary in general to check adapter->hwtstamp_config.tx_type for
>> HWTSTAMP_TX_ON or only to fix this bug?
> 
> I'll start with the problem description and work my way towards an answer.

(...)

>> I can take over this patch and test it when I understand more clearly
>> what needs to be done.
>>
>> Gerhard
> 
> It would be great if you could take over this patch. After the net ->
> net-next merge I can then submit the ndo_hwtstamp_get()/ndo_hwtstamp_set()
> conversion patch for tsnep, the one which initially prompted me to look
> into how this driver uses the provided configuration.

I will post a new patch version in the next days. You can send me the
ndo_hwtstamp_get()/ndo_hwtstamp_set() conversion patch for testing. I
have it on my list, but nothing done so far, so I feel responsible
for that too.

Gerhard

