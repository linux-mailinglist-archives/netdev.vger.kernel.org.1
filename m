Return-Path: <netdev+bounces-63170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4020982B88F
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 01:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4611B22EA7
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 00:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE8E362;
	Fri, 12 Jan 2024 00:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWrQnd/Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B41062A;
	Fri, 12 Jan 2024 00:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71639C433C7;
	Fri, 12 Jan 2024 00:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705018875;
	bh=mCf3cSFqycOAhQ6gY+sFpFybvl93NIcJb00EsVzll/E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SWrQnd/ZyQS6EbosQcZpucBzPPunZOArsmobCMquc1IC6/XcB7UYwqg+Em7EJpRAL
	 ei60eBsombOv2tEhGwRTDO/fdbBY0/HDR+1frNd4QNHAlwg/si5uLJfwdC8Z9xTtVT
	 Tv/w46hZj3sRnbTwV3x5AJHjP1BuLCtkFg8TFwFbIbmJYojZDmtWEK4P3mnKHxwv4u
	 5lqua8dgt1PABQLnZifieEqYhGMDB2d1RclLXknyRffbQyNDV9e9HCWGWclqPtPjLB
	 DQxoAkvfCT3bjxtY8+WRh7fHzfbNdup2qQ7yDbHLzjh/uM5a20afwIHZx9swDZh2ym
	 5QCBbWM7kHZtw==
Date: Thu, 11 Jan 2024 16:21:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
 <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, Johan Hedberg <johan.hedberg@intel.com>
Subject: Re: [PATCH net 5/7] MAINTAINERS: Bluetooth: retire Johan (for now?)
Message-ID: <20240111162114.658a752b@kernel.org>
In-Reply-To: <20240110151309.GD9296@kernel.org>
References: <20240109164517.3063131-1-kuba@kernel.org>
	<20240109164517.3063131-6-kuba@kernel.org>
	<20240110151309.GD9296@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jan 2024 15:13:09 +0000 Simon Horman wrote:
> + Johan Hedberg <johan.hedberg@intel.com>
> 
> On Tue, Jan 09, 2024 at 08:45:15AM -0800, Jakub Kicinski wrote:
> > Johan moved to maintaining the Zephyr Bluetooth stack,
> > and we haven't heard from him on the ML in 3 years
> > (according to lore), and seen any tags in git in 4 years.
> > Trade the MAINTAINER entry for CREDITS, we can revert
> > whenever Johan comes back to Linux hacking :)
> > 
> > Subsystem BLUETOOTH SUBSYSTEM
> >   Changes 173 / 986 (17%)
> >   Last activity: 2023-12-22
> >   Marcel Holtmann <marcel@holtmann.org>:
> >     Author 91cb4c19118a 2022-01-27 00:00:00 52
> >     Committer edcb185fa9c4 2022-05-23 00:00:00 446
> >     Tags 000c2fa2c144 2023-04-23 00:00:00 523
> >   Johan Hedberg <johan.hedberg@gmail.com>:  
> 
> I'm not arguing that this change isn't appropriate.
> But, nit picking the description above,
> I do think there has been some git activity within
> the last 4 years, albeit from a different email address.
> 
> The most recent Bluetooth Drivers patch I found committed by Johan is:
> 
> commit 0671c0662383eefc272e107364cba7fe229dee44
> Author:     Hans de Goede <hdegoede@redhat.com>
> AuthorDate: Sat Dec 5 16:02:01 2020 +0100
> Commit:     Johan Hedberg <johan.hedberg@intel.com>
> CommitDate: Mon Dec 7 17:01:54 2020 +0200
> 
> For reference, the most recent patched that I could
> find authored by Johan for Bluetooth Drivers is:
> 
> commit 6c3711ec64fd23a9abc8aaf59a9429569a6282df
> Author:     Johan Hedberg <johan.hedberg@intel.com>
> AuthorDate: Sat Aug 4 23:40:26 2018 +0300
> Commit:     Marcel Holtmann <marcel@holtmann.org>
> CommitDate: Sat Aug 4 23:23:32 2018 +0200

Indeed, my grepping must have failed me :(
If someone pops up in the top three reviewers at the end of the report
it's fairly easy to catch that they use a different address, but that
wasn't the case here. In any case, here is the report after having
added the correct email alias -- just to confirm that the script itself
is not buggy :)

Subsystem BLUETOOTH SUBSYSTEM
  Changes 173 / 986 (17%)
  Last activity: 2023-12-22
  Marcel Holtmann <marcel@holtmann.org>:
    Author 91cb4c19118a 2022-01-27 00:00:00 52
    Committer edcb185fa9c4 2022-05-23 00:00:00 446
    Tags 000c2fa2c144 2023-04-23 00:00:00 523
  Johan Hedberg <johan.hedberg@gmail.com>:
    Committer e6ed8b78eae5 2020-12-07 00:00:00 60
    Tags e6ed8b78eae5 2020-12-07 00:00:00 69
  Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
    Author d03376c18592 2023-12-22 00:00:00 241
    Committer da9065caa594 2023-12-22 00:00:00 341
    Tags da9065caa594 2023-12-22 00:00:00 493
  Top reviewers:
    [33]: alainm@chromium.org
    [31]: mcchou@chromium.org
    [27]: abhishekpandit@chromium.org


