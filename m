Return-Path: <netdev+bounces-167272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69377A398B1
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 11:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE7B53A2944
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 10:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6FB23024C;
	Tue, 18 Feb 2025 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2QapTgU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D04A198E81;
	Tue, 18 Feb 2025 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873921; cv=none; b=dFuWcQWCUSbuelvbHaTy85JsxvCQlk1TUcS4N7SkUuCmBUqnCmsSWdoBM3craEk89NbBp9nrLBTbzvL7zMspNBcKiu2R1CDIUXxX6g7A8Xz22nypnqdjwViaVQKCuuPrqjNd2qTqm1lTU0a/3NXm5HnKW1vf2aR86mywzvcuw30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873921; c=relaxed/simple;
	bh=1+S3gKfrEcgZOPoRZp4/LU2M06dkJFc1PkOFh9PlaKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bexsAaEYtsev+MlJ/Wqzkkc2oAQo9Q8N5ZmHn2nMbVzsd4OSpIyoNuqZT6xC1vdyBFntxx9JpUzdPbwobPJLKsmMYzJkcrm6fvLxtt613t1Mdw+XAvxffibDQIP/GaVyhxpFGxJs9C+psE6ttrq5VMNOEIyFLi8Fu3xEKoZSvkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2QapTgU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805AEC4CEE2;
	Tue, 18 Feb 2025 10:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739873920;
	bh=1+S3gKfrEcgZOPoRZp4/LU2M06dkJFc1PkOFh9PlaKo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M2QapTgU2gq2Up/G9Rgx35AA/GTQMsa/gndyQ9YiYsIuFS+hqrpuqP0pbtB17dWho
	 R49OrRHUBphR4vTQdabbm6F83fWYQpKWyDr5u31mXLeNrRGK+xualhJueiDLOrhBAu
	 BwRoFRD9aE2zIUz8/RF+2zBTckZIngaWwP3dWhHBE9GIhbBbUozduFx+obvvlYdhSj
	 CsZo2W70GoivaQQ0KlOexkI8tiiM9qArQoyzBdSoPkop8MBEf+eU6+VFUroKmsP7f3
	 fbPX62GzjJRT+Tu2eJchNuPkDbtCLy2EBAoGr6T1x2drzF7dDA4toty8BN7FCCnBhw
	 gSONTeWvp5wjg==
Message-ID: <f5e6302e-f91a-4fc8-b12e-faebb7c26e05@kernel.org>
Date: Tue, 18 Feb 2025 11:18:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH REPOST] selftests: net: Fix minor typos in MPTCP and
 psock_tpacket tests
Content-Language: en-GB
To: Suchit K <suchitkarunakaran@gmail.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, horms@kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org
References: <CAO9wTFggVh9LvJa_aH=dDBLrwBo8Ho4ZfYET3myExiqf0yfDCA@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzSRNYXR0aGlldSBC
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUDpDAIZAQAKCRD2t4JPQmmgcz33
 EACjROM3nj9FGclR5AlyPUbAq/txEX7E0EFQCDtdLPrjBcLAoaYJIQUV8IDCcPjZMJy2ADp7
 /zSwYba2rE2C9vRgjXZJNt21mySvKnnkPbNQGkNRl3TZAinO1Ddq3fp2c/GmYaW1NWFSfOmw
 MvB5CJaN0UK5l0/drnaA6Hxsu62V5UnpvxWgexqDuo0wfpEeP1PEqMNzyiVPvJ8bJxgM8qoC
 cpXLp1Rq/jq7pbUycY8GeYw2j+FVZJHlhL0w0Zm9CFHThHxRAm1tsIPc+oTorx7haXP+nN0J
 iqBXVAxLK2KxrHtMygim50xk2QpUotWYfZpRRv8dMygEPIB3f1Vi5JMwP4M47NZNdpqVkHrm
 jvcNuLfDgf/vqUvuXs2eA2/BkIHcOuAAbsvreX1WX1rTHmx5ud3OhsWQQRVL2rt+0p1DpROI
 3Ob8F78W5rKr4HYvjX2Inpy3WahAm7FzUY184OyfPO/2zadKCqg8n01mWA9PXxs84bFEV2mP
 VzC5j6K8U3RNA6cb9bpE5bzXut6T2gxj6j+7TsgMQFhbyH/tZgpDjWvAiPZHb3sV29t8XaOF
 BwzqiI2AEkiWMySiHwCCMsIH9WUH7r7vpwROko89Tk+InpEbiphPjd7qAkyJ+tNIEWd1+MlX
 ZPtOaFLVHhLQ3PLFLkrU3+Yi3tXqpvLE3gO3LM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l
 5SUCP1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp
 9nWHDhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM
 1ey4L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vf
 mjTsZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbi
 Kzn3kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IP
 Qox7mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqf
 Xlgw4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUs
 x6kQO5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskG
 V+OTtB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIv
 Hl7iqPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCr
 HR1FbMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb
 6p0WJS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxj
 Xf7D2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbW
 voxbFwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoa
 KrLfx3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6
 UxejX+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7I
 vrxxySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOv
 mpz0VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0
 JY6dglzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHaz
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CAO9wTFggVh9LvJa_aH=dDBLrwBo8Ho4ZfYET3myExiqf0yfDCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Suchit,

On 18/02/2025 10:28, Suchit K wrote:
> Fixes minor spelling errors:
> - `simult_flows.sh`: "al testcases" -> "all testcases"
> - `psock_tpacket.c`: "accross" -> "across"
> 
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> ---
>  tools/testing/selftests/net/mptcp/simult_flows.sh | 2 +-
>  tools/testing/selftests/net/psock_tpacket.c       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh
> b/tools/testing/selftests/net/mptcp/simult_flows.sh

The patch is exactly the same as v1, containing the same issues: long
lines are wrapped, corrupting the patch, like here above.

> index 9c2a41597..2329c2f85 100755
> --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
> +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
> @@ -28,7 +28,7 @@ size=0
> 
>  usage() {
>   echo "Usage: $0 [ -b ] [ -c ] [ -d ] [ -i]"
> - echo -e "\t-b: bail out after first error, otherwise runs al testcases"
> + echo -e "\t-b: bail out after first error, otherwise runs all testcases"
>   echo -e "\t-c: capture packets for each test using tcpdump (default:
> no capture)"

Same here

>   echo -e "\t-d: debug this script"
>   echo -e "\t-i: use 'ip mptcp' instead of 'pm_nl_ctl'"
> diff --git a/tools/testing/selftests/net/psock_tpacket.c
> b/tools/testing/selftests/net/psock_tpacket.c

Same here

> index 404a2ce75..221270cee 100644
> --- a/tools/testing/selftests/net/psock_tpacket.c
> +++ b/tools/testing/selftests/net/psock_tpacket.c
> @@ -12,7 +12,7 @@
>   *
>   * Datapath:
>   *   Open a pair of packet sockets and send resp. receive an a priori known
> - *   packet pattern accross the sockets and check if it was received resp.
> + *   packet pattern across the sockets and check if it was received resp.
>   *   sent correctly. Fanout in combination with RX_RING is currently not
>   *   tested here.
>   *

How are you sending this patch? Using 'git send-email' following
instructions like the ones from [1]?

I do recommend using b4 to prepare and send patches, see [2].

[1] https://git-send-email.io
[2] https://b4.docs.kernel.org/en/latest/contributor/overview.html

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


