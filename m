Return-Path: <netdev+bounces-305864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z7neMUtwTmoBMwIAu9opvQ
	(envelope-from <netdev+bounces-305864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 17:44:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0801472831E
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 17:44:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lBnJ3wOw;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305864-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305864-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A51D33020B61
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 15:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951AC3F12CB;
	Wed,  8 Jul 2026 15:18:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8423B38B8;
	Wed,  8 Jul 2026 15:18:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783523898; cv=none; b=Rb/nsFMheVl6UyzYtwGakPXN2AvbjYEHY8i56VxGsx6h+Zx2aVSWc/QVSF440LcvBB9UjwBEM4G0FpxeCaShZBGJBmdgQ19VeH1hgtvJLF6LMAr1Y/cbBIn3AYymmE5TBMHDnD07D5CJa8Mlj70+KH1eE2AR3wj4bHz0LiINuUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783523898; c=relaxed/simple;
	bh=hVLLP9ctd8IX3dhnbSd7/S7pBf4qrnCBsR221ie1WDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+ocvOiV1daOEztNxqwM6UYWgi7WPU76DzBqoaUDtSZzCgR07rveBj/7+rmfDlb7JhkxVaHBk6VGkXxZ5s230ODtov6Z+35o2Eae6S5IpkBe9517SEah4oFQ2EZ9F9Wz3VfwEY9C+crwGUW2E9YUghEUsHnJFQP1KikTFF+ipJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBnJ3wOw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27361F00A3A;
	Wed,  8 Jul 2026 15:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783523897;
	bh=IIWw6J2tftar4U32QMJUBurC/xgaQlSBZGNvsiWM3tE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lBnJ3wOwaTIJaiUXM3efsw2nz3JTqibBiG1nHc/F93OTSzeX4HFFLLVfBownWb4sw
	 tfNAn/JGW5Xh+exX2Y4HPFEzVv5X7ixxDFI2NDNU297IX9H19wFkkkSviO3EmltnSr
	 E+Q2TWvnN5mpiRnAjVUjZkN3kQe1gFuyYyAY/FbTGdxEfhUqJDv31EEuqW9yi/8P9E
	 DAr4iTYl5BJpuijQzRKgnHCFWqYQH3FLjmZ9w+AlySav3pffUIjSNZInOryVKVA4u7
	 Ck/fkdKypu0pKXj7Fylor91Ju7aUXGgghhHOtn3+eEvSDZRfzXFIiQCpbkFDukb/sd
	 +4FHMuLesoIpA==
Message-ID: <d7e3955e-6605-4de9-9641-f1755de65f1a@kernel.org>
Date: Wed, 8 Jul 2026 09:18:16 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v4 2/2] devlink: support u64-array values in
 devlink param show/set
Content-Language: en-US
To: Ratheesh Kannoth <rkannoth@marvell.com>, stephen@networkplumber.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 jiri@resnulli.us
References: <20260702031359.2392868-1-rkannoth@marvell.com>
 <20260702031359.2392868-3-rkannoth@marvell.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260702031359.2392868-3-rkannoth@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305864-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:rkannoth@marvell.com,m:stephen@networkplumber.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:pabeni@redhat.com,m:jiri@resnulli.us,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0801472831E

On 7/1/26 9:13 PM, Ratheesh Kannoth wrote:
> diff --git a/devlink/devlink.c b/devlink/devlink.c
> index 803ea5d7..5d092d92 100644
> --- a/devlink/devlink.c
> +++ b/devlink/devlink.c
> @@ -3516,12 +3516,143 @@ static const struct param_val_conv param_val_conv[] = {
>  
>  #define PARAM_VAL_CONV_LEN ARRAY_SIZE(param_val_conv)
>  
> +struct devlink_param_u64_array {
> +	uint64_t size;

use of uint64_t here causes claude to comment:

Style 2: int i loop counter vs uint64_t size field in
param_value_u64_array_put_from_str() — signed/unsigned comparison.


> +	uint64_t *val;
> +};
> +
> +static void param_value_u64_array_free(struct devlink_param_u64_array *arr)
> +{
> +	free(arr->val);
> +	arr->val = NULL;
> +	arr->size = 0;
> +}
> +
> +static int param_value_nested_u64_attr_cb(const struct nlattr *attr, void *data)
> +{
> +	struct devlink_param_u64_array *arr = data;
> +	unsigned int len;
> +	uint64_t val;
> +	uint64_t *new_val;

iproute2 follows netdev coding style - reverse xmas tree.

other comments from claude:

Bug 1 (both cmd_dev_param_set and cmd_port_param_set): When the new and
current U64_ARRAY values are equal, param_value_u64_array_put_from_str()
returns 1 as a sentinel. The code jumps to out: but err is still 1, so
the function returns a non-zero error code to its caller even though
nothing went wrong. All other types reach goto out with err = 0 because
a prior mnlu_gen_socket_sndrcv() call succeeded. Fix: explicitly set err
= 0 before the goto.

Bug 2 (JSON output for U64_ARRAY in pr_out_param_value_print): The loop
calls print_u64(PRINT_ANY, label, ...) with the same key on every
iteration. In JSON mode this produces duplicate keys ("value": 0,
"value": 1, ...), which is invalid JSON. Needs
open_json_array()/close_json_array() wrapping the loop.

Style 1: flag_as_u8 is repurposed to select which netlink attribute to
parse for U64_ARRAY — its name is completely unrelated to this use,
making the code fragile.


Please show json output in the commit message as well.


