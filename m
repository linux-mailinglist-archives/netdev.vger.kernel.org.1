Return-Path: <netdev+bounces-44643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E52427D8DE2
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 06:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB5E282199
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 04:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6A51FD3;
	Fri, 27 Oct 2023 04:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BBF5229
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 04:52:24 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892D0192
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 21:52:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qwEpX-0006BO-VL; Fri, 27 Oct 2023 06:52:19 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1qwEpX-004Yz6-Io; Fri, 27 Oct 2023 06:52:19 +0200
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qwEpX-00GYhh-GT; Fri, 27 Oct 2023 06:52:19 +0200
Date: Fri, 27 Oct 2023 06:52:19 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net-next 2/4] net: fill in MODULE_DESCRIPTION()s under
 net/core
Message-ID: <20231027045219.GK3803936@pengutronix.de>
References: <20231026190101.1413939-1-kuba@kernel.org>
 <20231026190101.1413939-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231026190101.1413939-3-kuba@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Oct 26, 2023 at 12:00:59PM -0700, Jakub Kicinski wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: o.rempel@pengutronix.de
> ---
>  net/core/dev_addr_lists_test.c | 1 +
>  net/core/selftests.c           | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/net/core/dev_addr_lists_test.c b/net/core/dev_addr_lists_test.c
> index 90e7e3811ae7..4dbd0dc6aea2 100644
> --- a/net/core/dev_addr_lists_test.c
> +++ b/net/core/dev_addr_lists_test.c
> @@ -233,4 +233,5 @@ static struct kunit_suite dev_addr_test_suite = {
>  };
>  kunit_test_suite(dev_addr_test_suite);
>  
> +MODULE_DESCRIPTION("KUnit tests for struct netdev_hw_addr_list");
>  MODULE_LICENSE("GPL");
> diff --git a/net/core/selftests.c b/net/core/selftests.c
> index 94fe3146a959..8f801e6e3b91 100644
> --- a/net/core/selftests.c
> +++ b/net/core/selftests.c
> @@ -405,5 +405,6 @@ void net_selftest_get_strings(u8 *data)
>  }
>  EXPORT_SYMBOL_GPL(net_selftest_get_strings);
>  
> +MODULE_DESCRIPTION("Common library for generic PHY ethtool selftests");
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
> -- 
> 2.41.0

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

