Return-Path: <netdev+bounces-286193-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6dHAJABe/2lJ5gAAu9opvQ
	(envelope-from <netdev+bounces-286193-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 18:17:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16679500713
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 18:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EBED300D97B
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 16:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCF92BEFED;
	Sat,  9 May 2026 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="ggKkdc9s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6738246782
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778343420; cv=none; b=E7f8JdjLsYq9cWWcSvJlOUIsb9AG3uub+xheGmgmJUr3hHHKprjiVjHAoHaOn0Pci3ekg9VbQ/KrxCARQZEt5qJ6YDiR99PJV4XHb6GeHCx9GlD1blaY1tTp4PPSgjiT26RpY2IvouUXRFsaVvyb4ZyjOWsQBiPAB7iXZIwnsqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778343420; c=relaxed/simple;
	bh=3xDSB3K202B0Xc2kvEIBPMDdc2cLIQyb9efpDgemxfA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRfNoXHCGRWLy/yHVTcOHKI7/tKYSgnel14xSf+5bvEO53xkc5dtK8kcXGjWTQNfAIOmGHEBX8bCJItOXoXDiWPQUMWkBPwALMDMlw86yEhz9jQWjxdieaF8kVyp4Ms9fcEh1bVPqDAE8Henpr5JE0UgZxl25zEIiR4dBRRUUNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=ggKkdc9s; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2f36da5c8fbso2947228eec.0
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 09:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778343418; x=1778948218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvV+7N115hqWDf7AxVDCQCtQTGv3SSU4elAZIl5DtPA=;
        b=ggKkdc9sdoenvpokdvp3PxHxnXxURR74GaxNarisjhIX2AG9GiAJBgXVm4+b2JJLAw
         Zfo1KA1O9AFXVREbl2yxeLpVBfTo2Gh2igQquz8VD5sNia7JVOWfiVrc6omC5anUVQoq
         AH8ER8YWuhBEhC6rVoE45uH7PS31ZpL98AzCAkC1zlhA61arYbPRGkUIyo1u3J7DiJzx
         2tC7VYPKWqGN9sY/ucRcs8YK2AjZ+comZNfo+edQnnOY8RKeNx0fpZJYwRcf/qnSmnWL
         pX93RP9EjGO65OBpQpLQS9RtGMVACQRplECkJhYVcL3/oHZ45Jdu0eiX01O5dL3rWFXy
         YRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778343418; x=1778948218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uvV+7N115hqWDf7AxVDCQCtQTGv3SSU4elAZIl5DtPA=;
        b=X/9NYiK2afAxXkpeBPHD98W08VVpMthFT3UkjgIqJlnQVMri59tExmEmHEXsZmJEVt
         YzgLc1aPAtuVSBviCt67SeslGcqVItBO/MfomHTnD4G7XW0pDVdDAyZbQoUkjkVQAJi5
         DSs4XeNEcWbYCVS28J5T2IbbRM7CIrhGtinTSyB0Ox9piOltBjjfEJ0Es3w3m/falYKF
         eSi37VpHD0bM3Y7SK1q+ovH+zmezuXGG9Ll9x71UgYC0QI5ue7fzmNIWEv9iyePQUX8P
         HWdO2Ge90G5vGsb3REO6Z+uWaZw7a2X8gY8YjWRplbOkxhyn3fsVe8GYXoxTim9jz265
         KTXg==
X-Gm-Message-State: AOJu0Yz2b5iKETjJi9Aapb1uVx//2RUPek6marPr1gGuAq4ryBSl1/Oy
	MDYi3KknihPtQNcY6LJ4qTO/eKlBFOY1NSWR15uZsyJ22bULQ9PphO2yID+JPlxUWTw=
X-Gm-Gg: Acq92OHI6Nv4c4TFb8J9IRplC9HZN2AHpUoMbZ/eltXF2muTrXWeXXkwfxF61HWEWc2
	wm00MLGdVQmhPbGNBQRTNrher/1R/3JMHC4dHBKAlNYcB6NtBwCDf+6cxLwEBsPUG61xz6QwbdF
	K3VobwKIWDRB5Lcax+BjtygSMrtDxhpnawEwCuhyDhWBg4WenL/7akjsJqUsvzz3Hvw7cWmBqnD
	Z5MIhynobw3wSo1VoXMXg0eUMAx/8ST+ogkXiDzzIFtpSY/Wpw+KEHMb1lh0Dz8IhkBvDOUJGo0
	6i27gnfOl7BG6mJyc5FDcMVcuc0fautOUSknpp09YgWuYVsccqtMUBEmklHbMtNcS4qIMJYoYcc
	lvoOpFtdJSqQSKLKl3NPMYH+OxzKprGeW59rXVWvhYRH9a+ShC3pAJYQ+UbiuEi7KoORbxQh7pH
	dB3QCpbNMGh6wztb8aw82SFdHZxZ6vt1vF7TfYFKHcvSQO6A==
X-Received: by 2002:a05:7300:df4b:b0:2ed:e12:3768 with SMTP id 5a478bee46e88-2fb5ff856bamr1031970eec.30.1778343417706;
        Sat, 09 May 2026 09:16:57 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88847506fsm7845399eec.18.2026.05.09.09.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 09:16:57 -0700 (PDT)
Date: Sat, 9 May 2026 09:16:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, ernis@linux.microsoft.com
Subject: Re: [PATCH iproute2-next v2 0/6] netshaper: Extend netshaper
 support
Message-ID: <20260509091654.6105884c@phoenix.local>
In-Reply-To: <20260509022353.3470738-1-mohsin.bashr@gmail.com>
References: <20260509022353.3470738-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 16679500713
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286193-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,anthropic.com:email,networkplumber-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

On Fri,  8 May 2026 19:23:47 -0700
Mohsin Bashir <mohsin.bashr@gmail.com> wrote:

> From: Mohsin Bashir <hmohsin@meta.com>
> 
> This series extends the netshaper CLI with missing parameter support
> and adds the group command for building scheduling hierarchies.
> 
> The existing netshaper tool only supports setting bw-max on individual
> shapers. This series adds the remaining shaper attributes (bw-min,
> weight) needed for TX scheduling, and introduces the group command
> which ties leaf shapers to a parent node in a single operation.
> 
> Changelog:
> 
>   Patch 1:
>   - parse_scope(): use loop over net_shaper_scope_names[]
>     instead of hardcoded string comparisons
>   - parse_rate(): replace magic number 8 with BITS_PER_BYTE
> 
>   Patch 2:
>   - Add has_bw_min/has_bw_max/has_weight booleans so zero-valued
>     attrs are correctly sent
>   - Add has_handle_id; only send handle id when explicitly provided
>   - Keep node id required in do_cmd(); only netdev scope has
>     optional id
>   - Only emit rate/weight attrs for set command, not show/delete
>   - Validate ll_name_to_index() return, error on unknown device
> 
>   Patch 3:
>   - Use print_rate() for bandwidth display instead of truncating
>     to integer Mbps
> 
>   Patch 4 (new):
>   - Extract struct shaper_args and parse_shaper_arg() helper to
>     share argument parsing between do_cmd() and do_group()
> 
>   Patch 5 (was v1 patch 5, v1 patch 4 dropped):
>   - Reuse parse_shaper_arg() for common argument parsing
>   - Validate group handle and parent scopes are node or netdev
>   - Require parent id when parent scope is node
>   - Fold optional node handle id into do_group() only
>   - Define NET_SHAPER_MAX_LEAVES (256) for leaves array size
> 
>   Patch 6:
>   - Document node id as required for set/show/delete, optional
>     only for group
>   - Add author to man page
> 
> V1: https://lore.kernel.org/netdev/20260501011611.3533573-1-mohsin.bashr@gmail.com/
> 
> Mohsin Bashir (6):
>   netshaper: Extract parse_scope() and parse_rate() helpers
>   netshaper: Add bw-min and weight parameter support
>   netshaper: Extend show output with parent, bw-min and weight
>   netshaper: Extract struct shaper_args and parse_shaper_arg() helper
>   netshaper: Add group command for creating scheduling hierarchies
>   netshaper: Update man page for new parameters and group command
> 
>  include/utils.h       |   1 +
>  man/man8/netshaper.8  | 140 ++++++++++--
>  netshaper/netshaper.c | 485 ++++++++++++++++++++++++++++++++++--------
>  3 files changed, 522 insertions(+), 104 deletions(-)
> 

Automated AI review is not setup for iproute2-next so ran it manually.

Subject: Re: [PATCH iproute2-next v2 0/6] netshaper: Extend netshaper support

On Fri, 8 May 2026, Mohsin Bashir wrote:

> This series extends the netshaper CLI with missing parameter support
> and adds the group command for building scheduling hierarchies.

Thanks for the patches. One issue found in patch 5:

On Fri, 8 May 2026 19:23:52 -0700, Mohsin Bashir wrote:
> +static int do_group(int argc, char **argv)
> +{
[...]
> +	err = rtnl_talk(&gen_rth, &req.n, &answer);
> +	if (err < 0) {
> +		printf("Kernel command failed: %d\n", err);
> +		return err;
> +	}

This error message uses printf() to write to stdout, which will corrupt
JSON output if enabled. Error messages must always go to stderr to preserve
the integrity of JSON output when using the -json flag.

This should be:
		fprintf(stderr, "Kernel command failed: %d\n", err);

The rest of the series looks good. All other error messages correctly
use fprintf(stderr, ...), the new parse_scope() helper properly uses
strcmp() instead of matches(), and the print_rate() usage for bandwidth
display is a nice improvement over the previous truncated integer Mbps
display.

With that fix:
Reviewed-by: Claude Assistant <noreply@anthropic.com>

