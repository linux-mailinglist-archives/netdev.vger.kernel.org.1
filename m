Return-Path: <netdev+bounces-237396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3061AC4A6D5
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 02:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D02F934C211
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 01:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB4C3054D7;
	Tue, 11 Nov 2025 01:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYPUZCBJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07953304BD5
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 01:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823861; cv=none; b=sw1Dvik5yfRu2ehbHRUOTRcR0g0BkbGfwnNgFbkAHqolD9Dj6/g6HZgbVB6yWIuZuFeHdtGSObVzqbY7E1tZOfNJdSjiepPR4C7qpXL23FEP5YVtDfUMnvWQqsvvra6e5wsbDdh0uyazMYlbUyw0d2USY0wxzSBqh5SCCMY98Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823861; c=relaxed/simple;
	bh=sdV9ZurrNAbiIi2HiLHriuN3gm5NNc9koWvEKJ/pm7w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oV8VvnpFMZCyBqmqBT+QdGJaxVl/q9+pIN07nDTuhGlx/tPYC2yTSM8yAQ678hCdmkWSqUwdYY/Ukd6y8uK3zFuxQDBYJWGg9jNH1RsmOl/kZhFnWfJD8iQwcAT+MmcZI5Nbf/qhR1ZvYkPNjzPImVQiDW4fkwHBxim/SjbVNu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYPUZCBJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103F8C2BC86;
	Tue, 11 Nov 2025 01:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762823860;
	bh=sdV9ZurrNAbiIi2HiLHriuN3gm5NNc9koWvEKJ/pm7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FYPUZCBJYBbZy5p3jil/+C0I/BN7NMI7eafABvGX7kOYIY4j7FrFwxe7go8F+8PXF
	 zIZ3YWZ5nxqHyaxiCS5fNvH8mg+5PQU3VZsPPQ3wJy6SFha2PbdQNsVrzWVcjFX89A
	 tnJUX2u/Um2I1CCBoZWdHFbCfqxASyI1zaEFTqsB176w4RMLvAXJVqu7pi9onfN/aS
	 m9Ad9ktYad8Ve+CkJQRR/KuABcpqiYNk3s8FrzBb25S29bVuIFTcJwlSatBnamaEHz
	 H+/QRC8sjusyDKWvEqJMpFEsi1fu6clZdBV3kSTBtsZW42tRZXIU1dPyZ/ffRFvQSb
	 iCX9s9vNN2KJA==
Date: Mon, 10 Nov 2025 17:17:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Zahari Doychev <zahari.doychev@linux.com>
Cc: donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, jacob.e.keller@intel.com,
 ast@fiberby.net, matttbe@kernel.org, netdev@vger.kernel.org,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 johannes@sipsolutions.net
Subject: Re: [PATCH v2 1/3] ynl: samples: add tc filter example
Message-ID: <20251110171739.6c6cf31d@kernel.org>
In-Reply-To: <20251106151529.453026-2-zahari.doychev@linux.com>
References: <20251106151529.453026-1-zahari.doychev@linux.com>
	<20251106151529.453026-2-zahari.doychev@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Nov 2025 16:15:27 +0100 Zahari Doychev wrote:
> diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
> index 865fd2e8519e..96c390af060e 100644
> --- a/tools/net/ynl/Makefile.deps
> +++ b/tools/net/ynl/Makefile.deps
> @@ -47,4 +47,5 @@ CFLAGS_tc:= $(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
>  	$(call get_hdr_inc,_TC_MIRRED_H,tc_act/tc_mirred.h) \
>  	$(call get_hdr_inc,_TC_SKBEDIT_H,tc_act/tc_skbedit.h) \
>  	$(call get_hdr_inc,_TC_TUNNEL_KEY_H,tc_act/tc_tunnel_key.h)
> +CFLAGS_tc-filter-add:=$(CFLAGS_tc)

Why do we need this? This file is intended for families themselves,
if sample needs flags it should be specified in samples/Makefile ?

>  CFLAGS_tcp_metrics:=$(call get_hdr_inc,_LINUX_TCP_METRICS_H,tcp_metrics.h)

