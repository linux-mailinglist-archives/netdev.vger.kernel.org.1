Return-Path: <netdev+bounces-21875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DBB7651E3
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 13:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C29EF1C215D9
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 11:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE1A14F88;
	Thu, 27 Jul 2023 11:00:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332A0AD2E
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 11:00:28 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EDC10D2;
	Thu, 27 Jul 2023 04:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SeUrHxdFJ3RZqJlDRVxFRCK47CcAYACML7/6mllauh8=; b=WDS088uxJZ/fjGMxymkMqKfPsL
	J7wKHIuYsGxOoFhmKhxupP/dDj9oHaAMhox2weDF2H62O3UN+xRGh7TpIRxiiLuyaWI3zhjySZr+V
	zyxK/qI20qyZ9OQQ433CAaHc4FHHWJh79B1qQ5/hygIWQ9L5gyvgD+FdVDoZzH64ftfA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qOyj9-002Ras-9J; Thu, 27 Jul 2023 13:00:15 +0200
Date: Thu, 27 Jul 2023 13:00:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Joe Perches <joe@perches.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	geert@linux-m68k.org, gregkh@linuxfoundation.org,
	netdev@vger.kernel.org, workflows@vger.kernel.org,
	mario.limonciello@amd.com
Subject: Re: [PATCH v2] scripts: get_maintainer: steer people away from using
 file paths
Message-ID: <1b96e465-0922-4c02-b770-4b1f27bebeb8@lunn.ch>
References: <CAHk-=wh4pbrNZGqfV9u1urZr3Xjci=UV-MP+KneB6a5yo7-VOQ@mail.gmail.com>
 <CAHk-=whCE9cWmTXu54WFQ7x-aH8n=dhCux2h49=pYN=14ybkxg@mail.gmail.com>
 <20230726130318.099f96fc@kernel.org>
 <CAHk-=wjfC4tFnOC0Lk_GcU4buf+X-Jv965pWg+kMRkDb6hX6mw@mail.gmail.com>
 <20230726133648.54277d76@kernel.org>
 <CAHk-=whZHcergYrraQGgazmOGMbuPsDfRMBXjFLo1aEQPqH2xQ@mail.gmail.com>
 <20230726145721.52a20cb7@kernel.org>
 <20230726-june-mocha-ad6809@meerkat>
 <20230726171123.0d573f7c@kernel.org>
 <20230726-armless-ungodly-a3242f@meerkat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726-armless-ungodly-a3242f@meerkat>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Think as if instead of being Cc'd on patches, they got Bcc'd on them.

And how does reply work? I assume it would only go to those in To: or
Cc: ? Is there enough context in the headers in a reply for the system
to figure out who to Bcc: the reply to?

   Andrew

