Return-Path: <netdev+bounces-256670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCAYKbsjg2nWhwMAu9opvQ
	(envelope-from <netdev+bounces-256670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 11:47:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47356E4BD5
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 11:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D2DD300E719
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 10:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F78399012;
	Wed,  4 Feb 2026 10:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5XUfZfG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F62372B3F;
	Wed,  4 Feb 2026 10:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770202039; cv=none; b=eIfC3uycOkG4SElkM1YWti0MybWF6JocGTLAk+EAuPTgPpAVJtcP9C2o6LwAVkF/zqxbm4SIHHy8bon0SYV/v2PxWc2KOJ2WQ9EAaelEcQEdbBmF8meaAaMWxF/63Te6vZM7oSeJowKp7sst676lvMG6jNh8kqZLByTyNbMg+10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770202039; c=relaxed/simple;
	bh=D/vdlnLyzaN0QF3n8GIGTjf2NTZ9bLWnm071K/SuhDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cOEemx5xKb7HZCuYK57lVRDW/2+XqScS+O0eQ9C5+D09LsWav2uJe+0PAeFXYQN44WRXO0BmJobMMZJX7LTC5BTrIyTUFv39aV8K2l9BvPEmG7KKF5Eb/DmV2vtVdacbwVFInX4ZOW2tiA4DP5TZo0bLLzpBYYU2UlhSkKUNEuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5XUfZfG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171DDC4CEF7;
	Wed,  4 Feb 2026 10:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770202038;
	bh=D/vdlnLyzaN0QF3n8GIGTjf2NTZ9bLWnm071K/SuhDM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c5XUfZfG0nTUy6F//9h+mGVevHuruLKwgme7sYOi6qFt3r+x3At/ugswNtwXh3fld
	 PP9eAL6BKHQ7JsywLqLNEDYVeMJoLWeaVOj8fsKPOWG2Wd0v6/jEkzKmlISLNSYa2C
	 YE76uPzLSk1WdR148Um037IgxF/DfHq3BGEpnv7W2bIqeJwWPsmZe9KpcpG/vuGcBi
	 +AaarvCrp+eB85pIfjFvT77x1hrj+qlOJc6A9SZ5+55+swp7bRrqDJ6cYGc0kyX1Vf
	 xZdwSUih5daDseFZ2WmlEJkfDm1YIRfgBEWlwGJVFTU8iePEoOD3u+3fw5I2K8o3mE
	 hcaNwtVVKrTqg==
Message-ID: <8037fb73-4e18-4ed1-9eaf-e4cd8b2c9d53@kernel.org>
Date: Wed, 4 Feb 2026 11:47:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next 07/15] mptcp: allow overridden write_space to be
 invoked
Content-Language: en-GB, fr-BE
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Gang Yan <yangang@kylinos.cn>
References: <20260203-net-next-mptcp-misc-feat-6-20-v1-0-31ec8bfc56d1@kernel.org>
 <20260203-net-next-mptcp-misc-feat-6-20-v1-7-31ec8bfc56d1@kernel.org>
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
In-Reply-To: <20260203-net-next-mptcp-misc-feat-6-20-v1-7-31ec8bfc56d1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256670-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47356E4BD5
X-Rspamd-Action: no action

Hello,

On 03/02/2026 19:41, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Future extensions with psock will override their own sk->sk_write_space
> callback. This patch ensures that the overridden sk_write_space can be
> invoked by MPTCP.
> 
> INDIRECT_CALL is used to keep the default path optimised.
> 
> This patch is shared early to ease discussions around future RFC and
> avoid confusions with this "fix" that is needed for different future
> extensions.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Co-developed-by: Gang Yan <yangang@kylinos.cn>
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/protocol.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index f4bfe91ca7f9..0bd1ee860316 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -975,7 +975,7 @@ static inline void mptcp_write_space(struct sock *sk)
>  	/* pairs with memory barrier in mptcp_poll */
>  	smp_mb();
>  	if (mptcp_stream_memory_free(sk, 1))
> -		sk_stream_write_space(sk);
> +		INDIRECT_CALL_1(sk->sk_write_space, sk_stream_write_space, sk);

Is it possible to drop only this patch from this series? It is
independent of the rest, and the AI review tool spotted that
sk->sk_write_space is not sk_stream_write_space by default.

I can send a v2 without this patch if preferred.

>  }
>  
>  static inline void __mptcp_sync_sndbuf(struct sock *sk)
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


