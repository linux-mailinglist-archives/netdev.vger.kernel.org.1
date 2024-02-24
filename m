Return-Path: <netdev+bounces-74667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E491E862278
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 04:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E0B286A24
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 03:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC097DF5A;
	Sat, 24 Feb 2024 03:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZYIP4B6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884D84416
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 03:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708744541; cv=none; b=AEVF7A+WYRooNFt8dQ2aCeNReG12pzv+SrfR/G0c67oiEssWyRf9mx6+5k8Q3GAvOyKA7HXkbgeU0AlYxKmgdWIeTeEitxKpnfiaqT+etyNXN0+Mkyr8HTWYbEZSbGt5EeCv6SmJVOglZWwOVJ8DoqCCmXylGbN9Q05tkR0IEJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708744541; c=relaxed/simple;
	bh=idRYJaJU1XaL8ananFgmur5YCWITMrqAzXgL0e/+MfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jmLCD2EyU4RD/lq1cbIEAfRWXqZzwUzTFXigYQrk78lhRY6DRlKRO2raNr4I/9YtPoNrSQEJZ8Ym502DzbDfKtZckXDvAsqOXTAriz/TdQiLiBt3C3eYEAUg/VjV+5E52fA1NYkRnJiNHbLp3/i+qpzJpR6Vknk2GACzAGJxxog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZYIP4B6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C220C433F1;
	Sat, 24 Feb 2024 03:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708744541;
	bh=idRYJaJU1XaL8ananFgmur5YCWITMrqAzXgL0e/+MfE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PZYIP4B6kLlcKXl++666L9htJm8HH3C4fWHpzC8YWOTK1jvb093iWip4WC4q0yORJ
	 LZxr/4gAgYV3Hx5PaltmKxnCKtZPrFHmwfm/h9XOq09XhVVDArYAhgoW1ou01IB1NB
	 OAVpmQ18c5OYGKjERTcGzYAGYDkBL5hLb96bSHDCMZk/RvvsjUe1BSt+ZpQ/nFQ3Po
	 58a/G8/GFWMhLa78ZANtzqngC0ZFaBLI/eMayQYpet/8SV27wW2PVPtDKmlOFz7Ye6
	 WE8QWQZiH2r1ZC9EkBUTMGMOQ0EF0mVl5WJkCypV/w6PXxfOyFMCHO2rln7cDCGF0A
	 6Y8VcM87VLKkg==
Message-ID: <b1386790-905f-4bc4-8e60-c0c86030b60c@kernel.org>
Date: Fri, 23 Feb 2024 20:15:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests/net: force synchronized GC for a test.
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Kui-Feng Lee <thinker.li@gmail.com>
Cc: netdev@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, davem@davemloft.net, sinquersw@gmail.com,
 kuifeng@meta.com
References: <20240223081346.2052267-1-thinker.li@gmail.com>
 <20240223182109.3cb573a2@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240223182109.3cb573a2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/23/24 7:21 PM, Jakub Kicinski wrote:
> On Fri, 23 Feb 2024 00:13:46 -0800 Kui-Feng Lee wrote:
>> Due to the slowness of the test environment
> 
> Would be interesting if it's slowness, because it failed 2 times
> on the debug runner but 5 times on the non-debug one. We'll see.

hmmm... that should be debugged. waiting 2*N + 1 and then requesting GC
and still failing suggests something else is at play

