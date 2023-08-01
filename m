Return-Path: <netdev+bounces-22994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B9C76A595
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 02:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31035281731
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 00:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C7C367;
	Tue,  1 Aug 2023 00:35:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4437E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 00:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5456BC433C8;
	Tue,  1 Aug 2023 00:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690850113;
	bh=0eydGxb46Gtf/ULnS6lD1CTNQ3j3YDzmrUe1/EASk3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gFc2Pm8/pKXAM+rO+hXsu4Elc6tWL6GPTtQp2piTOV1C0Q3CD+4sx4O2YRZBqkt/s
	 qeva/0wEJy9KOY2Etfdu9OGPpYYfmQ/NWok0T0KT8+NS6wPENtqZfjJviXpDAYB3Q2
	 NNSHt+hhj2I96hPCXptmTUzbPaGPKYlIi1FrT3Q++qEj9OpxK5AhJ4tYky9e4iKVoC
	 RKnCg3XLHEOZrHtIsG+quZe99rbbTiTvMTRZ8ZwEZ0SDBv1wZMBaRNrNmXZENWUr85
	 OpyaviqA1S/g2++FiRuZgd0bkRlRSWhVj5CTNFJYR5qzxW4BvTniwW3leoatAZg2Wx
	 t3CDrSoDPuSPw==
Date: Mon, 31 Jul 2023 17:35:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>,
 <sridhar.samudrala@intel.com>
Subject: Re: [net-next PATCH v1 3/9] netdev-genl: spec: Extend netdev
 netlink spec in YAML for NAPI
Message-ID: <20230731173512.55ca051d@kernel.org>
In-Reply-To: <c21aa836-a197-6c63-2843-ec6db4faa3be@intel.com>
References: <169059098829.3736.381753570945338022.stgit@anambiarhost.jf.intel.com>
	<169059162756.3736.16797255590375805440.stgit@anambiarhost.jf.intel.com>
	<20230731123651.45b33c89@kernel.org>
	<6cb18abe-89aa-a8a8-a7e1-8856acaaef64@intel.com>
	<20230731171308.230bf737@kernel.org>
	<c21aa836-a197-6c63-2843-ec6db4faa3be@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Jul 2023 17:24:51 -0700 Nambiar, Amritha wrote:
> >> [{'ifindex': 6},
> >>    {'napi-info': [{'irq': 296,
> >>                    'napi-id': 390,
> >>                    'pid': 3475,
> >>                    'rx-queues': [5],
> >>                    'tx-queues': [5]}]}]  
> > 
> > Dumps can be filtered, I'm saying:
> > 
> > $ netdev.yaml --dump napi-get --json='{"ifindex": 6}'
> >                  ^^^^
> > 
> > [{'napi-id': 390, 'ifindex': 6, 'irq': 296, ...},
> >   {'napi-id': 391, 'ifindex': 6, 'irq': 297, ...}]  
> 
> I see. Okay. Looks like this needs to be supported for "dump dev-get 
> ifindex" as well.

The main thing to focus on for next version is to make the NAPI objects
"flat" and individual, rather than entries in multi-attr nest within
per-netdev object.

I'm 100% sure implementing the filtering by ifindex will be doable as
a follow up so we can defer it.

