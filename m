Return-Path: <netdev+bounces-22890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 884DC769C6D
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 18:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94A31C20B52
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 16:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F6C19BCD;
	Mon, 31 Jul 2023 16:27:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD5919BA5
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 16:27:28 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B2A173F;
	Mon, 31 Jul 2023 09:27:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 90AF268AA6; Mon, 31 Jul 2023 18:26:39 +0200 (CEST)
Date: Mon, 31 Jul 2023 18:26:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Ulf Hansson <ulf.hansson@linaro.org>, Yangbo Lu <yangbo.lu@nxp.com>,
	Joshua Kinard <kumba@gentoo.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	linux-arm-kernel@lists.infradead.org,
	open list <linux-kernel@vger.kernel.org>,
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
	Netdev <netdev@vger.kernel.org>, linux-rtc@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH 1/5] ARM/pxa: use EXPORT_SYMBOL_GPL for
 sharpsl_battery_kick
Message-ID: <20230731162639.GA9441@lst.de>
References: <20230731083806.453036-1-hch@lst.de> <20230731083806.453036-2-hch@lst.de> <86b73242-94bb-4537-92ec-51da02127848@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86b73242-94bb-4537-92ec-51da02127848@app.fastmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 06:12:22PM +0200, Arnd Bergmann wrote:
> Or let me know if you want a better fix. Since sharpsl_pm.c and
> spitz.c are no longer loadable modules and just get linked together
> these days, I think the variant below would be simpler (this could
> be cleanup up further, endlessly, of course):

That actually looks way nicer, thanks!

If you give me a singoff I'll add it to the next version.

