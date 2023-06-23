Return-Path: <netdev+bounces-13472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D84AB73BBA3
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 17:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53EE1C21198
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 15:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2771C2C7;
	Fri, 23 Jun 2023 15:28:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE3AC2C4
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 15:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCFDC433C0;
	Fri, 23 Jun 2023 15:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687534126;
	bh=nqzu5MzFAMFgo2gxn4whtKY9kdbIt2Qku0qZB6aiZiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KGdopXQg9ELwWuL3DToADYRfaobpN9foyUQQSXFt2qlWiBK7li5JSWLiZYgVHr8aG
	 8UTZkunr2AWJWkg2oyMAZnzFoFCiX/++b8sm6huqrTIyYBcBrtUXhjo3Y4na3kfkSo
	 fQZM4ThL2nz2lSe1ACNCF7Ta8/SbuySKUfEVp+SdevUBhcNZxg39vwIAD/uIAzSRZG
	 YqL7fGTmyKrs77ltsHeQIYBZnhQFvAUAS4GqN0miFgksMd5HV2+R9pKqjv3iqHp3Sq
	 uxCn31dfIx8Sabh2GJF1ZwvhWjplwMIlorEyPcrUGgL0kB7mf1tVHOnjYXzVgE1CdC
	 kUyAZLg4rBWRQ==
Date: Fri, 23 Jun 2023 10:28:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: bjorn.helgaas@gmail.com, Jinjian.Song@fibocom.com, Reid.he@fibocom.com,
	bjorn@helgaas.com, haijun.liu@mediatek.com, kuba@kernel.org,
	netdev@vger.kernel.org, rafael.wang@fibocom.com,
	somashekhar.puttagangaiah@intel.com
Subject: Re: [v5,net-next]net: wwan: t7xx : V5 ptach upstream work
Message-ID: <20230623152844.GA174017@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623150142.292838-1-jtornosm@redhat.com>

On Fri, Jun 23, 2023 at 05:01:42PM +0200, Jose Ignacio Tornos Martinez wrote:
> I have a proposal because at this moment with the current status, t7xx is not
> functional due to problems like this if there is no activity:
> [   57.370534] mtk_t7xx 0000:72:00.0: [PM] SAP suspend error: -110
> [   57.370581] mtk_t7xx 0000:72:00.0: can't suspend
>     (t7xx_pci_pm_runtime_suspend [mtk_t7xx] returned -110)
> and after this the traffic is not working.
> 
> As yu know the situation was stalled and it seems that the final solution for
> the complete series can take longer, so in order to have at least the modem
> working, it would be enough if just the first commit of the series is
> re-applied (d20ef656f994 net: wwan: t7xx: Add AP CLDMA). With that, the
> Application Processor would be controlled, correctly suspended and the
> commented problems would be fixed (I am testing here like this with no related
> issue).
> 
> I think the first commit of the series is independent of the others and it can
> be re-applied cleanly. Later on, the other commits related to fw flashing and 
> coredump collection new features could be added taking into account Bjorn's 
> comments (and of course updated doc if needed).

Please just post your proposal the usual way: send a patch that can be
directly applied, and send it to the maintainers of the file and the
relevant mailing lists.

Since d20ef656f994 affects drivers/net/wwan, this would be handled by
the WWAN folks.  From get_maintainers.pl:

  Loic Poulain <loic.poulain@linaro.org> (maintainer:WWAN DRIVERS)
  Sergey Ryazanov <ryazanov.s.a@gmail.com> (maintainer:WWAN DRIVERS)
  Johannes Berg <johannes@sipsolutions.net> (reviewer:WWAN DRIVERS)
  "David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING DRIVERS)
  Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING DRIVERS)
  Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING DRIVERS)
  Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING DRIVERS)
  netdev@vger.kernel.org (open list:WWAN DRIVERS)
  linux-kernel@vger.kernel.org (open list)

I'm confused about what happened with d20ef656f994 [1].  Git claims it
appeared in v6.1, and I don't see a revert of it, but I don't see the
code changes it made, e.g., the changes to t7xx_hw_info_init() [2].

Bjorn

[1] https://git.kernel.org/linus/d20ef656f994
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wwan/t7xx/t7xx_hif_cldma.c?id=v6.4-rc7#n1063


