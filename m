Return-Path: <netdev+bounces-14134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B795473F2A1
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 05:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C46E01C20A33
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 03:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB727EA6;
	Tue, 27 Jun 2023 03:28:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE8CEA1
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 03:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BB5C433C8;
	Tue, 27 Jun 2023 03:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687836525;
	bh=Rvo2sb5xRqGIuOJc76e/Yp7Ddzl6Se8I9RDpIFWMsDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hMm/PzYvCV88xuRjBBRr8sLFn3UU0y4s++Vk0Plhbc4fB2QBCEtI1D465Wrr+78Ys
	 wQ59N0O7Xv82WgPv8yfCGP2ml1DYl4+iwbGjqoTuNiH9xG78Hlg88j6lfubx/bC3AV
	 AvN1q6IY2tAmNBNcUzogHy2Lj9cFmT8syb4b4y/yESMcEbchuVpz1PwSApKNObLTh2
	 05qbyr2fC6iVZjT3eFbrJbIPlrfjnOIFkbI6rl/dFZjy1kInS/soqQ8pLN5Op8jmal
	 mhl6EdVmL8dpl/sBYQ8UOAV6H1do/oLe3hdh1wNntB46kiTG20S6UPJJO8wMfZjMLh
	 4rpRAV+/w2TGQ==
Date: Mon, 26 Jun 2023 20:28:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jiawen Wu <jiawenwu@trustnetic.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] net: txgbe: change hw reset mode
Message-ID: <20230626202844.346de86b@kernel.org>
In-Reply-To: <23312110-478A-4AC2-A66D-33C4BD2DBD0E@net-swift.com>
References: <20230621090645.125466-1-jiawenwu@trustnetic.com>
	<20230622192158.50da604e@kernel.org>
	<D61A4E6D-8049-4454-9870-E62C2A980D0C@net-swift.com>
	<362f04fc-dafb-4091-a0cc-b94931083278@lunn.ch>
	<6964AD00-15BF-4F2D-9473-A84E07025BE8@net-swift.com>
	<20230626102411.2b067fa8@kernel.org>
	<23312110-478A-4AC2-A66D-33C4BD2DBD0E@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Jun 2023 10:18:46 +0800 mengyuanlou@net-swift.com wrote:
> > Why were you using the more complex FW command then rather than just 
> > the register write, previously then?
> 
> Using FW command can notify fw that lan reset has happened, then FW
> can configure something which should reconfigure.

This sentence is not entirely clear to me.

> Drivers write the register, the FW will not know lan reset has happened.
> 
> Later, we found the things which FW need in NCSI/LLDP/WOL... is only the phy. 
> So just block phy reset, and use simple the register write.

Fair enough, please include the explanation of backward compatibility
in the commit message and post a v2.

