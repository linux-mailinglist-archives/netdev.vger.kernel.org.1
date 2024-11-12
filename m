Return-Path: <netdev+bounces-144150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8B49C5C1E
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 16:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16E61F22FD9
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 15:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C652022D5;
	Tue, 12 Nov 2024 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usFj0Rco"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D08201261
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426048; cv=none; b=fPKtBnkfFrvJrUyEirsh3pKCTD3WNmO8YAuwI2MPX4bO5ZHBknR9auzrBpoDXTXgFDpwfJ1gou5BcioQWmNrZxZEcS5ES+IOaqW5pbmG2CAOMNSwkouLOSByBOO7MKtdo+OyBN02yPELm7BUNsup1h81cMMQnLnkZFBBseQv00g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426048; c=relaxed/simple;
	bh=L0dpDiJMmjdlYAOKDC9wZA7FJpWTTw9cN5/dys5aQAM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=efIn/rcZGuJ66vJwT8Gk0/Ss7W/Qy//ZHcr4V8rX5xUcPXPZrf5PsMRoq01Dn/ullDv3/Hli5ipae0UvTuf4WoTdrH1rUMJN730G1NJPiv6pZK/HfSq03LP4yAZdGF/NtlOd65jZggPt+fQnrmsRczcnQOTaeIR9yqkOR5U06po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usFj0Rco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AFFC4CECD;
	Tue, 12 Nov 2024 15:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731426048;
	bh=L0dpDiJMmjdlYAOKDC9wZA7FJpWTTw9cN5/dys5aQAM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=usFj0RcoEtTJbxf1XytUTrwzSFNq7aHN41N+HYkipJFNEOATDmH6RVeStyv0AyOHi
	 S399BYfxGK1C80zI0XoeQfvetYlNgPO9n9EkhnFqPaBY4ph1E0tv8Xqk8sIyZ2KccN
	 NN+z6LJqqSMimuHAuNvLcPJZhcp8NGkjj1FxQSfupUcsKaUKGqlNO/IbA4nbXVs5sj
	 pTWaKgLHetBCoS78XwbNq6KsDMgoQ6lHYDw+E4C59h0AXAWZzp7xaGOUCGT/qSG5fh
	 eO19wkLWB4qFJWDlxfOn/U07H1bYmtX1EkND9pXXUvRKmJOjr/hV9N+0p1UXbigrr3
	 C8HjVwAcaaLfw==
Date: Tue, 12 Nov 2024 07:40:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: ecree.xilinx@gmail.com, jdamato@fastly.com, davem@davemloft.net,
 mkubecek@suse.cz, martin.lau@linux.dev, netdev@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH ethtool-next v2] rxclass: Make output for RSS context
 action explicit
Message-ID: <20241112074047.44490c6e@kernel.org>
In-Reply-To: <978e1192c07e970b8944c2a729ae42bf97667a53.1731107871.git.dxu@dxuuu.xyz>
References: <978e1192c07e970b8944c2a729ae42bf97667a53.1731107871.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Nov 2024 12:05:38 -0700 Daniel Xu wrote:
> -	if (fsp->flow_type & FLOW_RSS)
> -		fprintf(stdout, "\tRSS Context ID: %u\n", rss_context);
> -
>  	if (fsp->ring_cookie == RX_CLS_FLOW_DISC) {
>  		fprintf(stdout, "\tAction: Drop\n");
>  	} else if (fsp->ring_cookie == RX_CLS_FLOW_WAKE) {
>  		fprintf(stdout, "\tAction: Wake-on-LAN\n");
> +	} else if (fsp->flow_type & FLOW_RSS) {
> +		u64 queue = ethtool_get_flow_spec_ring(fsp->ring_cookie);
> +
> +		fprintf(stdout, "\tAction: Direct to RSS context id %u", rss_context);

Do you have strong feelings about the change in formatting?
Looking at Ed's comment on the new test made me wonder if the change 
in capitalization is for the better.

Action: Direct to RSS context id 1 (queue base offset: 2)

vs

Action: Direct to RSS Context ID: 1 (queue base offset: 2)

Given "id" is a word (: I like the ID format, the extra colon is
annoying but OTOH if we retain it your regexp in the other patch
would match before and after..

Actually the best formatting IMHO would be to skip the ID altogether:

Action: Direct to RSS Context 1 (queue base offset: 2)

So please respin this, either set the ID to upper case or skip it.
And depending on the decision here respin the test (feel free to
repost before 24h passes, if you do).

