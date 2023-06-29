Return-Path: <netdev+bounces-14581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B6C74279E
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 15:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45A1280D02
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 13:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4AC11CB8;
	Thu, 29 Jun 2023 13:44:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9081096A
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 13:44:28 +0000 (UTC)
X-Greylist: delayed 430 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Jun 2023 06:44:23 PDT
Received: from smtpout11.ifi.lmu.de (smtpout11.ifi.lmu.de [IPv6:2001:4ca0:4000:0:141:84:214:246])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E5F30C4;
	Thu, 29 Jun 2023 06:44:22 -0700 (PDT)
Received: from tobhe.de (p200300eeaf18710014db52e6e13db9f4.dip0.t-ipconnect.de [IPv6:2003:ee:af18:7100:14db:52e6:e13d:b9f4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: heidert)
	by smtpin1.ifi.lmu.de (Postfix) with ESMTPSA id 81692AE99FB;
	Thu, 29 Jun 2023 15:37:07 +0200 (CEST)
Date: Thu, 29 Jun 2023 15:37:05 +0200
From: Tobias Heider <me@tobhe.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Michael Chan <michael.chan@broadcom.com>,
	Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Prashant Sreedharan <prashant@broadcom.com>,
	Michael Chan <mchan@broadcom.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add MODULE_FIRMWARE() for FIRMWARE_TG357766.
Message-ID: <ZJ2JARrRUUd4YRvX@tobhe.de>
References: <ZJt7LKzjdz8+dClx@tobhe.de>
 <CACKFLinEbG_VVcMTPVuHeoQ6OLtPRaG7q2U5rvqPqdvk7T2HwA@mail.gmail.com>
 <aa84a2f559a246b82779198d3ca60205691baa94.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa84a2f559a246b82779198d3ca60205691baa94.camel@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 29, 2023 at 03:05:23PM +0200, Paolo Abeni wrote:
> On Tue, 2023-06-27 at 18:31 -0700, Michael Chan wrote:
> > On Tue, Jun 27, 2023 at 5:13 PM Tobias Heider <me@tobhe.de> wrote:
> > > 
> > > Fixes a bug where on the M1 mac mini initramfs-tools fails to
> > > include the necessary firmware into the initrd.
> > > 
> > > Signed-off-by: Tobias Heider <me@tobhe.de>
> > 
> > Thanks.
> > Reviewed-by: Michael Chan <michael.chan@broadcom.com>
> 
> This is a borderline situation, but ... 
> 
> Is there a suitable 'Fixes:' tag we can add here?
> 
> Thanks!
> 
> Paolo
> 

Would "Fixes: c4dab50697ff ("video: remove unnecessary platform_set_drvdata()")"
work?

