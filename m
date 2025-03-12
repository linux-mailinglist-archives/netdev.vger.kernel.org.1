Return-Path: <netdev+bounces-174215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAC7A5DDBF
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 14:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30C1189F5DB
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 13:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B85324A07E;
	Wed, 12 Mar 2025 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZC9seZdX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA4B2459C3;
	Wed, 12 Mar 2025 13:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785288; cv=none; b=Cs624WjwQexP9JxTjN9r3JSX2C5nZgnHkpFFg4A62sz1O6tHG31DPDdilwucWCUiKZjmh3YKRYV9kC2rys8rkpBJ6HHgnqyAVyH36BIiv2bjjZqRBxNKoftPPMLJs5KqlagD4AprJLNudL4pta2NsgNKpUylSx+wePrcbFBixLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785288; c=relaxed/simple;
	bh=bj4Hh4tMMBh20XLZFjrHDGSBRCbHwQeMRZSmr4V2M6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXqivqgnGNtfhJ36QkuopaZZfcB23ENqpmQ0T9Wmu4yD7H2uvFg9MEnrNSPpEkNxgh9hbrnOXBABIvbVPuMg4kB/A7Zo78WXYWbgs8Qy5VgPeevUujpzoIlYj31yFWR0oLJ4l1AjjmvYbCCkJQT3N80GV0mng4/ylApr9JUUNPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZC9seZdX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6448C4CEE3;
	Wed, 12 Mar 2025 13:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741785287;
	bh=bj4Hh4tMMBh20XLZFjrHDGSBRCbHwQeMRZSmr4V2M6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZC9seZdX4OCdQxwTPmM+9rJ8TxwNF+iDKBzAFMSTDAa1LGaUCL2+aHIkuCPTLb50P
	 dfFC8dsmnGHWObghyn9QNLopPGsr8GFSYNt562ha4WIH0KZuBbcS2fIgV0AWVgZNtJ
	 nj79NTYu2dN/N2UDRdXrTPC1+PNi1JhbAgXsDaujw0sDzWwX/wo8KGgelA63rYWWv4
	 Pje25+0MmpBoz/BEs3HKNMNlcZww6AibXJCE8ns5eOlIF65YdEyccN00XPuPXaXpGU
	 48W4e534yJPkt7d/pvKM57P0abGYcZ+Vj+Cwp3oMZ0wFz2MDP27Xm2k2tQ6ZfFzBJb
	 GNLS6cU5ncEGg==
Date: Wed, 12 Mar 2025 14:14:33 +0100
From: Simon Horman <horms@kernel.org>
To: deller@kernel.org
Cc: netdev@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] net: tulip: avoid unused variable warning
Message-ID: <20250312131433.GS4159220@kernel.org>
References: <20250309214238.66155-1-deller@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250309214238.66155-1-deller@kernel.org>

On Sun, Mar 09, 2025 at 10:42:38PM +0100, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> When compiling with W=1 and CONFIG_TULIP_MWI=n one gets this warning:
>  drivers/net/ethernet/dec/tulip/tulip_core.c: In function ‘tulip_init_one’:
>  drivers/net/ethernet/dec/tulip/tulip_core.c:1309:22: warning: variable ‘force_csr0’ set but not used
> 
> Avoid it by annotating the variable __maybe_unused, which seems to be
> the easiest solution.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>

Hi Helge,

A few thoughts on this:

Firstly, thanks for your patch, which I agree addresses the problem you
have described.

However, AFAIK, this is a rather old driver and I'm not sure that
addressing somewhat cosmetic problems are worth the churn they cause:
maybe it's best to leave it be.

But if we do want to fix this problem, I do wonder if the following
solution, which leverages IS_ENABLED, is somehow nicer as
it slightly reduces the amount of conditionally compiled code,
thus increasing compile test coverage.

diff --git a/drivers/net/ethernet/dec/tulip/tulip_core.c b/drivers/net/ethernet/dec/tulip/tulip_core.c
index 27e01d780cd0..75eac18ff246 100644
--- a/drivers/net/ethernet/dec/tulip/tulip_core.c
+++ b/drivers/net/ethernet/dec/tulip/tulip_core.c
@@ -1177,7 +1177,6 @@ static void set_rx_mode(struct net_device *dev)
 	iowrite32(csr6, ioaddr + CSR6);
 }
 
-#ifdef CONFIG_TULIP_MWI
 static void tulip_mwi_config(struct pci_dev *pdev, struct net_device *dev)
 {
 	struct tulip_private *tp = netdev_priv(dev);
@@ -1251,7 +1250,6 @@ static void tulip_mwi_config(struct pci_dev *pdev, struct net_device *dev)
 		netdev_dbg(dev, "MWI config cacheline=%d, csr0=%08x\n",
 			   cache, csr0);
 }
-#endif
 
 /*
  *	Chips that have the MRM/reserved bit quirk and the burst quirk. That
@@ -1463,10 +1461,9 @@ static int tulip_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	INIT_WORK(&tp->media_work, tulip_tbl[tp->chip_id].media_task);
 
-#ifdef CONFIG_TULIP_MWI
-	if (!force_csr0 && (tp->flags & HAS_PCI_MWI))
+	if (IS_ENABLED(CONFIG_TULIP_MWI) && !force_csr0 &&
+	    (tp->flags & HAS_PCI_MWI))
 		tulip_mwi_config (pdev, dev);
-#endif
 
 	/* Stop the chip's Tx and Rx processes. */
 	tulip_stop_rxtx(tp);


