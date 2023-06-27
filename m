Return-Path: <netdev+bounces-14256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A547B73FC6B
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 15:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B711C20B05
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 13:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A2517FFE;
	Tue, 27 Jun 2023 13:07:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C49171C5
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 13:07:59 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DB41715;
	Tue, 27 Jun 2023 06:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XUis5pG35TsAgUo4YDECHCrWQ4QCida4BlQpVHkG5bA=; b=I3ROVaFWpWwm1rFStU6g8fw0Dr
	/RrARqjoo6AQ+tACuJcEbLhEDaqsy0Q0biQRlxT78jtC/mc1T+29TmNMLzxzuKOVTc1yQjVv9+bRX
	RZZFPIR1WFrKxW1//f6tvR4BryWk+pGFeEoE9nocVL2WnHgH5L/Obe3FqU2AapAXHxZA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qE8Pw-0001oD-IO; Tue, 27 Jun 2023 15:07:36 +0200
Date: Tue, 27 Jun 2023 15:07:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Moritz Fischer <moritzf@google.com>, netdev@vger.kernel.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com, mdf@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: lan743x: Don't sleep in atomic context
Message-ID: <35db66a9-d478-4b15-ad30-bfc4cded0b5c@lunn.ch>
References: <20230627035000.1295254-1-moritzf@google.com>
 <ZJrc5xjeHp5vYtAO@boxer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJrc5xjeHp5vYtAO@boxer>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > +static int lan743x_csr_wait_for_bit_atomic(struct lan743x_adapter *adapter,
> 
> adapter is not used in readx_poll_timeout_atomic() call, right?
> can be removed.

I thought that when i first looked at an earlier version of this
patch. But LAN743X_CSR_READ_OP is not what you think :-(

       Andrew

