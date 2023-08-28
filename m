Return-Path: <netdev+bounces-31104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D11378B7CD
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 21:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDDA81C20969
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 19:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5693D13FF2;
	Mon, 28 Aug 2023 19:05:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4966113AF8
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 19:05:23 +0000 (UTC)
Received: from mail.scottdial.com (bert.scottdial.com [104.237.142.221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11463CFC;
	Mon, 28 Aug 2023 12:04:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.scottdial.com (Postfix) with ESMTP id 86ACA111B49E;
	Mon, 28 Aug 2023 15:04:54 -0400 (EDT)
Received: from mail.scottdial.com ([127.0.0.1])
	by localhost (mail.scottdial.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 9EN6lY18c3e8; Mon, 28 Aug 2023 15:04:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.scottdial.com (Postfix) with ESMTP id A0454111B0C2;
	Mon, 28 Aug 2023 15:04:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.scottdial.com A0454111B0C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scottdial.com;
	s=24B7B964-7506-11E8-A7D6-CF6FBF8C6FCF; t=1693249492;
	bh=5OmDCOGEa2SP/NbvsW5JdLooYjt5BjPxfm70C0bKnbc=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=rpaPLqhYjHKJYaFoSHmBG7HLhrrELyCyP7Lnfov4gAnH1NzGiP3r/7I7R2sYGmWh9
	 2D/5Vxnz4Gp7+3DAsXVp2JNbLNrCVESzLEu4J50BLp3jQ/7bbVHUbSizeCcCDYZlKC
	 E5cRRwHFXHsTGfQe8Z8AKsOGh/nhi0JitXzMzKSZoqgV7cQ12H91qO7dTJ/VS7IoII
	 GX/adIuJd0dDlyzKrP1QOJ4C5oOKe+UIyqnno3k50mUHnMQd8XrdfMqP9qkpFLl57A
	 zdjQcsQdY0mq2bE2ey12Mrm1NRDCblVPiiNcP3LLa4lpyBNRoDmAOgx6+dP/+EBZLF
	 lRmYbXkIhMbEg==
X-Virus-Scanned: amavisd-new at scottdial.com
Received: from mail.scottdial.com ([127.0.0.1])
	by localhost (mail.scottdial.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1s3ckXlcyey1; Mon, 28 Aug 2023 15:04:52 -0400 (EDT)
Received: from [172.17.2.2] (unknown [172.17.2.2])
	by mail.scottdial.com (Postfix) with ESMTPSA id 761C9111B49E;
	Mon, 28 Aug 2023 15:04:52 -0400 (EDT)
Message-ID: <2d34e8a8-24c2-1781-2317-687bfcbeafda@scottdial.com>
Date: Mon, 28 Aug 2023 15:04:51 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next] macsec: introduce default_async_crypto sysctl
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <9328d206c5d9f9239cae27e62e74de40b258471d.1692279161.git.sd@queasysnail.net>
 <20230818184648.127b2ccf@kernel.org> <ZOTWzJ4aEa5geNva@hog>
 <a9af0c0a-ec7c-fa01-05ac-147fccb94fbf@scottdial.com> <ZOdUw66jbDWE8blF@hog>
 <76e055e9-5b2b-75b9-b545-cbdbc6ad2112@scottdial.com> <ZOxsAR42r8t3z0Dq@hog>
Content-Language: en-US
From: Scott Dial <scott@scottdial.com>
In-Reply-To: <ZOxsAR42r8t3z0Dq@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/28/2023 5:42 AM, Sabrina Dubroca wrote:
> 2023-08-24, 13:08:41 -0400, Scott Dial wrote:
>> On 8/24/2023 9:01 AM, Sabrina Dubroca wrote:
>>> 2023-08-23, 16:22:31 -0400, Scott Dial wrote:
>>>> AES-NI's implementation of gcm(aes) requires the FPU, so if it's busy the
>>>> decrypt gets stuck on the cryptd queue, but that queue is not
>>>> order-preserving.
>>>
>>> It should be (per CPU [*]). The queue itself is a linked list, and if we
>>> have requests on the queue we don't let new requests skip the queue.
>>
>> My apologies, I'll be the first to admit that I have not tracked all of the
>> code changes to either the macsec driver or linux-crypto since I first made
>> the commit. This comment that requests are queued forced me to review the
>> code again and it appears that the queueing issue was resolved in v5.2-rc1
>> with commit 1661131a0479, so I no longer believe we need the
>> CRYPTO_ALG_ASYNC since v5.2 and going forward.
> 
> Are you sure about this? 1661131a0479 pre-dates your patch by over a
> year.
> 
> And AFAICT, that series only moved the existing FPU usable +
> cryptd_aead_queued tests from AESNI's implementation of gcm(aes) to
> common SIMD helpers.

My original issue started with a RHEL7 system, so a backport of the 
macsec driver to the 3.10 kernel. I recall building newer kernels and 
reproducing the issue, but I don't have my test setup anymore nor any 
meaningful notes that would indicate to me what kernels I tested. In any 
case, I didn't bisect when the queuing behavior was changed, and maybe I 
misread the code, and maybe my test setup was flawed in some other way.

1661131a0479 wasn't obviously just moving code to me, so I didn't trace 
back further, but looking at the longterm maintenance 4.x kernels, I can 
see that the AES-NI code has the same cryptd_aead_queued check, so I 
think you are correct to say that you could revert my change on all of 
the maintenance kernels to restore the performance of MACsec w/ AES-NI.

Whether that causes any ordering regressions for any other crypto 
accelerations, I have no idea since it would require auditing a lot of 
crypto code.

-- 
Scott Dial
scott@scottdial.com

