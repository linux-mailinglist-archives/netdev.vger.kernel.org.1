Return-Path: <netdev+bounces-223507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3053B5962E
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9CC1670D7
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6EE2F7ADA;
	Tue, 16 Sep 2025 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r95OypCE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23617296BA9;
	Tue, 16 Sep 2025 12:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758025693; cv=none; b=q9w9S2CCWSc4rUXHu2S+/SfqFr8zr12SlI+r2zAZu2fx1QmDuN093YK9RV/3JbgaxzHZzWjpxo7qfUGyxgAAh64D69sOr5G0+7TEqwj1qxJx8mhHMGT7hbpBswnWhmIhjviOlOZpjw4AOMlZFoXCMUslxEoLYdlBmuYvLw1q460=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758025693; c=relaxed/simple;
	bh=kpqd+Vc8nIgits++fqAOhCtpU8iSr2A8mrWmA2YZR5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZh3E2940lJhlDuZ8nmeBxIP2RwChMBkwYqs4CWF9M7a/WjRE5YC/o1QnBIDXNtyk/LDf0OdBwp4cwf5TUdPw+5wKCNuX8JLUO9XZCO3XLHMl8Cy/XrcZVtu2v8mHJftMXWgdt5PQ8O79kstGFaHiKNsdxK0hEeSwWMZUcz7ENk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r95OypCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D6DC4CEEB;
	Tue, 16 Sep 2025 12:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758025692;
	bh=kpqd+Vc8nIgits++fqAOhCtpU8iSr2A8mrWmA2YZR5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r95OypCEiZU4+Yj77xgARU3VF5R5l92/5hjim9hlpJpBSYuR640msOGbpYiLrxH4S
	 0y0lLVAz6UxayZmeK857QPD5vlfgooFabQ1x46eVKv7yaQuZe3jt0KG6uIxm8obcZP
	 CHpGj7F07BjlhE+dYxJrk6AOHkgJAKWj/TdPUMyGDvYhNTM3CcQV3Bq50TfdWp3dy4
	 yl1upqtpf9qxMoamOrgk+gjvHNSdxapsKEROPauG+83pmI++iD5uiC5+mIvrPF4BUf
	 k6RCfWII1lSWpyfQ6cFROIBlGG99czV1Eh3QODXKVULABAvlZEKuqP1W3XLP/i5Mv1
	 IToI3SmCLLUzA==
Date: Tue, 16 Sep 2025 13:28:07 +0100
From: Simon Horman <horms@kernel.org>
To: Sathesh B Edara <sedara@marvell.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Satananda Burla <sburla@marvell.com>,
	Veerasenareddy Burru <vburru@marvell.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Haseeb Gani <hgani@marvell.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
	Shinas Rasheed <srasheed@marvell.com>
Subject: Re: [EXTERNAL] Re: [net PATCH] octeon_ep:fix VF MAC address
 lifecycle handling
Message-ID: <20250916122807.GX224143@horms.kernel.org>
References: <20250911144933.6703-1-sedara@marvell.com>
 <20250912170214.GB224143@horms.kernel.org>
 <CO1PR18MB47474A8DA6ECB6FFF3A5C02BD815A@CO1PR18MB4747.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR18MB47474A8DA6ECB6FFF3A5C02BD815A@CO1PR18MB4747.namprd18.prod.outlook.com>

On Mon, Sep 15, 2025 at 09:17:36AM +0000, Sathesh B Edara wrote:
> 
> 
> > > diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
> > > b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
> > > index ebecdd29f3bd..0867fab61b19 100644
> > > --- a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
> > > +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
> > > @@ -196,6 +196,7 @@ static void octep_pfvf_get_mac_addr(struct
> > octep_device *oct,  u32 vf_id,
> > >  			vf_id);
> > >  		return;
> > >  	}
> > > +	ether_addr_copy(oct->vf_info[vf_id].mac_addr,
> > > +rsp->s_set_mac.mac_addr);
> > >  	rsp->s_set_mac.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;  }
> > >
> > > @@ -205,6 +206,8 @@ static void octep_pfvf_dev_remove(struct
> > > octep_device *oct,  u32 vf_id,  {
> > >  	int err;
> > >
> > > +	/* Reset VF-specific information maintained by the PF */
> > > +	memset(&oct->vf_info[vf_id], 0, sizeof(struct octep_pfvf_info));
> > 
> > Hi Sathesh,
> > 
> > Can the following be used here?
> > (completely untested)
> > 
> > 	eth_zero_addr(oct->vf_info[vf_id].mac_addr);
> > 
> > Or does more of oct->vf_info[vf_id] need to be reset?
> 
> Hi Simon,
> Thank you for your comments.
> Yes, in addition to clearing the MAC address, we also need to reset other fields within oct->vf_info[vf_id] to fully clean up the VF-specific state maintained at the PF level.
> This ensures that all VF-related configuration and runtime data are properly cleared when the VF is removed.

Thanks, in that case this change good to me.

Given that the patch has been marked as Changes Requested, I assume on the
basis of my feedback, if it's not to much trouble could you repost with a
space after the 'octeon_ep:' in the subject.

Subject: [PATCH net] octeon_ep: fix VF MAC address lifecycle handling

Feel free to add:

Reviewed-by: Simon Horman <horms@kernel.org>

