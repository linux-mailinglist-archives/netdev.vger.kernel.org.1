Return-Path: <netdev+bounces-25858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3DE776033
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 15:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885AB281B82
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 13:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC2E18AFB;
	Wed,  9 Aug 2023 13:07:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8AB63DF
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 13:07:55 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB24C1FF9
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 06:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SBueEm+ATg2KVueyc9jCCSO0FZJuC2IWIzYzxKJf+a4=; b=hkyAy1Tl3s2t65x1kl+aVbZ9h0
	RgDIzJQk832g+IPZ+ox+ZiMVkRbO1VlDe60pbNKw8urc4UMXwNE1GDJDeNOOHZDLFCvtNnpRe/Jgr
	tid2tM1EXclEB2qEfPAfVUtMCxQG5YbCpz0saudoXd4qnr1JdB9lygBo6AwMt/k7mvZE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qTiuY-003ZvW-BM; Wed, 09 Aug 2023 15:07:38 +0200
Date: Wed, 9 Aug 2023 15:07:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: "'Russell King (Oracle)'" <linux@armlinux.org.uk>,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
	Jose.Abreu@synopsys.com, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v2 1/7] net: pcs: xpcs: add specific vendor
 supoprt for Wangxun 10Gb NICs
Message-ID: <317b1df4-0a95-40fb-9a1b-16f28ba1fcb7@lunn.ch>
References: <20230808021708.196160-1-jiawenwu@trustnetic.com>
 <20230808021708.196160-2-jiawenwu@trustnetic.com>
 <ZNIJDMwlBa/LRJ0C@shell.armlinux.org.uk>
 <082101d9c9dd$2595f400$70c1dc00$@trustnetic.com>
 <ZNISkaXBNO5z6csw@shell.armlinux.org.uk>
 <b53e4e02-dc74-4993-937d-6acd5d1cdd9b@lunn.ch>
 <086a01d9ca8d$94387df0$bca979d0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <086a01d9ca8d$94387df0$bca979d0$@trustnetic.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Yes, net-swift's OUI is 30:09:F9.
> 
> But if we want to read OUI from PCS to identify the vendor, we need the
> next version of firmware to do this. How can this be compatible with the
> old firmware version?
 
In general, the driver should offer only the features the firmware
supports.

So if you find a PCS with the old OUI, don't offer the link modes
which require the PCS configured in special ways. You can also issue a
warning that the firmware should be upgraded.

	Andrew

