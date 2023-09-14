Return-Path: <netdev+bounces-33894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A62D7A093A
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF03D282183
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F8626283;
	Thu, 14 Sep 2023 15:15:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBF039C
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:15:49 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2DF1BE7
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 08:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Jkz0RaA1Ijzo+oJ26ax7cjAm0B/iAAmevowLTA68ips=; b=5p8qamu0WX01u7tv3YEQj9qPeG
	8Hply1dFs8hPfo6Y+fq8HfyI6tBYMrFjT5uX3vMhQhZ472fOpXv0nBW9d7mll6rR+I6RV+DoCwzvf
	xnjMzONgvx0PwtUQYcQ/j6s7vJKaWA+DvUQ+hOAkSokbo3TW56hPoyTY+ZfqrPH147zk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qgo4I-006QKX-LW; Thu, 14 Sep 2023 17:15:46 +0200
Date: Thu, 14 Sep 2023 17:15:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fabio Estevam <festevam@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, l00g33k@gmail.com,
	netdev <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	sashal@kernel.org
Subject: Re: mv88e6xxx: Timeout waiting for EEPROM done
Message-ID: <8020f97d-a5c9-4b78-bcf2-fc5245c67138@lunn.ch>
References: <CAOMZO5AE3HkjRb9-UsoG44XL064Lca7zx9gG47+==GbhVPUFsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5AE3HkjRb9-UsoG44XL064Lca7zx9gG47+==GbhVPUFsw@mail.gmail.com>

On Thu, Sep 14, 2023 at 11:31:37AM -0300, Fabio Estevam wrote:
> Hi,
> 
> On an imx8mn-based board with an 88E6320 switch, the following error
> started showing up after the commit below on the 6.1 LTS branch:
> 
> mv88e6085 30be0000.ethernet-1:00: Timeout waiting for EEPROM done

Does this board actually have an EEPROM attached to the switch?

In mv88e6xxx_g1_wait_eeprom_done() what value is being returned for
the read of MV88E6XXX_G1_STS?

    Andrew

