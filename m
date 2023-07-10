Return-Path: <netdev+bounces-16467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C4274D611
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 14:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 225471C20A8A
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 12:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC233111AC;
	Mon, 10 Jul 2023 12:57:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE5610975
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 12:57:28 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74601C9;
	Mon, 10 Jul 2023 05:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zAdUESlNk5fFxjFObCoWuKOncSdiHBjIW11z46iYlUQ=; b=MlZ/IxeUDjRMI8Hmp0hS3O0/if
	5A6uW01bp3rm2WTPzunre62vYGvFIPy7rDdCVekv/OTACVC+3/bR9mXhbA/i0dgn57PHybIpj1i/I
	upo+EDf/YmF+9815vCHsUgjIpUq1JDGy/I2UeEYPw5l6Tvuv9IsIK2/4PAfUgTmGuUto=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qIqRu-000wmi-9n; Mon, 10 Jul 2023 14:57:06 +0200
Date: Mon, 10 Jul 2023 14:57:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Su Hui <suhui@nfschina.com>
Cc: iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
	quan@os.amperecomputing.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	wuych <yunchuan@nfschina.com>
Subject: Re: [PATCH net-next v2 08/10] net: mdio: Remove unnecessary (void*)
 conversions
Message-ID: <d9133c35-7817-499e-ad6d-2d19ceb6492a@lunn.ch>
References: <20230710064127.173818-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710064127.173818-1-suhui@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 02:41:27PM +0800, Su Hui wrote:
> From: wuych <yunchuan@nfschina.com>
> 
> Pointer variables of void * type do not require type cast.
> 
> Signed-off-by: wuych <yunchuan@nfschina.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

