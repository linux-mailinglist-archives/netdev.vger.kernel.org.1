Return-Path: <netdev+bounces-45707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B46F7DF1F8
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 13:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26E6F1C20DFA
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 12:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2BD15AD9;
	Thu,  2 Nov 2023 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF945179BF
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 12:05:47 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448EC1BF0
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 05:05:46 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qyWS5-0007MR-WE; Thu, 02 Nov 2023 13:05:34 +0100
Date: Thu, 2 Nov 2023 13:05:33 +0100
From: Florian Westphal <fw@strlen.de>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net] netlink: fill in missing MODULE_DESCRIPTION()
Message-ID: <20231102120533.GL6174@breakpoint.cc>
References: <20231102045724.2516647-1-kuba@kernel.org>
 <ZUOP7tOSK2ysyuUc@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUOP7tOSK2ysyuUc@nanopsycho>
User-Agent: Mutt/1.10.1 (2018-07-13)

Jiri Pirko <jiri@resnulli.us> wrote:
> Thu, Nov 02, 2023 at 05:57:24AM CET, kuba@kernel.org wrote:
> >W=1 builds now warn if a module is built without
> >a MODULE_DESCRIPTION(). Fill it in for sock_diag.
> >
> >Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> It's a bit odd to target -net with this, isn't it?

I had planned to fill the missing descriptions for
all netfilter via next nf.git PR as I consider those as
bug fixes.

Thats the regression risk here?

