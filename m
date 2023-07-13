Return-Path: <netdev+bounces-17632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1510475274B
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 17:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D0C1C21398
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 15:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8631F164;
	Thu, 13 Jul 2023 15:34:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E0B1F163
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 15:34:39 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62C830CA;
	Thu, 13 Jul 2023 08:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KXnGl5uKH9+jlrgrX8zZ+Z7E1f0HtWuXeb4tbLeH3Pg=; b=OZ9xdvxLLdJmo1TiaWKutdPsoI
	6jJSRlSVFNtPxdMrvRbDBdEpmjfmOEJaCiEpeTaGz3z/5FojuHY2v5dAIw6pCq3tU8P1lRiXz7YFU
	g6jiqalH4kZ5GLQ+m0aypW33rQbrKs71V28m/dZGqBMKG3C8LrVbbcZqudX9j8IPwRMA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qJyKn-001GdE-H4; Thu, 13 Jul 2023 17:34:25 +0200
Date: Thu, 13 Jul 2023 17:34:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"Haener, Michael" <michael.haener@siemens.com>,
	"olteanv@gmail.com" <olteanv@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>
Subject: Re: [PATCH v2 0/3] net: dsa: SERDES support for mv88e632x family
Message-ID: <d7466827-7f39-495b-a129-91188e3d150f@lunn.ch>
References: <20230704065916.132486-1-michael.haener@siemens.com>
 <20a135919ac7d54699d1eca5486fd640d667ad05.camel@siemens.com>
 <67189741-efd5-4f54-8438-66a6e2a693f5@lunn.ch>
 <6594cbb5b83312b73127f6bf23bbf988bb40c491.camel@siemens.com>
 <ZK+cvZJmYRkKKZ0d@shell.armlinux.org.uk>
 <d154d59edd2883b30de8f80fa9c08ec7700504d6.camel@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d154d59edd2883b30de8f80fa9c08ec7700504d6.camel@siemens.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> we did understand Andrew's request indeed, however we were not able to
> backport your series quickly to the version we are able to test on the
> HW.

But your own patchset has been tested on net-next by yourself? So it
should be trivial to use "b4 am <threadid>" to get Russells patchset,
apply them on top of net-next, and then add your patches as well.

      Andrew

