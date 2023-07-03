Return-Path: <netdev+bounces-15163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6275C745FF5
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 17:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A24C280CC5
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 15:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35532100C0;
	Mon,  3 Jul 2023 15:38:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251F579D5
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 15:38:28 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7FCE49;
	Mon,  3 Jul 2023 08:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wkqMLEVigBtW/F9ZQ5Js0pxTwVvpXSe9+nI17gSnD6U=; b=OB4Cj7jiwBQjss9EmPrZbH9RYS
	/h9Drdy2vDECtzQNkcUXAHLbIWEUieDHkJM7sU3e3J+xjOR3CyUn2MOwr5rVahZfMSVtw+sGzSABt
	sP/W2VT4rJNK0QiF4t0M80S9b1dK8V2XaqrhDS6xWh7O9QHXW9iOwDtD0uQiwRRBpCzU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qGLd9-000UQQ-5y; Mon, 03 Jul 2023 17:38:23 +0200
Date: Mon, 3 Jul 2023 17:38:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "M. Haener" <michael.haener@siemens.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: Re: [PATCH 0/3] net: dsa: SERDES support for mv88e632x family
Message-ID: <3664909e-a259-4bca-be53-5bab43e23dbc@lunn.ch>
References: <20230703152611.420381-1-michael.haener@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703152611.420381-1-michael.haener@siemens.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 03, 2023 at 05:26:06PM +0200, M. Haener wrote:
> From: Michael Haener <michael.haener@siemens.com>
> 
> This patch series brings SERDES support for the mv88e632x family.

Please take a look at Russell Kings series:

https://www.spinics.net/lists/netdev/msg914908.html

It would be good if you could build on top of that, which we should be
merging soon.

   Andrew

