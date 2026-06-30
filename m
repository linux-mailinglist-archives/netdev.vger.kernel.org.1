Return-Path: <netdev+bounces-303239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wBBfOOrUQ2onjwoAu9opvQ
	(envelope-from <netdev+bounces-303239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:38:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E706E5804
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:38:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JkSdYDgo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303239-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303239-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF0A4302BB9B
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8F043C043;
	Tue, 30 Jun 2026 14:36:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384E543C05C;
	Tue, 30 Jun 2026 14:36:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782830180; cv=none; b=otoq3xlr9xrWU+c6PBD9tH4jXf8eHc4Is3VugTiy4KpAWgJfkmcVFZzeAWkVV7P+oSo6lNBXQlNCTrt8MYNtca14HeoW9yqupkaA6UGm4WNq5Bi08bfH5IgdHnxXW7qwywVqXZ/XbmwbsNMURYf9lHZZTVrsx6t8Q5/tOOmoNgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782830180; c=relaxed/simple;
	bh=ilw4YVXEHWBPpGkFO4p7FYlUqGFBgKsMtwAiHrGJUxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rpziiSWg2MVk+bkAlsoJ1IwRHBUgbEqEK9X67ZW+G5l6XeF5tUJBNRY5FAoGnJUErKhEiEgJ/aoUCFhwO4+P5vjRDSyHfXmpIb1a37ttFVsHIjpYjA9K+nYDcP7ExC9/ywNDWHufzoJ4Vqj0hOf0gSBbW7wo+vHq4R3a/A+Bg4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkSdYDgo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3B11F000E9;
	Tue, 30 Jun 2026 14:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782830178;
	bh=czYxuO/tfR9xu7bQEpayuXT8vTh36LiK41BVvSPbPvg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JkSdYDgo0uITQsfMoy1Z9pxd0cSyoSZM9ET7vGObSBuI4ydBiQ9OPB67vz5l+qY2G
	 cXRHblWdkbthGgtfNnwAqPNKSjEely0UMKSDCE16YDUx8pryaSXgu9QGM1h1WZWp0m
	 b4HrBjeBSB8ENSD+qqjVPTasv06xzZyPHRuKep3LvAi0zvVBRvR88whx2bzOXn2OpR
	 wx2+6DDhantJ0PLX+BZf3Aj4n6zhf4Bp+WAUTb1op1B5a+Xx6IqzhLHTSpvrGrjJ/O
	 xVjj9W0ufFP9iuo2Fo97vYO2XMCd+p5cha+hSbHMf4F+wL9FhExQEd/vI0/LRR6rfe
	 FKyIgtnEOIURg==
Message-ID: <9d9cceae-3934-4dd6-ae8e-af995ae6b0ab@kernel.org>
Date: Tue, 30 Jun 2026 08:36:17 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2 2/2] devlink: support u64-array values in
 devlink param show/set
