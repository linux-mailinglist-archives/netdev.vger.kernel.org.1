Return-Path: <netdev+bounces-55708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B74B80C077
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 05:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B1B280C74
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 04:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FBE1A595;
	Mon, 11 Dec 2023 04:52:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B71ED
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 20:52:10 -0800 (PST)
Received: from c-76-132-34-178.hsd1.ca.comcast.net ([76.132.34.178]:58984 helo=sauron.svh.merlins.org)
	by mail1.merlins.org with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
	id 1rCYGv-0004Vc-9r by authid <merlins.org> with srv_auth_plain; Sun, 10 Dec 2023 20:52:01 -0800
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
	(envelope-from <marc@merlins.org>)
	id 1rCYGu-000roj-Sl; Sun, 10 Dec 2023 20:52:00 -0800
Date: Sun, 10 Dec 2023 20:52:00 -0800
From: Marc MERLIN <marc@merlins.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: Re: [PATCH net v3] net: ethtool: do runtime PM outside RTNL
Message-ID: <20231211045200.GC24475@merlins.org>
References: <20231206113934.8d7819857574.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
 <20231206084448.53b48c49@kernel.org>
 <e6f227ee701e1ee37e8f568b1310d240a2b8935a.camel@sipsolutions.net>
 <a44865f5-3a07-d60a-c333-59c012bfa2fb@intel.com>
 <20231207094021.1419b5d0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207094021.1419b5d0@kernel.org>
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
X-SA-Exim-Connect-IP: 76.132.34.178
X-SA-Exim-Mail-From: marc@merlins.org

On Thu, Dec 07, 2023 at 09:40:21AM -0800, Jakub Kicinski wrote:
> On Thu, 7 Dec 2023 11:16:10 +0100 Przemek Kitszel wrote:
> > I have let know our igc TL, architect, and anybody that could be
> > interested via cc: IWL. And I'm happy that this could be done at
> > relaxed pace thanks to Johannes
> 
> I think you may be expecting us to take Johannes's patch.
> It's still on the table, but to make things clear -
> upstream we prefer to wait for the "real fix", so if we agree
> that fixing igb/igc is a better way (as Heiner pointed out on previous
> version PM functions are called by the stack under rtnl elsewhere too,
> just not while device is open) - we'll wait for that. Especially
> that I'm 80% I complained about the PM in those drivers in
> the past and nobody seemed to care. It's a constant source of rtnl
> deadlocks.

For whatever it's worth, I want to be clear that all stock kernels
are 100% unusable on lenovo P17gen2 because of this deadlock and that
without the temporary patch, my laptop would be usuable.
It was also a risk of data loss due to repeated deadlocks and unclean
shutdowns.

I cannot say what the correct fix is, but I am definitely hoping you
will accept some solution for the next stable kernel.

Thank you
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

