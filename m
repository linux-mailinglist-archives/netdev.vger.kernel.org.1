Return-Path: <netdev+bounces-32169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC44F7932AA
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 01:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8692811EB
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 23:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54D9101F5;
	Tue,  5 Sep 2023 23:44:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931D6101ED
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 23:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3B5C433C7;
	Tue,  5 Sep 2023 23:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693957448;
	bh=Iy2Smr5XT9EydF4Ow/Odp5Oq0/ZFb4pdyDqcePjHOR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F2fPLad9rpQsL2yHDA/o1oETOAvn9xq8oG3LdyD83KFnrrXMpylapPzdxe1AZmC3n
	 R+EdrjzWzoZvPHmTN4IF81I3mZsUrLiSvLMz5qlk5xGa2an1XsNUZRHJrkURTUsXgg
	 31RVRWdKcc5LY3iOiWw9q25vYLdZ+BoZt1uf8mp2ZHzP7yMSa7YAjWuysEoaxh62GT
	 4z0kpLNL4v/cQABh/M7SuX8jo2RwW40PWbBXPiv+PzNVzmH/Ajr/6x0oLJF0eoKFI2
	 T9wsWV6V2HsutE3biEsIKXhsZiaOFbQOVtaCW9E/DuYIaBXqco28K97z9AVELuC/2E
	 IzEfMJKX4oqaA==
Date: Tue, 5 Sep 2023 16:44:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>, Networking <netdev@vger.kernel.org>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the net-next tree
Message-ID: <20230905164406.04ff113c@kernel.org>
In-Reply-To: <20230906085543.1c19079a@canb.auug.org.au>
References: <20230626162908.2f149f98@canb.auug.org.au>
	<20230906085543.1c19079a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Sep 2023 08:55:43 +1000 Stephen Rothwell wrote:
> > Documentation/networking/kapi:144: include/linux/phylink.h:614: WARNING: Inline literal start-string without end-string.
> > Documentation/networking/kapi:144: include/linux/phylink.h:644: WARNING: Inline literal start-string without end-string.  
> 
> These have not :-(

Fix posted. I thought it was about phylink_mode_*() but apparently 
the warnings are always reported with line num of the first line of
the paragraph, and the problem was actually in %PHYLINK_PCS_NEG_*.

Humpf.

