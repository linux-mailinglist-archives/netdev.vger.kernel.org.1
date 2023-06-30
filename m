Return-Path: <netdev+bounces-14727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378D87435B5
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 09:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A42E280F83
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 07:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F43881E;
	Fri, 30 Jun 2023 07:22:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226368BE8
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 07:22:57 +0000 (UTC)
Received: from muru.com (muru.com [72.249.23.125])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A329D10EC;
	Fri, 30 Jun 2023 00:22:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by muru.com (Postfix) with ESMTPS id 1B0A380FE;
	Fri, 30 Jun 2023 07:22:56 +0000 (UTC)
Date: Fri, 30 Jun 2023 10:22:54 +0300
From: Tony Lindgren <tony@atomide.com>
To: =?utf-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-omap@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeroen Hofstee <jhofstee@victronenergy.com>
Subject: Re: [RESEND][PATCH] net: cpsw: fix obtaining mac address for am3517
Message-ID: <20230630072254.GL14287@atomide.com>
References: <20230624121211.19711-1-mans@mansr.com>
 <ad0ec6ac-2760-4a03-8cee-0d933aea98eb@lunn.ch>
 <yw1x352h3plc.fsf@mansr.com>
 <457ae95b-8838-4c10-821c-379ed622ef41@lunn.ch>
 <yw1xy1k92ahj.fsf@mansr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xy1k92ahj.fsf@mansr.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

* Måns Rullgård <mans@mansr.com> [230624 14:36]:
> Andrew Lunn <andrew@lunn.ch> writes:
> > I assume you also want this back ported to stable? Please add a Fixed:
> > tag, and a Cc: stable@vger.kernel.org tag. And set the patch subject
> > to [PATCH net v3] to indicate this is for the net tree, not net-next.
> 
> I give up.  It's not worth my time.  This is why people hoard patches
> rather than sending them upstream.

Maybe just give it one more go filing the proper paperwork :) It would be
nice to have it in stable too so IMO it's worth the few more hoops to
addthe tags for automating picking it to stable kernels.

Regards,

Tony

