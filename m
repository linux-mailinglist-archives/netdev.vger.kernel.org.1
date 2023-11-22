Return-Path: <netdev+bounces-49936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF437F3ED1
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 08:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11BE6280DFF
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 07:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991F51C2AD;
	Wed, 22 Nov 2023 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KFbh52Me"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B524E98;
	Tue, 21 Nov 2023 23:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C3HyZQRnJO9EqJwETvVaXZbN3z73cWz7ZWScuDy8MZQ=; b=KFbh52MeuV7DDHCIaijeZcHO66
	efTM8ckcvShYP9b6aGDVWeKsSOHLWnvPV0ro6zclldqI0wwRqhLmHVEPEhZCx/cv0kLKoJloQDVs5
	uB/HWf/ocTNOY/wjoMPO5ToUfN12EQJfLODZVPKjYCeVUrAODBePK/cVXP1FoVI9Qig5Plm8HhELA
	MP8k54hO27Mm9tM004D1Z09YnW6w0gESvtqOXiTPpCEh6BtCLAzRLq5laL5lL4QXSzuIK3IK+7VUv
	NTz9teq11JCVIX2K6uU2o3cKCRTdHBmZBbOyiS+CV+PSmYY1EDEbqOhkTktOL2a/st+7c2sdssoj9
	EUvM3mnA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5hZh-000tqM-0r;
	Wed, 22 Nov 2023 07:23:05 +0000
Date: Tue, 21 Nov 2023 23:23:05 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jkbs@redhat.com,
	kunwu.chan@hotmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ipv6: Correct/silence an endian warning in
 ip6_multipath_l3_keys
Message-ID: <ZV2sWSRzZhy4klrq@infradead.org>
References: <20231122071924.8302-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122071924.8302-1-chentao@kylinos.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 22, 2023 at 03:19:24PM +0800, Kunwu Chan wrote:
> net/ipv6/route.c:2332:39: warning: incorrect type in assignment (different base types)
> net/ipv6/route.c:2332:39:    expected unsigned int [usertype] flow_label
> net/ipv6/route.c:2332:39:    got restricted __be32

Can you expain why you think the __force cast is the correct thing to do
here?

