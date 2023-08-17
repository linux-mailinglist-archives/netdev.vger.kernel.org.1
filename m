Return-Path: <netdev+bounces-28425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0792477F66B
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 14:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35426281EF6
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 12:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E22313FEB;
	Thu, 17 Aug 2023 12:29:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AF42115
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 12:29:02 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEFB2711
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 05:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1a7t5UeuoxharVlWMhP0LGizVwyyt/WbNyM2qKqByYE=; b=1GarRGNH3ChGOZtK0YYN6lDWX+
	tImjUbtFk54F2x2SswTzavWr88g+cRxQJmXCyJ1i2jNXZBH93YeMgMYczy6zL4h1wikc/C4OzoMF6
	mX4rYVFtM7g8Dv4BwZ0mW8PTJvg5iLRRlSfjk//+MxrDKNaWEcbV7vOpydJbrch996m4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qWc7P-004NBs-Dc; Thu, 17 Aug 2023 14:28:51 +0200
Date: Thu, 17 Aug 2023 14:28:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: Shyam-sundar.S-k@amd.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, yisen.zhuang@huawei.com,
	salil.mehta@huawei.com, iyappan@os.amperecomputing.com,
	keyur@os.amperecomputing.com, quan@os.amperecomputing.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, yankejian@huawei.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] amd-xgbe: Return proper error code for
 get_phy_device()
Message-ID: <b1887aa8-3327-497a-bd23-680b533f6356@lunn.ch>
References: <20230817074000.355564-1-ruanjinjie@huawei.com>
 <20230817074000.355564-3-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817074000.355564-3-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 03:39:59PM +0800, Ruan Jinjie wrote:
> get_phy_device() returns -EIO on bus access error and -ENOMEM
> on kzalloc failure in addition to -ENODEV, just return -ENODEV is not
> sensible, use PTR_ERR(phydev) to fix the issue.

Rather than say 'not sensible', it would be better to say 'Best
practice is to return these error codes'.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>


    Andrew

---
pw-bot: cr

