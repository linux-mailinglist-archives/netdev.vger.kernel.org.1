Return-Path: <netdev+bounces-29717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B64CC784697
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 18:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 708502810E3
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 16:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525A71DA5F;
	Tue, 22 Aug 2023 16:08:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471621DDC0
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 16:08:58 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298EACDA;
	Tue, 22 Aug 2023 09:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=G6ZcRu57pc0rNMbRY40DBeyunYVUkrnXfs8+LQg63vQ=; b=ZWcXMY2AQ9fQZ+rWYXzpW6ktKZ
	kVQzPqCHBpG6n07ynfUhC6ehC/jFk7Le15qzxDBmvlCv6ffI/5ZSwKv9NBG7dVoibEF4jhiy+i53S
	QZrDeIzbUuy7GUtLgaqowp6e4L/LujvTVKxVdyu7epiJdat2ybu/1lZLTuo026dkwl2I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qYTw0-004nZF-4u; Tue, 22 Aug 2023 18:08:48 +0200
Date: Tue, 22 Aug 2023 18:08:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: kornel.swierzy@embevity.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix encoding of ethernet frame length for big endian
 platforms in QCA7000/7005 protocol header.
Message-ID: <ef21625d-5df7-4421-ab5b-3d49b83c553e@lunn.ch>
References: <20230822065956.8719-1-kornel.swierzy@embevity.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822065956.8719-1-kornel.swierzy@embevity.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 22, 2023 at 08:59:56AM +0200, kornel.swierzy@embevity.com wrote:
> From: Kornel Swierzy <kornel.swierzy@embevity.com>
> 
> QCA7000 protocol requires that ethernet frame length is encoded
> as u16 little endian value. Current implementation does not work
> on big endian architectures.
> 
> Signed-off-by: Kornel Swierzy <kornel.swierzy@embevity.com>

Hi Kornel

Please take a look at

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#netdev-faq

and

https://docs.kernel.org/process/submitting-patches.html

This appears to be a bugfix, so it should have a Fixes: tag. It then
should be based on the net tree, and this should be indicated in the
Subject: line.

That change itself looks fine, you just have some process issues to
correct.

	Andrew

