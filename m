Return-Path: <netdev+bounces-270273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5xoiDPMxv2lKygMAu9opvQ
	(envelope-from <netdev+bounces-270273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 01:04:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 706162E7B01
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 01:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84B2630131D5
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 00:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072317478;
	Sun, 22 Mar 2026 00:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qg7HuyqL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D691B1B7F4;
	Sun, 22 Mar 2026 00:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774137835; cv=none; b=R/+M7AcW4gRzWcyUQKPm7zWhcBTCF6jfl50YA3Bow91lQ0n5fBtAreeH6u8cLn/luLN1M7P8oaWJShktLBLOXIgPRowS8KLTvv9gE31LI8dkF2zIWYcb1kG5r8wa3KHVJ3l4+NsVJFdxi/BjEukIkwV6L01eYQ6Gv9HG8EIEGA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774137835; c=relaxed/simple;
	bh=NagLrO69VZHEESK/Y80BiT8SH0ebiAIFdsHD93HFSB8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bkjNqL/NuGXEtSw+ai0fhlGNTtUZRk1Rr0FWDkx9AJcybDIfNnhm9BqkKnCtEEgXC4wCOwNVGEvs0eOSjj+yoRyfpT5Xt/iwTX2Z7GfS69JCra8KYjV2yexFPkOsFgCAPOgiTnZ+XsdJK1biJYoADwsNhzpkTMs2fu6ZnMBtGyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qg7HuyqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC99C19421;
	Sun, 22 Mar 2026 00:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774137835;
	bh=NagLrO69VZHEESK/Y80BiT8SH0ebiAIFdsHD93HFSB8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qg7HuyqLrQMZI0G/4G13ldOcJ6HSHiSioNATXJjrHSroQw0JaPFfCaI8YRadfxMlU
	 IKYYDgQ/jEaSnFNfTSw3EDLVSaE7LNDcN6s1YAg7SSyK8h+zjU5EH6E47BuqWYLzkQ
	 gWvCm5HQUD+EikEzZtTDdbvyG6+DRAW5qmM4jImUPcTaPl/SB6yFKIVy3YeQbVSUxh
	 jM0cN98gi/DXm+iaOmY3A8DCY1qgQLCT8LxAokML+/bcxeVqeOw2nZwXoi5Tod4RHh
	 2UnhLFs6VW7XCvgiNM18bSxVf0kmBddxTIuT6YzkG1cXGVFFrAmIvxutn/y5XARvvl
	 IPMww2cXZ2n8Q==
Date: Sat, 21 Mar 2026 17:03:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, rbm@suse.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11 net-next v4] Convert CONFIG_IPV6 to built-in and
 remove stubs
Message-ID: <20260321170354.17a2d888@kernel.org>
In-Reply-To: <20260320185649.5411-1-fmancera@suse.de>
References: <20260320185649.5411-1-fmancera@suse.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-270273-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 706162E7B01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 20 Mar 2026 19:55:52 +0100 Fernando Fernandez Mancera wrote:
> Historically, the Linux kernel has supported compiling the IPv6 stack as
> a loadable module. While this made sense in the early days of IPv6
> adoption, modern deployments and distributions overwhelmingly either
> build IPv6 directly into the kernel (CONFIG_IPV6=y) or disable it
> entirely (CONFIG_IPV6=n). The modular IPv6 use-case offers image size
> and memory savings for specific setups, this benefit is outweighed by
> the architectural burden it imposes on the subsystems on implementation
> and maintenance.

I think it breaks BPF LWT tests?

FWIW you can open a pull request against this repo, and it will run all
the BPF tests for you: https://github.com/kernel-patches/bpf
Just delete the code that makes it not build because of the conflict.

