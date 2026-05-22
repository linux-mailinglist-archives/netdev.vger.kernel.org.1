Return-Path: <netdev+bounces-290932-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEkhHnHWEGrYeQYAu9opvQ
	(envelope-from <netdev+bounces-290932-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:19:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2515BB169
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F003300B126
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 22:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB95B39060F;
	Fri, 22 May 2026 22:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZR/DGCtH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F29F368277
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 22:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779488023; cv=none; b=oBi0KGO8s2GrKsBaBm6afNuka26H6gJb1m46MRemLmGUbw53z3RMjfiK1UbltJhg08M4D0/GwXpCVZ8ycDMwdM+ONZHEcQHxw0jdG36zxBgv//W4VbAJcZyW68iStE0xrOuH2KMo2KtP/5ArfwNNh7XCBt0q7DX8OSUyDDuWTcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779488023; c=relaxed/simple;
	bh=IuDggnaBdw02uL4PjJOPAR1IIKF72Fop7RMA17Bwv5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eOrvwgGWdUvtbMFbvkogKjBe1aHJXkZ1NiGRGjxI4qJi8s+1FML68MAdwDIMssfBhA9Whz7e4DeeGVnEtUmRbrmGCB3+I0M6BpwbQZ9jvSDyCCJB1OT8A6thzJUo2BaJL9BvF7YsWknN10gz4YCR6R+F3hHOl9JCv8eFTzjq9ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZR/DGCtH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1C91F000E9;
	Fri, 22 May 2026 22:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779488022;
	bh=EI/G/Z9PWNeoG4kmmfBv6DHwzY6iS/t9oo41HUH3Q7c=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=ZR/DGCtHQEKdNmesQ048MqXfD7Spxe8WIJhSByatM+KJjaQwJUODeCD+SOQqSjG/m
	 fOOUo+ncS2j/evi+JXHN011rAPcS3+l2US4hw9J56fPPOrEhWrknO0/95zWmorAiCT
	 LUz9qWIjmXnkuDwMEum6HFuCsDwPT/x1Qv4G8Ej7Kv8Zta1hkgDBV9ZQ36Z8KBHNX0
	 BAAEZ+gCKyDO+rDcOB+VEHl2uwb1/GKmIub2qFvUL08HeYAhEQeD7jHir3av+ReNaH
	 IwDeChI02uC7dRbitCghKaFtgvd2sYRyXLNjC80myCqCQkUVaLyGSxHAlaYWaEnFam
	 tjAu46/TGxbqw==
Message-ID: <3f4835f6-37f1-4263-8764-293306194845@kernel.org>
Date: Fri, 22 May 2026 16:13:41 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] tc/netem: display per-impairment xstats
 counters
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
References: <20260520173512.807908-1-stephen@networkplumber.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260520173512.807908-1-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290932-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CE2515BB169
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/20/26 11:34 AM, Stephen Hemminger wrote:
> The kernel now reports struct tc_netem_xstats via TCA_STATS_APP with
> per-impairment counters: delayed, loss, corrupted, duplicated,
> reordered, and ecn_marked.
> 
> Add netem_print_xstats() following the same pattern as
> fq_print_xstats()
> 
> Example output of `tc -s qdisc show dev eth0`:
>   qdisc netem 8001: root refcnt 2 limit 1000 delay 100ms loss 5%
>    Sent 1234567 bytes 15483 pkt (dropped 774, overlimits 0 requeues 0)
>    delayed 14709 dropped 774 corrupted 154 duplicated 309 reordered 61 ecn_marked 0
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  tc/q_netem.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/tc/q_netem.c b/tc/q_netem.c
> index c48fde11..98e28909 100644
> --- a/tc/q_netem.c
> +++ b/tc/q_netem.c
> @@ -870,8 +870,34 @@ static int netem_print_opt(const struct qdisc_util *qu, FILE *f, struct rtattr *
>  	return 0;
>  }
>  
> +static int netem_print_xstats(const struct qdisc_util *qu, FILE *f,
> +			      struct rtattr *xstats)
> +{
> +	struct tc_netem_xstats *st, _st;
> +
> +	if (xstats == NULL)
> +		return 0;
> +
> +	/* future proof for addition of more stats */
> +	memset(&_st, 0, sizeof(_st));
> +	memcpy(&_st, RTA_DATA(xstats), min(RTA_PAYLOAD(xstats), sizeof(*st)));
> +	st = &_st;
> +
> +	print_u64(PRINT_ANY, "delayed",    "  delayed %llu",   st->delayed);
> +	print_u64(PRINT_ANY, "dropped",    " dropped %llu",    st->dropped);
> +	print_u64(PRINT_ANY, "corrupted",  " corrupted %llu",  st->corrupted);
> +	print_u64(PRINT_ANY, "duplicated", " duplicated %llu", st->duplicated);
> +	print_u64(PRINT_ANY, "reordered",  " reordered %llu",  st->reordered);
> +	print_u64(PRINT_ANY, "ecn_marked", " ecn_marked %llu", st->ecn_marked);
> +	if (st->allocation_errors)
> +		print_u64(PRINT_ANY, "alloc_errors", " alloc_errors %llu", st->allocation_errors);

wrapped that line (98 chars is a bit much) and applied to iproute2-next



