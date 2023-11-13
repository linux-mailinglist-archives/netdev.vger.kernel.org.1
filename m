Return-Path: <netdev+bounces-47476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 903B37EA618
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C335FB20A6C
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 22:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90573C699;
	Mon, 13 Nov 2023 22:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dqz8r4KO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3ED3C685
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 22:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0AEC433C7;
	Mon, 13 Nov 2023 22:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699915099;
	bh=FGsv7wdXiQu6Iku/2xGrGpaJYro5jFVKqvwxloDF4qk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dqz8r4KOXJO7ioJ0Oww+RFpXkPQA9G/1IJBJ4RNT9gw7tQhCP+3cxeGRkP/c9z8Q3
	 rObwpp4LQqBjWfP13VfknEbzcwKDua/LRRplbQn9zkxUe6oDwGPbXbe6YKsFEGGHXn
	 ZCbvI+UtsuNsImVwf5rXQPo5WX0//LHKJOjXitMPwdtJU2ABxtfAosLZbnWmCfS2bj
	 mZ2T2qCFDWaNMAUAjimjHQYo7FFL4lry2szcGldpzEFm2Qk88qrwwV6rDOM21HPcEZ
	 /g2HA9iHpFVRR5o25GfY8PIaPddQdKr8xUsLzMBHeMzmPm428/ZOvQ8qUuQF3uyGaD
	 0AZAO+IH62w6A==
Message-ID: <f27315c4-c20c-48cc-9fee-7f00c853921e@kernel.org>
Date: Mon, 13 Nov 2023 15:38:18 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2] ip, link: Add support for netkit
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: razor@blackwall.org, martin.lau@kernel.org, netdev@vger.kernel.org
References: <20231113032323.14717-1-daniel@iogearbox.net>
 <20231113093429.434186eb@hermes.local>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231113093429.434186eb@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/23 10:34 AM, Stephen Hemminger wrote:
> On Mon, 13 Nov 2023 04:23:23 +0100
> Daniel Borkmann <daniel@iogearbox.net> wrote:
> 
>> +	if (tb[IFLA_NETKIT_POLICY]) {
>> +		__u32 policy = rta_getattr_u32(tb[IFLA_NETKIT_POLICY]);
>> +		const char *policy_str =
>> +			policy == NETKIT_PASS ? "forward" :
>> +			policy == NETKIT_DROP ? "blackhole" : "unknown";
>> +
> 
> If you plan to add more modes in future, a table or helper would be good idea.
> 

I would prefer a table driven approach through a helper than the
multi-line logic here.

