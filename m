Return-Path: <netdev+bounces-50180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222A17F4CB5
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 17:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DDA9B20F2A
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C01459B54;
	Wed, 22 Nov 2023 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WUg1bIeu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A496319A8
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 08:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=leoEm8ZhbUztXd3txeK0kLu5wDsV4K8U+NMZzGakG2U=; b=WUg1bIeuHTwsKBrTs3q+wTXxi6
	Kone/gDT0Ilc8uLiL7Ca6/4ozUFp4LINvJR1prLuY7q9EIWSKQ5zSlfez1XroJpcUS+S7JgnIG555
	++nUlq0aOq3jpnpQxGcrfE7JqTMIVoIPbV8OeaPGl2HaTLBsO37snsirQ+WE073jFtk8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r5qDA-000tHJ-4b; Wed, 22 Nov 2023 17:36:24 +0100
Date: Wed, 22 Nov 2023 17:36:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	horms@kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 5/5] net: wangxun: add ethtool_ops for msglevel
Message-ID: <3ad8b985-b3bd-4200-befd-0ddb7a64fd66@lunn.ch>
References: <20231122102226.986265-1-jiawenwu@trustnetic.com>
 <20231122102226.986265-6-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122102226.986265-6-jiawenwu@trustnetic.com>

On Wed, Nov 22, 2023 at 06:22:26PM +0800, Jiawen Wu wrote:
> Add support to get and set msglevel for driver txgbe and ngbe.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

