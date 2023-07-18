Return-Path: <netdev+bounces-18554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABFD757987
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 12:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161B5281481
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 10:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC97C145;
	Tue, 18 Jul 2023 10:48:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428FA5671
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 10:48:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9624C433C8;
	Tue, 18 Jul 2023 10:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689677337;
	bh=fFVFTkysp28sp9JfZeEqHXN0A6sZRCvkdNFDFYqoPdI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oyMpOMPQkA3a0T0aolK8WyOz7p0MTi2MZAXU8W8U/2FbhqgcuL5Fc+ATMwcC9loSl
	 82ccyKLJxDmam+T46t/V/rFNtFEVl8cYJoy+xWLko5Y0dXLJtOth+ETfo1lc6mBppX
	 QSJz1OAW2PwjF/C0NoR/bxcfqD7TIpc2jIzkQe/JW/3e59YY4QJ1LiL/2CbnsBE/BE
	 fYaLfgFX7giwr0l+6FoOt4Sf87OHYHwOwBs+M9CjNUn8cWcfKS+u69BWFj02fj7dtR
	 iAzbIcc2w9iJrZ5RKafT+cv4ciyMkKTmgQgnwAvCpHvhk+N573z/uu6ZMQAbcLFk3B
	 7zajDbHB0RiRQ==
Date: Tue, 18 Jul 2023 12:48:46 +0200
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, francesco.dolcini@toradex.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v3 5/5] net: phy: marvell-88q2xxx: add driver
 for the Marvell 88Q2110 PHY
Message-ID: <20230718124846.321ca18f@dellmb>
In-Reply-To: <20230717193350.285003-6-eichest@gmail.com>
References: <20230717193350.285003-1-eichest@gmail.com>
	<20230717193350.285003-6-eichest@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jul 2023 21:33:50 +0200
Stefan Eichenberger <eichest@gmail.com> wrote:

> +#define MARVELL_PHY_ID_88Q2110	0x002b0981

Why not put the PHY ID macro to include/linux/marvell_phy.h where all
Marvell PHY IDs reside?

Marek

