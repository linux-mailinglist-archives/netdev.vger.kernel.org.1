Return-Path: <netdev+bounces-31950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322B9791A8A
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 17:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFBE1280F9D
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 15:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D105C146;
	Mon,  4 Sep 2023 15:23:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E035AD5F
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 15:23:11 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB238CF6
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 08:22:50 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8E7951C0008;
	Mon,  4 Sep 2023 15:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1693840968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3PJmqJcNuJ7HfHSuVrV5p4oCbtVZUtRIC0IHu9qKZwE=;
	b=LJ+PKbRLz7/p7ubYQoXQCaXTCh2UGlJ+GDII3HzDR9C8szVIlCtA7xITh848+BDEu8yw0J
	Gx1S7umkbdi0D6SHKtu5+c5rw80yO4RaXB3ll/DlTjE/5YMs5kpqUkhG+8WBXlgFKhkUDP
	jmEHha090KiA+dkRtuQlkwiO1NkzrXtZeP4yqgxw0EPFwBGy+mB8IEf2n/dHKdmqFI71re
	jGijJNy95JLFvrcHOS5nQDuDjFnwC62/BuXYt4+gBnVC9UZQU9SnZNl1MjjrBbtblA2Yhj
	OyGACCPgV/jhXNF+MJs+rQmIYJWo3cTxBz3XlUFMJzBVJ9newDul+D5yDMCpOw==
Date: Mon, 4 Sep 2023 17:22:45 +0200
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 glipus@gmail.com, maxime.chevallier@bootlin.com, vadim.fedorenko@linux.dev,
 richardcochran@gmail.com, gerhard@engleder-embedded.com,
 thomas.petazzoni@bootlin.com, krzysztof.kozlowski+dt@linaro.org,
 robh+dt@kernel.org
Subject: Re: [PATCH net-next RFC v4 2/5] net: Expose available time stamping
 layers to user space.
Message-ID: <20230904172245.1fa149fd@kmaincent-XPS-13-7390>
In-Reply-To: <20230517130706.3432203b@kernel.org>
References: <20230511203646.ihljeknxni77uu5j@skbuf>
	<54e14000-3fd7-47fa-aec3-ffc2bab2e991@lunn.ch>
	<ZF1WS4a2bbUiTLA0@shell.armlinux.org.uk>
	<20230511210237.nmjmcex47xadx6eo@skbuf>
	<20230511150902.57d9a437@kernel.org>
	<20230511230717.hg7gtrq5ppvuzmcx@skbuf>
	<20230511161625.2e3f0161@kernel.org>
	<20230512102911.qnosuqnzwbmlupg6@skbuf>
	<20230512103852.64fd608b@kernel.org>
	<20230517121925.518473aa@kernel.org>
	<2f89e35e-b1c9-4e08-9f60-73a96cc6e51a@lunn.ch>
	<20230517130706.3432203b@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello I am resuming my work on selectable timestamping layers.

On Wed, 17 May 2023 13:07:06 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Wed, 17 May 2023 21:46:43 +0200 Andrew Lunn wrote:
> > As i said in an earlier thread, with a bit of a stretch, there could
> > be 7 places to take time stamps in the system. We need some sort of
> > identifier to indicate which of these stampers to use.
> > 
> > Is clock ID unique? In a switch, i think there could be multiple
> > stampers, one per MAC port, sharing one clock? So you actually need
> > more than a clock ID.  
> 
> Clock ID is a bit vague too, granted, but in practice clock ID should
> correspond to the driver fairly well? My thinking was - use clock ID
> to select the (silicon) device, use a different attribute to select 
> the stamping point.
> 
> IOW try to use the existing attribute before inventing a new one.

What do you think of using the clock ID to select the timestamp layer, and add
a ts_layer field in ts_info that will describe the timestamp layer. This allow
to have more information than the vague clock ID. We set it in the driver.
With it, we could easily add new layers different than simple mac and phy.
I am currently working on this implementation.

