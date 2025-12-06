Return-Path: <netdev+bounces-243898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB49CAA394
	for <lists+netdev@lfdr.de>; Sat, 06 Dec 2025 10:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED9D7304EB58
	for <lists+netdev@lfdr.de>; Sat,  6 Dec 2025 09:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5198D26E6F3;
	Sat,  6 Dec 2025 09:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mM1x98uW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F8C79C8;
	Sat,  6 Dec 2025 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765014410; cv=none; b=SfgOutWw9MZhBWtPeCnAuzUu2Ehn7hujDX/y+m+OODbYHbLkSArqvbDZ8mG/SFmDMzkGFMC+T35ygTAtbf8hBdqb8CCwF6MVNf4p9UTjzYJUfC1eQMIKMivifHy+ROSZYjCNwZoAmbqXM+GvidjyeZ+TFa9iggwuFDshxrpAkvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765014410; c=relaxed/simple;
	bh=mibpu5ArLdj7E6P+wv/Tga2hbhE3zGh7mAv/AFvjc2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgEkJfzl423VcLjW124wGmdqgtaiJohPHBG7YD4LtPNbzv4WG9x2LgJ6KnjwUkYPBlfEoJL1itB0zXftLL+UHd0J0waREhAS/xvV27f2Uat0VshpJC5mQOv9KTxdH6boLeuLMJ/395/ETnR7o+SFVSFbCvAecD1d96wAaTGKu0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mM1x98uW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44578C4CEF5;
	Sat,  6 Dec 2025 09:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765014408;
	bh=mibpu5ArLdj7E6P+wv/Tga2hbhE3zGh7mAv/AFvjc2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mM1x98uWRX+8PTXnr8YFotNaKI8LsU1a/gkySZPBWlZP+uIXy2V9XvprGCVmyRqel
	 TeNyRyrfkhvxq5u4P0trcbP+OROpjOkVANAYvHQjRwHO964kFpXiSj9pTwqS+EBMZA
	 Q49lcLF+yfyFGJOvIpWVUYdjQdox8upjZ5IvNXsJRNR7JlwBPw7CigVRW5U0EeNtZ+
	 qJ4cP4wPk6iHq2DcBT1nAkvl88f6sXRlYZZdI0jSneeqypMR+/H+8reU6VbWpIFHi2
	 bnD6UXjoGj4fAcbmT6Jv94XwjIl9E46h6c57C/71LTMzuGVQvHYXWp5jJXvnVDexU/
	 wuNr5UEG+OrCQ==
Date: Sat, 6 Dec 2025 09:46:43 +0000
From: Simon Horman <horms@kernel.org>
To: Ding Hui <dinghui@sangfor.com.cn>
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: Re: [Intel-wired-lan] [PATCH net-next] ice: Fix incorrect timeout in
 ice_release_res()
Message-ID: <aTP7g5lmRMF5YtQO@horms.kernel.org>
References: <20251205081609.23091-1-dinghui@sangfor.com.cn>
 <IA3PR11MB898665810DD47854F80941A7E5A7A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <1188a9d2-a895-478b-9474-0fb84b4e2636@sangfor.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1188a9d2-a895-478b-9474-0fb84b4e2636@sangfor.com.cn>

On Sat, Dec 06, 2025 at 10:42:36AM +0800, Ding Hui wrote:
> On 2025/12/6 5:09, Loktionov, Aleksandr wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > > Of Ding Hui
> > > Sent: Friday, December 5, 2025 9:16 AM
> > > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > > Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> > > davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > > pabeni@redhat.com; Keller, Jacob E <jacob.e.keller@intel.com>; intel-
> > > wired-lan@lists.osuosl.org
> > > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Ding, Hui
> > > <dinghui@sangfor.com.cn>
> > > Subject: [Intel-wired-lan] [PATCH net-next] ice: Fix incorrect timeout
> > > in ice_release_res()
> > > 
> > > The commit 5f6df173f92e ("ice: implement and use rd32_poll_timeout for
> > > ice_sq_done timeout") converted ICE_CTL_Q_SQ_CMD_TIMEOUT from jiffies
> > > to microseconds.
> > > 
> > > But the ice_release_res() function was missed, and its logic still
> > > treats ICE_CTL_Q_SQ_CMD_TIMEOUT as a jiffies value.
> > > 
> > > So correct the issue by usecs_to_jiffies().
> > > 
> > 
> > Please add a brief "how verified" paragraph (platform + steps).
> > This is a unit-conversion fix in a timeout path; a short test description helps reviewers and stable backports validate the change.
> > 
> Sorry for not being able to provide the verification information, as
> I haven't actually encountered this issue.
> 
> The ice_release_res() is almost always invoked during downloading DDP
> when modprobe ice.
> 
> IMO, it seems like that only when the NIC hardware or firmware enters
> a bad state causing single command to fail or timeout (1 second), and
> then here do the retry logic (10 senconds).
> 
> So it's hard to validate on healthy NIC, maybe inject faults in low level
> function, such as ice_sq_send_cmd().

In that case I would suggest adding something like this:

Found by inspection (or static analysis, or a specific tool if publicly
available, ...).
Compile tested only.

> 
> > And you can add my:
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > 
> > 
> > > Fixes: 5f6df173f92e ("ice: implement and use rd32_poll_timeout for
> > > ice_sq_done timeout")
> > > Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
> > > ---
> > >   drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_common.c
> > > b/drivers/net/ethernet/intel/ice/ice_common.c
> > > index 6fb0c1e8ae7c..5005c299deb1 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_common.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> > > @@ -1885,7 +1885,7 @@ void ice_release_res(struct ice_hw *hw, enum
> > > ice_aq_res_ids res)
> > >   	/* there are some rare cases when trying to release the
> > > resource
> > >   	 * results in an admin queue timeout, so handle them correctly
> > >   	 */
> > > -	timeout = jiffies + 10 * ICE_CTL_Q_SQ_CMD_TIMEOUT;
> > > +	timeout = jiffies + 10 *
> > > usecs_to_jiffies(ICE_CTL_Q_SQ_CMD_TIMEOUT);
> > >   	do {
> > >   		status = ice_aq_release_res(hw, res, 0, NULL);
> > >   		if (status != -EIO)
> > > --
> > > 2.17.1
> > 
> > 
> > 
> 
> -- 
> Thanks,
> - Ding Hui
> 
> 

