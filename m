Return-Path: <netdev+bounces-60927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2D2821E32
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 15:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BDBB1C22311
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 14:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FCF12E5F;
	Tue,  2 Jan 2024 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vN8/GGbM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88F812E55;
	Tue,  2 Jan 2024 14:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209A9C433C8;
	Tue,  2 Jan 2024 14:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704207503;
	bh=3SCIZSGuvJnKQUWYQeR797zI+BSkErd0iIpBmXhHmsk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vN8/GGbMF1EVN6HIsYvbmi0duX3oMosmxPcRvjpotGu12UoPuayXSJ4apUpy9Y8WB
	 vm7G1CoMhVoics8CmNOs4F2CA34omaBrkiLsPBa92QxMzXfg44TvSCLtet/oee5UC/
	 b1dmEukQvXqtKik3kqa6kcFbxmgoOadK+1zaVO/uBq2ihLOjUHP0Y2tLCwNaRaS80v
	 n9eFC8DdwiwqE5VgApsAs8AYKN46mYEaOBvTDTEQv+4UYbVwxO8W5fZBbZtm+AEBK8
	 zGd+IRv9eA1WEAfggHkyrgorVRHbMX3Z+WUzCHEXeitfa8wkZdtounRF1JDhk3p864
	 55MU4SB+6gi6Q==
Date: Tue, 2 Jan 2024 06:58:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Stefan Wahren <wahrenst@gmx.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo Abeni"
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH V2 12/12 net-next] qca_7k: Replace old mail address
Message-ID: <20240102065822.319389ec@kernel.org>
In-Reply-To: <18c39111-1cee-429d-a9ff-ff98e1ed27dc@intel.com>
References: <20231218232639.33327-1-wahrenst@gmx.net>
	<20231218232639.33327-13-wahrenst@gmx.net>
	<18c39111-1cee-429d-a9ff-ff98e1ed27dc@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Dec 2023 15:04:51 -0800 Jacob Keller wrote:
> On 12/18/2023 3:26 PM, Stefan Wahren wrote:
> > From: Stefan Wahren <stefan.wahren@i2se.com>
> > 
> > The company I2SE has been acquired a long time ago. Switch to
> > my private mail address before the I2SE account is deactivated.
> > 
> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> > Signed-off-by: Stefan Wahren <wahrenst@gmx.net>  
> 
> You might also consider adding this to the .mailmap so that
> contributions from your old i2se.com address would show up to the
> gmx.net address and people might be less likely to try and cc the dead
> address.

Agreed, also - this driver seems to have no MAINTAINERS entry.
Please consider adding yourself as the maintainer :)

