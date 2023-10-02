Return-Path: <netdev+bounces-37488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D2A7B5A15
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 20:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 8D9651C208BC
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 18:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EC51DDC5;
	Mon,  2 Oct 2023 18:31:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140971EA74;
	Mon,  2 Oct 2023 18:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290E8C433C7;
	Mon,  2 Oct 2023 18:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696271509;
	bh=FwOWdXcduUEuYueUYb3WKEmK/UO8XkOGezapIcoLank=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nXztEeJMKGNe5w7pRztMXGYK/3RIFockMyii4+e+9IvyivRQTAnvy1vyrvzDeO21f
	 iKU2HTcj94fyDABBbgMlwgUC8CTQG89l1KY7S8LVPLMqOt+CDcuW0fQYRISYsaDvos
	 HvE6+8vVtjWuISVyQmW2JPpxrzcAI30tx4w0uZ+cgMSVdNgkM8R6uqiKq/uUe2RZra
	 Zib9hBL+cex/Ey/T3JkJAGJtMDV/iOr5V67gcACD5HLZKxJvB8rLBuSNxuTlg2qbIX
	 NzweXBCSFW9P5Ks5oDRRG/NO7iUyZAV6gyZIboSH+b8a9xVsxeJ0lDMU17k04my2UL
	 cqPirDsCOLtXQ==
Date: Mon, 2 Oct 2023 11:31:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ayush Sawal <ayush.sawal@chelsio.com>
Cc: Kees Cook <keescook@chromium.org>, Raju Rangoju <Raju.Rangoju@amd.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/5] chelsio: Annotate structs with __counted_by
Message-ID: <20231002113148.2d6f578b@kernel.org>
In-Reply-To: <202309291240.BC52203CB@keescook>
References: <20230929181042.work.990-kees@kernel.org>
	<202309291240.BC52203CB@keescook>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Sep 2023 12:44:45 -0700 Kees Cook wrote:
> On Fri, Sep 29, 2023 at 11:11:44AM -0700, Kees Cook wrote:
> > Hi,
> > 
> > This annotates several chelsio structures with the coming __counted_by
> > attribute for bounds checking of flexible arrays at run-time. For more details,
> > see commit dd06e72e68bc ("Compiler Attributes: Add __counted_by macro").
> > 
> > Thanks!
> > 
> > -Kees
> > 
> > Kees Cook (5):
> >   chelsio/l2t: Annotate struct l2t_data with __counted_by
> >   cxgb4: Annotate struct clip_tbl with __counted_by
> >   cxgb4: Annotate struct cxgb4_tc_u32_table with __counted_by
> >   cxgb4: Annotate struct sched_table with __counted_by
> >   cxgb4: Annotate struct smt_data with __counted_by
> > 
> >  drivers/net/ethernet/chelsio/cxgb3/l2t.h                | 2 +-
> >  drivers/net/ethernet/chelsio/cxgb4/clip_tbl.h           | 2 +-
> >  drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h | 2 +-
> >  drivers/net/ethernet/chelsio/cxgb4/l2t.c                | 2 +-
> >  drivers/net/ethernet/chelsio/cxgb4/sched.h              | 2 +-
> >  drivers/net/ethernet/chelsio/cxgb4/smt.h                | 2 +-
> >  6 files changed, 6 insertions(+), 6 deletions(-)  
> 
> Hm, it looks like this is not "Supported" any more? I'm getting bounces
> from "Raju Rangoju <rajur@chelsio.com>" ...
> 
> CXGB4 ETHERNET DRIVER (CXGB4)
> M:      Raju Rangoju <rajur@chelsio.com>
> L:      netdev@vger.kernel.org
> S:      Supported
> W:      http://www.chelsio.com
> F:      drivers/net/ethernet/chelsio/cxgb4/

Hi Ayush,

any idea who should be maintaining the Ethernet part of cxgb4 
at this point?

