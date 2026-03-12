Return-Path: <netdev+bounces-266881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMcnDncssmmlJQAAu9opvQ
	(envelope-from <netdev+bounces-266881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 04:01:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C188E26C884
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 04:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF0573033532
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CC33264FE;
	Thu, 12 Mar 2026 03:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtVH91Ar"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDEB1F7575;
	Thu, 12 Mar 2026 03:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773284466; cv=none; b=i00frEibpt1lujnIdHVDox/LK6zC6uIntM1gRHjquiWdjL0UH2LvUKkCUf00087JdX+o0NyiW5HA3ZRKVEzC51oNevJb3yuOArkkcv0NMyrQrG7WDrRW+G7btu0J19tizFOvUrdXNTnBVwVTeXM8ylSOgDCYo52CDYcecPv2BEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773284466; c=relaxed/simple;
	bh=E8LcffMsqUht6BPTNw0PB+gJK0Ehr9KfshV5zjAvBE0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S96BX1X8uC68MZukDRZAkEBdKy6YRGuzPfJ90DXBfJy2IQE7j4Q8mrg6l+Gbbo6CBKQvifAyUgZR9YciBpMUh067XAYM3QBCMCHQozGpxErakgM5KthiE1oBKytEJ2NASxI0j/Ne1WBwo/MPL4oMmL0EmrUEQlyNOjo1iGt3OmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtVH91Ar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F082AC4CEF7;
	Thu, 12 Mar 2026 03:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773284466;
	bh=E8LcffMsqUht6BPTNw0PB+gJK0Ehr9KfshV5zjAvBE0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OtVH91Arnc9zdFI46ZL8EQkMjbHjrtYhbtGmVeG3Ng6x4B7YymW6SAulfX1L6SVtK
	 z8IeePgAPuw4tc7qf1Ofe0Vzy4jufjBCL7I8IVnF4XZSMSlq1sLTvZ8EXnOWoeTgqH
	 QM/QSo1okolAUqpkJEyzaFLiMKvHv3GduJfXDQbiHWjecM2To2Dhh4n+r6F8yfpVRh
	 wKdXqCfiVusl4a2kbQ7ypC3HO7JJIBahp9i4IiyZEhs9Tjnvr2DGH5ok5Pxq6sUg5V
	 o1N8ElCxHSIdg+bJNh/6cQlFdCzTFXPCWOYu4OBRMieJyVM67Jhr43W+ZOjXD34bYu
	 GfRP0gb2g/d1A==
Date: Wed, 11 Mar 2026 20:01:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, rbm@suse.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10 net-next v2] Convert CONFIG_IPV6 to built-in and
 remove stubs
Message-ID: <20260311200105.3b5b5b60@kernel.org>
In-Reply-To: <20260310153506.5181-1-fmancera@suse.de>
References: <20260310153506.5181-1-fmancera@suse.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-266881-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C188E26C884
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 10 Mar 2026 16:34:23 +0100 Fernando Fernandez Mancera wrote:
> Historically, the Linux kernel has supported compiling the IPv6 stack as
> a loadable module. While this made sense in the early days of IPv6
> adoption, modern deployments and distributions overwhelmingly either
> build IPv6 directly into the kernel (CONFIG_IPV6=y) or disable it
> entirely (CONFIG_IPV6=n). The modular IPv6 use-case offers image size
> and memory savings for specific setups, this benefit is outweighed by
> the architectural burden it imposes on the subsystems on implementation
> and maintenance.

Would you mind also listing in the cover letter the examples folks have
provided on the RFC of distros etc validating that this is a common
choice even for openwrt these days? Also I quite like Geert's analysis
of kernel growing by this much anyway so this isn't a huge jump :)

When you repost could you trim the "(open list:.." stuff form the CC
lists? For lists just the email addr is enough, no need to quote the
rest of get_maintainers output.

