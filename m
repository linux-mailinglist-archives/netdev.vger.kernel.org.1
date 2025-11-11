Return-Path: <netdev+bounces-237764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53313C5018F
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 00:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3AB254E5EE9
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 23:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5892D2384;
	Tue, 11 Nov 2025 23:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W46XS3lW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD26E2EDD72
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 23:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762905266; cv=none; b=XsMJgcVvsobgIs8D3A3v/TIzUltMEwM98Eioq2PEp4SoKUzCEcG4ORZQaDXNL6Q+84+NLDTPW7/obnGMrVRJ4UWZiSR6neQ4xcOTBAjDehTujwRA92K8toOUbZobhMiV4R1YeNRtmIhB1f1gfvGghLrOEtEbFeKzNGkD1CzASLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762905266; c=relaxed/simple;
	bh=u+ovaC1ARD6Fvm+tYmUCYvXu6TqIrjCRlHqStvU7Ycc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/rOW4VA58aqioaUBr1JE1iGkrBBz3h971XmBheQdprwUvuUkSnOjTP8ruwk/QhnC7JAX7j1+37WyGNg4CHZCGqk3lCuzlPIHg9OojQ/XghRP/tcazB7dturPEV3/ZIOGY+8iSxQEBGWsg1dU98c6H6K26puW7GfniNG47liMF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W46XS3lW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF65C4CEF5;
	Tue, 11 Nov 2025 23:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762905266;
	bh=u+ovaC1ARD6Fvm+tYmUCYvXu6TqIrjCRlHqStvU7Ycc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W46XS3lWdvFj10af/Q1LBpRI82vhqGVYB3LOR0ocdaXWq4mu1WTZ+GyvOsaa0w65S
	 kUx/yfaa7V+plx8G32sUKd8ySqDT2jujwpR3QTXrMD+RgIVkX9Bw2TKo7KEu98NkPj
	 9qkf7/ghY0sDSo797yUYQi2OsbeRLGCl7YWW7RPUrSaq/GCibj3lCbQPOjTlSHQmSy
	 D79niSIGba/tWweF537CrEJJbljAYVq7WFrmrC/O+zYAdH69Q/NSH/YIaPqhtkUvR0
	 Evnq/98yrlGoHC+aZ5gjUDRTlIWyyRMlkbOerkcl6wHu1zdJGLQodM8bBecX72zx8l
	 6a7a3YIimkADg==
Date: Tue, 11 Nov 2025 15:54:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Zahari Doychev <zaharido@web.de>
Cc: Zahari Doychev <zahari.doychev@linux.com>, donald.hunter@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jacob.e.keller@intel.com, ast@fiberby.net,
 matttbe@kernel.org, netdev@vger.kernel.org, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, johannes@sipsolutions.net
Subject: Re: [PATCH v2 1/3] ynl: samples: add tc filter example
Message-ID: <20251111155424.68f085a6@kernel.org>
In-Reply-To: <cgsea6u5h26klyzcqcbbhhfs2a5zee54b2ixedbrlh6utjgsbn@wnrqu3pnapu5>
References: <20251106151529.453026-1-zahari.doychev@linux.com>
	<20251106151529.453026-2-zahari.doychev@linux.com>
	<20251110171739.6c6cf31d@kernel.org>
	<cgsea6u5h26klyzcqcbbhhfs2a5zee54b2ixedbrlh6utjgsbn@wnrqu3pnapu5>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Nov 2025 21:09:11 +0200 Zahari Doychev wrote:
> On Mon, Nov 10, 2025 at 05:17:39PM -0800, Jakub Kicinski wrote:
> > On Thu,  6 Nov 2025 16:15:27 +0100 Zahari Doychev wrote:  
> > > diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
> > > index 865fd2e8519e..96c390af060e 100644
> > > --- a/tools/net/ynl/Makefile.deps
> > > +++ b/tools/net/ynl/Makefile.deps
> > > @@ -47,4 +47,5 @@ CFLAGS_tc:= $(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
> > >  	$(call get_hdr_inc,_TC_MIRRED_H,tc_act/tc_mirred.h) \
> > >  	$(call get_hdr_inc,_TC_SKBEDIT_H,tc_act/tc_skbedit.h) \
> > >  	$(call get_hdr_inc,_TC_TUNNEL_KEY_H,tc_act/tc_tunnel_key.h)
> > > +CFLAGS_tc-filter-add:=$(CFLAGS_tc)  
> > 
> > Why do we need this? This file is intended for families themselves,
> > if sample needs flags it should be specified in samples/Makefile ?  
> 
> I am getting compile errors as without the CFLAGS my system
> headers files are used and not the ones in the kernel tree.
> As samples/Makfile is passing the CFLAGS_tc-filter-add when
> compiling I thought this was the way to do this similiar to the
> other examples.
> 
> Actually the following flags are fixing my problem:
>  -D__LINUX_PKT_SCHED_H -include ../../../../include/uapi//linux/pkt_sched.h
>  -D__LINUX_PKT_CLS_H -include ../../../../include/uapi//linux/pkt_cls.h
> 
> If I need to fix this in samples/Makefile then I probably need to create
> a new target. Is this really the expectation?

I meant:

diff --git a/tools/net/ynl/samples/Makefile b/tools/net/ynl/samples/Makefile
index c9494a564da4..552356473b68 100644
--- a/tools/net/ynl/samples/Makefile
+++ b/tools/net/ynl/samples/Makefile
@@ -19,6 +19,7 @@ include $(wildcard *.d)
 all: $(BINS)
 
 CFLAGS_page-pool=$(CFLAGS_netdev)
+CFLAGS_tc-filter-add=$(CFLAGS_tc)
 
 $(BINS): ../lib/ynl.a ../generated/protos.a $(SRCS)
        @echo -e '\tCC sample $@'


I could be missing something, I have 6.17 headers installed so it 
builds for me without any extra flags :(

