Return-Path: <netdev+bounces-89848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7DA8ABE5F
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 03:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCFA81C208F5
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 01:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96201211C;
	Sun, 21 Apr 2024 01:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kn2uWjC3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBA453A9
	for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 01:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713664420; cv=none; b=fAfxzSP/gjn+1kxceeXTEXKNQxaV8D8Dy01i3gWJBe39sYDHK6CRr7azJZ95HZxQRpWY+heal727zTrqQybwSFH98YoLLMKFzKbEGucc0c9qqpIfn7YQQVcl+lfp8Q7EAlK0BACNGiIc020UXxDSnY+kAkX8epztpWJoydarRNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713664420; c=relaxed/simple;
	bh=VP6j4yYM5KuS8hRDsX9QMtTyFMSvRselgwtL4B3Vrqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGEIHaUFqSYEK1B/hQLA09lFSKh/u44bZ+xnKKHPjQmlx3rLdiWvvDOnuVGy4XKtI4RSc0vW8JtUMzLiNXFNV0e4rwl255ZLt2KE98q2TdrcKvOMFXqnYx/U8U6GFgfiAn8WUEaE/iE78U3MfMk2lw7xudtZU/V5I8oWmmUfMcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kn2uWjC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC49EC072AA;
	Sun, 21 Apr 2024 01:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713664419;
	bh=VP6j4yYM5KuS8hRDsX9QMtTyFMSvRselgwtL4B3Vrqo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kn2uWjC3QGoPdnSiF0YChalS8a0B9zIOycncQOPHi0TtO83zC+5DKJPWmTlf5PUa2
	 TI4h5oO9L/QorrRpteW1rJ+dspi1DtzZRwkE+qLIHUvmaRBmbPHql4PNbpXqr/k3n1
	 mYhWzp0U3h0CFWledt9jK26EYtxinPJwDKYGxy1FqfIz9tigPdGkzrZGE9xqpZ0mMN
	 p3qxqOYBjPm1R5x1ZRA0OUBolaRSwN/hzckI2RTPNZ7KLdmOpJVuMZ4S7d24ukkdTM
	 7cjj2kpkwG2qiesihBFas3KUCKpFA0aq1OZD6P17CUhYx/Q7cQyqw4Tn58nzKX/c4o
	 1Ct+vw2BmJ0gw==
Message-ID: <41fc42a1-a0ed-4bbc-9bf5-d5876431497d@kernel.org>
Date: Sat, 20 Apr 2024 19:53:39 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2 2/2] f_flower: implement pfcp opts
Content-Language: en-US
To: Wojciech Drewek <wojciech.drewek@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, dsahern@gmail.com
References: <20240415125000.12846-1-wojciech.drewek@intel.com>
 <20240415125000.12846-3-wojciech.drewek@intel.com>
 <20240415145238.0f5286a3@hermes.local>
 <7d57d275-b58b-4b88-9436-863b5770cee8@intel.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <7d57d275-b58b-4b88-9436-863b5770cee8@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/24 4:20 AM, Wojciech Drewek wrote:
> 
> 
> On 15.04.2024 23:52, Stephen Hemminger wrote:
>> On Mon, 15 Apr 2024 14:50:00 +0200
>> Wojciech Drewek <wojciech.drewek@intel.com> wrote:
>>
>>> 	} else if (key_tb[TCA_FLOWER_KEY_ENC_OPTS_PFCP]) {
>>> +		flower_print_pfcp_opts("pfcp_opt_key",
>>> +				key_tb[TCA_FLOWER_KEY_ENC_OPTS_PFCP],
>>> +				key, len);
>>> +
>>> +		if (msk_tb[TCA_FLOWER_KEY_ENC_OPTS_PFCP])
>>> +			flower_print_pfcp_opts("pfcp_opt_mask",
>>> +				msk_tb[TCA_FLOWER_KEY_ENC_OPTS_PFCP],
>>> +				msk, len);
>>> +
>>> +		flower_print_enc_parts(name, "  pfcp_opts %s", attr, key,
>>> +				       msk);
>>>  	}
>>
>> I find the output with pfcp_opt_key and pfcp_opt_mask encoded as hex,
>> awkward when JSON.
> 
> But we don't support JSON output for pfcp_opts.
> Do you want me to implement it?
> 

json support is preferred.


