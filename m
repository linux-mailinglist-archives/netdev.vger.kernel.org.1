Return-Path: <netdev+bounces-14777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FC5743C96
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 15:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E89C3280FBC
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 13:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBBB154B2;
	Fri, 30 Jun 2023 13:22:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012A1101E2
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 13:22:03 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADA23A98;
	Fri, 30 Jun 2023 06:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=n0WqcGKVVTD9bO1ZsGFYOwnTXL/ZDC/uZem6waEIMg8=; b=G1q+UquIvwUlIMdH6wJvTNuFwm
	l1v5ecZihhJB7Bj34rZHYYrdLPXvTv9hnXztkVexafa3nlGImS26ALNpBSsmJ0beOjgu6F9oZengV
	NmnUlwkEZGFV5m0ATjkozKQR5qayAr4WBU0XbWUxD+kMjtvMzIxKCol6g/j6RFtTwLMg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qFE4L-000J54-5P; Fri, 30 Jun 2023 15:21:49 +0200
Date: Fri, 30 Jun 2023 15:21:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jie Luo <quic_luoj@quicinc.com>
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] net: phy: at803x: add qca8081 fifo reset on the link
 down
Message-ID: <924ebd8b-2e1f-4060-8c66-4f4746e88696@lunn.ch>
References: <20230629034846.30600-1-quic_luoj@quicinc.com>
 <20230629034846.30600-4-quic_luoj@quicinc.com>
 <e1cf3666-fecc-4272-b91b-5921ada45ade@lunn.ch>
 <0f3990de-7c72-99d8-5a93-3b7eaa066e49@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f3990de-7c72-99d8-5a93-3b7eaa066e49@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> SERDES device is the block converts data between serial data and parallel
> interfaces in each direction, which is the SGMII interface in qca8081 PHY,
> it's address is always the PHY address added by 1 in qca8081 PHY.

What other registers does this block have? What behaviour can be
configured? Does it have any support for Clause 73? Is there an open
datasheet for it?

	    Andrew

