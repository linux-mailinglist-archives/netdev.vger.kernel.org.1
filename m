Return-Path: <netdev+bounces-226723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA60BA474C
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 17:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442B5189C9B3
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 15:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60275212B2F;
	Fri, 26 Sep 2025 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0R43WcR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9A535966
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901291; cv=none; b=MLqrqdUm5VP71iOHIJSI39YWaeS/WLb2fE/eUNyHSzcFwWjCYSfXTkXeU2EGb7xL786jmV5vXvEYn8Q2BFfqeLeRVfrQ14eBapYW1GnjHlb5O1QJsAZGRLMBVYsfdTT49Ff++UORfQ+g071C3ZhSNUDpwOdWP87BIDJSUu8wjPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901291; c=relaxed/simple;
	bh=MDLb91xtZ/aXbB5ApDp6V4+f5YVnmyTeQR35+jPnC8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lylFeSmBghA7ZuDprGpzEXkRW87LgDIIYodUX6oyYdq96gdcjrTeJBZyLqJAtaQiOfBzgZ2lMsUiS1QUG0TXeiFhozTRybPpTMZu6r/SCZYitFyi3dIJWB+bTqgLhg4pxE1Nj7dYValSCp33Wwn0JvNT4OWh39fvezLnIX6RFBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0R43WcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E7EC4CEF4;
	Fri, 26 Sep 2025 15:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758901290;
	bh=MDLb91xtZ/aXbB5ApDp6V4+f5YVnmyTeQR35+jPnC8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F0R43WcRyhzg8l5Uie/6hs0lS5IU8pd6YQhX7I7xv8N5jlXeMXHF6ZuwabXWNSH8+
	 N8OQv9Zrw07nNYFmQtdkHjmiM2z9qLOuD4cEpgw4ymPBGOZ9Ww7kKo9XusRD9/Lwta
	 97rjeaF1+O82MJbND1m31WxUYXJMkgJxo7Pafxbu/a05UgnyLYjzknNeNR+Uzz83RC
	 oKud2Rpbt0o/+Wste0q3FMzEjoQU58xI/LC2/3nFaGZU/Cpe76uFNv4omw3GvOo+Nw
	 g1L+gKKGp9YIdvWv8hJuvV9KVLix0BXCt6OH3HRlF5oI/D6jkw8p4pyb60m9qB+481
	 bnCAB1I7C1BGA==
Date: Fri, 26 Sep 2025 16:41:27 +0100
From: Simon Horman <horms@kernel.org>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: Dmitry Antipov <dmantipov@yandex.ru>, Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	"tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 net-next] tipc: adjust tipc_nodeid2string() to return
 string length
Message-ID: <aNa0J14NdhrTus4S@horms.kernel.org>
References: <GV1P189MB1988AF3D7C3BC2F0F8DE2491C61EA@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
 <20250926074113.914399-1-dmantipov@yandex.ru>
 <GV1P189MB19887FECAF892F25ED014D95C61EA@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV1P189MB19887FECAF892F25ED014D95C61EA@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>

On Fri, Sep 26, 2025 at 10:29:31AM +0000, Tung Quang Nguyen wrote:
> >Subject: [PATCH v4 net-next] tipc: adjust tipc_nodeid2string() to return string
> >length
> >
> >Since the value returned by 'tipc_nodeid2string()' is not used, the function may
> >be adjusted to return the length of the result, which is helpful to drop a few
> >calls to 'strlen()' in 'tipc_link_create()'
> >and 'tipc_link_bc_create()'. Compile tested only.
> >
> >Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> >---
> >v4: revert to v2's behavior and prefer NODE_ID_LEN over
> >    explicit constant (Tung Quang Nguyen)
> >v3: convert to check against NODE_ID_LEN (Simon Horman)
> >v2: adjusted to target net-next (Tung Quang Nguyen)

Reviewed-by: Simon Horman <horms@kernel.org>


