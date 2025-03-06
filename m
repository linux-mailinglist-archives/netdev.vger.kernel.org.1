Return-Path: <netdev+bounces-172549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC79A55661
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A42F31897F9A
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF5F20F072;
	Thu,  6 Mar 2025 19:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pMduT6TL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2C125A652;
	Thu,  6 Mar 2025 19:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288544; cv=none; b=pYESfXRUKUex0gjvkOfh0sfUNqspZX19U+ttsyYOsAsjyqZFYz8MTGDYS1e8r2jKFd6VqAfGXIH4hauPmJ5jc1gXCKAzlry68dNF1cFvadxzFMyrfopxfC5wLlTHq1kn3mGEkqQgl7/lEQSnchsLXk+hNdN3ZwQ4KCZJVKtvxnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288544; c=relaxed/simple;
	bh=FI4Ykkx+qGEIkojq+fXlvHUD0svrkRp76J6+LsOSy7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjsk8RQFrNk7Rut4S5dSdg4xy0ONZJLBkVR2pvRC+41BkH+S8ZDBugyBNhfus6EBJ+ln9/UDFilNYpuBHSrRdyxy2E35A5nZn6D5mZdDI/rfRpXPIwvzWWA0Cm8fzJ6RY1pLGe/KYBtFfkCBHPeTCxImhg7n8UBDTuizIFmEfLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pMduT6TL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=njBjp8n+P+eiIOScwAy/pVcoC4cQAunH1M0r8J1fwAM=; b=pMduT6TLeujIJJWivGuHqUM3jV
	I66Ki5ImnEBN/qOZ6aCPrpZIB3JYgeiOwzwrGydvMNOp5HOqexAj/ItHp0D0241A6L28qna20dEDL
	7hCDFLiI9EWY2PFEgN8K3jj4he6mA0iC6r6IUC32DN6EJvhvRqjIFYXnUgQwiYKXA3yg5Rc3KtNWj
	nQjGlMso3NVdfImX8FiydPtaiPrxHEDojnyd24ieqasJV5f0UB+ao8dmII4rMVM/v/gIltKDh4AEV
	ow5gxi8gRDj5AcMycQ+Kt6vcHtwWidHid4DUr523m6PTfHhOuUb7b0ibJlKEIoM3b+B4FNRwSclrE
	DpGmzQxA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50112)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tqGgv-0006NI-3B;
	Thu, 06 Mar 2025 19:15:34 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tqGgt-000731-0C;
	Thu, 06 Mar 2025 19:15:31 +0000
Date: Thu, 6 Mar 2025 19:15:30 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: linux@treblig.org
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phylink: Remove unused phylink_init_eee
Message-ID: <Z8n0Ui6kXu90TrGG@shell.armlinux.org.uk>
References: <20250306184534.246152-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306184534.246152-1-linux@treblig.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 06, 2025 at 06:45:34PM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> phylink_init_eee() is currently unused.
> 
> It was last added in 2019 by
> commit 86e58135bc4a ("net: phylink: add phylink_init_eee() helper")
> but it didn't actually wire a use up.
> 
> It had previous been removed in 2017 by
> commit 939eae25d9a5 ("phylink: remove phylink_init_eee()").
> 
> Remove it again.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

