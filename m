Return-Path: <netdev+bounces-286620-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKojFa+8AWoJjQEAu9opvQ
	(envelope-from <netdev+bounces-286620-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 13:25:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E35E850CAF1
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 13:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7FCA6300A30E
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7967C371049;
	Mon, 11 May 2026 11:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4vdMEtG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5510B2C0299;
	Mon, 11 May 2026 11:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778498731; cv=none; b=sXMh21y5anfu6hY0wra3uZjVae0miADDM8eYm5v0/ggAFl8oW70Q6VvLxEDvSmOj+r12PxY6Rg2xqGNibekhM8WoE6W51+4bavJj2oYX1f+8ZmCqVooeCeZ80XyLIyGjUmyP5Uuple+g0K02YmBvXq7SECTldGp2uNP22mXA/ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778498731; c=relaxed/simple;
	bh=w3guzvyASfYrFyqBwE8/oBQLOP9kwSiWu56SinbzOCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QjwzUPUpmBzmyxw6VdQBuVHDBbD5u9ntCCdfBuj5QZHFwBHHVWKpyeGi4CH4JFZExtIZzxoa4+RdAn/YItFv3Usxwz6ErbJu0MV+Ijc7b9rHcDN7YWfQJCwXeR7ZNCO0JVF8eKyYPQroMMkDu/1bb4a5re+tQ5pZu3C1BRYja6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4vdMEtG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C361AC2BCB0;
	Mon, 11 May 2026 11:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778498731;
	bh=w3guzvyASfYrFyqBwE8/oBQLOP9kwSiWu56SinbzOCc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M4vdMEtGh2R+yj/SAmYpboFuH2l06z1+b0WxW8D0CQtEHOr8YxVfelwjAxEqvOHPN
	 vxJ4YnBUF836M8yWSS7fJwofG3o6X+B9Se491XvSI4j+awRJRUmjvtxFWJ/8GNZS1s
	 DstTIdVELCmOhS91rtLMx4HmkdNTdMDKy8jjJ51lbVVm+2IMLwRKw0GABX6ozDrNeX
	 gDO2mDFeFPNl0CeiFTVQFeL4v3j8LhtBLmEyckfiHUvOdy+NrFvgaDSNfQMyneUakh
	 2U7NYC0RwmIs4Q2CKkHsJ22hZJ0p0PHwXEgI5s2xc6Qo+0M1Y4pCxS5qvybE7/iEVV
	 Hiqg9cPttooHA==
Message-ID: <549e318b-5f37-4b8b-b76a-563831525042@kernel.org>
Date: Mon, 11 May 2026 13:25:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next 3/8] mptcp: pm: kernel: allow flushing more than
 8 endpoints
Content-Language: fr
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260508-net-next-mptcp-pm-inc-limits-v1-0-c84e3fdf9b6a@kernel.org>
 <20260508-net-next-mptcp-pm-inc-limits-v1-3-c84e3fdf9b6a@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260508-net-next-mptcp-pm-inc-limits-v1-3-c84e3fdf9b6a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E35E850CAF1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286620-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,alist.nr:url]
X-Rspamd-Action: no action

Hello,

On 08/05/2026 17:40, Matthieu Baerts (NGI0) wrote:
> The mptcp_rm_list structure contains an array of IDs of 8 entries: to be
> able to send a RM_ADDR with 8 IDs. This limitation was OK so far because
> there could maximum 8 endpoints.
> 
> But this is going to change in the next commit. To cope with that, if
> one of the arrays is full, the iteration stops, the lists are processed,
> then the iteration continues where it previously stopped.
> 
> Note that if there are many endpoints to remove, and multiple RM_ADDR to
> send, it might be more likely that some of these RM_ADDRs are dropped or
> lost. This is a known limitation: RM_ADDR are not retransmitted in
> MPTCPv1.

(...)

> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index aabd73d15c15..ea3a7ea82013 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -1223,19 +1223,30 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
>  }
>  
>  static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
> -					      struct list_head *rm_list)
> +					      struct list_head *rm_list,
> +					      struct mptcp_pm_addr_entry *entry)
>  {
> -	struct mptcp_rm_list alist = { .nr = 0 }, slist = { .nr = 0 };
> -	struct mptcp_pm_addr_entry *entry;
> +	struct mptcp_rm_list alist, slist;
> +	bool more;
>  
> -	list_for_each_entry(entry, rm_list, list) {
> -		if (slist.nr < MPTCP_RM_IDS_MAX &&
> -		    mptcp_lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
> +again:
> +	alist.nr = 0;
> +	slist.nr = 0;

FYI, Sashiko Gemini is saying:

> Are the ids arrays in alist and slist left uninitialized on the stack here?
> Later, in mptcp_pm_remove_addr(), a full struct assignment
> (msk->pm.rm_list_tx = *rm_list) copies the structure. Could this copy
> uninitialized stack memory into the persistent socket structure and
> trigger KMSAN use-of-uninitialized-value warnings?

It is not an issue, because if 'nr' are 0, nothing else is read from the
structures. AFAICS KMSAN will then not complain if the uninitialized
values are not used.

> +	more = false;

Sashiko Gemini is saying:

> If "more" is true and the function loops back to process another batch,
> mptcp_pm_remove_addr() will have already set the MPTCP_RM_ADDR_SIGNAL bit in
> msk->pm.addr_signal during the first iteration.
> Since mptcp_pm_flush_addrs_and_subflows() is called with lock_sock(sk) held,
> the MPTCP TX path cannot run to transmit the RM_ADDR and clear the signal bit
> between iterations.
> When the loop processes the second batch and calls mptcp_pm_remove_addr()
> again, msk->pm.addr_signal is still set.
> Will this cause mptcp_pm_remove_addr() to return -EINVAL and silently drop all
> batches after the first locally?

That's fine: RM_ADDR are notifications that can be lost anyway. What is
important is to remove the different addresses internally.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


