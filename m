Return-Path: <netdev+bounces-191575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A92ABC34B
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 17:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536B3189343F
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 15:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917BE28466A;
	Mon, 19 May 2025 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N46HbwmY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF9028000A
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747670224; cv=none; b=iEzC9eoC0Eaul0uJVyR/xt/ti2VcrQfG5JBvjNkjWbqYSjUrG30D80ieJBIzPUamDQp2AQa16jk2VL2EM5Mm+IngBW41lqQpuCvFJVBzktayUjD9hBMErU9YXXvE/Tb6lEPSO3ySmGrHB3US/EamqAcmI5KgcqrpH8dcGgpYgBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747670224; c=relaxed/simple;
	bh=kkbmh8oIvxjBizvHOZ16GXrLyYokpJ1Yxs4td0Q1wKM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uL7gO9/jCkZcsPfI5CNIo2wXEJpiFwwsLDelFk+cxumuzqfFWcrm6veFMQIyX3hmdIWmlWGnk/0nz+REu3qm8elbtRJQyZBqEi0adlnwWKDYXBEEZXxVaQQSF9e4J0jWmZXpmxXQ2IouNU206JeMos/1+61p/NsM9HnR143Rr+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N46HbwmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB391C4CEE4;
	Mon, 19 May 2025 15:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747670224;
	bh=kkbmh8oIvxjBizvHOZ16GXrLyYokpJ1Yxs4td0Q1wKM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N46HbwmYRMN1yxwA9SMQpj14u6Jai64xy26QuI88lLQK9Jzc0pvr02UNExXtAKbQL
	 3l+dOJW3vmTARtuTTFN0GcSQ0iYRp3YnMjBOXkmdYtzpKnRV+Qk7RbIw1MQ0xw/r3q
	 FCtDlCbn6qAaTYxwtn61PLRv3+TP04Q9p6UAb83RF/aZtgzX0T/5TUblhFRvekXxDr
	 GsZwsUSnagMvDFhO7/h34pctTnQn7S8davxuElOyCl1n+KbYy6i6tO27JTF/FJopSN
	 yRQe6FZDHUwk33IBdYEHhJpfQ2MF4ea9oMCzE8UyFhbgvRnFh4rqf8rS8rZE90CfZn
	 vk9JMD4xTIgiA==
Date: Mon, 19 May 2025 08:57:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, daniel@iogearbox.net, nicolas.dichtel@6wind.com,
 jacob.e.keller@intel.com
Subject: Re: [PATCH net-next 8/9] tools: ynl: enable codegen for all rt-
 families
Message-ID: <20250519085703.7677ba07@kernel.org>
In-Reply-To: <20250519164949.597d6e92@kmaincent-XPS-13-7390>
References: <20250515231650.1325372-1-kuba@kernel.org>
	<20250515231650.1325372-9-kuba@kernel.org>
	<20250519164949.597d6e92@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 May 2025 16:49:49 +0200 Kory Maincent wrote:
> > -GENS=$(patsubst $(SPECS_DIR)/%.yaml,%,${GENS_PATHS}) rt-addr rt-route
> > +SPECS_PATHS=$(wildcard $(SPECS_DIR)/*.yaml)
> > +GENS_UNSUP=conntrack nftables tc
> > +GENS=$(filter-out ${GENS_UNSUP},$(patsubst
> > $(SPECS_DIR)/%.yaml,%,${SPECS_PATHS})) SRCS=$(patsubst %,%-user.c,${GENS})
> >  HDRS=$(patsubst %,%-user.h,${GENS})
> >  OBJS=$(patsubst %,%-user.o,${GENS})  
> 
> This patch introduces a build error when building the specs.
> 
> Maybe we should add a spec build check in the net CI?

Sorry about that :( We do have build tests, but the problem only
happens if system headers are much older than the spec. Looks like
these defines are there on both Fedora and Ubuntu LTS so builds pass.
Once the initial support is merged we should be out of the woods.

I can't repro on any of my systems, could you see if 
https://lore.kernel.org/all/20250517001318.285800-1-kuba@kernel.org/
will also give you trouble?

For the issue reported here could you see if this is enough?

diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index 4e5c4dff9188..21132e89ceba 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -35,7 +35,8 @@ CFLAGS_rt-addr:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
 	$(call get_hdr_inc,__LINUX_IF_ADDR_H,if_addr.h)
 CFLAGS_rt-link:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
 	$(call get_hdr_inc,_LINUX_IF_LINK_H,if_link.h)
-CFLAGS_rt-neigh:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h)
+CFLAGS_rt-neigh:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
+	$(call get_hdr_inc,__LINUX_NEIGHBOUR_H,neighbour.h)
 CFLAGS_rt-route:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h)
 CFLAGS_rt-rule:=$(call get_hdr_inc,__LINUX_FIB_RULES_H,fib_rules.h)
 CFLAGS_tc:=$(call get_hdr_inc,__LINUX_PKT_SCHED_H,pkt_sched.h) \
diff --git a/include/uapi/linux/neighbour.h b/include/uapi/linux/neighbour.h
index 5e67a7eaf4a7..b851c36ad25d 100644
--- a/include/uapi/linux/neighbour.h
+++ b/include/uapi/linux/neighbour.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __LINUX_NEIGHBOUR_H
-#define __LINUX_NEIGHBOUR_H
+#ifndef _UAPI__LINUX_NEIGHBOUR_H
+#define _UAPI__LINUX_NEIGHBOUR_H
 
 #include <linux/types.h>
 #include <linux/netlink.h>

