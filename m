Return-Path: <netdev+bounces-231420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 690B0BF9292
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 00:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6D3A4EA337
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 22:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D372309AA;
	Tue, 21 Oct 2025 22:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Ec9Wg9hN"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0255D1DE4C4;
	Tue, 21 Oct 2025 22:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761087260; cv=none; b=O83x0LqM7/IxZxThUGSHWCQQ2puJx+O5fn/s/Mn65ecQSB1/O0mPj789D/zz+KK0lu0ViExoqZQaFX7o7F+cySZUxyso7G13aiLSWJwxgEzBBMjc6LH24xhcz+x60NvfWqPIe4GQo1CtCXUif6wCgV/IseENeQAZgTiVosWB9c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761087260; c=relaxed/simple;
	bh=Mz6ppVPbPpZy4N6bSRCqo74i7MJXXQUsttNkV9dweYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OxdwjhmlYGv+qXJ/Ho919KXo3AHCSRRMu2qJzjGPDhisJH43nQWSEKUckx2jNMIXkUuio6Gw/qNbPmK5UO4DOpPCckPTIEGqC3AYNgqa9Q4siO9MVAFS1W7pUBu7sGLSv+m0G2TgCjgnblabGdSTrMqcRSK1UgyjI/wBci8jNzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Ec9Wg9hN; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1761087248;
	bh=Mz6ppVPbPpZy4N6bSRCqo74i7MJXXQUsttNkV9dweYM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ec9Wg9hN1I0HzLAu495AZ/VzRkMZBnsY6sJvrjdRhk3OgIRMcLwWwMjLAlB5ZxWno
	 1AHjxr9dwaSHcjWpeUOnvXlQKKxQ/6/3odaD93jlGQWQmS+quC66sgFffYknCdgrEF
	 9kH3iacZsWkDZvRMvLIU59+w3pVXRox8Qotk99HYNTVSagje6cv/C9ttLrb33aWMOW
	 o83xSzxSOMLln1h5Zcre3P+9Z+HyL/JLwc2utFvqrvGsnYAgssLAt8tkLU3jNhVLw2
	 9h4soE8Io+f1b7F4EEsGo2ryfVSjdO5xMIP0bZ9ygINGuUP4xjl2T6gKn1Y+NgJVI7
	 63J/metiOCNUg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 29D096000C;
	Tue, 21 Oct 2025 22:53:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 84F52200ABF;
	Tue, 21 Oct 2025 22:52:57 +0000 (UTC)
Message-ID: <de6e309f-0b03-4224-a035-d06c2765b023@fiberby.net>
Date: Tue, 21 Oct 2025 22:52:56 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] tools: ynl: add start-index property for indexed
 arrays
To: Zahari Doychev <zahari.doychev@linux.com>,
 Jakub Kicinski <kuba@kernel.org>, jacob.e.keller@intel.com
Cc: donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, matttbe@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, johannes@sipsolutions.net
References: <20251018151737.365485-1-zahari.doychev@linux.com>
 <20251018151737.365485-5-zahari.doychev@linux.com>
 <20251020163221.2c8347ea@kernel.org>
 <75gog4sxd6oommzndamgddjbz3jrrrpbmnd4rhxg4khjg3rnnp@tlciirwh5cig>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <75gog4sxd6oommzndamgddjbz3jrrrpbmnd4rhxg4khjg3rnnp@tlciirwh5cig>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/25 5:50 PM, Zahari Doychev wrote:
> On Mon, Oct 20, 2025 at 04:32:21PM -0700, Jakub Kicinski wrote:
>> We need to be selective about what API stupidity we try to
>> cover up in YNL. Otherwise the specs will be unmanageably complex.
>> IMO this one should be a comment in the spec explaining that action
>> 0 is ignore and that's it.
>>
> 
> I am not sure if this applies for all cases of indexed arrays. For sure
> it applies for the tc_act_attrs case but I need to check the rest again.
> 
> Do you think it would be fine to start from 1 for all indexed arrays?

I have a series, that I will try to get posted tomorrow, where I add a new
attribute `ignore-index` which can be used to mark indexed arrays where the
index is just an incremental value. This is a follow-up to an earlier
discussion[1].

In that series, in order to add the new attribute to the existing specs,
in the commit messages I walk through all the existing indexed arrays,
and also include things like if they start their indexes from 0 or 1.

[1] https://lore.kernel.org/netdev/7fff6b2f-f17e-4179-8507-397b76ea24bb@intel.com/

