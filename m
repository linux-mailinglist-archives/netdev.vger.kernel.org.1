Return-Path: <netdev+bounces-27533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 367A077C4ED
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 03:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4281C20BED
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 01:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B1915C1;
	Tue, 15 Aug 2023 01:16:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31E4625
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 01:16:14 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848D31715;
	Mon, 14 Aug 2023 18:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vmDqYNYNVKX9nXI+lnVpwoCYe/6hDlYjcGo/oG9uNZw=; b=pU6w/PiTHnSopHqx4VBIZ9YE+K
	Peh6KOzMWxCwpjUPzVboVRk8HlCIt2ia5B6yapuSphNtOBHySbIuXH8+Ck36sg805kKE269OThiNM
	Ix5oCOPg0FWwvm2s1NyFG9V9jsvzdpjAEjlhLdteBO3EPw7tUlIqCX3eAAWld1wlTXrA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qVifD-0046d9-ES; Tue, 15 Aug 2023 03:16:03 +0200
Date: Tue, 15 Aug 2023 03:16:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alfred Lee <l00g33k@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, sgarzare@redhat.com, AVKrasnov@sberdevices.ru
Subject: Re: [PATCH net v3] net: dsa: mv88e6xxx: Wait for EEPROM done before
 HW reset
Message-ID: <a7f0ffc1-eb12-4e76-8e0e-7adf40912d08@lunn.ch>
References: <20230815001323.24739-1-l00g33k@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815001323.24739-1-l00g33k@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 14, 2023 at 05:13:23PM -0700, Alfred Lee wrote:
> If the switch is reset during active EEPROM transactions, as in
> just after an SoC reset after power up, the I2C bus transaction
> may be cut short leaving the EEPROM internal I2C state machine
> in the wrong state.  When the switch is reset again, the bad
> state machine state may result in data being read from the wrong
> memory location causing the switch to enter unexpected mode
> rendering it inoperational.

Hi Alfred

It is normal to place a history after the --- of what changed between
each version.

> Fixes: a3dcb3e7e70c ("net: dsa: mv88e6xxx: Wait for EEPROM done after HW reset")
> Signed-off-by: Alfred Lee <l00g33k@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

