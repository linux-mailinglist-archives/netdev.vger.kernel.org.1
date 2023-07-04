Return-Path: <netdev+bounces-15361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F78747245
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 15:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB53D280E88
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 13:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229CA611F;
	Tue,  4 Jul 2023 13:08:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E922575
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 13:08:08 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06711B4;
	Tue,  4 Jul 2023 06:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=p2IeYQpGstyHc2o1uZoj5LpWskpFkCurknri7FAU7Sc=; b=doFCJ3+M2ZbnwCnNdylf69dbn7
	dEt8U5JRYhixIcAX4/NUmMkQDZ4Yv1Hh/NkwBjC5ObE9o8vEoAfQPYw7wCHQQI5Yuja91bxFm+NbL
	Blb/HMHvkbYn5Xo+/+e/pq8EDf7c9kn3U8xCg61HatQrAw8Kz3JHzRXB1XKbecqxHB30=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qGfkR-000Ydd-1w; Tue, 04 Jul 2023 15:07:15 +0200
Date: Tue, 4 Jul 2023 15:07:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Quan, Evan" <Evan.Quan@amd.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Koenig, Christian" <Christian.Koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"mdaenzer@redhat.com" <mdaenzer@redhat.com>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	"hdegoede@redhat.com" <hdegoede@redhat.com>,
	"jingyuwang_vip@163.com" <jingyuwang_vip@163.com>,
	"Lazar, Lijo" <Lijo.Lazar@amd.com>,
	"jim.cromie@gmail.com" <jim.cromie@gmail.com>,
	"bellosilicio@gmail.com" <bellosilicio@gmail.com>,
	"andrealmeid@igalia.com" <andrealmeid@igalia.com>,
	"trix@redhat.com" <trix@redhat.com>,
	"jsg@jsg.id.au" <jsg@jsg.id.au>, "arnd@arndb.de" <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH V5 1/9] drivers core: Add support for Wifi band RF
 mitigations
Message-ID: <18dfe989-2610-4234-ade2-ffbc2f233c19@lunn.ch>
References: <20230630103240.1557100-1-evan.quan@amd.com>
 <20230630103240.1557100-2-evan.quan@amd.com>
 <7e7db6eb-4f46-407a-8d1f-16688554ad80@lunn.ch>
 <DM6PR12MB2619591A7706A30362E11DC5E42EA@DM6PR12MB2619.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB2619591A7706A30362E11DC5E42EA@DM6PR12MB2619.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > What is the purpose of this stage? Why would it not be supported for this
> > device?
> This is needed for wbrf support via ACPI mechanism. If BIOS(AML code) does not support the wbrf adding/removing for some device,
> it should speak that out so that the device can be aware of that.

How much overhead is this adding? How deep do you need to go to find
the BIOS does not support it? And how often is this called?

Where do we want to add complexity? In the generic API? Or maybe a
little deeper in the ACPI specific code?

       Andrew


