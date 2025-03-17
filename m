Return-Path: <netdev+bounces-175425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF8BA65D5F
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 19:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B85F916BC26
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 18:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C696E1EB5C8;
	Mon, 17 Mar 2025 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g49BcDQt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBA01E1E03;
	Mon, 17 Mar 2025 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237786; cv=none; b=N1VxvIbXIn/LQMpqU8an9bW8fSdF2c2LM3SbZA1CpYvd7OlDUTWwuvn+XC31J+FFkhFL1XpEdzW13EDBlvuRlceb9tgG/GqdQXvWde3Rq1tSdVky4PpeM/Zf/tkDjs4VEhPGxsB9f0Ws16vefUJRxL7fXBc0+Eqha1OlksAQxqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237786; c=relaxed/simple;
	bh=1e4w5hz4mFH34gA0uZbOVpuAdr2fk4qSjjH+ov2gFLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueLw3EY0bOaB0BiYblJ2QsF4OnKUarKxVV/8++cxbvwoxdyE38P+LhCh/UryyAanQoCmFkOjVgCq/ntfy7tG0sOzXJcTCwAyf7NfI3eU23+oiBjYTwQawZ3L4wZT11vRUfaQBV2CDR7BIthkvyBxdA7LFG2wXpOTF1QE+I93Cyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g49BcDQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032BDC4CEE3;
	Mon, 17 Mar 2025 18:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742237786;
	bh=1e4w5hz4mFH34gA0uZbOVpuAdr2fk4qSjjH+ov2gFLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g49BcDQtydEODtoRxCv/0Ge+wIgFimsFVv5x/AJpF/ythvIFKKS9oYn5Wxtb0BJzm
	 /mEW9xjQyZ8X47jAFPu+Ra2biaQu7IC+TlIdOerTe1HCdu1NxIdyV8zKGyKNZM4m/k
	 O0aQ/Ls1cmqO8npyLDm9xHwu3TigAfP9s3shzHGxydmEu177pGTcYYoUY9jk7HRy04
	 6iJ4WORIARH2yTic/VTMJJ7Ek6GytJFI19GvNj75KvmWS43x1staKu6FjidFD0Ja2O
	 vLnEeLYC3CXvXLmDUw6T/odZ1CC2NS/H7XIv+2hhZHNOo5SdEkHECKiNAW64RjE37N
	 IK3SO3DDadWgg==
Date: Mon, 17 Mar 2025 18:56:22 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: Chen Ni <nichen@iscas.ac.cn>, manishc@marvell.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] qed: remove cast to pointers passed to kfree
Message-ID: <20250317185622.GK688833@kernel.org>
References: <20250311070624.1037787-1-nichen@iscas.ac.cn>
 <Z9BuCIqxg5CRzD8w@localhost.localdomain>
 <Z9Bv+cjkxlVHsKAd@localhost.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9Bv+cjkxlVHsKAd@localhost.localdomain>

On Tue, Mar 11, 2025 at 06:16:41PM +0100, Michal Kubiak wrote:
> On Tue, Mar 11, 2025 at 06:08:24PM +0100, Michal Kubiak wrote:
> > On Tue, Mar 11, 2025 at 03:06:24PM +0800, Chen Ni wrote:
> > > Remove unnecessary casts to pointer types passed to kfree.
> > > Issue detected by coccinelle:
> > > @@
> > > type t1;
> > > expression *e;
> > > @@
> > > 
> > > -kfree((t1 *)e);
> > > +kfree(e);
> > > 
> > > Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> > > ---
> > >  drivers/net/ethernet/qlogic/qed/qed_main.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
> > > index f915c423fe70..886061d7351a 100644
> > > --- a/drivers/net/ethernet/qlogic/qed/qed_main.c
> > > +++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
> > > @@ -454,7 +454,7 @@ int qed_fill_dev_info(struct qed_dev *cdev,
> > >  
> > >  static void qed_free_cdev(struct qed_dev *cdev)
> > >  {
> > > -	kfree((void *)cdev);
> > > +	kfree(cdev);
> > >  }
> > >  
> > >  static struct qed_dev *qed_alloc_cdev(struct pci_dev *pdev)
> > > -- 
> > > 2.25.1
> > > 
> > > 
> > 
> > 
> > LGTM.
> > 
> > Thanks,
> > Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> > 
> 
> I'm sorry I missed that the patch is addressed to "net-next".
> It rather looks like as a candidate for the "net" tree.
> 
> Please resend it to the "net" tree with an appropriate "Fixes" tag.
> 
> My apologies for the noise.

Hi Michal,

I'm unclear what bug this fixes.

It seems to me that this is a clean-up.
That as such it should only be considered in the context
of more material changes to this driver.

