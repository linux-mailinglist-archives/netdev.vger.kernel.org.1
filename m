Return-Path: <netdev+bounces-36587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A1D7B0B93
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 20:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 71E902845E3
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 18:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52BC3B7B9;
	Wed, 27 Sep 2023 18:01:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED151D6AE
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 18:01:42 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CC2E5
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 11:01:39 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qlYqn-00074l-Oq; Wed, 27 Sep 2023 20:01:29 +0200
Date: Wed, 27 Sep 2023 20:01:29 +0200
From: Florian Westphal <fw@strlen.de>
To: kernel test robot <oliver.sang@intel.com>
Cc: Florian Westphal <fw@strlen.de>, oe-lkp@lists.linux.dev, lkp@intel.com,
	netdev@vger.kernel.org, nharold@google.com, lorenzo@google.com,
	benedictwong@google.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au
Subject: Re: [PATCH ipsec-next 2/2] xfrm: policy: replace session decode with
 flow dissector
Message-ID: <20230927180129.GD17767@breakpoint.cc>
References: <20230918125914.21391-3-fw@strlen.de>
 <202309271628.27fd2187-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309271628.27fd2187-oliver.sang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

kernel test robot <oliver.sang@intel.com> wrote:
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202309271628.27fd2187-oliver.sang@intel.com
> 
> 
> kern  :warn  : [  173.147140] ------------[ cut here ]------------
> kern :warn : [  173.147759] WARNING: CPU: 12 PID: 2260 at net/core/flow_dissector.c:1096 __skb_flow_dissect (net/core/flow_dissector.c:1096 (discriminator 1)) 

Two options, more 'guess the right netns' in flow dissector:
derive netns from skb->dst->dev.

Or, pass struct net down to xfrm session decode functions.

I'll have a go at option 2 to see how much noise its going to be.

