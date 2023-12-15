Return-Path: <netdev+bounces-58070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC27814F37
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 18:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF8841F231E4
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 17:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8707A3FE2F;
	Fri, 15 Dec 2023 17:49:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6BD3FB28
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 17:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merlins.org
Received: from c-76-132-34-178.hsd1.ca.comcast.net ([76.132.34.178]:53094 helo=sauron.svh.merlins.org)
	by mail1.merlins.org with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
	id 1rECJI-0007yx-G3 by authid <merlins.org> with srv_auth_plain; Fri, 15 Dec 2023 09:49:16 -0800
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
	(envelope-from <marc@merlins.org>)
	id 1rECGg-000UUd-Az; Fri, 15 Dec 2023 09:46:34 -0800
Date: Fri, 15 Dec 2023 09:46:34 -0800
From: Marc MERLIN <marc@merlins.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: Re: [PATCH net v3] net: ethtool: do runtime PM outside RTNL
Message-ID: <20231215174634.GA10053@merlins.org>
References: <20231206113934.8d7819857574.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
 <20231206084448.53b48c49@kernel.org>
 <e6f227ee701e1ee37e8f568b1310d240a2b8935a.camel@sipsolutions.net>
 <a44865f5-3a07-d60a-c333-59c012bfa2fb@intel.com>
 <20231207094021.1419b5d0@kernel.org>
 <20231211045200.GC24475@merlins.org>
 <83dc80d3-1c26-405d-a08d-2db4bc318ac8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83dc80d3-1c26-405d-a08d-2db4bc318ac8@gmail.com>
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
X-SA-Exim-Connect-IP: 76.132.34.178
X-SA-Exim-Mail-From: marc@merlins.org

On Fri, Dec 15, 2023 at 02:42:01PM +0100, Heiner Kallweit wrote:
> Why don't you simply disable runtime pm for the affected device as a
> workaround? This can be done via sysfs.

1) because I didn't know what the exact bug was and how to work around it :)
2) without power management, the battery use is not good, but yes not
good is better than laptop crashing :)

That said, if it's only affecting wired ethernet, I can also unload the
igc module until I actually need wired ethernet, which is sometimes but
not often.

Thanks for your suggestion
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

