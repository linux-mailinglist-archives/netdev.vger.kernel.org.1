Return-Path: <netdev+bounces-18621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D451757FF2
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 16:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4803B2815A5
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 14:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEA6D532;
	Tue, 18 Jul 2023 14:45:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED50FBEE
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 14:45:18 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85908EC
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 07:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=srAcaDTs+jlFpwZXVI9kZY0ddnPyOkCeK+wMC8grPxA=; b=qJABC96K/LQRSDfwIlqWfKpMS2
	JWyNcJNkqxpNcys7Mlk5k3wiirK0LQ5lvgA+4zdyzN651pHIvbYj1scxyXYasbcGx6Cg6m2VfShiv
	R7iyGxuCX21JNDSoMZMWV+120CPQHRn9F+OCUtdgNNQFaSGFbHY9kC8jnvXswgoK8Leo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qLlwy-001dK2-0e; Tue, 18 Jul 2023 16:45:16 +0200
Date: Tue, 18 Jul 2023 16:45:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: core: add member ncsi_enabled to net_device
Message-ID: <46b7d67f-b43e-4231-b03f-48df0ff27804@lunn.ch>
References: <3CF66F8947B520BF+20230718022321.30911-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3CF66F8947B520BF+20230718022321.30911-1-mengyuanlou@net-swift.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 18, 2023 at 10:23:21AM +0800, Mengyuan Lou wrote:
> Add flag ncsi_enabled to struct net_device indicating whether
> NCSI is enabled. Phy_suspend() will use it to decide whether PHY
> can be suspended or not.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>

You posted the patch twice, with no explanation why? I already
commented on the previous version.


    Andrew

---
pw-bot: cr

