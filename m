Return-Path: <netdev+bounces-222814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367ACB563BA
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 01:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2D917FFA3
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 23:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8332C2C159A;
	Sat, 13 Sep 2025 23:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="WzeHUuy6"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FC657C9F;
	Sat, 13 Sep 2025 23:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757805301; cv=none; b=KhKnT7zynjQoXBN6Lz/sXAnU9NKInGCd/JcSlrC4pWktkIauI7N1iUoSITgPESBiSOsZuSU42FAReCLmCFOdUAW0W6s9nlNAlYdq7+RwdCsLKF0s6jwt+ftqIu9OxteAagSW9sxseEDBGZfB8vpImQRNF9GYYL26mCSr8bR5Nvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757805301; c=relaxed/simple;
	bh=8wDYtDrhpFgUUI+jhVG4Tnavlo0d2jYskZlAletJsXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GrP+q8+/1Wq4nCg2M3zNDy0jLCZXjTYH4jWg8ZqD+tdWxc/STwirtqo+oB6DevtzGfYBMErtOk7+kZxw30f+cTdP3DVWpPLvv/97+kWvaiLvOazvoqnveUArUyMW2hZpY022FtT6CQgyqhboxTsvlNXYnFVosG/Ae2Aagy2zTL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=WzeHUuy6; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757805289;
	bh=8wDYtDrhpFgUUI+jhVG4Tnavlo0d2jYskZlAletJsXY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WzeHUuy6lg97Q2koIZK33Jw7f5uG4oTiq8dmQAFKifab5663vM5HUqqH/FCTn+LVB
	 57n5vKQC+Xd0YHQJc/r39n0LGMiea81eyOqqivbXIF9GLLWSp3imOa2J3QJkuDjVWs
	 OBPsWTymIEjGY+JN20FEiGdJfbio1kUMW0ueB5OGl/rHUWvPOqcFvobu9moMCxMZ8M
	 MeVSB9BDkQGu57sL2SvZyQu0FwjqWFQ9oXsw/PAGarCpq42A8ll5PclZtRLL7+FDPK
	 m6PnyaripS2mgYHC2GiGP+44coUBkslaEXSBizP6LB9jx+JLI/wO8V/HqfMcOnHxLo
	 gkZT9sd5fzS5A==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id CB8FF600C4;
	Sat, 13 Sep 2025 23:14:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 924CD202FBF;
	Sat, 13 Sep 2025 23:14:38 +0000 (UTC)
Message-ID: <aba5915c-5246-4a31-a2ea-2eeedb4ab108@fiberby.net>
Date: Sat, 13 Sep 2025 23:14:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 06/13] tools: ynl-gen: deduplicate
 fixed_header handling
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 Sabrina Dubroca <sd@queasysnail.net>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250911200508.79341-1-ast@fiberby.net>
 <20250911200508.79341-7-ast@fiberby.net> <20250912172418.1271771d@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20250912172418.1271771d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/13/25 12:24 AM, Jakub Kicinski wrote:
> On Thu, 11 Sep 2025 20:04:59 +0000 Asbjørn Sloth Tønnesen wrote:
>> Fixed headers are handled nearly identical in print_dump(),
>> print_req() and put_req_nested(), generalize them and use a
>> common function to generate them.
>>
>> This only causes cosmetic changes to tc_netem_attrs_put() in
>> tc-user.c.
>>
>> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
>> ---
>>   tools/net/ynl/pyynl/ynl_gen_c.py | 39 ++++++++++++++++----------------
>>   1 file changed, 20 insertions(+), 19 deletions(-)
> 
> This only makes the code longer and harder to follow.

We have 3 functions using put_attr():
* put_req_nested()
* print_req()
* print_dump()

I was just trying to align them a bit more so that they don't
do the same thing in three different ways. I would prefer to
make these functions more aligned, as it will hopefully make
it easier avoid issue like the missing local variables for
.attr_put().

I agree these clean up patches would also fit better in a
dedicated cleanup series, the only reason that I added this to
this series, was because you pushed back, then I said that the
`len` dedup, and other "make code look natural" cleanups might
not be for this series.

I have dropped this patch in v4, it's not important for this
series.

