Return-Path: <netdev+bounces-17003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 171E574FC73
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 02:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448E61C20E64
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 00:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC3E376;
	Wed, 12 Jul 2023 00:58:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01265362
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 00:58:46 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C4710C2
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 17:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=u63cQ9KJgFZk0WRTc/D8CnfvJCtpLoT7pCLvVg5QEIg=; b=K5Z9pafVgL3h8v9oVD4MMbaxhL
	RBAEtAUzV26ECVMQGfrwPo2mJrCfxaeIw/Oqjqp6A3JMxwRpm2BNoV5bLe+x51mdCvVd6iWTlZiO/
	YdCaBp1Zld8yXya2jKVf6REGIUS3zcduXAp6x7193P/2hXeJhKdtys4l1I0SaNcVDC9o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qJOBn-0015VV-Qy; Wed, 12 Jul 2023 02:58:43 +0200
Date: Wed, 12 Jul 2023 02:58:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Sergei Antonov <saproj@gmail.com>, netdev@vger.kernel.org,
	rmk+kernel@armlinux.org.uk
Subject: Re: Regression: supported_interfaces filling enforcement
Message-ID: <f1fec161-1eb5-4b3f-b621-9bb9b4bfd634@lunn.ch>
References: <CABikg9wM0f5cjYY0EV_i3cMT2JcUT1bSe_kkiYk0wFwMrTo8=w@mail.gmail.com>
 <20230710123556.gufuowtkre652fdp@skbuf>
 <CABikg9zfGVEJsWf7eq=K5oKQozt86LLn-rzMaVmycekXkQEa8Q@mail.gmail.com>
 <20230710153827.jhdbl5xh3stslz3u@skbuf>
 <CABikg9xc5PryyT+b=3JsJoHppe+tfOs+BWrq+kETQK99A-DG=g@mail.gmail.com>
 <20230711215848.lhflxqbpyjkmkslj@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711215848.lhflxqbpyjkmkslj@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 12:58:48AM +0300, Vladimir Oltean wrote:
> On Mon, Jul 10, 2023 at 09:09:48PM +0300, Sergei Antonov wrote:
> > On Mon, 10 Jul 2023 at 18:38, Vladimir Oltean <olteanv@gmail.com> wrote:
> > 
> > > That being said, given the kind of bugs I've seen uncovered in this
> > > driver recently, I'd say it would be ridiculous to play pretend - you're
> > > probably one of its only users. You can probably be a bit aggressive,
> > > remove support for incomplete device trees, see if anyone complains, and
> > > they do, revert the removal.
> > 
> > Can mv88e6060 functionality be transferred to mv88e6xxx?
> 
> Honestly, I don't know.

I think Vivien looked at that once, but decided against it. I don't
remember why. Maybe because of lack of hardware, or anybody to test
it?

	Andrew



