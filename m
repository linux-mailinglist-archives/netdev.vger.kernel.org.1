Return-Path: <netdev+bounces-50573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFC17F626A
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 16:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE111C20FA0
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 15:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245B535887;
	Thu, 23 Nov 2023 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SwIwAKvj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A69D5E
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 07:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SOA1onw+0EpDyFmeXmQa7IXNt57J7yV7bHfOE3LlvK8=; b=SwIwAKvjD3YlFFBYKBEo5yujmH
	zzXuZvUIlQNlYzbs1qfMoS3yChgw6O/7axQ2v20MECxqA6oqazX+yfaU+h4aUOcD22ooTY6CVzpXu
	qbjuyxOgd5bwgEkMVQRdQYwVp6HfeI4h3JmZl0Ke05s+kBl1j7wclvChO1g8vFsJwenE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r6BOz-0010QH-OG; Thu, 23 Nov 2023 16:14:01 +0100
Date: Thu, 23 Nov 2023 16:14:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	horms@kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 2/5] net: wangxun: add ethtool_ops for ring
 parameters
Message-ID: <7ea9bbf9-cde3-4280-9967-861b39309b23@lunn.ch>
References: <20231122102226.986265-1-jiawenwu@trustnetic.com>
 <20231122102226.986265-3-jiawenwu@trustnetic.com>
 <4a36b46d-3f71-430f-8158-da58769ae52a@lunn.ch>
 <00f801da1dee$fe4975a0$fadc60e0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00f801da1dee$fe4975a0$fadc60e0$@trustnetic.com>

> I tried to move them into the library, but *_down() and *_up() here
> involves some different flows for the two devices, it's not easy to handle.
 
O.K. Thanks for the explanation.

     Andrew

