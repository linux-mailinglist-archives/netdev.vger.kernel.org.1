Return-Path: <netdev+bounces-25546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856047749E9
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 22:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF5A02817F1
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07667168CB;
	Tue,  8 Aug 2023 20:06:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FFF15AE7
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 20:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AD2C433C7;
	Tue,  8 Aug 2023 20:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691525178;
	bh=EXXgYeO8+2thyLJnvnLv8j6A+askNI7McKgPFzgsrAI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XuZ9+hENrre4giva7n00N0bFg27pLNhnPyPqDyGlMhYcKysZHD7s+wB5GQ9gKWMhr
	 xLEBZEtxy4Ijq280LlshZ0OQtc5bdOBJaYsmdcRVVjYgwBmCDKYBR3TcdMZV9c8G8L
	 IvwUuNxIeLXI3+ekfhqB1C/LmZKr6JOPykHbiaQvHxJ8f/hfZgIXJ3/W73BAC6hI/X
	 Xg+8ejZndgpq9pr3s9d/dV4IDGbuok/uNo2SrySkFxU60DkqseTlu+lEE0WQusCotG
	 4NUeCjA6QmY4IlkytAP5Gja51o1bFOHrk2BMskSBjBMwWkcdvEcpmhPs0YTxVf8+gn
	 pDR0jFGaIeuUQ==
Date: Tue, 8 Aug 2023 13:06:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jiri Pirko <jiri@resnulli.us>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Jonathan Lemon
 <jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Milena Olech
 <milena.olech@intel.com>, Michal Michalik <michal.michalik@intel.com>,
 linux-arm-kernel@lists.infradead.org, poros@redhat.com,
 mschmidt@redhat.com, netdev@vger.kernel.org, linux-clk@vger.kernel.org,
 Bart Van Assche <bvanassche@acm.org>, intel-wired-lan@lists.osuosl.org,
 Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next v2 2/9] dpll: spec: Add Netlink spec in YAML
Message-ID: <20230808130617.5ad74486@kernel.org>
In-Reply-To: <20230808130327.5638d15b@kernel.org>
References: <20230804190454.394062-1-vadim.fedorenko@linux.dev>
	<20230804190454.394062-3-vadim.fedorenko@linux.dev>
	<ZNCjwfn8MBnx4k6a@nanopsycho>
	<a7e2f7e1-e36a-2c79-46c3-874550d24575@linux.dev>
	<20230808130327.5638d15b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Aug 2023 13:03:27 -0700 Jakub Kicinski wrote:
> >   const struct nla_policy dpll_pin_parent_pin_nl_policy[DPLL_A_PIN_STATE 
> > + 1] = {
> >          [DPLL_A_PIN_STATE] = NLA_POLICY_RANGE(NLA_U8, 1, 3),
> >          [DPLL_A_PIN_ID] = { .type = NLA_U32, },
> > 
> > 
> > The "/* private: */" comment was added to the generator after Simon's
> > comment. But I'll include this part into the next version.  
> 
> We only added private for enum masks, I'll send a patch for nlattrs.

On closer look these have no kdoc, so the priv markings are not
necessary, dropping them sounds right.

