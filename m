Return-Path: <netdev+bounces-139166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBB89B08ED
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 17:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0752283DBA
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 15:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E201416FF5F;
	Fri, 25 Oct 2024 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgYSQvUS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B561A165EF8;
	Fri, 25 Oct 2024 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729871553; cv=none; b=TRcQlIyRjC+TTW9nTHds0bAAJ8hUA1UBoIc++AUucaYbuMa1Mc3l1sOaNvITnxR+MoIBR6VWcFN2k+08wT4vVuCj1SN8oO5Gp/1EJzWfUbxJwf91YJYoBku53XhBkLFcG57ARdN3GJZ394og7DSstK91wgXaSOkccXNfM3b4cgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729871553; c=relaxed/simple;
	bh=tZGjiCDpW51uCZKGL5brHwQQtM4jv1AtwQwvZbtlDpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewB0awRbYuksJrc68EUdpzU7ku52ZnDaexvwZLL+N8t6naTMVg0qvqQZkC7GH7Mv1ZoxBiNoM6al4Vq7mf2maoUKIAUtPhpTGDen4Puwo6vUqA2ny4wr5mVLLn0TZbRBVQ/kBTtwircmx00A9ffqF/JyUiO/VzdwdbbMBsEX9bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgYSQvUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B50C4CEC3;
	Fri, 25 Oct 2024 15:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729871553;
	bh=tZGjiCDpW51uCZKGL5brHwQQtM4jv1AtwQwvZbtlDpM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CgYSQvUSllOaLGqdbEOxBaDcU4xvq7QSKPHjbJU/X8VcMko0HBkdiF/SQPZ+Jr9gQ
	 l5A3m6r7goPKkeL3woAIFtOj/h7OGF0o37M+dt0T+c1vlj2pNc0Tc5bAfAc/AXEKGy
	 LG1M+nhMOUA9GKhOwmeCWzPhffuQ5SEJecadWWPHG5AehEWSOsS/ai+FXAQws0VysB
	 U3shwhp5CE7kvIiczz3bD4Viy3mDncctK4L1XOETaCPQLQcQ4lMY96/cxT2j5/I94q
	 zw0R0x6ymfUibb1NevuqB3+pUC15U+Ch7RoXgh4XOLBs5MXD1tmqPW8L+uzbwr7MNe
	 Ri9JH4J3j9E1w==
Message-ID: <805bd3a1-ae85-4d87-8678-0bf63a261c66@kernel.org>
Date: Fri, 25 Oct 2024 17:52:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next 2/4] mptcp: annotate data-races around
 subflow->fully_established
Content-Language: en-GB
To: Simon Horman <horms@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gang Yan <yangang@kylinos.cn>
References: <20241021-net-next-mptcp-misc-6-13-v1-0-1ef02746504a@kernel.org>
 <20241021-net-next-mptcp-misc-6-13-v1-2-1ef02746504a@kernel.org>
 <20241025095548.GM1202098@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20241025095548.GM1202098@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Simon,

Thank you for the review!

On 25/10/2024 11:55, Simon Horman wrote:
> On Mon, Oct 21, 2024 at 05:14:04PM +0200, Matthieu Baerts (NGI0) wrote:
>> From: Gang Yan <yangang@kylinos.cn>
>>
>> We introduce the same handling for potential data races with the
>> 'fully_established' flag in subflow as previously done for
>> msk->fully_established.
>>
>> Additionally, we make a crucial change: convert the subflow's
>> 'fully_established' from 'bit_field' to 'bool' type. This is
>> necessary because methods for avoiding data races don't work well
>> with 'bit_field'. Specifically, the 'READ_ONCE' needs to know
>> the size of the variable being accessed, which is not supported in
>> 'bit_field'. Also, 'test_bit' expect the address of 'bit_field'.
>>
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/516
>> Signed-off-by: Gang Yan <yangang@kylinos.cn>
>> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> ...
> 
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index 568a72702b080d7610425ce5c3a409c7b88da13a..a93e661ef5c435155066ce9cc109092661f0711c 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -513,7 +513,6 @@ struct mptcp_subflow_context {
>>  		request_bkup : 1,
>>  		mp_capable : 1,	    /* remote is MPTCP capable */
>>  		mp_join : 1,	    /* remote is JOINing */
>> -		fully_established : 1,	    /* path validated */
>>  		pm_notified : 1,    /* PM hook called for established status */
>>  		conn_finished : 1,
>>  		map_valid : 1,
>> @@ -532,10 +531,11 @@ struct mptcp_subflow_context {
>>  		is_mptfo : 1,	    /* subflow is doing TFO */
>>  		close_event_done : 1,       /* has done the post-closed part */
>>  		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
>> -		__unused : 8;
>> +		__unused : 9;
>>  	bool	data_avail;
>>  	bool	scheduled;
>>  	bool	pm_listener;	    /* a listener managed by the kernel PM? */
>> +	bool	fully_established;  /* path validated */
>>  	u32	remote_nonce;
>>  	u64	thmac;
>>  	u32	local_nonce;
> 
> ...
> 
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index 6170f2fff71e4f9d64837f2ebf4d81bba224fafb..860903e0642255cf9efb39da9e24c39f6547481f 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -800,7 +800,7 @@ void __mptcp_subflow_fully_established(struct mptcp_sock *msk,
>>  				       const struct mptcp_options_received *mp_opt)
>>  {
>>  	subflow_set_remote_key(msk, subflow, mp_opt);
>> -	subflow->fully_established = 1;
>> +	WRITE_ONCE(subflow->fully_established, true);
>>  	WRITE_ONCE(msk->fully_established, true);
>>  
>>  	if (subflow->is_mptfo)
>> @@ -2062,7 +2062,7 @@ static void subflow_ulp_clone(const struct request_sock *req,
>>  	} else if (subflow_req->mp_join) {
>>  		new_ctx->ssn_offset = subflow_req->ssn_offset;
>>  		new_ctx->mp_join = 1;
>> -		new_ctx->fully_established = 1;
>> +		WRITE_ONCE(new_ctx->fully_established, true);
>>  		new_ctx->remote_key_valid = 1;
>>  		new_ctx->backup = subflow_req->backup;
>>  		new_ctx->request_bkup = subflow_req->request_bkup;
> 
> My understanding is that 1) fully_established is now a single byte and
> 2) WRITE_ONCE is not necessary for a single byte, as if I understand Eric's
> comment in [1] correctly, tearing is not possible in this case.

Good point, I appreciate this note, I didn't realise it was always not
necessary to use it for a single byte!

Just to be sure: is it an issue to keep them?

I mean: here, we are not in the fast path, and I think it "feels" better
to see WRITE_ONCE() being used when all the readers use READ_ONCE(). Do
you see what I mean? Not to have to think "strange, no WRITE_ONCE() here
; oh but that's fine here because it is a single byte when I look at its
definition".

Also, many other single byte variables in MPTCP structures are being
used with WRITE_ONCE(): "msk->fully_established" (used just above), but
also the other booleans declared above the new one in the subflow
context structure, and in other structures declared in protocol.h.

(Note that WRITE_ONCE() could also be a NOOP when used with a single
byte to keep the consistency, if it is always useless in this case.)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


