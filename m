Return-Path: <netdev+bounces-96313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 053008C4F0A
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 12:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C871F22258
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 10:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D1E135A79;
	Tue, 14 May 2024 09:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="kGzY9Grk"
X-Original-To: netdev@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357A357880;
	Tue, 14 May 2024 09:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715680119; cv=none; b=mIx0JwavA5+i1SW79t6FML+d0JPRRyOMFdgJT/ER/5/JomLn2ktx6hojqK3HNNqaxHXhqIWB0FURJzfJdu31W83OS44p8F6nx1V6COLE1aNqW6TQy2U+r0Pn0LiwP7cGjop/K43hnbxvaqkM4mDUIJOj7/h+nhVJabxXHGgPNqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715680119; c=relaxed/simple;
	bh=OftvRN5FYOGb0QnfwZasmhuCm52IoMGg8swzhWcgK/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z5ZxU3CyjklcKyG4KouedCmsJbEkJqZwWJPDkZUzodQ4NuWmd1XB/ZqmThG2TYrON9t1XPRSIPGjI3ODnYf9YwSvW+xQO4jD3xsqD5sLz3gRqoFlmMcy2NHrIKEBciv8Ais7Ff5txxs3b9bEPEKBq5PpPTIuuRdv4yPMfnVjP8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=kGzY9Grk; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=OftvRN5FYOGb0QnfwZasmhuCm52IoMGg8swzhWcgK/0=; t=1715680117;
	x=1716112117; b=kGzY9Grk6KEhop/IWLfdCtviAVSYObF4RDzRK8WGDttEmW0ipHbWLcgsqk5El
	Ywfj8LnMtDxg0/2AUlnsolzYvJjkq2rATS7tJT0ZDtZSmYyztGfZUMjCo/LDgpRMWkhXQh6kfYKSy
	n9Wp5RAMbUyXh4eew5gEL3J4Z9Phwbse7EMwMMoxc83mH4C5R+tVYMKfM4pWhUmV6CMLEE0mw8lgf
	ANXnE2QmRrZcGaya05MLub5kJ1mcHdg2wX7U6ga6b5UfP6jlmUbhmqJc9egkGxoNWcNZZd/lS9nig
	z8GxBZVWREFkqMmfcoBm4RQqVNP6zqcmHAtQlQ4vElwKDEngCg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s6olk-0001jy-TO; Tue, 14 May 2024 11:48:24 +0200
Message-ID: <ce8b63da-8bc0-456d-8fff-23e937871246@leemhuis.info>
Date: Tue, 14 May 2024 11:48:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression of e1000e (I219-LM) from 6.1.90 to 6.6.30
To: Bagas Sanjaya <bagasdotme@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux Networking <netdev@vger.kernel.org>, intel-wired-lan@lists.osuosl.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 lukas.probsthain@googlemail.com
References: <ZkHSipExKpQC8bWJ@archie.me>
 <b2897fda-08e8-40de-b78a-86e92bde41db@lunn.ch>
 <56463a97-eb90-4884-b2f5-c165f6c3516a@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <56463a97-eb90-4884-b2f5-c165f6c3516a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1715680118;2a0210a5;
X-HE-SMSGID: 1s6olk-0001jy-TO

On 14.05.24 06:34, Bagas Sanjaya wrote:
> On 5/14/24 00:17, Andrew Lunn wrote:
>> On Mon, May 13, 2024 at 03:42:50PM +0700, Bagas Sanjaya wrote:
>>>
>>> <lukas.probsthain@googlemail.com> reported on Bugzilla
>>> (https://bugzilla.kernel.org/show_bug.cgi?id=218826) regression on his Thinkpad
>>> T480 with Intel I219-LM:

Bagas, why did you start forwarding these bugs by mail yourself again
after we had agreed you forward them to me, so I can handle it from there?

Yes, you forwarded that particular bug to me a few days ago and I didn't
do anything. But that was on purpose: I usually wait at least two
working days before doing so, as some subsystem are active in bugzilla
and might feel annoyed by starting a separate thread on the mailing list.

Side note: you also apparently make it not obvious enough that you are
just forwarding the bug, as both here and in the other bug your
forwarded today the developer apparently thought it was a bug you face.

Please lets avoid all of that again and switch back to the model we
agreed on a few months ago.

>>>> After updating from kernel version 6.1.90 to 6.6.30, the e1000e driver exhibits a regression on a Lenovo Thinkpad T480 with an Intel I219-LM Ethernet controller.
>>
>> Could you try a git bisect between these two kernel versions? You
>> might be able to limit it to drivers/net/ethernet/intel/e1000e, which
>> only had around 15 patches.
>
> The BZ reporter (Cc'ed) says that bisection is in progress. You may
> want to log in to BZ to reach him.

Side note: you should not assume every developer has a BZ account (or is
willing to create one).

Ciao, Thorsten

