Return-Path: <netdev+bounces-126491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FEA9715E8
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 13:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DD831F25052
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 11:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6E81AF4F9;
	Mon,  9 Sep 2024 11:00:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C8F14A09E
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725879614; cv=none; b=KB1cXWmjShmpPsQHGATcRwSy7GlsnleMdRNeGaxavn/qdsEul7EnjbE8gcTLKdFi5EcV+r+DSboXx+JuVMZ9RPnRUVtnTtPIIWygdyfa0OOHmtiofBO99IO4vrkVRACoa8k3D85Ax1+uLhZrqAxhbEiqhOpp2EEQnBsfA5cKBMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725879614; c=relaxed/simple;
	bh=eVpqAuyPWkqzS290xXvzSVI0szDTf/v+uiZg0T7dRCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnORj8KzKwymH0tZ2UGfcK4mf0KBwef8+rpQcJseNGBnLq1jacZfmeWuwFUguoxoMjVaNMoMTtKSOlRePRHY0s0c9+lSwhNoVbK13h0iijuJFoZyZ8DPVflS3jc2JklK4QwfaZJMvJIPFpqIgna4sciDIuXh+FA8wJFC04qVhlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1snc7e-00051y-JO; Mon, 09 Sep 2024 12:59:54 +0200
Date: Mon, 9 Sep 2024 12:59:54 +0200
From: Florian Westphal <fw@strlen.de>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org
Subject: Re: [PATCH 09/11] xfrm: policy: use recently added helper in more
 places
Message-ID: <20240909105954.GA19195@breakpoint.cc>
References: <20240909100328.1838963-1-steffen.klassert@secunet.com>
 <20240909100328.1838963-10-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909100328.1838963-10-steffen.klassert@secunet.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Steffen Klassert <steffen.klassert@secunet.com> wrote:
> From: Florian Westphal <fw@strlen.de>
> 
> No logical change intended.

This patch is bogus and needs to be dropped/reverted or following
patch:

https://patchwork.kernel.org/project/netdevbpf/patch/20240829-xfrm-restore-dir-assign-xfrm_hash_rebuild-v2-1-1cf8958f6e8e@kernel.org/

