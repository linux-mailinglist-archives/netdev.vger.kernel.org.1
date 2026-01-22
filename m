Return-Path: <netdev+bounces-252122-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id h2KpGLV1cWngHgAAu9opvQ
	(envelope-from <netdev+bounces-252122-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:56:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F29ED601EA
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5F0DD386CE7
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 00:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28207312835;
	Thu, 22 Jan 2026 00:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjLDUAUK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE15C30FF2E;
	Thu, 22 Jan 2026 00:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769043377; cv=none; b=LCYCOH4AHkC71uOmeohEv+scWa3wmuCl9XWWjv79o+zbteXO/K7Rt4kF+/YFBCgKjbn2yqZaF/Q+/mDe7BONp9Z1pTiQJiT1Bd3N8VniYg0MB0iKotqPnuqGZL5+rot7tVvuu7AWQbBheUMQn0dSqF2DsO3kaCL4LzUOU6HhovM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769043377; c=relaxed/simple;
	bh=WN1M+wuGxXKqX24TOyzbGQn3LWi6zcwDEOyl/o8L1EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sDRgu+8UePnTa0RzUr4DEWzED47FXGyNBwZcD74VAXSJ1T9vnvbMA0tFrIoyoqRR46OuuNNLpqOoEPxHTu9kkAH/GCwkQ52PtHepaqujCDb7NF08piIjUJx0adhep1eRNsn8WFRSc38JKRXoCfydRmLEDKdk8XBYKv9EANAHyno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjLDUAUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06EF1C4CEF1;
	Thu, 22 Jan 2026 00:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769043375;
	bh=WN1M+wuGxXKqX24TOyzbGQn3LWi6zcwDEOyl/o8L1EQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NjLDUAUK4UCp/GQeyVfO/uYCA1SlWkWrGj9nqCU9E5N2pz8nc7XsziOQOZu7gbg1v
	 Bzfn4Vfmx7d4xibXNl+ZPcsFT9ROaRBiX7TjKvcCdePVfgu+jrB14O5EBZoCaY6R5y
	 3KXBgx5a16xq438ULSF4Ni+zXqlWVxTtof6MayDUMTGIlS10tHY0OjW7HLyq6H0vwQ
	 /iG1ezGWbr62l0V2nCvVroLBPLaGa7r81cjAJkNTAsMqwL9qLqRrXuX8p7NrZZGWRm
	 LvvuSjeoU2jvtOm4jJ3GTh53g4tPjnNRL9OmoZhVyjcbCQ0L+kAWFACl9Z9RkYJei7
	 2V0oWP6zVHgoQ==
Date: Wed, 21 Jan 2026 16:56:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Konstantin
 Khorenko <khorenko@virtuozzo.com>
Subject: Re: [PATCH 3/5] selftests: net: run reuseport tests in netns to
 avoid port conflicts
Message-ID: <20260121165614.71b56b07@kernel.org>
In-Reply-To: <20260120230558.328423-4-aleksey.oladko@virtuozzo.com>
References: <20260120230558.328423-1-aleksey.oladko@virtuozzo.com>
	<20260120230558.328423-4-aleksey.oladko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252122-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,rps_default_mask.sh:url,psock_snd.sh:url,reuseport_bpf_numa.sh:url,reuseport_bpf.sh:url]
X-Rspamd-Queue-Id: F29ED601EA
X-Rspamd-Action: no action

On Tue, 20 Jan 2026 23:05:56 +0000 Aleksei Oladko wrote:
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index b66ba04f19d9..a160e0d816d9 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -64,6 +64,10 @@ TEST_PROGS := \
>  	psock_snd.sh \
>  	reuseaddr_ports_exhausted.sh \
>  	reuseport_addr_any.sh \
> +	reuseport_bpf.sh \
> +	reuseport_bpf_cpu.sh \
> +	reuseport_bpf_numa.sh \
> +	reuseport_dualstack.sh

missing trailing \ here, which breaks the build :(

>  	route_hint.sh \
>  	route_localnet.sh \
>  	rps_default_mask.sh \
-- 
pw-bot: cr

