Return-Path: <netdev+bounces-12759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EBD738CEF
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 19:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E0928171D
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 17:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648D919BAE;
	Wed, 21 Jun 2023 17:20:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572CA1953D
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 17:20:59 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8A9132;
	Wed, 21 Jun 2023 10:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xnUasspDrFh2JWpGqcDGD0SKHtZoehpVCtmFhJIxYiY=; b=aKQt3noraRaWZVrPLRFixFgDyF
	doLwBueYpIG4MOV+mgf9YgWlBBG2MzoCYzjDCdbHJLL0/GDopxL7uOPzCNq5iT+ghXm25qqhepAkk
	GZT/IuvRUl0B8HzrNqPhg3sL1OLk/dZE/c7AujarJ1ypiRLAwJUBDPAwkWgEDJfpjNYo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qC1VK-00HAZS-8l; Wed, 21 Jun 2023 19:20:26 +0200
Date: Wed, 21 Jun 2023 19:20:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Limonciello, Mario" <mario.limonciello@amd.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Evan Quan <evan.quan@amd.com>, rafael@kernel.org, lenb@kernel.org,
	alexander.deucher@amd.com, christian.koenig@amd.com,
	Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mdaenzer@redhat.com,
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
	hdegoede@redhat.com, jingyuwang_vip@163.com, lijo.lazar@amd.com,
	jim.cromie@gmail.com, bellosilicio@gmail.com,
	andrealmeid@igalia.com, trix@redhat.com, jsg@jsg.id.au,
	arnd@arndb.de, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH V4 1/8] drivers/acpi: Add support for Wifi band RF
 mitigations
Message-ID: <4aad8dfa-2eaa-4268-8c52-f0ec209e18f9@lunn.ch>
References: <20230621054603.1262299-1-evan.quan@amd.com>
 <20230621054603.1262299-2-evan.quan@amd.com>
 <3a7c8ffa-de43-4795-ae76-5cd9b00c52b5@lunn.ch>
 <216f3c5aa1299100a0009ddf4e95b019855a32be.camel@sipsolutions.net>
 <d2dba04d-36bf-4d07-bf2b-dd06671c45c6@lunn.ch>
 <98c858e6-fb18-d50f-6eea-eddc63ba136f@amd.com>
 <9435a928-04c4-442f-89f2-e76713c908a5@lunn.ch>
 <d1e01e52-df5f-a595-eaa1-95466f7b4ff8@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1e01e52-df5f-a595-eaa1-95466f7b4ff8@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Think a little more about what a non-ACPI implementation
> would look like:
> 
> 1) Would producers and consumers still need you to set CONFIG_ACPI_WBRF?

I would expect there to be an CONFIG_WBRF, and then under that a
CONFIG_WBRF_ACPI, CONFIG_WBRF_DT, CONFIG_WBRF_FOOBAR, each indicating
they are mutual exclusive to the other.

> 2) How would you indicate you need WBRF support?

As far as i understand it, you have something in ACPI which indicates
it? Could that not also be a DT property?

> 3) How would notifications from one device to another work?

Linux notified chains? This is something which happens a lot in
networking. A physical interface goes down and needs to tell
team/bonding interface stack on top of it that its status has
changed. It just calls a notification chain.

> I don't think those are trivial problems that can be solved by
> just making the pointer 'struct device' particularly as with the
> ACPI implementation consumers are expecting the notification from
> ACPI.

Do consumers really care who the notification is from? Isn't the event
and its content what matters, not who sent it?

But I agree, i don't expect it is trivial. But it is going to get
harder and harder to make abstract as more and more users are
added. So we need to consider, do you want to do that work now, or
later? Do we want to merge something we know is limited and not using
the generic kernel abstractions?

     Andrew

