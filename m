Return-Path: <netdev+bounces-223522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEBEB59656
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DDF732152C
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AEB307AE5;
	Tue, 16 Sep 2025 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPoJD6jX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC652D7803
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758026223; cv=none; b=ifK51+uVdZpvtw91iP8BjuTvhh5zpj6zwil3xBqSYIj9+JMAyWb+DM6+pcCu/bMlYAUHNj+oDi/rY1VG/FnJeojHSTAWYSUY+uL7dAFGTW43OYlXs4fuRuqqRX1XtSJor3CNIEEGpzc00456LiA7Vocm0RCcadKQowlNJtYTFTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758026223; c=relaxed/simple;
	bh=5i7NWMdQIRE96SiJyT4IPklOjq/IupxIEhiiBgYnHbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nW+Llt2yaKceLwnmAFBWVa0kRSkbVAgN0iJ655yePyjKdd+ByHqSgPOrBeZKQPrrH9z60LWysPfrtrefIp+iqF0hsfkNNjb3RRJQzhqelpI5VAnOvv8SaL+OXYNCIFQmESmFAKS4K4U6XxXjQ4bq4afpL5R98mFVyb6StNYZkfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPoJD6jX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C0DC4CEFA;
	Tue, 16 Sep 2025 12:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758026222;
	bh=5i7NWMdQIRE96SiJyT4IPklOjq/IupxIEhiiBgYnHbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gPoJD6jXdGrz//KZ6/Bwt5CquKAwNmIQnRH1Kc6uBbZS92L1gtOvNeZHu30WEHUxw
	 p/l3AoXzHquUFyJWOP2Y+8iP+9jnvP/tOPbNYwBQOKQCH1xEzTNdJdtf0nyGmqPV9o
	 mtgq/7er4smelWDFKKiSO0DBVCbm1/15XTxhdh21DKOqvZukPES0ZZNBhk/K/6W6gA
	 FJRNrQSS06YrI/ifMqdaMQ22AFaCDndNgsAoYA84n5lM+F1IZtJ7K6VWeUYyFTUhDi
	 yyElQB56JBtX+jAkEcubw4DE3OFKCQq4zAllmtQ49nukgTHDSx2wMF0elzpjBzT6PV
	 vT2xhOkbmMogg==
Date: Tue, 16 Sep 2025 13:36:59 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, alexanderduyck@fb.com,
	jacob.e.keller@intel.com
Subject: Re: [PATCH net-next v2 7/9] eth: fbnic: add FW health reporter
Message-ID: <20250916123659.GF224143@horms.kernel.org>
References: <20250915155312.1083292-1-kuba@kernel.org>
 <20250915155312.1083292-8-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915155312.1083292-8-kuba@kernel.org>

On Mon, Sep 15, 2025 at 08:53:10AM -0700, Jakub Kicinski wrote:
> Add a health reporter to catch FW crashes. Dumping the reporter
> if FW has not crashed will create a snapshot of FW memory.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


