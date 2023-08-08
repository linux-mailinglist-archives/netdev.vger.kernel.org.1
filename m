Return-Path: <netdev+bounces-25556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D26B5774B25
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 22:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F56281878
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFACC14F90;
	Tue,  8 Aug 2023 20:42:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB6B1B7F0
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 20:42:12 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035CF93D3
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 13:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IUUupTrh01KI7GSQaLdgaJaq14w9m6HX6j5jdiwQCYE=; b=jjKpRVwhjiAdNnmitZ1TNXToKK
	fqUR935hMAAcjLuIgnZOevPuVlndcKdvSq/weciOJpVXHXT2xUGlirC856sms/ECMdye+qS3663+m
	1yS2KkwM7ye8tdjTyTaCosiNzInHhsrYInYSnX5RQDgizIlc5G0Dabubw0PpIRxYYxDs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qTTWZ-003W4A-8j; Tue, 08 Aug 2023 22:41:51 +0200
Date: Tue, 8 Aug 2023 22:41:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, hkallweit1@gmail.com, Jose.Abreu@synopsys.com,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v2 1/7] net: pcs: xpcs: add specific vendor
 supoprt for Wangxun 10Gb NICs
Message-ID: <b53e4e02-dc74-4993-937d-6acd5d1cdd9b@lunn.ch>
References: <20230808021708.196160-1-jiawenwu@trustnetic.com>
 <20230808021708.196160-2-jiawenwu@trustnetic.com>
 <ZNIJDMwlBa/LRJ0C@shell.armlinux.org.uk>
 <082101d9c9dd$2595f400$70c1dc00$@trustnetic.com>
 <ZNISkaXBNO5z6csw@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNISkaXBNO5z6csw@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > > If the answer to that is yes, it would be preferable to use that
> > > rather than adding a bitarray of flags to indicate various "quirks".
> > 
> > It has not been implemented yet. We could implement it in flash if it's wanted.
> > But it would require upgrading to the new firmware.
> 
> Andrew, do you any opinions? Do you think it would be a good idea to
> use the device/package identifiers, rather than a bitfield of quirks?

Using identifiers would be cleaner.

Does trustnetic or net-swift have an OUI?

     Andrew

