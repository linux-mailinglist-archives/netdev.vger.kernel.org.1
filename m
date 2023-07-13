Return-Path: <netdev+bounces-17398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD4C751719
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 06:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324C31C2126B
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 04:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B9A4694;
	Thu, 13 Jul 2023 04:02:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068704691
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 04:02:20 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F091FFD
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 21:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EL3pDOR8xSomCN3igCFGNEClMfvwW0Uw+a3VeiOR3js=; b=fm2hltAgLNYCtSdU8pq959unN2
	vMDfjLv4kIe5g/Zc6ICJjFmZ8Pe6H7oGAhE2GcTPtDMo07TfHvcimlMFhmGH9k/4iRXRNAOMlydFt
	MaAsamElH/djK4cgX0ycKFJ94xt+uHnDBQeExY47LhkjEjx+20IoaYC83LlNzhM+79+I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qJnWt-001CU7-24; Thu, 13 Jul 2023 06:02:11 +0200
Date: Thu, 13 Jul 2023 06:02:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Feiyang Chen <chenfeiyang@loongson.cn>
Cc: hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	chenhuacai@loongson.cn, linux@armlinux.org.uk, dongbiao@loongson.cn,
	loongson-kernel@lists.loongnix.cn, netdev@vger.kernel.org,
	loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [RFC PATCH 02/10] net: stmmac: Pass stmmac_priv and chan in some
 callbacks
Message-ID: <0ed12e00-4ca8-43dd-a383-ba6380f21418@lunn.ch>
References: <cover.1689215889.git.chenfeiyang@loongson.cn>
 <a200a15b1178dd8f6b80a925b927d30d4e841c3c.1689215889.git.chenfeiyang@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a200a15b1178dd8f6b80a925b927d30d4e841c3c.1689215889.git.chenfeiyang@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 10:46:54AM +0800, Feiyang Chen wrote:
> Like commit 1d84b487bc2d90 ("net: stmmac: Pass stmmac_priv in some
> callbacks"), passing stmmac_priv and chan to more callbacks and
> adjust the callbacks accordingly.

Commit messages don't say what a patch does, you can see that from
reading the patch. The commit message should explain why it is doing
something. 

	Andrew

