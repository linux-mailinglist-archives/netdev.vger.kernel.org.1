Return-Path: <netdev+bounces-275809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPBfOvZc1GlrtQcAu9opvQ
	(envelope-from <netdev+bounces-275809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:25:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C67D3A8AE1
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DA4E301107F
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 01:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4231F91E3;
	Tue,  7 Apr 2026 01:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrSGLug5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257BB1F8691;
	Tue,  7 Apr 2026 01:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775525106; cv=none; b=Ou6CQC1Kjzu5Nt2GfMX7e4py6a0RviDLTEhMee1keVPKIuy5zZ+tm2AWNv0GyxFa13ry0jkGPMhZGLvrEEQyHdiKbNkqT5MPxvYGyTGdPLG5bP+U3QDIQGvZ6KcGJHuqzdigjf0Sb90nPU3WVfMTyfwoTGHUGuzZfgH271119vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775525106; c=relaxed/simple;
	bh=LKaanIRB0mVTM6u+vUqwo3v6gkW7YTy7tjioKxkgS7M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXDOkAe95CKa8Bxh0s3Q2OwSEKcJi24QTI9OIP/ULF2kUPvSPi8UM2d2AdS7f0HvQTTgJZGGN6eM9cjzXMUl5NM7Gj8ZSdWX0gy5R3JmEaIh6URpe0MRjOoJh7uqFd72GerD7c7Tt1et0oGHGsbEr/4LvJoXPOAbbSaY+p2imyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrSGLug5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C02CC4CEF7;
	Tue,  7 Apr 2026 01:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775525106;
	bh=LKaanIRB0mVTM6u+vUqwo3v6gkW7YTy7tjioKxkgS7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PrSGLug56Hz+rqzF+K21bcj59K+C1m+LyKp6JTfTh00e6ti4uSMf7BD55kOjzKoR6
	 7eQloHO+XzAINp/2uzCNhntk4NLo7BcukjoNTnfZ3Hk+DT9Yzz3aI5Akp/qDs7WuYX
	 p+PdMacOXiSeEdJ1k/pnT8R7Cri81IJvLRQHBzYmqd00M17MAe4BSeHw7nvPDbt2Ei
	 wZ8MJHCMDijkZO/yiZhORR9Ktc1rF2BCXtu9uvY6lfspnbn5WDmv5UcWrL8IBV1f7x
	 mKfc6VbheFR+d2Tt3PV9mxdXZkrZ/8tPFuKV6PeJYnRVn8o5AovlsHyEqLU2Z8y/jP
	 EtK6t42zgwBSA==
Date: Mon, 6 Apr 2026 18:25:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ujjal Roy <royujjal@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
 <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, Yong Wang
 <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ujjal Roy
 <ujjal@alumnux.com>, bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/5] selftests: net: bridge: add tests for
 MRC and QQIC validation
Message-ID: <20260406182504.52a03794@kernel.org>
In-Reply-To: <20260403150050.1235-6-royujjal@gmail.com>
References: <20260403150050.1235-1-royujjal@gmail.com>
	<20260403150050.1235-6-royujjal@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275809-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3C67D3A8AE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri,  3 Apr 2026 15:00:50 +0000 Ujjal Roy wrote:
> --- a/tools/testing/selftests/net/forwarding/.gitignore
> +++ b/tools/testing/selftests/net/forwarding/.gitignore
> @@ -1,3 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  forwarding.config
>  ipmr
> +mc_encode
> +mc_decode

please keep this file sorted

> diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
> index bbaf4d937dd8..a26da846632d 100644
> --- a/tools/testing/selftests/net/forwarding/Makefile
> +++ b/tools/testing/selftests/net/forwarding/Makefile
> @@ -1,5 +1,15 @@
>  # SPDX-License-Identifier: GPL-2.0+ OR MIT
>  
> +top_srcdir = ../../../../..
> +
> +CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
> +CFLAGS += -I$(top_srcdir)/tools/include

Could you please keep the format more aligned with the ksft
net/Makefile? Also is the -I$(top_srcdir)/tools/include
still necessary? KHDR_INCLUDES don't include $src/usr/include ??

> +TEST_GEN_FILES := \
> +	mc_encode \
> +	mc_decode \
> +# end of TEST_GEN_FILES

Also needs to be sorted
-- 
pw-bot: cr

