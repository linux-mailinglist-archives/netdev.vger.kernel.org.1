Return-Path: <netdev+bounces-41650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4097E7CB82D
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 03:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F04AF2814CD
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 01:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDD8440D;
	Tue, 17 Oct 2023 01:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="H66hswY+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A754402
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 01:57:50 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA814D9
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 18:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LLL8azOnxijkldHrCyjrkUMH6ntn9EpQTnNIpM02RF4=; b=H66hswY+SdTYzvRbk1Id/zrNyD
	uLggmlQtXsbWd1Ywqox1mc9nZbpDkx57YYlb6IZjtFExPMleYWtvn3BIWG3+f7DrFpwq9r6MjM9oh
	2lEUnrRuYHk939tfQa2RLsq/9p5V+9u+clOSkGWx3arLRO2mIWCGDoxPWkgMjf4It4tM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qsZL7-002QHY-8X; Tue, 17 Oct 2023 03:57:45 +0200
Date: Tue, 17 Oct 2023 03:57:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Coco Li <lixiaoyan@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Mubashir Adnan Qureshi <mubashirq@google.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>,
	David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH v2 net-next 2/5] net-smnp: reorganize SNMP fast path
 variables
Message-ID: <a666cea7-078d-4dc0-bad9-87fa15e44036@lunn.ch>
References: <20231017014716.3944813-1-lixiaoyan@google.com>
 <20231017014716.3944813-3-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017014716.3944813-3-lixiaoyan@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 01:47:13AM +0000, Coco Li wrote:
> From: Chao Wu <wwchao@google.com>
> 
> Reorganize fast path variables on tx-txrx-rx order.
> Fast path cacheline ends afer LINUX_MIB_DELAYEDACKLOCKED.
> There are only read-write variables here.
> 
> Below data generated with pahole on x86 architecture.
> 
> Fast path variables span cache lines before change: 12
> Fast path variables span cache lines after change: 2

As i pointed out for the first version, this is a UAPI file.

Please could you add some justification that this does not cause any
UAPI changes. Will old user space binaries still work after this?

Thanks
	Andrew

