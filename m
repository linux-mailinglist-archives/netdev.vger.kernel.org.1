Return-Path: <netdev+bounces-21116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2627627D7
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 02:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EAE11C2107E
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 00:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8436564A;
	Wed, 26 Jul 2023 00:47:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586B07C;
	Wed, 26 Jul 2023 00:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5F9C433C8;
	Wed, 26 Jul 2023 00:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690332433;
	bh=Wl5oBCsN+Rpuig2vlDDIl7wkx5DAqU7N9LpCXvvXqaU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tg2/mzATAsk2JQ0uYNT3N+GHenozvBgwCi5f4JqKBrUuAG9hn9CkOh1PBed16pjnw
	 /+7KKpB/o60eGaGYvknDV1QoKFEpah9DpJ1b9dIUklCyhc0mP+mJ3ZxibWx8ciQstT
	 rVQfH4ZZEWFWoPDVdydQQB9JFM/5JKe4g5kVpJGeyL11/FMYc/S69r9DsK+G2JyNjk
	 o38r2xCRsC4a1uex6J70uX+oRoJnGsGYOvIYly5yvpmE/he4ykCc4IxsOI9jliSauJ
	 3J0YBUclGBfQLxzzUgGSdzYhmdHFF7b/GcsQGDOCUfbo6qapiupE3r/DdNEYaUKFev
	 T8loQZuGRMA9Q==
Date: Tue, 25 Jul 2023 17:47:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>, Krystian
 Pradzynski <krystian.pradzynski@linux.intel.com>, Stanislaw Gruszka
 <stanislaw.gruszka@linux.intel.com>, Jacek Lawrynowicz
 <jacek.lawrynowicz@linux.intel.com>, Oded Gabbay <ogabbay@kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Linux
 regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
 hq.dev+kernel@msdfc.xyz, Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Regressions
 <regressions@lists.linux.dev>, Linux DRI Development
 <dri-devel@lists.freedesktop.org>, Linux Networking
 <netdev@vger.kernel.org>, Linux Intel Ethernet Drivers
 <intel-wired-lan@lists.osuosl.org>
Subject: Re: Unexplainable packet drop starting at v6.4
Message-ID: <20230725174712.66a809c4@kernel.org>
In-Reply-To: <ZMBf3Cu+MgXjOpvF@debian.me>
References: <e79edb0f-de89-5041-186f-987d30e0187c@gmail.com>
	<ZMBf3Cu+MgXjOpvF@debian.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jul 2023 06:50:52 +0700 Bagas Sanjaya wrote:
> This time, the bisection points out to v6.4 networking pull, so:
> 
> #regzbot introduced: 6e98b09da931a0

Ask the reporter to test 9b78d919632b, i.e. the tip of net-next before
the merge. It seems quite unlikely that the merge itself is the problem.

