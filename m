Return-Path: <netdev+bounces-53652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E624D804073
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 21:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3B91F21071
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 20:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C6635EE3;
	Mon,  4 Dec 2023 20:55:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F775CA
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 12:55:04 -0800 (PST)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
	id 1rAFxf-0003gi-1l by authid <merlin>; Mon, 04 Dec 2023 12:54:39 -0800
Date: Mon, 4 Dec 2023 12:54:39 -0800
From: Marc MERLIN <marc@merlins.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [RFC PATCH] net: ethtool: do runtime PM outside RTNL
Message-ID: <20231204205439.GA32680@merlins.org>
References: <20231204200710.40c291e60cea.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
 <20231204200038.GA9330@merlins.org>
 <a6ac887f7ce8af0235558752d0c781b817f1795a.camel@sipsolutions.net>
 <20231204203622.GB9330@merlins.org>
 <24577c9b8b4d398fe34bd756354c33b80cf67720.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24577c9b8b4d398fe34bd756354c33b80cf67720.camel@sipsolutions.net>
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org

On Mon, Dec 04, 2023 at 09:40:08PM +0100, Johannes Berg wrote:
> This one's still the problem, so I guess my 2-line hack didn't do
> anything.

sorry, I wasn't clear, this was the last hang before your patch. I
wanted to make sure it matched your analysis, which it seems to, so
that's good.  I now understand that the order in printk is not actually
the order of who is at fault.
I'm testing your patch now, will let you know ASAP

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  

