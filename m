Return-Path: <netdev+bounces-22210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BD4766812
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 11:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021C91C216B5
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 09:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7732107B6;
	Fri, 28 Jul 2023 09:02:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6F9101D9
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 09:02:32 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D903106;
	Fri, 28 Jul 2023 02:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Efxv61OBl1EiofB69+walzHGXHvBZzrPaLxDwIpj2oQ=; b=cJQBpCixdMKHnu++k/y74R3p+q
	UZgo7/3fDOmrojIZ20WoTYF3SLqVV/sR7xv9L/QXDGl+rAHR19b3w2HWownm6jVpZLlyN9y0FfA+h
	vrgBD9oDTbKJYBT/46TUt7rptaoWMl80ga7JNcA1Epg31i620B5NEFBEKXMi2tQnaWeM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qPJMe-002WI0-Cv; Fri, 28 Jul 2023 11:02:24 +0200
Date: Fri, 28 Jul 2023 11:02:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Mark Brown <broonie@kernel.org>,
	Masahisa Kojima <masahisa.kojima@linaro.org>,
	Jassi Brar <jaswinder.singh@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
Message-ID: <777d7770-4ab6-4c69-89a4-a0b1a6abb998@lunn.ch>
References: <20230727-synquacer-net-v1-1-4d7f5c4cc8d9@kernel.org>
 <CAMj1kXH_4OEY58Nb9yGHTDvjfouJHKNVhReo0mMdD_aGWW_WGQ@mail.gmail.com>
 <ZMN/4F4TZZtt8B/b@hades>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMN/4F4TZZtt8B/b@hades>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> U-Boot does support the network interface (sni-netsec.c) but I'll have to
> check what that code does wrt to the PHY config.  Since the interface works
> I am assuming some config is done properly. 

It might only be done if TFTP boot is used etc. If booting from FLASH,
maybe the network is not initialised, leaving the PHY in its power on
default state.

In general, it is much better for Linux not to assume the bootloader
has configured the hardware, since developers have a choice of boot
loaders.

	Andrew

