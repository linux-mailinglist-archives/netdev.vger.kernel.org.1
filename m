Return-Path: <netdev+bounces-18268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D45D756297
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 14:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9CA2812F3
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 12:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05004AD42;
	Mon, 17 Jul 2023 12:18:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAECB79C8
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 12:18:22 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A23187;
	Mon, 17 Jul 2023 05:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=n3/NLzthO8nFAChycRfPzWGbiyc6k+gcSfvI5EWt610=; b=TvhtZCv/FkWYN5C00HB718zp9W
	ealOzyLlpHG6UKdasOxE3IFuwOZwB1D9pQ7JfCxqfreotz3/Fpt5EDmEVq+6td4Y0i82FdGHQUotI
	HWelNAfJIeXkE7OXwPirytGna47GnzJpYpnw4E/1VDTV+KeTAuAeCxogzNO6q8xGHdNCSje0gwIH0
	QmWUVwCEj+j6GdB4pDIfOTjthMn43KDOQYhC5QNeb2DqCA3huJbNlE+SDw7J9ZfBzAsVJyIcl6GkW
	zk/sv9dFE1LivheXHRnvtoNAc8qT3M9QL/ZDY41CF7a35bjsJWd1LvQLg7cGEbvq1fVEB0KzJf8I7
	1ehuWzRA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51890)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qLNB6-0003ru-0k;
	Mon, 17 Jul 2023 13:18:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qLNB3-0001uG-Ch; Mon, 17 Jul 2023 13:18:09 +0100
Date: Mon, 17 Jul 2023 13:18:09 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Minjie Du <duminjie@vivo.com>
Cc: simon.horman@corigine.com, Marcin Wojtas <mw@semihalf.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MARVELL MVPP2 ETHERNET DRIVER" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v2] net: mvpp2: debugfs: remove redundant parameter check
 in three functions
Message-ID: <ZLUxgSioFUjERay0@shell.armlinux.org.uk>
References: <20230717025538.2848-1-duminjie@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717025538.2848-1-duminjie@vivo.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 17, 2023 at 10:55:37AM +0800, Minjie Du wrote:
> As per the comment above debugfs_create_dir(), it is not expected to
> return an error, so an extra error check is not needed.
> Drop the return check of debugfs_create_dir() in
> mvpp2_dbgfs_c2_entry_init(), mvpp2_dbgfs_flow_tbl_entry_init()
> and mvpp2_dbgfs_cls_init().
> 
> Fixes: b607cc61be41 ("net: mvpp2: debugfs: Allow reading the C2 engine table from debugfs")
> Signed-off-by: Minjie Du <duminjie@vivo.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

