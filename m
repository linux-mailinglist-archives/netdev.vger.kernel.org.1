Return-Path: <netdev+bounces-267020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LdISNRWdsmndOAAAu9opvQ
	(envelope-from <netdev+bounces-267020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 12:01:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC7C2708B7
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 12:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6695E3023A7C
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29B139281B;
	Thu, 12 Mar 2026 11:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+SGG5FR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B91B823DD;
	Thu, 12 Mar 2026 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773313292; cv=none; b=Fh4EwCRoTl1XLCS4JbS6L8Wz66U1+lPqr5cltyLJ8n5WOYJBl/UTFEZZ9Q3MQJWIGQAq2AHZ2Xnbnm22k/+8uQ6aVALbDwDSIs3WhTzSUEEyuLcRZjM3k75m/h83LL/4RexAtAMtZZj7Ex3ZM8ftjXJpWjw5ZXQ0myaw8OW9V1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773313292; c=relaxed/simple;
	bh=+Ulv+PCYekiAEop42YtuVmuhDO5Wmf5GGZG23pHYKps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SEcJF27GIEhBbEk1m4R2vjVQjXkNCrfLd6MRMF+nVAaE4l6bNcdQeqnT2R3yqdLzMO1cKnytbxQ+3f4bCKWanmH7zbLbfmIvTmpupZcN2bWE4NJGy3F6nCJj2Y9XGK3RrIBnEWseAEaSFmUf8E1t0Yr5ODM3FjZGDNuZR/JarAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+SGG5FR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591C6C4CEF7;
	Thu, 12 Mar 2026 11:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773313291;
	bh=+Ulv+PCYekiAEop42YtuVmuhDO5Wmf5GGZG23pHYKps=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p+SGG5FRxlZ4uxcoqLLyxtMOuhYboEMc3iKZe+NZ8LRsukrNgN6+d6B5uyGWLC71y
	 6fTSEq9NXVq3wpguq2DWqJbiAEl+bm3Jb6GCwCngidmv9YWRzV4yTyfBYE1t84CUrT
	 dL+kXjY7gaKtBULPEUKubNEGW+tXF8GwO8s/fHtvRyORxb0E9ASZGbnAuAQa1CRKZ5
	 MTaMHrNlASOYf8pr6ZITrsyx9OBXcSzOdoD/ex/srzXYQi/TRepcLBm6QBZKS6erBv
	 AjyZpp2Jx7u79jhe5J5Nav83z/FZxx8qk1Nxz9AT7lz/s3u/pzZxETib+jNHEZt9eg
	 HtCi9k+LloE1w==
Message-ID: <bb4e4feb-cc51-4418-93a5-47c2781e6d17@kernel.org>
Date: Thu, 12 Mar 2026 12:01:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v3 2/6] mptcp: keep rcv_mwnd_seq in sync with
 subflow rcv_wnd
Content-Language: fr
To: Simon Baatz <gmbnomis@gmail.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 mptcp@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 David Ahern <dsahern@kernel.org>, Jon Maloy <jmaloy@redhat.com>,
 Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com,
 Shuah Khan <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
 <20260309-tcp_rfc7323_retract_wnd_rfc-v3-2-4c7f96b1ec69@gmail.com>
 <334053df-9824-4bfe-b37c-8711d0a5a9bd@kernel.org>
 <abHnyJInqmGNIWiq@gandalf.schnuecks.de>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <abHnyJInqmGNIWiq@gandalf.schnuecks.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267020-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	RSPAMD_EMAILBL_FAIL(0.00)[gmbnomis.gmail.com:query timed out];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8BC7C2708B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Simon,

On 11/03/2026 23:08, Simon Baatz wrote:
> On Wed, Mar 11, 2026 at 07:27:34PM +0100, Matthieu Baerts wrote:
>> On 09/03/2026 09:02, Simon Baatz via B4 Relay wrote:
>>> From: Simon Baatz <gmbnomis@gmail.com>
>>>
>>> MPTCP shares a receive window across subflows and applies it at the
>>> subflow level by adjusting each subflow's rcv_wnd when needed.  With
>>> the new TCP tracking of the maximum advertised window sequence,
>>> rcv_mwnd_seq must stay consistent with these subflow-level rcv_wnd
>>> adjustments.
>>
>> Thank you for these modifications!
>>
>>> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
>>> ---
>>>  net/mptcp/options.c | 6 ++++--
>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>> index 43df4293f58bfbd8a8df6bf24b9f15e0f9e238f6..8a1c5698983cff3082d68290626dd8f1e044527f 100644
>>> --- a/net/mptcp/options.c
>>> +++ b/net/mptcp/options.c
>>
>> (...)
>>
>>> @@ -1338,8 +1339,9 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
>>>  		 */
>>>  		rcv_wnd_new = rcv_wnd_old;
>>>  		win = rcv_wnd_old - ack_seq;
>>> -		tp->rcv_wnd = min_t(u64, win, U32_MAX);
>>> -		new_win = tp->rcv_wnd;
>>> +		new_win = min_t(u64, win, U32_MAX);
>>> +		tp->rcv_wnd = new_win;
>>
>> Out of curiosity, why did you change the two lines above?
>> (even if it makes sense, the diff is a bit confusing, and the commit
>> message doesn't mention this :) )
> 
> I wanted to keep tcp_update_max_rcv_wnd_seq() calls close to the
> respective update sites (same pattern everywhere).

Thanks, I now understand the reason.

> In the original form
> 
> tp->rcv_wnd = min_t(u64, win, U32_MAX);
> tcp_update_max_rcv_wnd_seq(tp);
> new_win = tp->rcv_wnd;
> 
> the ordering suggests that tcp_update_max_rcv_wnd_seq() might modify
> tp->rcv_wnd.

Note that if tp->rcv_mwnd_seq always needs to be modified when
tp->rcv_wnd and/or tp->rcv_wup are modified, maybe a single helper could
be called to modify all of them, so it might be less likely to forget
about modifying tp->rcv_mwnd_seq as well in the future.

But probably it might be unlikely to have new places where tp->rcv_wnd
and/or tp->rcv_wup need to be modified like here with MPTCP. So probably
fine like that.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


