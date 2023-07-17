Return-Path: <netdev+bounces-18434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6F9756F14
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 23:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B47A1C2084F
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 21:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFED107B9;
	Mon, 17 Jul 2023 21:44:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB097C2D7
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 21:44:12 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8786792
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 14:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9AlDxrfrCnaUgF7MCaNSZI4toF7sBELMk3aubRtuKSw=; b=ql+k0kseAIuotcT5PBajzP5Wa8
	UOyNMdh688dCNu4FVu2Ol2ruTRn9XwOa18uzKLM1pX4gWhsEd0PGKmBxLJ24Dl8o1yyS0zAmburPi
	4ezVo6idMgQO3feaySM4doHKNVgmC6cfZ5BGlgfatMg3ofCGmsOFytKv3J3dIhtWuL+E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qLW0j-001a6K-RW; Mon, 17 Jul 2023 23:44:05 +0200
Date: Mon, 17 Jul 2023 23:44:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	francesco.dolcini@toradex.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v3 1/5] net: phy: add registers to support
 1000BASE-T1
Message-ID: <5d2a5687-712f-4529-b3e8-836f9ff59bf9@lunn.ch>
References: <20230717193350.285003-1-eichest@gmail.com>
 <20230717193350.285003-2-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717193350.285003-2-eichest@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 17, 2023 at 09:33:46PM +0200, Stefan Eichenberger wrote:
> Add registers and definitions to support 1000BASE-T1. This includes the
> PCS Control and Status registers (3.2304 and 3.2305) as well as some
> missing bits on the PMA/PMD extended ability register (1.18) and PMA/PMD
> CTRL (1.2100) register.
> 
> Signed-off-by: Stefan Eichenberger <eichest@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

