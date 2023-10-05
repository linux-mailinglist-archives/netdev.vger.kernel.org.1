Return-Path: <netdev+bounces-38296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2947BA0C7
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B9AE8281B2F
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 14:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D18D28DAB;
	Thu,  5 Oct 2023 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvUtLqCG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB322AB34
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 14:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F216CC433CD;
	Thu,  5 Oct 2023 14:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696517422;
	bh=Cfx4NIhnhmSnDlcZrtZVJc7mM5jWFh/wy1BMr4tGedM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SvUtLqCGQMHff7uUeT3UYhdEhfZNQrW3N38nqK0uii6f7m17jnNHdzc3K3brsHgDo
	 0TGbKWz9+KQC+roOrl9lr9v8IJwAgL/kZUItmGwOqWVhbz7TNicCczzdADWOlqOXFb
	 i4D7REdTSXkof/rnarlv2GiyL2wwJFZu3Y2I96m2NbbXCERiu4l79J/H3RzMuMmfV6
	 d/h4tjCKZQWzIzflTJfmaxqAorzGUoraZexgrvLt0yAg6s47B7pRtHPdKye8mSEZem
	 lAqjhR2jRisj//NNV6aTGcEpX6ySTCx83QiSuDBzQTpv56gFsPF9NBoieypoICqxjQ
	 J/mtaK0jTRZeA==
Date: Thu, 5 Oct 2023 07:50:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, netdev@vger.kernel.org,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC] tools: ynl: Add source files for nfsd netlink
 protocol
Message-ID: <20231005075021.0da40d7d@kernel.org>
In-Reply-To: <169651139213.16787.3812644920847558917.stgit@klimt.1015granger.net>
References: <169651139213.16787.3812644920847558917.stgit@klimt.1015granger.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 05 Oct 2023 09:10:38 -0400 Chuck Lever wrote:
> Should I include this with the nfsd netlink protocol patches already
> in nfsd-next, or do you want to take it after those have been merged?

Either way works, I don't see any conflicts right now.
Worst case we'll have a minor conflict on the Makefile.

Note that you should probably also add an entry for nfsd to
tools/net/ynl/Makefile.deps in case there are discrepancies
between the system headers and new uAPI extensions.

