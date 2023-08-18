Return-Path: <netdev+bounces-28835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8C4780F3F
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 17:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55D82823EE
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 15:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3CE18C3A;
	Fri, 18 Aug 2023 15:33:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FB5182BC
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 15:33:21 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473032D5A;
	Fri, 18 Aug 2023 08:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qzszM0Lpy8x0zxd5N5n7Y7VXGfZYKgbxkD8yi0ja1zg=; b=cZ3Im820w1GTOcKi8DR15WO51g
	pmo0tXIQvyw16CvvXpt4fXgdm2q0YCgJpqQ9elRg7ZWpSaFyptynnIqsLoSMf8AnExnA2mcISB+YN
	vfyTVUFCb22CNFZx4HzYXcgJtJsqKwDwQmS86ntyukViNkFkAoszMYhPCXgd8WjC6rLA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qX1T9-004VPy-Vu; Fri, 18 Aug 2023 17:32:59 +0200
Date: Fri, 18 Aug 2023 17:32:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: Fix deadlocking in phy_error() invocation
Message-ID: <d6569dc7-f7ae-480e-9d7a-fe3bd5bd31ed@lunn.ch>
References: <20230818125449.32061-1-fancer.lancer@gmail.com>
 <6e52f88e-73ad-4e2a-90ca-ada471f30b9d@lunn.ch>
 <mk5yter5d6pvdyahfhfruszwp54immvfb3bb7a7chofyhauksb@7vkgyxevt2yv>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mk5yter5d6pvdyahfhfruszwp54immvfb3bb7a7chofyhauksb@7vkgyxevt2yv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> A trace is already printed by means of WARN()/WARN_ON()
> in the phy_process_error() method callers:
> phy_error_precise()
> and
> phy_error()
> Wouldn't it be too much to print it twice in a row?

Ah, good point. I missed that.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

pw-bot: new

