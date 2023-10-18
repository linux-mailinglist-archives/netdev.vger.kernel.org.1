Return-Path: <netdev+bounces-42255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 765697CDDED
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 15:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2FABB20F62
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 13:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3431136AF9;
	Wed, 18 Oct 2023 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Vz6OyfJn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F3B199B3
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 13:53:49 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE72F119
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XrnQ7SNzMZi1cu5H1Ik6cFTb2ZYHfKIlE4KvGTYaOYs=; b=Vz6OyfJnur/jkzdmANiMAFK9Tg
	cBNIXZPLqW1iDB6XMJVN9PkiZdVWnOGUY5ptXq2MN34NmK63wmkKdXJ54thQ0jE4QB/G1nJeFAEdi
	HWBdvulZ3tqBJiioXWnYvuZK0Is3YPXqLeMw5MRQGpzjZnGvJ+GcAORC17F0UBiqXiw0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qt6zQ-002aWm-MN; Wed, 18 Oct 2023 15:53:36 +0200
Date: Wed, 18 Oct 2023 15:53:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH] net: wangxun: remove redundant kernel log
Message-ID: <585fdcaa-d6e7-4bea-93b4-82786bf82017@lunn.ch>
References: <20231017100635.154967-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017100635.154967-1-jiawenwu@trustnetic.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 06:06:35PM +0800, Jiawen Wu wrote:
> Since PBA info can be read from lspci, delete txgbe_read_pba_string()
> and the prints. In addition, delete the redundant MAC address printing.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