Content-Language: en-US
To: Ratheesh Kannoth <rkannoth@marvell.com>, stephen@networkplumber.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 jiri@resnulli.us
References: <20260630015012.3728870-1-rkannoth@marvell.com>
 <20260630015012.3728870-3-rkannoth@marvell.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260630015012.3728870-3-rkannoth@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[vger.kernel.org:server fail,sea.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-303239-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rkannoth@marvell.com,m:stephen@networkplumber.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:pabeni@redhat.com,m:jiri@resnulli.us,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43E706E5804

On 6/29/26 7:50 PM, Ratheesh Kannoth wrote:
> diff --git a/devlink/devlink.c b/devlink/devlink.c
> index 9372e92f..3c29601d 100644
> --- a/devlink/devlink.c
> +++ b/devlink/devlink.c
> @@ -3496,13 +3496,115 @@ static const struct param_val_conv param_val_conv[] = {
>  };
>  
>  #define PARAM_VAL_CONV_LEN ARRAY_SIZE(param_val_conv)
> +#define DEVLINK_PARAM_MAX_ARRAY_SIZE 32

Why 32? Is that based on current code? How does the kernel side handle
the number of parameters? What happens if the kernel sends more than 32
parameters - from a user's perspective, not this code and processing the
output?

> +
> +struct devlink_param_u64_array {
> +	uint64_t size;
> +	uint64_t val[DEVLINK_PARAM_MAX_ARRAY_SIZE];
> +};
> +
> +static int param_value_nested_u64_attr_cb(const struct nlattr *attr, void *data)
> +{
> +	struct devlink_param_u64_array *arr = data;
> +	unsigned int len;
> +
> +	if (mnl_attr_get_type(attr) != DEVLINK_ATTR_PARAM_VALUE_DATA)
> +		return MNL_CB_OK;
> +
> +	if (arr->size >= DEVLINK_PARAM_MAX_ARRAY_SIZE)
> +		return MNL_CB_ERROR;
> +
> +	len = mnl_attr_get_payload_len(attr);
> +	if (len == sizeof(uint32_t))
> +		arr->val[arr->size++] = mnl_attr_get_u32(attr);
> +	else if (len == sizeof(uint64_t))
> +		arr->val[arr->size++] = mnl_attr_get_u64(attr);
> +	else
> +		return MNL_CB_ERROR;
> +
> +	return MNL_CB_OK;
> +}
> +
> +static int param_value_u64_array_fill(struct nlattr *nl,
> +				      struct devlink_param_u64_array *arr)
> +{
> +	int err;
> +
> +	arr->size = 0;
> +	err = mnl_attr_parse_nested(nl, param_value_nested_u64_attr_cb, arr);
> +	if (err != MNL_CB_OK)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static bool param_value_u64_array_equal(const struct devlink_param_u64_array *a,
> +					const struct devlink_param_u64_array *b)
> +{
> +	uint64_t i;
> +
> +	if (a->size != b->size)
> +		return false;
> +
> +	for (i = 0; i < a->size; i++) {
> +		if (a->val[i] != b->val[i])
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +static int param_value_u64_array_put_from_str(struct nlmsghdr *nlh,
> +					      const char *param_value,
> +					      const struct devlink_param_u64_array *cur)
> +{
> +	struct devlink_param_u64_array new_arr = {};
> +	char *copy, *token, *saveptr = NULL;
> +	char delim[] = " ,";
> +	uint64_t val;
> +	int err;
> +
> +	copy = strdup(param_value);
> +	if (!copy)
> +		return -ENOMEM;
> +
> +	token = strtok_r(copy, delim, &saveptr);
> +	while (token) {
> +		if (new_arr.size >= DEVLINK_PARAM_MAX_ARRAY_SIZE) {
> +			free(copy);
> +			pr_err("Too many array elements (max %d)\n",
> +			       DEVLINK_PARAM_MAX_ARRAY_SIZE);
> +			return -EINVAL;
> +		}
> +		err = get_u64((__u64 *)&val, token, 10);
> +		if (err) {
> +			free(copy);
> +			pr_err("Value \"%s\" is not a number or not within range\n",
> +			       token);
> +			return err;
> +		}
> +		new_arr.val[new_arr.size++] = val;
> +		token = strtok_r(NULL, delim, &saveptr);
> +	}
> +	free(copy);
> +
> +	if (cur && param_value_u64_array_equal(&new_arr, cur))
> +		return 1;
> +
> +	for (uint64_t i = 0; i < new_arr.size; i++)

put the declaration at the top of the function with the rest of them.
global comment; fix all of them.

> +		mnl_attr_put_u64(nlh, DEVLINK_ATTR_PARAM_VALUE_DATA, new_arr.val[i]);

Why can't this put be done in the loop above as the string is processed?

> +
> +	return 0;
> +}
>  
>  static int pr_out_param_value_print(const char *nla_name, int nla_type,
>  				     struct nlattr *val_attr, bool conv_exists,
> -				     const char *label, bool flag_as_u8)
> +				     const char *label, bool flag_as_u8, struct nlattr *nl)
>  {
> +	struct devlink_param_u64_array u64_arr = { };
>  	const char *vstr;
> -	int err;
> +	char buffer[1024];
> +	int err, cnt = 0;
>  
>  	print_string(PRINT_FP, NULL, " %s ", label);
>  


