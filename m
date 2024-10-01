Return-Path: <netdev+bounces-130886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB7C98BE2F
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50DF0285AC2
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BC71C3F32;
	Tue,  1 Oct 2024 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJRZ9aM9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E9517E00B;
	Tue,  1 Oct 2024 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790158; cv=none; b=OWo/AyrJtZL6XzXdVPuUzfTCNcCqrSa9R94VBONnn4L6NcNt5BWc53iNvSUgRzSqDrNsVsVVyUIFFAvTi4igO5dGDl3xu5gONI53A+EADPqKmuaLI/beovlWy/dtEioTl+zU9oSjc/TgZnA6Tx57YsT7VgsANEFJvw2zbsP0w9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790158; c=relaxed/simple;
	bh=gxCzHRI9bsyx+/T4fKn4Q+hzUu3Fwf+KDMIfSDeYvDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddl/CK83XhOO4T6v1mmPmzXHVWjpUqFmJMpoYyLrqaJQaM7z72lFhwG9gzA8sxdvaddX/qqm5M/UOYWDFIwF1Ib5+nQXFK5+CsJZIRlGxDueQmNRIX61Y9kKAcBB/rDhOdyrhbrY74Z9NdPNJpRd5nQWjFf+qoXbfNuyNT+TgHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJRZ9aM9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA07C4CEC6;
	Tue,  1 Oct 2024 13:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727790157;
	bh=gxCzHRI9bsyx+/T4fKn4Q+hzUu3Fwf+KDMIfSDeYvDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gJRZ9aM9o4WrW7SPdR+elYqF3aR62bU2Wxvybj8evbt8Sq9zN4GJNKGs1paS+OeS7
	 lHcK6bLTCuX+piQ+7lDYv1PzugamuQ/01l275X3bg1yzoY9Q9is9MgWinLbYmYNiWU
	 SgtT7Np/XlWBTG6pSLgcclkASfy28YwvUD5ZdGJucwMSI9HtOIHaVWc6ytK6IcEIAn
	 L8WgT9DW5qacQLUDbOBMsmT8SBwPMunVtvvsfHW43YevyqUd44Sne0bQSsXRM2mlfg
	 6YsknFalGY0esK58nsJYEZoD0Pv5iqVuRahf9k16DeG3ee1rQ3f6EUthb94ctJnZmX
	 BhNKPtaCYSWNg==
Date: Tue, 1 Oct 2024 14:42:33 +0100
From: Simon Horman <horms@kernel.org>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: marvell: octeontx2: nic: Add error
 pointer check in otx2_ethtool.c
Message-ID: <20241001134233.GS1310185@kernel.org>
References: <20240923113135.4366-1-kdipendra88@gmail.com>
 <20240924071026.GB4029621@kernel.org>
 <CAEKBCKPw=uwN+MCLenOe6ZkLBYiwSg35eQ_rk_YeNBMOuqvVOw@mail.gmail.com>
 <20240924155812.GR4029621@kernel.org>
 <CAEKBCKO45g4kLm-YPZHpbcS5AMUaqo6JHoDxo8QobaP_kxQn=w@mail.gmail.com>
 <20240924181458.GT4029621@kernel.org>
 <CAEKBCKPz=gsLbUWNDinVVHD8t760jW+wt1GtFgJW_5cHCj0XbQ@mail.gmail.com>
 <CAEKBCKOykRKyBGzBA6vC0Z7eM8q5yiND64fa4Xxk5s5vCufXtA@mail.gmail.com>
 <CAEKBCKOLPUYJaXOG9p8Gznve86vq+GxOde+iZAYRCPqdjEAgsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEKBCKOLPUYJaXOG9p8Gznve86vq+GxOde+iZAYRCPqdjEAgsw@mail.gmail.com>

On Mon, Sep 30, 2024 at 11:57:02PM +0545, Dipendra Khadka wrote:

...

> Are we accepting any changes related to the error pointer handling for
> the driver octeontx2?

Sorry, I think I'm missing some context.
Could you explain in a bit more detail?

