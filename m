Return-Path: <netdev+bounces-238735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 620D7C5EC61
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 19:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 974BC363037
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 18:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCF42D9EE4;
	Fri, 14 Nov 2025 18:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0lX28/j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657F92D6E4B
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 18:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763143452; cv=none; b=n4Ui6ttcGgysOroVkCNC/l/a6uQWjCSyis9jiwc6B1LxPQ2D7GzExv/uqgPb6tnPmxnWW5Q/+rNbu0B0tByi0rWUzmsVq3wGEAgNlLvtFoZ7uSLDwUXXW25xoZUYg4+uPsbnpK3a9BhHzpG+6/ZfzCR2LgLeTj87+AUJDf8hLbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763143452; c=relaxed/simple;
	bh=QFU7JWjWMiS12OfEDzIu2u4dBSRUh0rMOXA3nwPt5DA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jO+ozWvmJVqVRitU0rGMfx+N/kzRWxsxRjlAf8Zt3n+7mc6o5j2DaRMzrajOFGClkW1Vf9L/yrx8OlKpxYJOUAMuhELQgi6c2JGfWTy+5hyZj3FdXtOUbpybOXGrVA3ztNKtYw2JxKTbzrrx4F89bTsHM9nNjEP9iURggjqMDdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0lX28/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1AF2C4CEF5;
	Fri, 14 Nov 2025 18:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763143451;
	bh=QFU7JWjWMiS12OfEDzIu2u4dBSRUh0rMOXA3nwPt5DA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c0lX28/jG4iaHHWu76LTcIruE0v4vGgVXAj0BmnPsJj/XgLrTbqGiu9iGQQYkwHhJ
	 B8qaCMtJ4V0Hx7XVdv/T50lZKplfRlsEPSi26zvkW2YNb/6P5W0F/aMV2BZ9c2HApN
	 CiV91Vdbgu3k/yRAZfCaf8jfirdGrGa/qp2F7DjG4vwcUM++tEZgBscFKA93CRTl4K
	 6z6kdvwS76NylDP9/MWtxorwdPW9AZ5s+tjmufBMRQ3mINbuGVbZXYOKBrons97xxr
	 N/41dB3N5fRN//+GRcdJfxRqyazNonmyzAFFNT/+eqa6mNp01Iut/xSRd2aoFUdIEM
	 gJ/NLfpqWmYag==
Message-ID: <3f3ecb14-88ce-4de3-91b7-d1b84867c182@kernel.org>
Date: Fri, 14 Nov 2025 19:04:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 net-next 3/3] tools: ynl: add YNL test framework
Content-Language: en-GB, fr-BE
To: Donald Hunter <donald.hunter@gmail.com>,
 Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jan Stancek <jstancek@redhat.com>, =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnes?=
 =?UTF-8?Q?en?= <ast@fiberby.net>, Stanislav Fomichev <sdf@fomichev.me>,
 Ido Schimmel <idosch@nvidia.com>, Guillaume Nault <gnault@redhat.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Petr Machata <petrm@nvidia.com>
References: <20251114034651.22741-1-liuhangbin@gmail.com>
 <20251114034651.22741-4-liuhangbin@gmail.com> <m2pl9komz5.fsf@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <m2pl9komz5.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Donald,

On 14/11/2025 12:46, Donald Hunter wrote:
> Hangbin Liu <liuhangbin@gmail.com> writes:
>>
>> +cleanup() {
>> +	if [[ -n "$testns" ]]; then
>> +		ip netns exec "$testns" bash -c "echo $NSIM_ID > /sys/bus/netdevsim/del_device" 2>/dev/null || true
>> +		ip netns del "$testns" 2>/dev/null || true
>> +	fi
>> +}
>> +
>> +# Check if ynl command is available
>> +if ! command -v $ynl &>/dev/null && [[ ! -x $ynl ]]; then
>> +	ktap_skip_all "ynl command not found: $ynl"
>> +	exit "$KSFT_SKIP"
>> +fi
>> +
>> +trap cleanup EXIT
>> +
>> +ktap_print_header
>> +ktap_set_plan 9>> +setup
>> +
>> +# Run all tests
>> +cli_list_families
>> +cli_netdev_ops
>> +cli_ethtool_ops
>> +cli_rt_route_ops
>> +cli_rt_addr_ops
>> +cli_rt_link_ops
>> +cli_rt_neigh_ops
>> +cli_rt_rule_ops
>> +cli_nlctrl_ops
>> +
>> +ktap_finished
> 
> minor nit: ktap_finished should probably be in the 'cleanup' trap handler

@Donald: I don't think 'ktap_finished' should be called there: in case
of errors with an early exit during the setup phase, the two scripts
will call 'ktap_skip_all', then 'exit "$KSFT_SKIP"'. If 'ktap_finished'
is called in the 'cleanup' trap, it will print a total with everything
set to 0 and call 'exit' again with other values (and no effects). So I
think it is not supposed to be called from the exit trap.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


