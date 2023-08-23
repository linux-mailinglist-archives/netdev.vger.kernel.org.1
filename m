Return-Path: <netdev+bounces-30062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204A0785C33
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 17:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4745F1C20C9A
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 15:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E7FC8D4;
	Wed, 23 Aug 2023 15:35:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FC4C2F8
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 15:35:51 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD39BE4E
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 08:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ErDNAUCocKSLt+qkkGIfIJzWEGJFTz9fQ02v0TDuewA=; b=BUM3vf4X+FMLcRF3MINmuGl0WW
	8kdcnxfmyooNn8G7t+mD2K/cL3aV9eT9lazqN2nD0Yh6ATft/bIfOGNRijOxjC2hjOryTHdPtnGT/
	w3q9OjzV/jbNJaCupMu1zsVxfDHzHs9D6CzLa/8njgtE5h/Y0v7ZeSz48r38XddX7F9Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qYptT-004u1X-BH; Wed, 23 Aug 2023 17:35:39 +0200
Date: Wed, 23 Aug 2023 17:35:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, Jose.Abreu@synopsys.com,
	rmk+kernel@armlinux.org.uk, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v3 7/8] net: txgbe: support copper NIC with
 external PHY
Message-ID: <7d999689-cea9-4e66-8807-a04eb9ad4cb5@lunn.ch>
References: <20230823061935.415804-1-jiawenwu@trustnetic.com>
 <20230823061935.415804-8-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823061935.415804-8-jiawenwu@trustnetic.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +static int txgbe_phy_read(struct mii_bus *bus, int phy_addr,
> +			  int devnum, int regnum)

There is a general pattern to use the postfix _c45 for the method that
implements C45 access. Not a must, just a nice to have.

Does this bus master not support C22 at all?

     Andrew

