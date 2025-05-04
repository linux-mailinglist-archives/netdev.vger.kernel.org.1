Return-Path: <netdev+bounces-187665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA57AA89B5
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 00:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36BE8173927
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 22:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913381D9A41;
	Sun,  4 May 2025 22:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUHxrHtB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EEC4C62;
	Sun,  4 May 2025 22:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746397002; cv=none; b=HaIdUBFppQpKfOJ22DpUFg3sI2jCdrKr5FsNBiPX4i9oUmPN3Qvw5IeUpJzSGg8/ufTxkKFOJKaWjxe8zSEFNP3S5FGU8Yt/AcqAdZA/9cknQTvT0rppzt/8HuvEiTVp2JZq4VW7nycwlZHSiuC49cNxDqmKOWCrSz332xnXZYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746397002; c=relaxed/simple;
	bh=beKfR6HjFlnY/P8zdhmJ7Qq4Li2sesKeU7YVYmfZXH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J6ZHyak+AxtCpFRHnbUHU4su1m/6jrvOWQfY1scEjB2eZrPh2FFaRizEUgDdPTN9Ltsdvu19j4cGxroB/YMZ1kng5NRsDtZtSDMz33Io1w0A9q3CYQrJNAULZYiQzUdFkq66y0F+TxWr9ANTMtiDe1/pZ4LcJMeDkVwAuoLGo4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUHxrHtB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F1EC4CEE7;
	Sun,  4 May 2025 22:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746397001;
	bh=beKfR6HjFlnY/P8zdhmJ7Qq4Li2sesKeU7YVYmfZXH4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NUHxrHtB0+lM+Jk3BHUFgF+I7guI67DxCj2c83EtKDk7q+r81TQKX952AEguTEyqW
	 oRLXC5vq65grR2aS3qVwBO/w2q3M1/hVFwXllPN9YtA2j1nVNxlUX3rA/9T1iTdd8W
	 0a542tt4nvg8L+w0tMc34MkKVgxesdbC60MhUe1FkIryaEF/WO/u/neNlSlZZiLuCq
	 JkUh2mfkNnMhM4bjLo/uHiH3B6pY0O4yXciya6flIjRyWpksNTKLswvZK07gOANevY
	 ruu2i6yaNi7cQzg6p1baBU3tlE74w3IDnBe3H85fFrJzuE2gqKH0bfvWw6UPZb7vxi
	 y/e7JE7XO6DuQ==
Message-ID: <260b6cc3-db8b-4b4c-a360-7bdd858943a8@kernel.org>
Date: Sun, 4 May 2025 17:16:39 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 RESEND] clk: socfpga: agilex: add support for the Intel
 Agilex5
To: "Gerlach, Matthew" <matthew.gerlach@altera.com>, mturquette@baylibre.com,
 sboyd@kernel.org, richardcochran@gmail.com, linux-clk@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
 Teh Wen Ping <wen.ping.teh@intel.com>
References: <20250417145238.31657-1-matthew.gerlach@altera.com>
 <fd295c8b-c5fd-4fda-b5d4-3c261d8dbfeb@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <fd295c8b-c5fd-4fda-b5d4-3c261d8dbfeb@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/4/25 16:34, Gerlach, Matthew wrote:
> 
> 
> On 4/17/2025 7:52 AM, Matthew Gerlach wrote:
>> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
>>
>> Add support for Intel's SoCFPGA Agilex5 platform. The clock manager
>> driver for the Agilex5 is very similar to the Agilex platform, so
>> it is reusing most of the Agilex clock driver code.
>>
>> Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
>> Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
>> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> 
> Is there any feedback on this patch?
> 

I've applied it and sent a PR for 6.16.

Dinh


