Return-Path: <netdev+bounces-37148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B48407B3EB5
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 08:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9FCD9281D7A
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 06:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C135E1857;
	Sat, 30 Sep 2023 06:55:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE011385;
	Sat, 30 Sep 2023 06:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA92C433C8;
	Sat, 30 Sep 2023 06:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696056945;
	bh=guQT3JiBzCPPuL1dYwDcKOlL9WR9CDm5p+2uo6aSLWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J2yPDcksFdMsqzJtKri8RFOgXhcYDt1QponptUU7V897WrEaCK7u60QpZqqY0wGTI
	 8sCIZJbgPtwauPUj0o2Egs4bUp/omXTdQTpNTe42xU/ZhahLYEk9GLjSwYxf/zx4e6
	 C5+EHIUTk4LR4QJ0+PnHAEA12VyfbJlXwLujkegc=
Date: Sat, 30 Sep 2023 08:55:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"oneukum@suse.com" <oneukum@suse.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: ZDI-CAN-22166: New Vulnerability Report
Message-ID: <2023093035-primate-prankster-7f60@gregkh>
References: <DM5PR0102MB3477C75A38D67E275032FADB80C0A@DM5PR0102MB3477.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR0102MB3477C75A38D67E275032FADB80C0A@DM5PR0102MB3477.prod.exchangelabs.com>

On Fri, Sep 29, 2023 at 07:00:54PM +0000, zdi-disclosures@trendmicro.com wrote:
> Trend Micro's Zero Day Initiative has identified a vulnerability affecting the following products:
> Linux - Kernel

As reported to you before, this is NOT a "vulnerability" but rather,
just a normal bug that you are somehow claiming needs to be fixed.

Patches to help resolve the issue would be most appreciated as you are
in the best position to test them.

thanks,

greg k-h

