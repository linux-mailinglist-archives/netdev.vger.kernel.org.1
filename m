Return-Path: <netdev+bounces-270567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJxbIelRwWnqSAQAu9opvQ
	(envelope-from <netdev+bounces-270567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 15:44:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3F72F519F
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 15:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67D463012D02
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 14:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEDC3AD525;
	Mon, 23 Mar 2026 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BspFQl6O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEA0396D3D;
	Mon, 23 Mar 2026 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774276699; cv=none; b=X/97pvFUnIMo4bvFh2OsE/akQ0OOQDSQpoHdOtJukhx0hpWnWnRXX5q9iXwziBPN0/Iy5GpdqY9YY1dCPUpbp7PRx8ZSErhYYQgqCWk+QSKB/DC4E/wC3JnPIyk5bTSRht2FKr4kZDu52QKkioJbXDX06JXqpacLPEcW/P/xVbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774276699; c=relaxed/simple;
	bh=m+j+MhLLJJbGtfM5ZjFBvOSHaKIIKvND+pIr/YOfjfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DipmnAXXE+Nz9TKWoYeAc/Z2+RdRgaruPo0GL5OTzzhEYpQMG7UnuqQa21br+wjKoTEBZbEsyYsrZHozywFVxUFUmEY0TSqyW16weV3Z/WqNjFnXBRGW6wqclfx4tf02znRhKmcqgjrm2mRBqGyy3bfiVvp3sLxFbwcDrMk31LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BspFQl6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42723C4CEF7;
	Mon, 23 Mar 2026 14:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774276698;
	bh=m+j+MhLLJJbGtfM5ZjFBvOSHaKIIKvND+pIr/YOfjfE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BspFQl6O01XpBCqs35BFydtRQkdnTjNP+beGYOz/5Vvqck+yB6br0QusOzKZAo5dp
	 lP0FD3vRv++0TJVSWBUBkaPzYLcaHsCSGpCae/dIhEaiS2b/zoXHbrUXBPoSsqob4K
	 n82WEL3b+2XpWMwgQ+vzGg2e5stmkQunUwkscqOJOwuyVDbPMiiGfJjeLfpZTlLH0y
	 7dok1GkrQGvc6yr/XexcmJWfu/S5ndJF14cHXPvvxaleJpKN5g7a/GdyxCXWFvqDdS
	 OpYoRqpZy1eYxG5x2+KYTW45xnTEXEuEvCuiP7L4WiHT1yCGLR3mUgE5T//us9bIKL
	 TqsLTkQcI8qMQ==
Message-ID: <2f1d55ee-440c-49a6-97a8-4354c57f9fe9@kernel.org>
Date: Mon, 23 Mar 2026 08:38:17 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11 net-next v4] Convert CONFIG_IPV6 to built-in and
 remove stubs
Content-Language: en-US
To: Fernando Fernandez Mancera <fmancera@suse.de>,
 Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, rbm@suse.com,
 linux-kernel@vger.kernel.org
References: <20260320185649.5411-1-fmancera@suse.de>
 <20260322172702.GA121169@shredder>
 <8c136575-e23e-4cc2-a455-f1ba1abde2d5@suse.de>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <8c136575-e23e-4cc2-a455-f1ba1abde2d5@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-270567-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1C3F72F519F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 6:19 AM, Fernando Fernandez Mancera wrote:
> On 3/22/26 6:27 PM, Ido Schimmel wrote:
>> On Fri, Mar 20, 2026 at 07:55:52PM +0100, Fernando Fernandez Mancera
>> wrote:
>>> Changes:
>>>    v4:
>>>      Patch 2: new patch introduced on this revision
>>>      Patch 3: drop some IS_BUILTIN(IPV6) on files compiled only when
>>> IPV6=y
>>>      Patch 5: introduce ipv6_mod_enabled() checks on fib6_nh_init(),
>>> ip6_dst_lookup_flow() and ip6_fragment() to avoid crash when
>>> ipv6.disable=1 during boot
>>>      Patch 6: use &nd_tbl on code guarded by IS_ENABLED(CONFIG_IPV6)
>>
>> The IPv6 code is still using ipv6_get_nd_tbl() for some reason. If you
>> remove it from there (it's not needed), then we are only left with
>> handful of users that can be converted to use '&nd_tbl' when IPv6 is
>> enabled. Something like the patch below.
>>
> Hi Ido, the main reason why ipv6_get_nd_tbl() is used on IPv6 code is
> due to inlined functions. __ipv6_neigh_lookup_noref() is used in several
> places not guarded by IS_ENABLED(CONFIG_IPV6) preprocessor directive.
> That leads to undefined references when compiling with CONFIG_IPV6=n.
> 
> ld: vmlinux.o: in function `bpf_ipv4_fib_lookup':
> filter.c:(.text+0x322b9dc): undefined reference to `nd_tbl'
> ld: filter.c:(.text+0x322b9fb): undefined reference to `nd_tbl'
> ld: filter.c:(.text+0x322ce1a): undefined reference to `nd_tbl'
> ld: vmlinux.o: in function `ipv4_confirm_neigh':
> route.c:(.text+0x345ade7): undefined reference to `nd_tbl'
> ld: route.c:(.text+0x345ae06): undefined reference to `nd_tbl'
> ld: vmlinux.o:route.c:(.text+0x345b74f): more undefined references to
> `nd_tbl' follow

are these errors with Ido's suggested additional change?

