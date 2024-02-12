Return-Path: <netdev+bounces-70955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E54851356
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 13:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD6E6B224FA
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 12:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A150739AE3;
	Mon, 12 Feb 2024 12:15:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from torres.zugschlus.de (torres.zugschlus.de [85.214.160.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BC0882D
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 12:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.160.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707740134; cv=none; b=Ccv8vR05T8G4zOVxqeMWF8/LbM3NQ7S33C2kEC9RAFJfPPPbU1kGmJahTjBT6NtkxFdQQLtftuWr1GqjPzgeMJnRq04nMGHDjZr9wjY6dtjTbbk+MrSRl5uvekK/VpktP2TDPAppTDkGSiA9WxI9Ayuj6wkFFDTnHrpMxtjooGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707740134; c=relaxed/simple;
	bh=Oo6weIIuhCpZHEQ+hPT/fvEXd7+5quKaT7d6G9U5nLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYQPgfxA3BHRDiuAIBcZ1/eySFJsJnzz72PMIodFKCAL3VQ1BLboesRGJBEsuI6xmwfmReny4G3CVecSgcrM/Jt5Da1q6WGDUAFis8opAHUtobA5vjmhN4abYDCFyfz1illLRRxOxHJ5OMo0ZW8whutKuEbLY836Usa81f3ZB2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zugschlus.de; spf=none smtp.mailfrom=zugschlus.de; arc=none smtp.client-ip=85.214.160.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zugschlus.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=zugschlus.de
Received: from mh by torres.zugschlus.de with local (Exim 4.96)
	(envelope-from <mh+netdev@zugschlus.de>)
	id 1rZVDM-005Euh-2O;
	Mon, 12 Feb 2024 13:15:12 +0100
Date: Mon, 12 Feb 2024 13:15:12 +0100
From: Marc Haber <mh+netdev@zugschlus.de>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	alexandre.torgue@foss.st.com, Jose Abreu <joabreu@synopsys.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jisheng Zhang <jszhang@kernel.org>, netdev@vger.kernel.org
Subject: Re: stmmac on Banana PI CPU stalls since Linux 6.6
Message-ID: <ZcoL0MseDC69s2_P@torres.zugschlus.de>
References: <8efb36c2-a696-4de7-b3d7-2238d4ab5ebb@lunn.ch>
 <ZbKiBKj7Ljkx6NCO@torres.zugschlus.de>
 <229642a6-3bbb-4ec8-9240-7b8e3dc57345@lunn.ch>
 <99682651-06b4-4c69-b693-a0a06947b2ca@gmail.com>
 <20240126085122.21e0a8a2@meshulam.tesarici.cz>
 <ZbOPXAFfWujlk20q@torres.zugschlus.de>
 <20240126121028.2463aa68@meshulam.tesarici.cz>
 <ZcFBL6tCPMtmcc7c@torres.zugschlus.de>
 <0ba9eb60-9634-4378-8cbb-aea40b947142@gmail.com>
 <20240206092351.59b10030@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240206092351.59b10030@meshulam.tesarici.cz>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Tue, Feb 06, 2024 at 09:23:51AM +0100, Petr Tesařík wrote:
> On Mon, 5 Feb 2024 13:50:35 -0800
> Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
> > On 2/5/24 12:12, Marc Haber wrote:
> > > On Fri, Jan 26, 2024 at 12:10:28PM +0100, Petr Tesařík wrote:  
> > >> Then you may want to start by verifying that it is indeed the same
> > >> issue. Try the linked patch.  
> > > 
> > > The linked patch seemed to help for 6.7.2, the test machine ran for five
> > > days without problems. After going to unpatched 6.7.2, the issue was
> > > back in six hours.  
> > 
> > Do you mind responding to Petr's patch with a Tested-by? Thanks!
> 
> I believe Marc tested my first attempt at a solution (the one with
> spinlocks), not the latest incarnation. FWIW I have tested a similar
> scenario, with similar results.

Where is the latest patch? I can give it a try.

Sorry for not responding any earlier, February 10 is an important tax
due date in Germany.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Leimen, Germany    |  lose things."    Winona Ryder | Fon: *49 6224 1600402
Nordisch by Nature |  How to make an American Quilt | Fax: *49 6224 1600421

