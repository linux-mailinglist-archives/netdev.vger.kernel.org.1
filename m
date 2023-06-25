Return-Path: <netdev+bounces-13825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741E673D1CD
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 17:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C655280EFA
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 15:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C7B6AAD;
	Sun, 25 Jun 2023 15:40:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64DD63C5
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 15:40:41 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DA8AB
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 08:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=wbA1X8P8q9Nn2dgeHCb9Ky10cuZDXQlKYXH8urp2PWs=; b=E7
	CXDAnX4PkRoJ8995zAZsxti7WiAd3eMVKqYGgFZENM6zxBH3DHItlA0PV+HC0L0krJowhc2cqnJxF
	IMUD5Ne0igo/pxtIMUKxtvbNAhLTlOm1qMD9cBdxx5o7Clzi0WrSO4DqDN5x5BUfy5luVWia25vGU
	KGPovYMD09aXmKM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qDRqo-00HUR4-4z; Sun, 25 Jun 2023 17:40:30 +0200
Date: Sun, 25 Jun 2023 17:40:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiawen Wu <jiawenwu@trustnetic.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: txgbe: change hw reset mode
Message-ID: <362f04fc-dafb-4091-a0cc-b94931083278@lunn.ch>
References: <20230621090645.125466-1-jiawenwu@trustnetic.com>
 <20230622192158.50da604e@kernel.org>
 <D61A4E6D-8049-4454-9870-E62C2A980D0C@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D61A4E6D-8049-4454-9870-E62C2A980D0C@net-swift.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jun 25, 2023 at 04:31:01PM +0800, mengyuanlou@net-swift.com wrote:
> 
> 
> > 2023年6月23日 10:21，Jakub Kicinski <kuba@kernel.org> 写道：
> > 
> > On Wed, 21 Jun 2023 17:06:45 +0800 Jiawen Wu wrote:
> >> The old way to do hardware reset is sending reset command to firmware.
> >> In order to adapt to the new firmware, driver directly write register
> >> of LAN reset instead of the old way.
> > 
> > Which versions of the FW use one method vs the other? Why is it okay 
> > to change the driver for new FW, are there no devices running old FW
> > in the wild? Or the new method is safe for both?
> 
> Lan reset contains of phy reset and dma reset.
> New FW versions will support NCSI/LLDP which needs phy not to down.
> When drivers do lan reset, fw can set a veto bit to block phy reset and
> still to do dma reset.

That does not answer the question. Is this backwards compatible with
old firmware?

	Andrew

