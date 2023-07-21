Return-Path: <netdev+bounces-19820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B4375C823
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 15:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6761C21567
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 13:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33BC1DDF9;
	Fri, 21 Jul 2023 13:46:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74A019A1F
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 13:46:50 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBD41986;
	Fri, 21 Jul 2023 06:46:48 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="433255150"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="433255150"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 06:46:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="728103153"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="728103153"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jul 2023 06:46:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
	(envelope-from <andy@kernel.org>)
	id 1qMqSj-006s0v-2p;
	Fri, 21 Jul 2023 16:46:29 +0300
Date: Fri, 21 Jul 2023 16:46:29 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Hartley Sweeten <hsweeten@visionengravers.com>,
	Jakub Kicinski <kuba@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Kris Bahnsen <kris@embeddedts.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lennert Buytenhek <kernel@wantstofly.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lukasz Majewski <lukma@denx.de>, Mark Brown <broonie@kernel.org>,
	Michael Peters <mpeters@embeddedts.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>,
	Olof Johansson <olof@lixom.net>, Paolo Abeni <pabeni@redhat.com>,
	Richard Weinberger <richard@nod.at>,
	Rob Herring <robh+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Sebastian Reichel <sre@kernel.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>, Takashi Iwai <tiwai@suse.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Vinod Koul <vkoul@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>, soc@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
	netdev@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org,
	linux-input@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 03/42] clk: ep93xx: add DT support for Cirrus EP93xx
Message-ID: <ZLqMNU6XtTEO2a1R@smile.fi.intel.com>
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
 <20230605-ep93xx-v3-3-3d63a5f1103e@maquefel.me>
 <3fcb760c101c5f7081235290362f5c02.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fcb760c101c5f7081235290362f5c02.sboyd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 04:27:45PM -0700, Stephen Boyd wrote:
> Quoting Nikita Shubin via B4 Relay (2023-07-20 04:29:03)

...

> > +static bool is_best(unsigned long rate, unsigned long now,
> > +                    unsigned long best)
> > +{
> > +       return abs(rate - now) < abs(rate - best);
> 
> Another case where we need abs_diff() so that it doesn't get confused
> when trying to do signed comparison.

Here you are: Message-Id: <20230721134235.15517-1-andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



