Return-Path: <netdev+bounces-204764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD92AFC037
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 03:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9243A3B2BF4
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 01:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660F81F4626;
	Tue,  8 Jul 2025 01:46:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358E140BF5;
	Tue,  8 Jul 2025 01:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751939167; cv=none; b=kvus6iedgtqU8iNDUpweUku8Wt8yNifV4f26xQFY31+ZS3uZ+rm322jhhIXWtuUEjczSYxs3EKDiSMj9rgu7XXhkldRSDXSR+PY2hwOlu2Tmyp27vUWjBmcOChEG1F9wxsFVoRnbjXtJfRBvZY8Xfn87gvrgn6BzzDDk275sCh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751939167; c=relaxed/simple;
	bh=nh1nOo+b5eqCWDB++x2DN24D8FPhCx0Ss2EJiOM+OlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsAFPE8pONPZfx7uCFU9YfllYLtCjbTJQ2Hsa3EcGyhNbzeTIZLfiYBE150euUQRCxjhvvV6QMcC2D10xA1icIJvflJ1ej0OnOdy7XsgIm1mM7kvxJVXHM6mOkpWWHL04T+OxRmzpb2RqdA3SitwszjsGe7Ah/bTujbrIl5lajA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz3t1751939082t7078b810
X-QQ-Originating-IP: twOakQHm7qDk0ySEKf/UEQ4ZvX2xLJPYK2kg6T+4SrI=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 08 Jul 2025 09:44:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6188477510607775095
Date: Tue, 8 Jul 2025 09:44:40 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	andrew+netdev@lunn.ch, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] net: rnpgbe: Add basic mbx ops support
Message-ID: <6677D57C5FDDCB92+20250708014440.GA216877@nic-Precision-5820-Tower>
References: <20250703014859.210110-1-dong100@mucse.com>
 <20250703014859.210110-4-dong100@mucse.com>
 <80644ec1-a313-403a-82dd-62eb551442d3@lunn.ch>
 <9C6FCA38E28D6768+20250707063955.GA162739@nic-Precision-5820-Tower>
 <f8a69fa5-cc3d-4968-8b19-0bdb27e1e917@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8a69fa5-cc3d-4968-8b19-0bdb27e1e917@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Ma+A2HZKKIKoltb8mRtc7YBDUt2RuMk8scYsQwnrzBMUUTeUfSuqJ8Bq
	2sNdc1Ifj13id1WQeQZ4afdzt5fcDDEDeeHsv069JFfQyjbFoPcJSE3D4ccLZXjXFQQwbdr
	0Pmnvvbloqw/3PMu9wTuQKu1pmVooxb0C5GSXk9FCaxjz6aHyqvHFZhbxkil6sAk158QHtl
	CLZ3Br+A5bmjRch06Jzk0oJjnEtAb68Szl4eidB0jtba3PqN2rOvPOZMzcHgaCkbkY0sX37
	xYCiCI4OUuI5o3UPtP7lTaHDoIxX7icoaRz9onehLf2YXw8zMc12dLroDo1wszmRHucHFYK
	9z7veoJVVv26MRc59hUPXcL82B3ov/+JF5QasLKGjdA4rZP/flTaerSM91aG0rJZDtqsAcM
	EbKyfUbv8qcIOdZA1D0LECoQKVT2guTI9Tl90VyqvZCtEJBJuQWZ1EoGbrY8G9SaAFqDTFy
	F9kqBJCpOEkQdHYq9AN3KObaK/PpaLU8eWjXo+B5aeu1M2zOWjoFIdMvO48Pzi8KJXvEpin
	8p6YIDwl4Ru4YOtPNzeWHqbZYUConTcG9uUYt8m6gGpm4Eb8QNdgEL9GrTwMW26xro9j800
	iWjFHnVOsIVXvuseo5nKTZ07SyawM8LAMf7rReVKA1zYKBxBS9Lmui0FFk2RYH6OnP5Z1no
	JrnJ3G9hyNlUM+HTVW1LO3F5iCkIfCy0ihQlq6Ov2GrVyCJNGYEOL0acbp9m2qvLvhCtaHU
	lzXx1PFzMSy9ndfC94uY5OW3nh32SnWZnf5j3MFnpESwz2aui3i4HUuyXSk+mK3ktbWWH1Q
	BSfoaOx/6yMkBUTsUppK58kZ4im03sPiQT2FQkuXR2pizvXt3gInFTfRGopAkFBrLuvMR4O
	icL0NInPVfR+4BJyJ4ZydRZh47lI2yUodCf8RHq4YBq7rYg5EsjMR5hYoDVzKnUEYUTRosH
	N5Hz304DwCNZuqqZDCGR5wLHkKpQ2H0mKS3Q=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Mon, Jul 07, 2025 at 02:00:16PM +0200, Andrew Lunn wrote:
> On Mon, Jul 07, 2025 at 02:39:55PM +0800, Yibo Dong wrote:
> > On Fri, Jul 04, 2025 at 08:13:19PM +0200, Andrew Lunn wrote:
> > > >  #define MBX_FEATURE_WRITE_DELAY BIT(1)
> > > >  	u32 mbx_feature;
> > > >  	/* cm3 <-> pf mbx */
> > > > -	u32 cpu_pf_shm_base;
> > > > -	u32 pf2cpu_mbox_ctrl;
> > > > -	u32 pf2cpu_mbox_mask;
> > > > -	u32 cpu_pf_mbox_mask;
> > > > -	u32 cpu2pf_mbox_vec;
> > > > +	u32 fw_pf_shm_base;
> > > > +	u32 pf2fw_mbox_ctrl;
> > > > +	u32 pf2fw_mbox_mask;
> > > > +	u32 fw_pf_mbox_mask;
> > > > +	u32 fw2pf_mbox_vec;
> > > 
> > > Why is a patch adding a new feature deleting code?
> > > 
> > Not delete code, 'cpu' here means controller in the chip, not host.
> > So, I just rename 'cpu' to 'fw' to avoid confusion.
> 
> So, so let me rephrase my point. Why was it not called fw_foo right
> from the beginning? You are making the code harder to review by doing
> stuff like this. And your code is going to need a lot of review and
> revisions because its quality if low if you ask me.
> 
> 	Andrew
> 

Ok, you are right. It should be the right name at the beginning. I will
try to avoid this in the future.


