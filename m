Return-Path: <netdev+bounces-175379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 988B9A65830
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079DA17B318
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 16:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183961A3168;
	Mon, 17 Mar 2025 16:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4o2fvaw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FD61A0711
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229244; cv=none; b=BpB9RIozVQrDGklZhA66fvjkMlEzD6d8XQencHZ6N6tmRiOcXiurBAA2bMwW3C2fL26nTVPvuaxCzZeLMHhRcqPvGiU4Jb8vQ0yRtQU6wbi5Lx0ihgb2FnKXLDB2RzSVzQDImoo+lC2bDxptBy3ogDzMPpC2n8mqpzooaypQUOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229244; c=relaxed/simple;
	bh=mQw5qekmpzoK/qjP+ndIMzj8Aa7WTwL40recPHtQpcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghip7XdNpErMZMuXa6j12WwRgQxineuEa6fPGPvDcK+mr1BoFhH3B2gp46/OKsQj+tVkjt7uDqt0wvufiE7EArO9ZJQAqnQNnFvt2vPXf7KfN6JGqoLDIAFxXfZDfwP5DL8x1c09H/5dW8gc6N7zo9nh+htnx3Ggh5JPCRzoed4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4o2fvaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE070C4CEE3;
	Mon, 17 Mar 2025 16:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229243;
	bh=mQw5qekmpzoK/qjP+ndIMzj8Aa7WTwL40recPHtQpcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O4o2fvawsjGFwmkQ41AQd/G+0bs4SbyXkz3JG1ecTn46TJFhQU2m4k9qi7FmmzA7m
	 gStpsOie82GW7IZ6oPLTSFGyL2dleYTpmd+iOCa4+8suUyIe6vIVMFl3fCSDJlnddm
	 tEyLQ1xhExMEOS7BbgCVxBVOeILyCdk8ISbblsBNDS+tGzb7326l+DKTOmqVsdqzDC
	 SwhwXu0KChx9bjiFxCOpr7PHyyKaOg/fCMGbTf+6bXdTAqT+pGUHw2nln8JJOQC9My
	 OMlLQJ+mCC7VhwFfuKrvIFx6IolyV5K9pJD8nfNiU9i3zqgLRd6b3GQCAbwzldQqcQ
	 GiT/LV3azdj4A==
Date: Mon, 17 Mar 2025 16:33:59 +0000
From: Simon Horman <horms@kernel.org>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	"Kolacinski, Karol" <karol.kolacinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 1/3] ice: remove SW side
 band access workaround for E825
Message-ID: <20250317163359.GC688833@kernel.org>
References: <20250221123123.2833395-1-grzegorz.nitka@intel.com>
 <20250221123123.2833395-2-grzegorz.nitka@intel.com>
 <aecd919b-fbb8-4790-af1f-69b50cc78438@molgen.mpg.de>
 <IA1PR11MB6219197D989E2DD57307AE8D92C82@IA1PR11MB6219.namprd11.prod.outlook.com>
 <IA1PR11MB62190A2A70EF90C94589A6F092D62@IA1PR11MB6219.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IA1PR11MB62190A2A70EF90C94589A6F092D62@IA1PR11MB6219.namprd11.prod.outlook.com>

