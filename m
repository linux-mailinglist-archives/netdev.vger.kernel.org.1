Return-Path: <netdev+bounces-39775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B7B7C4711
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 03:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B471C20E61
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 01:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCD0354F6;
	Wed, 11 Oct 2023 01:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azd0VSfO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB41D2115
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 01:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD97C433CD;
	Wed, 11 Oct 2023 01:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696986614;
	bh=2IfNHYRbev2ob8PWFLqJ/T/VpvjKdoXQ/QJwspMHZVQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=azd0VSfOVuUgSlae+InN/Nq0QJC5WUtCO/YxqhpEbFIYFUpyiyDyb6V3bE1s+8631
	 dLXPNNEBRg9WYNwbyh9SEL94tP1io6c82lloUP5xjmRaTCr9ELT85IDVq5xg8ts/w5
	 0/QIy8+GdxsT0bT18PFF39/agaql2agzuPCUtTX52GtptjnryvX5EBWPbPKPUQxyA3
	 DYG/SeWTMegue7lrEukE6JiFyG40bmVjuIxYakBb2eti3qxHDR8oh0SDi1XTp5hJOy
	 MXXy5sfhXSF8rDAXQxTPSdhArn+3a/HiTRhAk7V4mY1S4Nd9fG7eWK3mEzCveaYTWf
	 MsMr8JG4BK+Sg==
Date: Tue, 10 Oct 2023 18:10:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joel Becker <jlbec@evilplan.org>
Cc: Breno Leitao <leitao@debian.org>, davem@davemloft.net,
 pabeni@redhat.com, Eric Dumazet <edumazet@google.com>, hch@lst.de,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org
Subject: Re: [PATCH net-next v3 2/4] netconsole: Initialize configfs_item
 for default targets
Message-ID: <20231010181013.67187de2@kernel.org>
In-Reply-To: <ZSWlppHwravDLyZN@google.com>
References: <20231010093751.3878229-1-leitao@debian.org>
	<20231010093751.3878229-3-leitao@debian.org>
	<ZSWlppHwravDLyZN@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Oct 2023 12:27:34 -0700 Joel Becker wrote:
> > +#define NETCONSOLE_PARAM_TARGET_NAME "cmdline"  
> 
> Perhaps `NETCONSOLE_PARAM_TARGET_PREFIX` is better.  Makes it clear this
> is not the whole name.

FWIW I had the same thought when looking at v2.
Didn't wanna nit-pick but if there's two of us...
-- 
pw-bot: cr

