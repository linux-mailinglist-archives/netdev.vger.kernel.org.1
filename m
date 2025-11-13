Return-Path: <netdev+bounces-238259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 152E5C5693D
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 10:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 46B9A353F57
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 09:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4862D6E78;
	Thu, 13 Nov 2025 09:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiT9ia6k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467D62D1F7B
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 09:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763025709; cv=none; b=ejzvp4AfgkwIVBYcuCCUg8LQW68AS1JiinN+7I5SPVJrIA/wAz6BClQ6OTyTcOtFx2Fq7RvfsnL5PDWVIe9XvsVMeGP88IjQ2Dc8g6YGCqicBhnUVWPY7FzkNJfOb/jLaWA4jFFk28ge4UY6S6v5tk/g/kkV5sKld5vqu+He7Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763025709; c=relaxed/simple;
	bh=+Rc3gD0O3vqv/OjSzaWoPNmb5Kbbl+gtSUhidy7ZmeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7MC1RzpW+zUM0wVz9nXWQqiqPs0O3LnXPsA2jJsRj0KfTpBsm+zIPt1on/DpLTMK/VoEu50eM7KEoqO/YJyKQTabNX/XIROkG9ZRgIeWZj2u7CySAzc00oZ2zbSOzEwxPoHVfUGCwmvu4JRd8fcN+N5HT4Sr0NR4mmHs5ZAaUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiT9ia6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFF5C4AF09;
	Thu, 13 Nov 2025 09:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763025708;
	bh=+Rc3gD0O3vqv/OjSzaWoPNmb5Kbbl+gtSUhidy7ZmeI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eiT9ia6kx5R/VP2Wt/UAkKKgU+m07Ek60wm0F+v0690KaUGGBDaEdFNAo5FcK0oqo
	 jPShrOqCeaFDM1ew6ZtPc6IDLOPkwFWo7+xTmT1+Z1HMM7L22i9kcyXDmst5V9oHuw
	 JATzcepaAOa/1ZdvNPwUZcbVbD6qhvd+7VJH62060sQbBLXQ0TFf0i2wpkNVH2YvGJ
	 QH8BbEWrMdAl8EZpZn/DIsh1rreL90CXD9sQ8P2kZupR28hofF9yFGAbjVAk/NIk+a
	 nWpHhbdHdv7i6ntBfB4L7ahrUmAP4/8miPuyqyo34wYKT7dAdpmgwHmOQW48Ov5Q2X
	 77PvSG7eSn4iQ==
Message-ID: <e63b88ca-ba6b-4a6f-9a57-8d3b2e8c5de2@kernel.org>
Date: Thu, 13 Nov 2025 10:21:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCHv3 net-next 3/3] tools: ynl: add YNL test framework
Content-Language: en-GB, fr-BE
To: Hangbin Liu <liuhangbin@gmail.com>,
 Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jan Stancek <jstancek@redhat.com>, =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnes?=
 =?UTF-8?Q?en?= <ast@fiberby.net>, Stanislav Fomichev <sdf@fomichev.me>,
 Ido Schimmel <idosch@nvidia.com>, Guillaume Nault <gnault@redhat.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Petr Machata <petrm@nvidia.com>
References: <20251110100000.3837-1-liuhangbin@gmail.com>
 <20251110100000.3837-4-liuhangbin@gmail.com> <m27bvwpz1x.fsf@gmail.com>
 <aRV1VZ6Z-tzbDlLH@fedora>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <aRV1VZ6Z-tzbDlLH@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Hangbin,

On 13/11/2025 07:06, Hangbin Liu wrote:
> On Tue, Nov 11, 2025 at 11:51:38AM +0000, Donald Hunter wrote:
>>> diff --git a/tools/net/ynl/tests/Makefile b/tools/net/ynl/tests/Makefile
>>> new file mode 100644
>>> index 000000000000..4d527f9c3de9
>>> --- /dev/null
>>> +++ b/tools/net/ynl/tests/Makefile
>>> @@ -0,0 +1,38 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +# Makefile for YNL tests
>>> +
>>> +TESTS := \
>>> +	test_ynl_cli.sh \
>>> +	test_ynl_ethtool.sh \
>>> +# end of TESTS
>>> +
>>> +all: $(TESTS)
>>> +
>>> +run_tests:
>>> +	@echo "Running YNL tests..."
>>> +	@failed=0; \
>>> +	echo "Running test_ynl_cli.sh..."; \
>>> +	./test_ynl_cli.sh || failed=$$(($$failed + 1)); \
>>> +	echo "Running test_ynl_ethtool.sh..."; \
>>> +	./test_ynl_ethtool.sh || failed=$$(($$failed + 1)); \
>>
>> This could iterate through $(TESTS) instead of being hard coded.
>>
>>> +	if [ $$failed -eq 0 ]; then \
>>> +		echo "All tests passed!"; \
>>> +	else \
>>> +		echo "$$failed test(s) failed!"; \
>>
>> AFAICS this will never be reported since the scripts only ever exit 0.
>> The message is also a bit misleading since it would be the count of
>> scripts that failed, not individual tests.
>>
>> It would be great if the scripts exited with the number of test failures
>> so the make file could report a total.
> 
> Oh, BTW, do you think if we should exit with the failed test number or just

I know these new tests are not in the selftests, but maybe "safer" to
keep the same exit code to avoid being misinterpreted?

  KSFT_PASS=0
  KSFT_FAIL=1
  KSFT_XFAIL=2
  KSFT_XPASS=3
  KSFT_SKIP=4

If there is a need to know which tests have failed, why not using (K)TAP
format for the output?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


