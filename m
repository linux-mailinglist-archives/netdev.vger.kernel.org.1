Return-Path: <netdev+bounces-33411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB3579DCE0
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 01:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448CA1C20B1C
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 23:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D5513AFB;
	Tue, 12 Sep 2023 23:53:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F290813AC1
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 23:52:59 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFFE10FE;
	Tue, 12 Sep 2023 16:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nBpSgF2Su5u82JSYSi+zUUbgQUjeDg7ng27KeS8vFWw=; b=r68yS8JXls7i5jVEwoMfeYPOdm
	5PlVpd+LGe41rtopjni7qVr0Tt+3ikErhITI0ZP6TmvqGvsDkuwVKh5y2OMP5evOrUhRPmsrL0/7q
	OBk79IWqI6m4RPmLc9fob0fiV38lk8Zm1uL7SzaDK2ty7IYvWTigZWCdatgW8IevhaNw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qgDBS-006GfT-NY; Wed, 13 Sep 2023 01:52:42 +0200
Date: Wed, 13 Sep 2023 01:52:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc: "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
	"simon.horman@corigine.com" <simon.horman@corigine.com>,
	"Verdun, Jean-Marie" <verdun@hpe.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] net: hpe: Add GXP UMAC Driver
Message-ID: <daabaedb-1943-425e-b5be-73c4f6566121@lunn.ch>
References: <20230816215220.114118-1-nick.hawkins@hpe.com>
 <20230816215220.114118-5-nick.hawkins@hpe.com>
 <01e96219-4f0c-4259-9398-bc2e6bc1794f@lunn.ch>
 <88B3833C-19FB-4E4C-A398-E7EF3143ED02@hpe.com>
 <1b8058e1-6e7f-4a4a-a191-09a9b8010e0a@lunn.ch>
 <CF9BD927-B788-4554-B246-D5CC6D06258F@hpe.com>
 <befbee5a-7b11-4948-a837-6311dd4d7276@lunn.ch>
 <DM4PR84MB1927E85827B5450F1952E58A88E3A@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <729dcda6-2d2c-4054-a570-17cdf6e4e57b@lunn.ch>
 <3DB6DD63-C8AB-4009-8AF8-79290054AC5C@hpe.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB6DD63-C8AB-4009-8AF8-79290054AC5C@hpe.com>

> Greetings Andrew,
> 
> In that case I will continue to attempt to try and adopt the page pool
> API. In all the examples with page pool HW rings it appears they are
> using alloc_etherdev_mqs. Are there any HW requirements to use this
> library? If there are none what is the typical number for rx and tx
> queues?

There are no hardware requirements as far as i understand it. If your
hardware only has one RX queue and one TX queue, define it as
1. Having more allows you to spread the load over multiple CPUs, with
each queue typically having its own interrupt, and interrupts are then
mapped to a single CPU. But if you don't have any of that, it should
not be a hindrance.

    Andrew

