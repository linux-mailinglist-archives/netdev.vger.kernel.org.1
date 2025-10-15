Return-Path: <netdev+bounces-229730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF40BE04BA
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 21:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5B5545388
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 19:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4B830596F;
	Wed, 15 Oct 2025 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgBFlW5N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA575302CAB;
	Wed, 15 Oct 2025 19:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760554854; cv=none; b=RafCs1NzsPNwUGH2EH2nxJ4E6kD/AhEU7X7Mi+eGQMRcDtXYOkl7SSSYQ6AfA+gj52xBBD9WOeS9sOjxCDmxBTLVGbH2+UTh97GXnJIFfMFePpsTZiJPRlC14Vznvbx0eATE0opbbo8AmHfOw4z11d6J2Uv8csLznRLw0wSTl9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760554854; c=relaxed/simple;
	bh=U1O5JJjDwfsLfdO35GX3nUek30Grms+9GVEVpNFCLUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ixj0sTMwktCtWkc/zxV3QggfAv11Jsq4t0iW6zgPkMiBPUS16eU511/+yNksZbLVO7mZbb/U6ms5D4ubD2PLMPFLDJJACcKMzprPQs8rre24KGSqsczGr5lq6HU+kdCAHTe86J6UpnQ83KW/LJR/dTNka+4VfD3ZpVw9mpoJMrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgBFlW5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FADDC113D0;
	Wed, 15 Oct 2025 19:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760554853;
	bh=U1O5JJjDwfsLfdO35GX3nUek30Grms+9GVEVpNFCLUU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BgBFlW5NsWOtmAhzyadk7XleOyG2zwnk2bAhFHIHHFUFkgpOCBhE1uTpFzClsHmKU
	 3hhsQsksjGAeomuL1twLTBYfiGivSv1RJcF2Uwn5aNcsLwHR8mvrFOF5CqEPLUMf6G
	 zwftn98cbaXtvZ4NMA2jAYkx3tSdIfqSuz42ddfjLJgRQnUR2obncd5gxZ50i0wcu2
	 GRUOjz/Gyi1xKhkld7IVvK+a3HIvGt6yADpEa0v8zpiJ6x47u4DQKWECYM7FiBJ7To
	 tXXURm0Uw61CkJhTmYNSNt5u/hd3hEEUsthhGIn+KYfcVEFSTxDYFRy6M8cHbbpRX4
	 8NkCiv0SiP1Qg==
Message-ID: <578cc11f-654d-44fb-829a-ae6421863d50@kernel.org>
Date: Wed, 15 Oct 2025 13:00:52 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: usb: lan78xx: fix use of improperly
 initialized dev->chipid in lan78xx_reset
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: Thangaraj.S@microchip.com, Rengarajan.S@microchip.com,
 UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com
References: <20251013181648.35153-1-viswanathiyyappan@gmail.com>
 <1adfe818-c74f-4eb1-b9f4-1271c6451786@kernel.org>
 <CAPrAcgPs48t731neW4iLq3d+HXEQAezHj5Ad9KR8EK+TNu5wbg@mail.gmail.com>
Content-Language: en-US
From: Khalid Aziz <khalid@kernel.org>
In-Reply-To: <CAPrAcgPs48t731neW4iLq3d+HXEQAezHj5Ad9KR8EK+TNu5wbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/25 10:51 AM, I Viswanath wrote:
> On Wed, 15 Oct 2025 at 21:25, Khalid Aziz <khalid@kernel.org> wrote:
> 
>> How did you determine this is the commit that introduced this bug?
>>
>>   From what I can see, commit a0db7d10b76e does not touch lan78xx_reset()
>> function. This bug was introduced when devid was replaced by chipid
>> (commit 87177ba6e47e "lan78xx: replace devid to chipid & chiprev") or
>> even earlier when the order of calls to lan78xx_init_mac_address() and
>> lan78xx_read_reg() was introduced in lan78xx_reset() depending upon if
>> lan78xx_init_mac_address() at that time used devid in its call sequence
>> at the time.
> 
> The commit a0db7d10b76e introduced the dependency on devid to
> lan78xx_read_raw_eeprom() and
> lan78xx_read_eeprom() and ultimately lan78xx_init_mac_address() and
> lan78xx_reset()
> 
> In lan78xx_init_mac_address()
> 
> Only lan78xx_read_eeprom() depends on devid as
> 
> lan78xx_read_reg() and lan78xx_write_reg() do not use devid
> 
> lan78xx_read_otp() depends on lan78xx_read_raw_otp() which depends
> only on lan78xx_write_reg() and lan78xx_read_reg()
> and hence doesn't use devid either
> 
> is_valid_ether_addr(), random_ether_addr() and ether_addr_copy() are
> net core functions and do not care about driver specific data
> 
> The devid read exists in this commit (was added in ce85e13ad6ef4)
> 
> a0db7d10b76e was supposed to move the devid read before the
> lan78xx_init_mac_address() because of the newly added
> dependency but it was a tricky detail that the author failed to see
> 
> Thanks,
> I Viswanath

Ah, I see. That makes sense.

--
Khalid

