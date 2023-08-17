Return-Path: <netdev+bounces-28426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8141177F66E
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 14:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2A571C21350
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 12:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCF913FEC;
	Thu, 17 Aug 2023 12:29:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EB713AD4
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 12:29:43 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61734210D
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 05:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JOWevmkNsbaqec7oF2Se76s2/IFx1rO3zLk5Fu7XmGw=; b=hFYqRXrs8nQjEYDDF+sFQpU6y4
	UxeMhgc5fhhBOGvanhDpaBg+6hseHFEX+cZ8pCQ8WXE9XvJPmA8RDM9dTe5lf/78B7adP84eUrrxW
	XNheP0F/D+oTZ9O/RqPw8tWMjxCQMUTYMLIx6CBedt4Mc3/x3IYJl2l16A3y6V1UvdV4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qWc84-004NCf-Ot; Thu, 17 Aug 2023 14:29:32 +0200
Date: Thu, 17 Aug 2023 14:29:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: Shyam-sundar.S-k@amd.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, yisen.zhuang@huawei.com,
	salil.mehta@huawei.com, iyappan@os.amperecomputing.com,
	keyur@os.amperecomputing.com, quan@os.amperecomputing.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, yankejian@huawei.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: hisilicon: hns: Fix return value check
 for get_phy_device()
Message-ID: <6e5445ad-22bb-4e35-9333-3a1de800113d@lunn.ch>
References: <20230817074000.355564-1-ruanjinjie@huawei.com>
 <20230817074000.355564-4-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817074000.355564-4-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 03:40:00PM +0800, Ruan Jinjie wrote:
> The get_phy_device() function returns error pointers and never
> returns NULL. Update the checks accordingly.
> 
> Fixes: 1d1afa2ebf82 ("net: hns: register phy device in each mac initial sequence")
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

