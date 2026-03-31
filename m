Return-Path: <netdev+bounces-273408-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +D76NzwWy2lrDwYAu9opvQ
	(envelope-from <netdev+bounces-273408-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:33:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C60362AC9
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D373B301546F
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA901DE2AD;
	Tue, 31 Mar 2026 00:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gM/SME+l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC16192590;
	Tue, 31 Mar 2026 00:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774917178; cv=none; b=civBv8lLsJuGVdl6M00B0pluVnW5bdxrdL6u7gXI7oBxyuX5gTMKmrljAPE1uVlB02JcZf+nn++oxq5LwAR8JLVAghESqfoZxv5sHGa3rMdJwVPuYGAvgiHyZEa4UPpmvShONELLC1k5ChfWIUM79BHE0JoQa2leY7vyURHkWXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774917178; c=relaxed/simple;
	bh=rhWblmww09z2cv9HzsSRTaZ0LmxQ98tMwMatZhyKrzc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rIruoQcIYAhMDlEuj5JM8GahBSeH+VKki7RDOxJqRsuitV3PCpR7njX5IKUootZ/i7JzaTfUU6B9J9EeU+LhOO+V+nqz/zweq6/jwY6SuvoMXcKkzs94e0oYsqFIMDLuZWve2jSy2Ax9EKKlMHBficX6Y9rcGwZ9qEApq5+Uui8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gM/SME+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EC1C4CEF7;
	Tue, 31 Mar 2026 00:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774917177;
	bh=rhWblmww09z2cv9HzsSRTaZ0LmxQ98tMwMatZhyKrzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gM/SME+lhAUd5mfdse9KGDuISob47fpywg7BPit08WYmfzcwfdpZ6SEB3shDuwfvH
	 WoAkSBfOOStAgmpJXQcoEKGuLlj+ZKBrDiqw+QN86Bt7/4zy7MriL10dZJnF8x0zMS
	 FBAuOxBLxVsv7f5efQ8Bqmk4pJiwqsIn0Pf+/mM8pyK6QsvuA/ZcZrtOjNXwBtaPUr
	 gxpgzZZ7fDf4kUIMSxt6Drq1ab60GKNFMJAdVBd3I2dqP62ny2IY1BEJBtK78y0Ty7
	 kn13kVk0bW046jIvZGu8XGKHoihxjCDmpl7+pwMcx26aRMVH/hvGOTxeybtaA6/YU1
	 oExuiKN3U1aKg==
Date: Mon, 30 Mar 2026 17:32:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, Yousuk Seung
 <ysseung@google.com>, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next 2/6] net/sched: netem: check for invalid slot
 range
Message-ID: <20260330173246.31029449@kernel.org>
In-Reply-To: <20260328182704.456993-3-stephen@networkplumber.org>
References: <20260328182704.456993-1-stephen@networkplumber.org>
	<20260328182704.456993-3-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-273408-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 80C60362AC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 28 Mar 2026 11:26:03 -0700 Stephen Hemminger wrote:
> Reject slot configuration where min_delay exceeds max_delay.
> The delay range computation in get_slot_next() underflows in
> this case, producing bogus results.
> 
> Fixes: 0a9fe5c375b5 ("netem: slotting with non-uniform distribution")
> 

spurious new line, but something either is a fix, gets a Fixes tag 
and goes to net, or it's not a fix and goes to net-next. No fixes 
in net-next please.

> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  net/sched/sch_netem.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index 73d0e85eeadc..de22d754cb79 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -831,6 +831,17 @@ static int get_dist_table(struct disttable **tbl, const struct nlattr *attr,
>  	return 0;
>  }
>  
> +static int validate_slot(const struct nlattr *attr, struct netlink_ext_ack *extack)
> +{
> +	const struct tc_netem_slot *c = nla_data(attr);
> +
> +	if (c->min_delay > c->max_delay) {
> +		NL_SET_ERR_MSG(extack, "slot min delay greater than max delay");

This wants _ATTR ?

> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
>  static void get_slot(struct netem_sched_data *q, const struct nlattr *attr)
>  {
>  	const struct tc_netem_slot *c = nla_data(attr);
> @@ -1045,6 +1056,12 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt, struct netlink_ex
>  			goto table_free;
>  	}
>  
> +	if (tb[TCA_NETEM_SLOT]) {
> +		ret = validate_slot(tb[TCA_NETEM_SLOT], extack);
> +		if (ret)
> +			goto table_free;
> +	}

