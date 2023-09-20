Return-Path: <netdev+bounces-35283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FFF7A89B7
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 18:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD2C1C20AD3
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 16:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFA63E475;
	Wed, 20 Sep 2023 16:46:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E424339BB
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 16:46:12 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903D89F
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 09:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ay9PHcWxiK4vWdjkkwbpBjlT99feGpYkvpRk/jVtxdM=; b=euF2J3AFtHqUJRofzBzWyhjEAk
	pR5WHq8MRU1pCYzk/H2Q7xxKA9CFdUxIzrEzC9hI76MM+RxG6pO8b3zFI/5vwiIFEsSztpdA0/08G
	TRkHSdKHzavM8A4dZtfYMRsLbvP/Xbaj7DmHcRHaew0UXZKgREOgggB5fGowrNKBP98c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qj0Kx-0071VC-71; Wed, 20 Sep 2023 18:46:03 +0200
Date: Wed, 20 Sep 2023 18:46:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fabio Estevam <festevam@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, l00g33k@gmail.com,
	netdev <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	sashal@kernel.org
Subject: Re: mv88e6xxx: Timeout waiting for EEPROM done
Message-ID: <33eed988-f7cd-4e65-8047-0fe128a386e1@lunn.ch>
References: <333e23ae-fe75-48e1-a2fb-65b127ec9b3e@lunn.ch>
 <CAOMZO5AQ6VJi7Qhz4B0VQk5f2_R0bXB_RqipgGMBz9+vtHBMmg@mail.gmail.com>
 <5b5f24f4-f98f-4ea1-a4a3-f49c8385559d@lunn.ch>
 <CAOMZO5C3zPsu_K3z09Rc5+U1NCLc3wqbTpbeScn_yO02HwYkAg@mail.gmail.com>
 <2ff5a364-d6b3-4eda-ab5c-e61d4f7f4054@lunn.ch>
 <CAOMZO5D-F+V+5LFGqiw_N8tNPtAVMANGQjUnUW9_WeTj6sBN5g@mail.gmail.com>
 <15320949-6ee3-48f3-b61d-aaa88533d652@lunn.ch>
 <CAOMZO5BV3MucdxhEXhLy+XTo7yh5vGDHuA1r82B8vdrexo+N6g@mail.gmail.com>
 <bcc0f229-fbf9-42f4-9128-63b9f61980ae@lunn.ch>
 <CAOMZO5BGB4paCc=r7H9w1nq9ZCetkmjQBowSAro5WjLW5EG+mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5BGB4paCc=r7H9w1nq9ZCetkmjQBowSAro5WjLW5EG+mw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> If this works for Alfred, I can submit it as a proper patch.

Hi Fabio

Thanks for testing. This is the correct concept. But there is one
detail to take care of.

Not all generations of switches support accessing the EEPROM. So
mv88e6xxx_g2_eeprom_wait() cannot be used unconditionally. You need to
test chip->info->ops->get_eeprom and if it is not NULL, then you know
it is supported. If it is NULL, then all i can suggest is we do
nothing and hope for the best with the reset.

For stable, such a test is sufficient. For net-next, we might consider
adding a .wait_eeprom to struct mv88e6xxx_ops.

       Andrew

