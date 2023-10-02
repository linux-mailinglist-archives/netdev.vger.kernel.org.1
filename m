Return-Path: <netdev+bounces-37525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3907B5C5C
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 23:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 944852816D3
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 21:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E7320324;
	Mon,  2 Oct 2023 21:07:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8701C6FB8
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 21:07:36 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88948E;
	Mon,  2 Oct 2023 14:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cHdxPJkUffAe71uXd4ceymr9QjRVP6992Y6TUUtw5Jk=; b=VOLjccYRB8DDrJeZxkRDhrd9M6
	BAI10X6BkVMCgCay8Q3Q/aMez4oITD685DE1zeK8PUNHxCZEcL94F657Z7+jH/bdNSKjik+R56PUe
	5XF6DFiRwvZykTNg+UQ+yL8B5S3k960aDSS0N0+z9O4BnqwpL6Gn2Dcu66A3071gKz0k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qnQ8T-0083OV-Ly; Mon, 02 Oct 2023 23:07:25 +0200
Date: Mon, 2 Oct 2023 23:07:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Robert Marko <robimarko@gmail.com>, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next] net: phy: aquantia: add firmware load
 support
Message-ID: <9a84642e-b4fe-4e36-bcdc-d02c84bb1dc9@lunn.ch>
References: <20230930104008.234831-1-robimarko@gmail.com>
 <df89a28e-0886-4db0-9e68-5f9af5bec888@lunn.ch>
 <651b26a5.050a0220.213bf.e11b@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <651b26a5.050a0220.213bf.e11b@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> This is problematic... Since this is a plain standard PHY and we don't
> have a compatible (as it's matched with the PHY id) we don't have DT to
> add this... Sooo how to add this? Should we update the generic-phy dt?
> 
> Should we create a dummy dt and add a compatible adding
> ethernet-phy.ID... just for this properties?
> 
> This is why we were a bit confused about adding a DT commit to this.

Just do what other PHYs do. ti,dp83869.yaml, motorcomm,yt8xxx.yaml,
nxp,tja11xx.yaml, etc.

	Andrew

