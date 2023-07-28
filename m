Return-Path: <netdev+bounces-22215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB9576693E
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 11:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1370282678
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 09:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D8410968;
	Fri, 28 Jul 2023 09:48:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93673D305
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 09:48:55 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522F22736
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 02:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rXshwr6NnA0DnMNbNzwAtTxHmL0vO/4n2x/hVfc4kRs=; b=u13mH9TE8mIffQpWdwfsZNLnBV
	U5HjwTfCaEr65g6YPXe170UJk496K8cweZY9mhFAZ2mrWoQwNsfLlY57cz5Ic4BjwvHcPME8N1XWR
	i0PIIEPbYwt9adQz325D26Al4M5TcWOgJAz+Vhw3DOE/e1HPFzmgvTQdTHeQgJZA5G7E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qPK5M-002WQ1-Bn; Fri, 28 Jul 2023 11:48:36 +0200
Date: Fri, 28 Jul 2023 11:48:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next 2/2] net: phy: add keep_data_connection to
 struct phydev
Message-ID: <ca9ab336-8ea9-43f5-8f3c-436832a9af2d@lunn.ch>
References: <20230724092544.73531-1-mengyuanlou@net-swift.com>
 <20207E0578DCE44C+20230724092544.73531-3-mengyuanlou@net-swift.com>
 <ZL+6kMqETdYL7QNF@corigine.com>
 <ZL/KIjjw3AZmQcGn@shell.armlinux.org.uk>
 <4B0F6878-3ABF-4F99-8CE3-F16608583EB4@net-swift.com>
 <21770a39-a0f4-485c-b6d1-3fd250536159@lunn.ch>
 <20230726090812.7ff5af72@kernel.org>
 <ba6f7147-6652-4858-b4bc-19b1e7dfa30c@lunn.ch>
 <20230726112956.147f2492@kernel.org>
 <E7600051-05CD-4440-A1E3-E0F2AFA10266@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E7600051-05CD-4440-A1E3-E0F2AFA10266@net-swift.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > All of this is usually in FW so we should be able to shape the
> > implementation in the way we want...
> > 
> We certainly can do all phy operations in Fw when we are using NCSI.

I would actually prefer Linux does it, not firmware. My personal
preference is also Linux driver the hardware, since it is then
possible for the community to debug it, extend it with new
functionality, etc. Firmware is a black box only the vendor can do
anything with.

But as Jakub points out, we are entering a new territory here with
your device. All the other host devices which support NCSI have
firmware driving the hardware, not Linux. This is why you cannot find
code to copy. You need to actually write the host side of the NCSI
protocol, and figure out what the API to phylink should be, etc.

	Andrew


