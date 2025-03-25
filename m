Return-Path: <netdev+bounces-177463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31714A70437
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3A83A54EE
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A391525A350;
	Tue, 25 Mar 2025 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OClNU45o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7334325A33A;
	Tue, 25 Mar 2025 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914167; cv=none; b=qdRpKXsc9sEO1spsGOnO1YnsKNIylXZ/gM2kXOy78pBIbTTDKGWSypjrNjRSfJXjyFpQIrdvD2nNI5zJD7nCYdIMhVtqLYZO5ecsoUmQMnljvN0BQDRVp83B+TTH7VM4h9Q7Eind8y87adrCxyZE+DzuQW5F+MXnSl6l+vnObWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914167; c=relaxed/simple;
	bh=BQI8r2tNSf/GBr8upXFWeT4J4zHpNsizwzERSQmTE/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vl4oiu9Kw/VKEhMLZ/mUJ36IOrQYCKv3z0HBfBn/FsVaFG1jqhGDDxoyUbWHq3GtiIYi0JSzXo8ZW9wZj60bxV92SpEq23rajbvP5xCxjJ+NEOk95B64ZgXsz8uhQbqbgLHUDIuNiq4mqA5hbMoClK3ogG8K+kNO6Lupy64QUx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OClNU45o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66455C4CEE4;
	Tue, 25 Mar 2025 14:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742914167;
	bh=BQI8r2tNSf/GBr8upXFWeT4J4zHpNsizwzERSQmTE/o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OClNU45o8k2Ffx8CtCqNfwzaT1lBkxRbTt4KtSaLSoeHwPMCKM4fg7/yq9NVfllrF
	 ZjDZ6glQzMNEOF5OPTvLZjlcEztnVCi/+uhheu/ci8qDL7AUvb1rdRCtn+hmNwVXU8
	 7GKViKBOp/nRReFJl6qYTbSSaj43uBBkhMlUfh0KOPtJYWW1vIsJ8wg0xrvaBb/GCF
	 tMpP3LIybYsvTsaHoJ+OgDeoQTsEYzTez0sJtsoGEVbeAmx2mDWD+PiclgvfiNZbLX
	 eaEIsn7ces7P34Z8JZ+MvXjPP4eQvkoOzCBtxt4UMcR5imz+A8jzhYEykbqLv/KgaI
	 8Rw9Ox5KgWw5g==
Message-ID: <75cccf77-7a4e-4ef0-9dca-2f1903c4a7ca@kernel.org>
Date: Tue, 25 Mar 2025 15:49:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next] mptcp: pm: Fix undefined behavior in
 mptcp_remove_anno_list_by_saddr()
Content-Language: en-GB, fr-BE
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
References: <20250325110639.49399-2-thorsten.blum@linux.dev>
 <7F685866-E146-4E99-A750-47154BDE44C6@linux.dev>
 <20250325053058.412af7c5@kernel.org>
 <7EEE7001-CCD4-4A5A-8723-3AAC3A88F6FF@linux.dev>
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
In-Reply-To: <7EEE7001-CCD4-4A5A-8723-3AAC3A88F6FF@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Thorsten,

On 25/03/2025 13:51, Thorsten Blum wrote:
> On 25. Mar 2025, at 13:30, Jakub Kicinski wrote:
>> On Tue, 25 Mar 2025 12:33:11 +0100 Thorsten Blum wrote:
>>> On 25. Mar 2025, at 12:06, Thorsten Blum wrote:
>>>>
>>>> Commit e4c28e3d5c090 ("mptcp: pm: move generic PM helpers to pm.c")
>>>> removed a necessary if-check, leading to undefined behavior because
>>>> the freed pointer is subsequently returned from the function.
>>>>
>>>> Reintroduce the if-check to fix this and add a local return variable to
>>>> prevent further checkpatch warnings, which originally led to the removal
>>>> of the if-check.
>>>>
>>>> Fixes: e4c28e3d5c090 ("mptcp: pm: move generic PM helpers to pm.c")
>>>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>>>> ---  
>>>
>>> Never mind, technically it's not actually undefined behavior because of
>>> the implicit bool conversion, but returning a freed pointer still seems
>>> confusing.
>>
>> CCing the list back in.
> 
> Thanks!
> 
> The change imo still makes sense, but the commit message should be
> updated.

Yes, I think it still makes sense, and I understand the confusion.
Another reason to change that is to avoid future issues when kfree()
will be able to set variables to NULL [1].

Instead of re-introducing the if-statement, why not assigning 'ret' to
'entry'?

  entry = mptcp_pm_del_add_timer(...);
  ret = entry; // or assign it at the previous line? ret = entry = (...)
  kfree(entry);

[1] https://lore.kernel.org/20250321202620.work.175-kees@kernel.org

> I'll submit a new patch for after the merge window.
Thank you!

An alternative if you want to send it before is to rebase it on top of
the MPTCP "export" branch, and to send it only to the MPTCP ML. I can
apply the new version in our tree, and send it to Netdev later with
other patches.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


