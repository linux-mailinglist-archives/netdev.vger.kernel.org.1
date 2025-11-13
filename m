Return-Path: <netdev+bounces-238267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1D4C56BD9
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 403403ADA20
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 09:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309662DF71D;
	Thu, 13 Nov 2025 09:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXHQDoRV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6052DF709
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763027996; cv=none; b=T7ljefVivAmj+dnK4Qvpx04fvngdq6OhMFAqYPGRT7hBrKjR9Kja8TRP+yKpH4mzoBePrRBiRHEP7caoDTTBycPzI54uFE6DCn9MHjmP1jgOsbntCU9AqaDHqtETrvIBBd8okl1E/whJidIMgEuz3GLJ4f11Sitnt2Q4P90MSUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763027996; c=relaxed/simple;
	bh=/dgGs4C97wxy8uyC33Ehvup61Fr/520IRPHnpbPX4Xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEUGord7kmNhyRnFf/8w7pGfejf7yWttZYIi+/MGyE7Td5wu29H005DUJ/52HjWykHSnrqXz9tz6D9Lh014aKVH7772NzQc8J4/t72AUxkJ6EfiP2Iarx23mJIPNxQBSCp+6FRHQWxyi5+1O748AmrsnrdjVK6HeNBZfDreYClU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXHQDoRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB03C4CEF8;
	Thu, 13 Nov 2025 09:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763027995;
	bh=/dgGs4C97wxy8uyC33Ehvup61Fr/520IRPHnpbPX4Xk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TXHQDoRVde43WThwASzvo6wIqAPwnLvM5l36WGu4orOrJWqxXgvF4napv8vUdQy1V
	 bVQpJz5IwBOJ3cjL4q6mio8mo1sftIeCjwxojY2/DX7nNcE9YdF6o+XI5NAkb4lUU2
	 Sf3eQfmdxdY0HJzvN2Xqnh1q3Kd0hTpz2lIUhdiUIvXiVPL0V7py2JCO3Y7NSOacCy
	 durHk8Zfc4j4VKUJVzgvvS0jy60GxPNDbk9g1T2fUC90r+TZnXoglUAIGNIR1Tawzw
	 DO23Wi3IaganJuwrclQGSgdfTO3eEj79Qev9OcgLktS8gbwjKvRJlvA9YZQtIw8r4u
	 AJpUF4jvosLjQ==
Message-ID: <e5c95174-2f6f-439d-b557-6e223f982de5@kernel.org>
Date: Thu, 13 Nov 2025 10:59:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCHv3 net-next 3/3] tools: ynl: add YNL test framework
Content-Language: en-GB, fr-BE
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jan Stancek <jstancek@redhat.com>,
 =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
 Stanislav Fomichev <sdf@fomichev.me>, Ido Schimmel <idosch@nvidia.com>,
 Guillaume Nault <gnault@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Petr Machata <petrm@nvidia.com>
References: <20251110100000.3837-1-liuhangbin@gmail.com>
 <20251110100000.3837-4-liuhangbin@gmail.com> <m27bvwpz1x.fsf@gmail.com>
 <aRV1VZ6Z-tzbDlLH@fedora> <e63b88ca-ba6b-4a6f-9a57-8d3b2e8c5de2@kernel.org>
 <aRWqKA5nUAySkJFX@fedora>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <aRWqKA5nUAySkJFX@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/11/2025 10:51, Hangbin Liu wrote:
> On Thu, Nov 13, 2025 at 10:21:41AM +0100, Matthieu Baerts wrote:
>>>>> +	if [ $$failed -eq 0 ]; then \
>>>>> +		echo "All tests passed!"; \
>>>>> +	else \
>>>>> +		echo "$$failed test(s) failed!"; \
>>>>
>>>> AFAICS this will never be reported since the scripts only ever exit 0.
>>>> The message is also a bit misleading since it would be the count of
>>>> scripts that failed, not individual tests.
>>>>
>>>> It would be great if the scripts exited with the number of test failures
>>>> so the make file could report a total.
>>>
>>> Oh, BTW, do you think if we should exit with the failed test number or just
>>
>> I know these new tests are not in the selftests, but maybe "safer" to
>> keep the same exit code to avoid being misinterpreted?
>>
>>   KSFT_PASS=0
>>   KSFT_FAIL=1
>>   KSFT_XFAIL=2
>>   KSFT_XPASS=3
>>   KSFT_SKIP=4
> 
> Yes, that's why I ask about the return code. I also prefer use the same exit
> code with selftest.

Should you then exit with rc=4 instead of 0 in case of SKIP?

>> If there is a need to know which tests have failed, why not using (K)TAP
>> format for the output?
> 
> I feel it's too heavy to copy the (K)TAP format here. I would just using the
> exit code unless Jakub ask to using the specific output format

OK, I thought it was just a question of changing your 'echo' from "PASS"
and "FAIL" to "(not )ok ${COUNTER} (...)" + print the header and the
number of tests. But sure, if this format is not needed, no need to bother.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


