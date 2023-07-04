Return-Path: <netdev+bounces-15406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB6B747614
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 18:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3724280F7B
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 16:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B256ADE;
	Tue,  4 Jul 2023 16:06:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F9B63C1
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 16:05:58 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21E9E7A
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 09:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LuqWZGzCLPJWJ8JQY8Xtvctus15e9aHuHNNHon4DIsY=; b=PiMHqfbZd8X6VjzxeBMrcjmoDT
	cu8XkbasMtkzVPCPyedrliObYtEgw2/XlnxotzMdv5pLV+3ajfQQzhJ+YKFOaOBVq2DiPK36rJJJx
	oCMRyq7kycheaNNpW8z7v7F57PBjzjZRLYBjgoV8v+pFXhYge0PPPmLB3Uu4OMEBMsm8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qGiXH-000ZY4-CN; Tue, 04 Jul 2023 18:05:51 +0200
Date: Tue, 4 Jul 2023 18:05:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: Fw: [Bug 217629] New: [regression] Wake-on-LAN broken in new
 kernel for E2400 Ethernet Controller with Qualcomm Atheros
Message-ID: <8790dfc9-745b-4366-94e4-2618118f9dd9@lunn.ch>
References: <20230703151314.1b2a21a6@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703151314.1b2a21a6@hermes.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 03, 2023 at 03:13:14PM -0700, Stephen Hemminger wrote:
> 
> 
> Begin forwarded message:
> 
> Date: Mon, 03 Jul 2023 15:40:58 +0000
> From: bugzilla-daemon@kernel.org
> To: stephen@networkplumber.org
> Subject: [Bug 217629] New: [regression] Wake-on-LAN broken in new kernel for E2400 Ethernet Controller with Qualcomm Atheros
> 
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=217629
> 
>             Bug ID: 217629
>            Summary: [regression] Wake-on-LAN broken in new kernel for
>                     E2400 Ethernet Controller with Qualcomm Atheros
>            Product: Networking
>            Version: 2.5
>           Hardware: All
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: Other
>           Assignee: stephen@networkplumber.org
>           Reporter: myrbourfake@gmail.com
>         Regression: No
> 
> I recently upgraded my pc to linux mint 21.1 (ubuntu 22.04) with kernel
> 5.15.0.75 and I realized that wake on lan functionality is not working any
> more. Up to Linux Mint 20.3 it was always working perfectly!
> I have a Killer E2400 Gigabit Ethernet Controller with Qualcomm Atheros
> AR816x/AR817x chipset.

This might be a vendor kernel issue.
drivers/net/ethernet/atheros/alx/ethtool.c ethtool_ops does not have a
set_wol. There is no indication it has been removed. So i guess the
vendor kernel might have additional patches adding WoL support.

       Andrew

