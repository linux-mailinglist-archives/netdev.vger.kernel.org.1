Return-Path: <netdev+bounces-30455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E3C78765D
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 19:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422691C20EB2
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 17:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D9A13FE8;
	Thu, 24 Aug 2023 17:08:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B4D28917
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 17:08:45 +0000 (UTC)
Received: from mail.scottdial.com (bert.scottdial.com [104.237.142.221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62445199D;
	Thu, 24 Aug 2023 10:08:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.scottdial.com (Postfix) with ESMTP id 790D5111B49E;
	Thu, 24 Aug 2023 13:08:43 -0400 (EDT)
Received: from mail.scottdial.com ([127.0.0.1])
	by localhost (mail.scottdial.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id FdDpOXnD-yFF; Thu, 24 Aug 2023 13:08:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.scottdial.com (Postfix) with ESMTP id 2FD30111B0C2;
	Thu, 24 Aug 2023 13:08:42 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.scottdial.com 2FD30111B0C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scottdial.com;
	s=24B7B964-7506-11E8-A7D6-CF6FBF8C6FCF; t=1692896922;
	bh=j1D4pDk69Gos+fiIt3X/+08O3Du6N7Ir40z0U6EJvoA=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=WLrIjaRwjyh3qKAJ192AWwh2MyYBQaytzJff/ttiWrxXb8jxLiSppg/RNorjRiSox
	 BZfYCx98ktYFOLmeIel7d89sHz+UYqD0GdZux6pIOylMxk15SpBsFWz/OcOn+HSqEF
	 rJ+ygFkqs/HiqVV3EJACp1hgIWiyU7O+IZe/4p+/JNXFv37rGNhj8WRWFLNhiV6Syk
	 PMvhidMFSXbZobwx873QA9s1wPUeLPVdv40d2757MDE9iqjwH7kZ3hJCnWWuD0i8SQ
	 QPRLvvNLzKm6StXx5nY+UuSSvbC91klogKeFngdUrPwy4Nuo5LzwPUeu9yJ6+9N/+K
	 oqidcgJkb68Bw==
X-Virus-Scanned: amavisd-new at scottdial.com
Received: from mail.scottdial.com ([127.0.0.1])
	by localhost (mail.scottdial.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FFwVxnrqyBg7; Thu, 24 Aug 2023 13:08:42 -0400 (EDT)
Received: from [172.17.2.2] (unknown [172.17.2.2])
	by mail.scottdial.com (Postfix) with ESMTPSA id 026DD111B49E;
	Thu, 24 Aug 2023 13:08:41 -0400 (EDT)
Message-ID: <76e055e9-5b2b-75b9-b545-cbdbc6ad2112@scottdial.com>
Date: Thu, 24 Aug 2023 13:08:41 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next] macsec: introduce default_async_crypto sysctl
Content-Language: en-US
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <9328d206c5d9f9239cae27e62e74de40b258471d.1692279161.git.sd@queasysnail.net>
 <20230818184648.127b2ccf@kernel.org> <ZOTWzJ4aEa5geNva@hog>
 <a9af0c0a-ec7c-fa01-05ac-147fccb94fbf@scottdial.com> <ZOdUw66jbDWE8blF@hog>
From: Scott Dial <scott@scottdial.com>
In-Reply-To: <ZOdUw66jbDWE8blF@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/24/2023 9:01 AM, Sabrina Dubroca wrote:
> 2023-08-23, 16:22:31 -0400, Scott Dial wrote:
>> AES-NI's implementation of gcm(aes) requires the FPU, so if it's busy the
>> decrypt gets stuck on the cryptd queue, but that queue is not
>> order-preserving.
> 
> It should be (per CPU [*]). The queue itself is a linked list, and if we
> have requests on the queue we don't let new requests skip the queue.

My apologies, I'll be the first to admit that I have not tracked all of 
the code changes to either the macsec driver or linux-crypto since I 
first made the commit. This comment that requests are queued forced me 
to review the code again and it appears that the queueing issue was 
resolved in v5.2-rc1 with commit 1661131a0479, so I no longer believe we 
need the CRYPTO_ALG_ASYNC since v5.2 and going forward.

So, I believe my patch should be reverted from the mainline kernel and 
any releases that are still getting maintenance releases -- I believe 
v5.4, v5.10, v5.15, and v6.1.

-- 
Scott Dial
scott@scottdial.com


