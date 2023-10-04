Return-Path: <netdev+bounces-38006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4877B8560
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 18:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 33B202817DC
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 16:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FECE1400F;
	Wed,  4 Oct 2023 16:34:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E6E1094A;
	Wed,  4 Oct 2023 16:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4510CC433C7;
	Wed,  4 Oct 2023 16:34:17 +0000 (UTC)
Date: Wed, 4 Oct 2023 12:35:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/4] tracing: improve symbolic printing
Message-ID: <20231004123524.27feeae7@gandalf.local.home>
In-Reply-To: <20231004092205.02c8eb0b@kernel.org>
References: <20230921085129.261556-5-johannes@sipsolutions.net>
	<20231004092205.02c8eb0b@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Oct 2023 09:22:05 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> Potentially naive question - the trace point holds enum skb_drop_reason.
> The user space can get the names from BTF. Can we not teach user space
> to generically look up names of enums in BTF?

That puts a hard requirement to include BTF in builds where it was not
needed before. I really do not want to build with BTF just to get access to
these symbols. And since this is used by the embedded world, and BTF is
extremely bloated, the short answer is "No".

-- Steve

