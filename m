Return-Path: <netdev+bounces-12497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B72737DBF
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 10:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E635F2814B8
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 08:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4182DC2FB;
	Wed, 21 Jun 2023 08:45:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372CA5C97
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:45:00 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1669710E6;
	Wed, 21 Jun 2023 01:44:59 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qBtSL-0005d4-9f; Wed, 21 Jun 2023 10:44:49 +0200
Date: Wed, 21 Jun 2023 10:44:49 +0200
From: Florian Westphal <fw@strlen.de>
To: Sohom <sohomdatta1@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sohom <sohomdatta1+git@gmail.com>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: Don't parse CTCP message if shorter than
 minimum length
Message-ID: <20230621084449.GD3799@breakpoint.cc>
References: <20230621032953.107143-1-sohomdatta1+git@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621032953.107143-1-sohomdatta1+git@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sohom <sohomdatta1@gmail.com> wrote:
> If the CTCP message is shorter than 10 + 21 + MINMATCHLEN
> then exit early and don't parse the rest of the message.

Please send a v2 explaining why, not what.

> +	if (data >= data_limit - (10 + 21 + MINMATCHLEN)) {
> +		goto out;
> +	}

Please run your patches through scripts/checkpatch.pl,
we don't use { } for single-line conditional bodies.

>  	/* Skip any whitespace */
> -	while (data < data_limit - 10) {
> +	while (data < data_limit) {

Why this change?

