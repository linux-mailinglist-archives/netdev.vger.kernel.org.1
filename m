Return-Path: <netdev+bounces-21515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A36763C50
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A20281FD6
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303533799F;
	Wed, 26 Jul 2023 16:23:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EA33798E
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 16:23:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81387C433C7;
	Wed, 26 Jul 2023 16:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690388593;
	bh=AElnco8jCL1hpSQykjxH2VNrzDAyihUbYuyPeUcjv9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oyQ3bUvJ7GHPKG/BTY2Szw/fPrkBt4R8k+dpjWZZ/nQp52Dh1Cb9gj7VfHiTy+Zoj
	 /IOM5qG459yCzkQiEmn4mlhiMgFkoO+yJmf+NlCIJhU6156Wbx1lkuhxoQq6X5fHzq
	 em8FqJ2uc1wQ1aPOUAWR25W7fk/e4CtAPc4le7R0L9Zd8FMHDGR/8krC5Fo99aCWXf
	 9mtM+uHOnAyFLWqDvH6hYGI9hmQvOvAD63JHscjZYFcKPrgSPsN1TRpJfATqk+n9Ur
	 40v8m08D2Ijrz2a5l3ip9WMZGYQ1DT7pW0Q3valD5alnY7w8JGpovtRIwACvja9yTe
	 Ep95yWvX6RJZQ==
Date: Wed, 26 Jul 2023 09:23:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 geert@linux-m68k.org, gregkh@linuxfoundation.org, netdev@vger.kernel.org,
 workflows@vger.kernel.org, mario.limonciello@amd.com, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] scripts: get_maintainer: steer people away from
 using file paths
Message-ID: <20230726092312.799503d6@kernel.org>
In-Reply-To: <11ec5b3819ff17c7013348b766eab571eee5ca96.camel@perches.com>
References: <20230726151515.1650519-1-kuba@kernel.org>
	<11ec5b3819ff17c7013348b766eab571eee5ca96.camel@perches.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jul 2023 08:43:30 -0700 Joe Perches wrote:
> > Print a warning when someone tries to use -f and remove
> > the "auto-guessing" of file paths.  
> 
> Nack on that bit.
> My recollection is it's Linus' preferred mechanism.

Let Linus speak for himself, hopefully he's okay with throwing
in the -f.

BTW get_maintainer is central to our ML-based development process.
I think the patches to get_maintainer and checkpatch should flow
to workflows@.

