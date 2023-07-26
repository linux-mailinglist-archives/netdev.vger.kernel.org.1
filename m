Return-Path: <netdev+bounces-21259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EA2763010
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 10:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B75281CE8
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 08:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADE4AD29;
	Wed, 26 Jul 2023 08:39:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7FA8469
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 08:39:21 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14CC4EFC;
	Wed, 26 Jul 2023 01:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EWUaQxeKGJ4qJalm52aP93ztFzOZTVzpHXehk2zbXTY=; b=DhOnjCq1ioxxsp65AMIiLHniTW
	8m4u3Cq6Wa5ONKj85O7PiifX7Y+fCJIr+f/ZQcU8g1vR2VfjSyU45GbVxBOu+bDmYohMPh/yDWavW
	C0Oqng3Ws+tcykRjQO/uh5qiXviftFfrfJjdPzBUaZOjYHuup5AFxZr0YuiimBPGw+kI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qOa37-002L6O-Ck; Wed, 26 Jul 2023 10:39:13 +0200
Date: Wed, 26 Jul 2023 10:39:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hayes Wang <hayeswang@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
	nic_swsd@realtek.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] r8152: set bp in bulk
Message-ID: <0c42418b-7271-415d-991a-a4564cb3fad5@lunn.ch>
References: <20230726030808.9093-417-nic_swsd@realtek.com>
 <20230726030808.9093-419-nic_swsd@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726030808.9093-419-nic_swsd@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -	ocp_write_word(tp, type, PLA_BP_0, 0);
> -	ocp_write_word(tp, type, PLA_BP_1, 0);
> -	ocp_write_word(tp, type, PLA_BP_2, 0);
> -	ocp_write_word(tp, type, PLA_BP_3, 0);
> -	ocp_write_word(tp, type, PLA_BP_4, 0);
> -	ocp_write_word(tp, type, PLA_BP_5, 0);
> -	ocp_write_word(tp, type, PLA_BP_6, 0);
> -	ocp_write_word(tp, type, PLA_BP_7, 0);
> +	generic_ocp_write(tp, PLA_BP_0, BYTE_EN_DWORD, bp_num << 1, bp, type);
>  
>  	/* wait 3 ms to make sure the firmware is stopped */
>  	usleep_range(3000, 6000);

How much time do you save compared to this 3ms - 6ms sleep?

    Andrew

