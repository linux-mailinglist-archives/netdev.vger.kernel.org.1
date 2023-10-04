Return-Path: <netdev+bounces-38014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AB17B85E4
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 18:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 19B9B28169A
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 16:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265921C2BF;
	Wed,  4 Oct 2023 16:54:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115536128;
	Wed,  4 Oct 2023 16:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42553C433C9;
	Wed,  4 Oct 2023 16:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696438472;
	bh=VpzyBn3Pwo9+mwRDTSw2t9nV2rS3KflHer205rUr8ec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mNeNF8ppZsNimabomo0sOLVL5LVo7YlSYKE6MvG4KPQC2fW1tSDEX1absM2bvoTeo
	 AGFB7gRvoGpM7oTT7hn8u5dswttm7l7Hy+FZhCQHosnJISjohT2EXEmLJJN8DJGWhh
	 6zNvX02klCMsOnPZ+3+CTFOqthkeLkm4I2Zq0iqYQY0SoxYnnCgLzr9740TqARkWPl
	 +nmk7SdBx0DobLYKsXzwaMx9mO2AAgb9ElF//O+Wa4NfHaK1G2bLOIMMnhTrOCtwKh
	 5/3ckG02jIQGLH7Ja2IfAFvOzda+FLHxX/tRu5qcZdcD+kb0Im/BHAQmuaAOjmhV2s
	 VicGPxkROFeDg==
Date: Wed, 4 Oct 2023 09:54:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/4] tracing: improve symbolic printing
Message-ID: <20231004095431.1dd234e6@kernel.org>
In-Reply-To: <20231004123524.27feeae7@gandalf.local.home>
References: <20230921085129.261556-5-johannes@sipsolutions.net>
	<20231004092205.02c8eb0b@kernel.org>
	<20231004123524.27feeae7@gandalf.local.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Oct 2023 12:35:24 -0400 Steven Rostedt wrote:
> > Potentially naive question - the trace point holds enum skb_drop_reason.
> > The user space can get the names from BTF. Can we not teach user space
> > to generically look up names of enums in BTF?  
> 
> That puts a hard requirement to include BTF in builds where it was not
> needed before. I really do not want to build with BTF just to get access to
> these symbols. And since this is used by the embedded world, and BTF is
> extremely bloated, the short answer is "No".

Dunno. BTF is there most of the time. It could make the life of
majority of the users far more pleasant.

I hope we can at least agree that the current methods of generating 
the string arrays at C level are... aesthetically displeasing.

