Return-Path: <netdev+bounces-15529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7417483FC
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 14:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC37280FA8
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 12:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64876FD9;
	Wed,  5 Jul 2023 12:16:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B04746C
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 12:16:32 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A20BE;
	Wed,  5 Jul 2023 05:16:30 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qH1Qp-00062P-U5; Wed, 05 Jul 2023 14:16:27 +0200
Date: Wed, 5 Jul 2023 14:16:27 +0200
From: Florian Westphal <fw@strlen.de>
To: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH] netfilter: nf_tables: do not ignore genmask when looking
 up chain by id
Message-ID: <20230705121627.GC19489@breakpoint.cc>
References: <20230705121255.746628-1-cascardo@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705121255.746628-1-cascardo@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thadeu Lima de Souza Cascardo <cascardo@canonical.com> wrote:
> When adding a rule to a chain referring to its ID, if that chain had been
> deleted on the same batch, the rule might end up referring to a deleted
> chain.

Reviewed-by: Florian Westphal <fw@strlen.de>

