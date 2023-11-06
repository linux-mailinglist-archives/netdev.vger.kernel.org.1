Return-Path: <netdev+bounces-46154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6557E1B7E
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 08:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC64EB20C2C
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 07:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9B3DF66;
	Mon,  6 Nov 2023 07:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SSznQCH/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDC5DF51
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 07:49:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D6C93;
	Sun,  5 Nov 2023 23:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JsR9ayW5W/B/juTQaypftAOI6FoM2p6JwLFtaaXiYeY=; b=SSznQCH//sjs76e1wLV444srrk
	IjB9fGYRmpH98jSF6D9OGwcgvbQaqTdm5CXHbU/Ves9131e8i7/fW7YMAGIBhViM6Azlh2HiGHZZ8
	ScO1bEes4pdl4jnHCJlzr0zoI1oTJOXkbgRR9u5bi6OQwXwXAYDOsmxsjGvDY7DeUXiBMSx5NEmUn
	2Tr/uf8AN4z3twUhnZZKV8AuvnvPBWc/RkkjUVZ3X9iXzkh5psGgYL2/4+Z66RPlWXbUN2le8YYb0
	hr/mmhXZjnD6O9ZNH5xmrvdY6bL7shMS1Zc+C46kXVZqrjgO/Nyp2WWYqAdCI7rRELn6VYJwcaVS3
	qjfAMdCA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qzuMZ-00G1sz-1b;
	Mon, 06 Nov 2023 07:49:35 +0000
Date: Sun, 5 Nov 2023 23:49:35 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, edumazet@google.com,
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, ndesaulniers@google.com, trix@redhat.com,
	0x7f454c46@gmail.com, fruggeri@arista.com, noureddine@arista.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH net] tcp: Fix -Wc23-extensions in tcp_options_write()
Message-ID: <ZUiaj9qCKD/U2KLp@infradead.org>
References: <20231031-tcp-ao-fix-label-in-compound-statement-warning-v1-1-c9731d115f17@kernel.org>
 <ZUStrQCqBjBBB6dc@infradead.org>
 <20231103165312.GA3670349@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103165312.GA3670349@dev-arch.thelio-3990X>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Normally the kernel keeps the ifdef outside the function body and adds
a stub.  But this already looks like a huge imrpovement over the
existing version to me.

