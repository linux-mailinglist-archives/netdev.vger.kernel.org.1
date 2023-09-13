Return-Path: <netdev+bounces-33684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA38A79F3E7
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 23:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652791F2146B
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 21:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A853322EFC;
	Wed, 13 Sep 2023 21:37:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D5A1DA50
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 21:37:31 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816AE1724;
	Wed, 13 Sep 2023 14:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WgAB9SAfkpGIabHV4CqdvtxhlA1ScpVv8kzv92uGnyM=; b=Hv/YvKQov0SoJ8rTHsgChXNdgZ
	e0bGH6agSkcEtOoEXsZmt0aLiwPIlE4e39u95QoWkZvn9dSNFnaHt/YRPsoZ21wUXrNrazh7Zvois
	vjOSuUv/U/u4GA8evFI10ATj7pLLzu+H1Uc6qcN3E/RjvtyPWRcRL7uDa6wg/B+I2zNk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qgXY1-006LK5-8V; Wed, 13 Sep 2023 23:37:21 +0200
Date: Wed, 13 Sep 2023 23:37:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 02/13] net:ethernet:realtek:rtase: Implement
 the .ndo_open function
Message-ID: <a7a4d7b6-84cd-49fc-9fde-1a6a232bf7af@lunn.ch>
References: <20230912091830.338164-1-justinlai0215@realtek.com>
 <20230912091830.338164-3-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912091830.338164-3-justinlai0215@realtek.com>

On Tue, Sep 12, 2023 at 05:18:19PM +0800, Justin Lai wrote:
> Implement the .ndo_open function to set default hardware settings
> and initialize the descriptor ring and interrupts. Among them,
> when requesting irq, because the first group of interrupts needs to
> process more events, the overall structure will be different from
> other groups of interrupts, so it needs to be processed separately.

Please take a look at the page pool code.

       Andrew

