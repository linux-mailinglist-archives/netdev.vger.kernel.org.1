Return-Path: <netdev+bounces-263884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DhJFLtaqGmZtgAAu9opvQ
	(envelope-from <netdev+bounces-263884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:15:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A827A203FEE
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B38332AED74
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 15:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF2B34E770;
	Wed,  4 Mar 2026 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwfUaB+4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C838934D939
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639334; cv=none; b=NkK/HxBlW/QoL6fvndda6NqVNoSEhKAmNDeEW4cKeEraxij9q8XQxBC8DpnWuG2ohukY9hvKfTU/SeR7vtczSAeGyFkv40D62AlmrZpr2v/wOqlUQP1WzbqTSALlafv/QezQ367ifLYePKt52XS/4X3ZjXsoeqVHU/Ez4V8icNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639334; c=relaxed/simple;
	bh=hJ4+IIviYkQQi0IXA+ww8JQAuvRltcrkKqqk8JiMmzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OnBzRZHefRANNCTPoglNWuIACbnnpONOVnVOuF5u+LDn7VtfrZ3p59IWVTsOG0FT/57rv8kaWtqYCqa4/K1E9+EXhPprxrvbd6S8IXluntTR2WaZ194SgCvdzHcxO5aMpQ6+4W5xH8R0Tr5n8880r2LLGEM0m6F2t2n5mObRN8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwfUaB+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203BFC2BCAF;
	Wed,  4 Mar 2026 15:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772639334;
	bh=hJ4+IIviYkQQi0IXA+ww8JQAuvRltcrkKqqk8JiMmzY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pwfUaB+4fiZRPevdnFd/pLVHkT/Ziz2Klq6YgsJSbTuETICMaw6OtWl0H3mNHmpux
	 tR3d76thWb/q9xQRAMgwtKDmpUclMoMc2AJCGUxTxJuVnReSWRvi3K++CT6rCH8dQL
	 5UArPViFgSQN+z2gbm1Z2tMuhYgM9g/X61StjjCY3mgb5qIL0NKncWpTs/89ovz59Z
	 iAhrJL1E9IWTt5JlyJiUBLQTcxmk1svdLv3oGcX4O+aA/cjsm6hE3o8FRYkYr3rflb
	 1qf2+w0ofccs6c34mY026MM8wOM7rZLXLDsVjgBtf6rUXWvVe3/uCPY8ZzjuolYFoi
	 8vEpQ9LBhZMkg==
Message-ID: <93b5fb6d-7aa0-481f-823f-995ed8ab0e52@kernel.org>
Date: Wed, 4 Mar 2026 08:48:53 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] inet_diag: report delayed ack timer information
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20260304094318.1769536-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260304094318.1769536-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A827A203FEE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-263884-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/4/26 2:43 AM, Eric Dumazet wrote:
> inet_sk_diag_fill() populates r->idiag_timer with the following
> precedence order:
> 
> 1 - Retransmit timer.
> 4 - Probe0 timer.
> 2 - Keepalive timer.
> 
> This patch adds a new value, last in the list, if other timers
> are not active.
> 
> 5 - Delayed ACK timer.
> 
> A corresponding iproute2 patch is needed to replace "unknown"
> with "delack":

...

> diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
> index 9d215485b5c7e7ba29dd53c924f0245439d74af5..e4cb18061aefcc22df04644c00bf5c7db4e150d2 100644
> --- a/net/ipv4/inet_diag.c
> +++ b/net/ipv4/inet_diag.c
> @@ -298,6 +298,10 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
>  		r->idiag_retrans = READ_ONCE(icsk->icsk_probes_out);
>  		r->idiag_expires =
>  			jiffies_delta_to_msecs(icsk->icsk_keepalive_timer.expires - jiffies);
> +	} else if (timer_pending(&icsk->icsk_delack_timer)) {
> +		r->idiag_timer = 5;

How come the idiag_timer values an enum in
include/uapi/linux/inet_diag.h since this is a uapi?

> +		r->idiag_expires =
> +			jiffies_delta_to_msecs(icsk_delack_timeout(icsk) - jiffies);
>  	}
>  
>  	if ((ext & (1 << (INET_DIAG_INFO - 1))) && handler->idiag_info_size) {


