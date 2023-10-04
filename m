Return-Path: <netdev+bounces-38094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2F97B969A
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 23:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 53789281847
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 21:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC745241F7;
	Wed,  4 Oct 2023 21:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC13F23750;
	Wed,  4 Oct 2023 21:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9F1C433C8;
	Wed,  4 Oct 2023 21:42:13 +0000 (UTC)
Date: Wed, 4 Oct 2023 17:43:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Johannes Berg
 <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/4] tracing: improve symbolic printing
Message-ID: <20231004174321.5afa2fb6@gandalf.local.home>
In-Reply-To: <2f749ade-7821-00fa-ba34-e2d25cbad441@oracle.com>
References: <20230921085129.261556-5-johannes@sipsolutions.net>
	<20231004092205.02c8eb0b@kernel.org>
	<20231004123524.27feeae7@gandalf.local.home>
	<20231004095431.1dd234e6@kernel.org>
	<20231004132955.0fb3893d@gandalf.local.home>
	<2f749ade-7821-00fa-ba34-e2d25cbad441@oracle.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Oct 2023 22:35:07 +0100
Alan Maguire <alan.maguire@oracle.com> wrote:

> One thing we've heard from some embedded folks [1] is that having
> kernel BTF loadable as a separate module (rather than embedded in
> vmlinux) would help, as there are size limits on vmlinux that they can
> workaround by having modules on a different partition. We're hoping
> to get that working soon. I was wondering if you see other issues around
> BTF adoption for embedded systems that we could put on the to-do list?
> Not necessarily for this particular use-case (since there are
> complications with trace data as you describe), but just trying to make
> sure we can remove barriers to BTF adoption where possible.

I wonder how easy is it to create subsets of BTF. For one thing, in the
future we want to be able to trace the arguments of all functions. That is,
tracing all functions at the same time (function tracer) and getting the
arguments within the trace.

This would only require information about functions and their arguments,
which would be very useful. Is BTF easy to break apart? That is, just
generate the information needed for function arguments?

Note, pretty much all functions do not pass structures by values, and this
would not need to know the contents of a pointer to a structure. This would
mean that structure layout information is not needed.

-- Steve

