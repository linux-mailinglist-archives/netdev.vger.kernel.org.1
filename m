Return-Path: <netdev+bounces-22322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F62376703B
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F68282742
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7330214001;
	Fri, 28 Jul 2023 15:11:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1251A13FFB
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C25C433C8;
	Fri, 28 Jul 2023 15:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690557071;
	bh=lbbp+XxCC7dXox5AfxPxES5dYCucsAx7Bn96W7/LtlI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o7IRvxJsiNa6QANZh+MXhpu1Gl1B5XNbK5wpxklkaGlgSXSNaG8OTtg9jOmG88KgA
	 lKha6fVjWoDo5auf2ZUBSAQ/gthkadCeGS4a0exFTIutvXGAVCniYQFhyYmx7akY/C
	 JrSA+WegZzXZPpk0ZLW58oPvMW6ICgDxLu6pqbQQz5tP0Gzp4/w4VDG8i83DVTtanC
	 yahL4MXBOcnrMAAuDdcolHRRu0GYA2JN3s9oDvbHtl1vnmL/9TubuXuu9y/pTAGz0G
	 Sho70nWEa6K+qwD+BLRXwA6LKcL/wE6ToeSDarSTlL1RDKQEQkbry3foGTu+i8rb0e
	 TQ5diM9YMv76w==
Date: Fri, 28 Jul 2023 08:11:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>, "Russell King
 (Oracle)" <linux@armlinux.org.uk>, Simon Horman
 <simon.horman@corigine.com>, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next 2/2] net: phy: add keep_data_connection to
 struct phydev
Message-ID: <20230728081110.18c8a0cd@kernel.org>
In-Reply-To: <ca9ab336-8ea9-43f5-8f3c-436832a9af2d@lunn.ch>
References: <20230724092544.73531-1-mengyuanlou@net-swift.com>
	<20207E0578DCE44C+20230724092544.73531-3-mengyuanlou@net-swift.com>
	<ZL+6kMqETdYL7QNF@corigine.com>
	<ZL/KIjjw3AZmQcGn@shell.armlinux.org.uk>
	<4B0F6878-3ABF-4F99-8CE3-F16608583EB4@net-swift.com>
	<21770a39-a0f4-485c-b6d1-3fd250536159@lunn.ch>
	<20230726090812.7ff5af72@kernel.org>
	<ba6f7147-6652-4858-b4bc-19b1e7dfa30c@lunn.ch>
	<20230726112956.147f2492@kernel.org>
	<E7600051-05CD-4440-A1E3-E0F2AFA10266@net-swift.com>
	<ca9ab336-8ea9-43f5-8f3c-436832a9af2d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jul 2023 11:48:36 +0200 Andrew Lunn wrote:
> > > All of this is usually in FW so we should be able to shape the
> > > implementation in the way we want...
> > >   
> > We certainly can do all phy operations in Fw when we are using NCSI.  
> 
> I would actually prefer Linux does it, not firmware. My personal
> preference is also Linux driver the hardware, since it is then
> possible for the community to debug it, extend it with new
> functionality, etc. Firmware is a black box only the vendor can do
> anything with.

Just to be clear, my comment was more about NCSI commands (which
I don't think should be handled by the host), not PHY control.

