Return-Path: <netdev+bounces-143760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAD69C4005
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 14:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C7D1F21357
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 13:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0EC19E80F;
	Mon, 11 Nov 2024 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tykzY2Hu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584B519C552
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731333501; cv=none; b=U0caHhfywrmPZkcvnTLgu5K/jY20vNySSbchhKP52HPE0ercu3FNCx8H2cAkQjTSVhzsT9fgBRhnBmSn2Tje59UfnX/7tF9VuQOgYZUEW6QTtUbUjDqZiIGlfvJ//nGrlXcydZWQHNfTxBHITJm3fP6t/ItHwTrVlFTSDTS4dbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731333501; c=relaxed/simple;
	bh=qCjXrvzUOOdu3h0mQcfyR6CSxHGWBH3xRNzG2Y2nKmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUEuk7aO1J9N9Iw8rczfD66NG7XPRtXFyBypZ10YIx8HT/EfaClt+EUFPNoKgWp7r6utXfACsOxeI3co2RfgjdWURJ6hhtOlWve3N+M6fvxFWhCJ9B6DEtwwEeYXI6eo0oIdh9Huosaoks9v9fN0ypKCaQGHMOrZIuR68vVtRVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tykzY2Hu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89555C4CECF;
	Mon, 11 Nov 2024 13:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731333500;
	bh=qCjXrvzUOOdu3h0mQcfyR6CSxHGWBH3xRNzG2Y2nKmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tykzY2Hun1j6bIUSOXgrPWL/aQX494OLYSNUFMrgp9+2oISPgej2lWlrhp6luzEsD
	 Vy0TYKiTpSS5QskWNfNAXcTql91NktfI6RWPABa1L2NYG0sIEdpq1By+/3hpRwWJb8
	 KeeH7DHn8R4IlbmKWQWB1E+dvhsKk0I/lZxWDf/mnDGr24gIeQxgudyWfP+Y83Z3h2
	 hL3uD4SFtXWeOd4XoRtgA/1SMuD2UXDoehHWyiT40XMaYu22EQmBwOOzzFogHhFeiX
	 MDnodvZN9qZQIAQlYGVyvI1jxre0HjsT61bwEK253DJxTflBEsc2LXLCaaQLaFPHmQ
	 /KYKgDm9hQlPA==
Date: Mon, 11 Nov 2024 13:58:16 +0000
From: Simon Horman <horms@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	andrew@lunn.ch, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, kernel-team@meta.com,
	sanmanpradhan@meta.com, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next] eth: fbnic: Add support to dump registers
Message-ID: <20241111135816.GD4507@kernel.org>
References: <20241108013253.3934778-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108013253.3934778-1-mohsin.bashr@gmail.com>

On Thu, Nov 07, 2024 at 05:32:53PM -0800, Mohsin Bashir wrote:
> Add support for the 'ethtool -d <dev>' command to retrieve and print
> a register dump for fbnic. The dump defaults to version 1 and consists
> of two parts: all the register sections that can be dumped linearly, and
> an RPC RAM section that is structured in an interleaved fashion and
> requires special handling. For each register section, the dump also
> contains the start and end boundary information which can simplify parsing.
> 
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


