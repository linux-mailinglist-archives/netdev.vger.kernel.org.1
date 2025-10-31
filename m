Return-Path: <netdev+bounces-234558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8911DC22F1C
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 03:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD126188CFAF
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 02:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DF626ED21;
	Fri, 31 Oct 2025 02:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlWOceLO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CE123D7F5;
	Fri, 31 Oct 2025 02:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761876369; cv=none; b=DebBSiBo6vWzkCubAKjAor7NJaRDN5w6o69YL6YUAEj35XhVocDu8zfPeZ7bahKpSq+DpVOAmw6uVkvO5BCk9o3RR/rnEBaCxNEK0NywXPw290/fXzOfC7+JeIhhmmlMWfGV/6yb7Y+Yu7PPrrEp+tX4hYVESYwnz1ymR0FQkp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761876369; c=relaxed/simple;
	bh=dm6BLpbWI4tGkf1xkZ1jW8UKNKYbVLXofPTsyB9w1Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QlWXwnau+NNpYJNWweSMyWWkJi7S7P5OO3oWfRxFaBgaVbYLS4mb5StuUX9AZT9wY4VEkidDJTGMPLmfwVCXHCFivFtqr7qs4IIoUXChCbiSjBJ93vSTEwf3E1r6OeIeIeK1hBGpRJNNPU93ed15xBV0sAJ7VaxPvmTExO7IFno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlWOceLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8477C4CEF1;
	Fri, 31 Oct 2025 02:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761876364;
	bh=dm6BLpbWI4tGkf1xkZ1jW8UKNKYbVLXofPTsyB9w1Yc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tlWOceLOPUD8cLQrFA4Dg2AYUHdHD4fWpwzJ00zimWDP+0JloyLlda/iOmo5NDQ3D
	 dIScxacCTNQI9H+n9OsSMhdNVsAzW3N1phm7nwz178SSbSmazIyVq6xZ2ezU7xo88h
	 Z+iiSjzY8x14wf7I3Hu/lFcQxfXUM19TdI0YzQCSITyp5KIzDR6OXMkokRaVDrW0XT
	 al48eD9rrTNKT8fbXRQqu3HHAiuAK72w3Tk4m1440VdvB9m0pEyIRdArqTzELH/Rbg
	 1hINXAbIsJ2++yxtX9psBicfAfjfDmAedMWIV0Z6OhMiFeFXQbnQHoflfAv7mbqriP
	 B3GLc7RIVEDCA==
Date: Thu, 30 Oct 2025 19:05:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yibo Dong <dong100@mucse.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, andrew+netdev@lunn.ch,
 danishanwar@ti.com, vadim.fedorenko@linux.dev, geert+renesas@glider.be,
 mpe@ellerman.id.au, lorenzo@kernel.org, lukas.bulwahn@redhat.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v16 5/5] net: rnpgbe: Add register_netdev
Message-ID: <20251030190558.302a3ec8@kernel.org>
In-Reply-To: <7D45894046CE41CC+20251031014410.GA49419@nic-Precision-5820-Tower>
References: <20251027032905.94147-1-dong100@mucse.com>
	<20251027032905.94147-6-dong100@mucse.com>
	<20251029192135.0bada779@kernel.org>
	<24FCCB72DBB477C9+20251030023838.GA2730@nic-Precision-5820-Tower>
	<20251030081640.694aff44@kernel.org>
	<7D45894046CE41CC+20251031014410.GA49419@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 09:44:10 +0800 Yibo Dong wrote:
> > > It is for 'u8 perm_addr[ETH_ALEN];'
> > > Maybe I should just "#include <linux/if_ether.h>" for this patch.   
> > 
> > I see, that's fine. Then again, I'm not sure why you store the perm
> > addr in the struct in the first place. It's already stored in netdevice.
> >   
> 
> I get 'mac_addr' from fw, and store it to hw->perm_addr 'before'
> registe netdev (rnpgbe_get_permanent_mac in rnpgbe_chip.c).
> You mean I can use a local variable to store mac_addr from fw,
> and then use it to registe netdev?
> 
> Maybe like this?
> int rnpgbe_get_permanent_mac(struct mucse_hw *hw, u8 *perm_addr)
> ...
> 	u8 perm_addr[ETH_ALEN]
> ...
> 	err = rnpgbe_get_permanent_mac(hw, perm_addr);
> 	if (!err) {
> 		eth_hw_addr_set(netdev, perm_addr);

Yes, LGTM.

