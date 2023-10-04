Return-Path: <netdev+bounces-38035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 918567B8B07
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 20:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 3555B1F22D55
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 18:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5887C1DDEE;
	Wed,  4 Oct 2023 18:45:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401461DA33;
	Wed,  4 Oct 2023 18:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3ADC433C7;
	Wed,  4 Oct 2023 18:45:14 +0000 (UTC)
Date: Wed, 4 Oct 2023 14:46:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/4] tracing: improve symbolic printing
Message-ID: <20231004144622.6b944803@gandalf.local.home>
In-Reply-To: <46b5785866870e9c1aefbe222d69fbacb93c1cdd.camel@sipsolutions.net>
References: <20230921085129.261556-5-johannes@sipsolutions.net>
	<20231004092205.02c8eb0b@kernel.org>
	<46b5785866870e9c1aefbe222d69fbacb93c1cdd.camel@sipsolutions.net>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 04 Oct 2023 20:38:46 +0200
Johannes Berg <johannes@sipsolutions.net> wrote:

> On Wed, 2023-10-04 at 09:22 -0700, Jakub Kicinski wrote:
> > 
> > Potentially naive question - the trace point holds enum skb_drop_reason.
> > The user space can get the names from BTF. Can we not teach user space
> > to generically look up names of enums in BTF?  
> 
> I'll note that, unrelated to the discussion about whether or not we
> could use BTF, we couldn't do it in this case anyway since the whole
> drop reasons aren't captured in enum skb_drop_reason, that contains only
> the core ones, and now other subsystems are adding their own somewhat
> dynamically later.

Another issue with using BTF, is that the BTF would need to be saved in the
trace.dat or perf.data file, as many times the trace data is moved off to
another machine for offline analysis. And using the vmlinux would not be
useful, because there is several times you have multiple trace files for
various versions of a build and that would require mapping which
vmlinux/btf file goes with which trace data.

Right now, the conversions can easily be saved in the trace file directly.

-- Steve

