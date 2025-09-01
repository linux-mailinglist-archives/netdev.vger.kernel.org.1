Return-Path: <netdev+bounces-218912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B64CB3F053
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 23:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BAA42C078D
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 21:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6542690D5;
	Mon,  1 Sep 2025 21:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="c573L+J4"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AE220298C;
	Mon,  1 Sep 2025 21:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756761061; cv=none; b=ICFm/SfIdrEKoJGv5neov+Ll02nHK9rAl6wmRzqWthVShMIfai9jmA3NnVHmz4A7ktP067UK0JLVV+S5oJ0aFilzGp3Cm0/1AQkyuE3a2XTRtvgDbZyLFIDbqnYJEzUPmseuLLn32hxXs9mrYVujd2aavPtKRrM0ET485lGNz2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756761061; c=relaxed/simple;
	bh=7ur5mmjPY/HIn1XlTa0BTe/FlH1pt8Kop8wrtPnCpFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tlxsnwZpB0FAi7DZcMv1yAawQ31+CehI+vxKmaC4pLVElEhnmo2gQc8tz6scZL1gJrR0mCzE9MdztnkNPqnlqU8QSLinFQFLr+iQEY3r36eOtnk19shmJKRhPyiWFsNzs2owWfp9DtS0DuWs/VYTPFNV9n9JAANxj9S5BpneFfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=c573L+J4; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1756761055;
	bh=7ur5mmjPY/HIn1XlTa0BTe/FlH1pt8Kop8wrtPnCpFY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c573L+J4XCXPrbL6GKALIco6pSO4IlbDMIFF8QerLU6myV28ZFFR8Qpyq1kgcQVtz
	 KWq9Noc8+5M9hN8wrOt2/cOJD02yWK4QC2BnBoZC8/jD3TMofD5GeELKjBW0D5u9EM
	 rXZmSGKlhYveRwKlidnOIElPbKJfDqn4NdT0eqLaOlErcPr3st9OfsC2fWmw1eGVDd
	 gHiK7kxrzbmrLDPKWWwNm2wrU7yUZyU9DY/IiB2TVve9pAVgUZKQLQ2ZL0lCXUgFjR
	 twTOADwA/WpOTSMfzMdbtncEgyqRnfw6YUp2/CXSB7QYV8WlifI7nsFrh4g4sDqKbY
	 AOMsoCSYJN6Lw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 25BF560078;
	Mon,  1 Sep 2025 21:10:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 7B057201924;
	Mon, 01 Sep 2025 21:10:41 +0000 (UTC)
Message-ID: <be3fe50a-437d-40b5-8ff3-1db558f6e964@fiberby.net>
Date: Mon, 1 Sep 2025 21:10:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/4] tools: ynl-gen: use macro for binary min-len
 check
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 David Ahern <dsahern@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250901145034.525518-1-ast@fiberby.net>
 <20250901145034.525518-3-ast@fiberby.net>
 <20250901115208.0cc7e9a6@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20250901115208.0cc7e9a6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thank you for the quick reviews.

On 9/1/25 6:52 PM, Jakub Kicinski wrote:
> On Mon,  1 Sep 2025 14:50:21 +0000 Asbjørn Sloth Tønnesen wrote:
>> This patch changes the generated min-len check for binary
>> attributes to use the NLA_POLICY_MIN_LEN() macro, and thereby
>> ensures that .validation_type is not left at NLA_VALIDATE_NONE.
> 
> Please test this well and include the results in the commit message.
> I'm pretty sure it's fine as is.

You are right, because .type is unset, then .validation_type doesn't matter.

Sorry, I didn't do enough testing for the fixes, I had looked at the NLA_BINARY
case in validate_nla(), not NLA_UNSPEC.

Will re-post for net-next without fixes, and a new commit message.