On Mon, Mar 10, 2025 at 12:36:31PM +0000, Nitka, Grzegorz wrote:
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> > Nitka, Grzegorz
> > Sent: Tuesday, March 4, 2025 2:04 PM
> > To: Paul Menzel <pmenzel@molgen.mpg.de>; Kolacinski, Karol
> > <karol.kolacinski@intel.com>
> > Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; Michal Swiatkowski
> > <michal.swiatkowski@linux.intel.com>
> > Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 1/3] ice: remove SW side
> > band access workaround for E825
> > 
> > > -----Original Message-----
> > > From: Paul Menzel <pmenzel@molgen.mpg.de>
> > > Sent: Friday, February 21, 2025 10:16 PM
> > > To: Nitka, Grzegorz <grzegorz.nitka@intel.com>; Kolacinski, Karol
> > > <karol.kolacinski@intel.com>
> > > Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Kitszel,
> > > Przemyslaw <przemyslaw.kitszel@intel.com>; Michal Swiatkowski
> > > <michal.swiatkowski@linux.intel.com>
> > > Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 1/3] ice: remove SW side
> > > band access workaround for E825
> > >
> > > Dear Grzegorz, dear Karol,
> > >
> > >
> > > Thank you for your patch.
> > >
> > > Am 21.02.25 um 13:31 schrieb Grzegorz Nitka:
> > > > From: Karol Kolacinski <karol.kolacinski@intel.com>
> > > >
> > > > Due to the bug in FW/NVM autoload mechanism (wrong default
> > > > SB_REM_DEV_CTL register settings), the access to peer PHY and CGU
> > > > clients was disabled by default.
> > >
> > > I’d add a blank line between the paragraphs.
> > >
> > > > As the workaround solution, the register value was overwritten by the
> > > > driver at the probe or reset handling.
> > > > Remove workaround as it's not needed anymore. The fix in autoload
> > > > procedure has been provided with NVM 3.80 version.
> > >
> > > Is this compatible with Linux’ no regression policy? People might only
> > > update the Linux kernel and not the firmware.
> > >
> > > How did you test this, and how can others test this?
> > >
> > > > Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > > > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > > > Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> > > > Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> > > > ---
> > > >   drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 23 ---------------------
> > > >   1 file changed, 23 deletions(-)
> > >
> > >
> > > Kind regards,
> > >
> > > Paul
> > >
> > >
> > 
> > Dear Paul, first of all thank you for your review and apologize for late
> > response (simply, I was out previous week).
> > 
> > Removing that workaround was a conscious decision.
> > Rationale for that is, that the 'problematic' workaround was provided
> > in very early product development stage (~ year ago).  Now, especially
> > when E825-C product was just officially announced, the customer shall
> > use official, approved SW ingredients.
> > 
> > Here are more details on this:
> > - introduction to E825-C devices was provided in kernel 6.6, to allow
> >   selected customers for early E825-C enablement. At that time E825-C
> >   product family was in early phase (kind of Alpha), and one of the
> >   consequences, from today's perspective,  is that it included 'unwanted'
> >   workarounds like this.
> > 
> > - this change applies to E825-C products only, which is SoC product, not
> >   a regular NIC card.  What I'd like to emphasize here, it requires even more
> >   customer support from Intel company in terms of providing matching
> >   SW stack (like BIOS, firmware, drivers etc.).
> > 
> > I see two possibilities now:
> > 1) if the regression policy you mentioned is inviolable, keep the workaround
> >    in the kernel code like it is today. Maybe we could add NVM version
> > checker
> >    and apply register updates for older NVMs only.
> >    But, in my opinion, it would lead to keeping a dead code. There shouldn't
> > be
> >    official FW (I hope I won't regret these words) on the market which
> > requires
> >    this workaround.
> > 
> > 2) remove the workaround like it's implemented in this patch and improve
> >    commit message to clarify all potential doubts/questions from the user
> >    perspective.
> > 
> > What's your thoughts?
> > 
> > Kind regards
> > 
> > Grzegorz
> > 
> 
> I've just submitted v2 of this series, but no changes in this area yet (except adding
> blank line suggestion)
> I'm waiting for feedback or confirmation if above justification is sufficient.
> I'll submit one more if needed.

Hi Grzegorz,

Sorry for not commenting on this earlier,
your question has been hanging out on the ML for a while now.

From my point of view the key part of your justification is that
Intel has sufficient control of the SW stack and availability of (SoC)
devices such that in practice users would not see a regression.
And in my view this is entirely reasonable and the approach taken by
this patch is fine.

I do, however, think some text regarding this belongs in the patch
description. And I'll respond in that vein to v3 [*].

[*] https://lore.kernel.org/netdev/20250310122439.3327908-2-grzegorz.nitka@intel.com/

