Return-Path: <netdev+bounces-116146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C0594945D
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 17:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78F71C21107
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4978E15E88;
	Tue,  6 Aug 2024 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u131cLA8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2529218D63A
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722957645; cv=none; b=hX9jaB8MdkhRvq3iBa68ct/2a05DmYFFx1VhIXueOWfd/RmiRNgxrJ3OAaTmg/hGjOBvPsAXrxJY7sJr5eXBQCJLGen9ekwlHq2iN2MR++EjMu7S0FgrH34YjJfMARsqbnHm7gF3z5s8u4CqD277UfJhC7feshgJ2qHEQPnN5Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722957645; c=relaxed/simple;
	bh=9eCXM6rjQCeQizhfYMpyhL9T0I8ql/d3q/guQlfcN8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSw1gM0dC1NJj/d13wIQvH+z5VpufMi7BkuMpTBqwLudDFMoSCr09c3Xh6KEOlvY4xtB9T3AHg5MYxorjXa3RWeZj61+USA9ECwSLT4cmIFIcYwO1glaX6y7/NFaru8KEclYrC+N5lriajpOyRwjNbSoWHKayMv5MPTCA1WDfNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u131cLA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33714C4AF0C;
	Tue,  6 Aug 2024 15:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722957644;
	bh=9eCXM6rjQCeQizhfYMpyhL9T0I8ql/d3q/guQlfcN8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u131cLA8pL8ghEhBjqCt41B9uGlsBaMvThZugLolK81kGbotMUBW9RTAq+RU36xzc
	 js7OafmQtKWxcxSPoyXEDDykdWdqTwo6GejIsedH9eWZaSQq/qk2lVmkMxdVjxtiSg
	 6y9DTloBAoudi5/tglBIHj41NBOBVTYt7nxCYTQaW4qctt5UZO9KZ1SljFViP5kn6v
	 zKJfCIdKVO3umD/gMQHLNmP5224s9yqOiI7pBGobGBqIVmFLZJh+QZciphk9N7vrft
	 TMba0VChOUAeD+7/F9I1Gx1R7PZOk20Lf3UOZBT4+DsFf3FZFr2BwvVV5YSpBflzVB
	 E8/NsOVdqSJRw==
Date: Tue, 6 Aug 2024 16:20:42 +0100
From: Simon Horman <horms@kernel.org>
To: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 00/10] add sriov support for wangxun NICs
Message-ID: <20240806152042.GY2636630@kernel.org>
References: <598334BC407FB6F6+20240804124841.71177-1-mengyuanlou@net-swift.com>
 <20240805164015.GH2636630@kernel.org>
 <AADA412A-F7C4-4B73-A23A-ECD68ABFC060@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AADA412A-F7C4-4B73-A23A-ECD68ABFC060@net-swift.com>

On Tue, Aug 06, 2024 at 05:37:36PM +0800, mengyuanlou@net-swift.com wrote:
> 
> 
> > 2024年8月6日 00:40，Simon Horman <horms@kernel.org> 写道：
> > 
> > On Sun, Aug 04, 2024 at 08:48:31PM +0800, Mengyuan Lou wrote:
> >> Add sriov_configure for ngbe and txgbe drivers.
> >> Reallocate queue and irq resources when sriov is enabled.
> >> Add wx_msg_task in interrupts handler, which is used to process the
> >> configuration sent by vfs.
> >> Add ping_vf for wx_pf to tell vfs about pf link change.
> >> Make devlink allocation function generic to use it for PF and for VF.
> >> Add PF/VF devlink port creation. It will be used to set/get VFs.
> > 
> > I think it would be good to summarise the overall status of SR-IOV support
> > with this patch, and what follow-up work is planned. As Jakub mentioned [1]
> > this does not seem complete as is.
> > 
> 
> Ok，got it.

Thanks.

Did you get my 2nd point below?
This seems relevant to you:
- https://lore.kernel.org/netdev/20240620002741.1029936-1-kuba@kernel.org/

> 
> > [1] https://lore.kernel.org/netdev/988BFB51-32C8-499C-837D-91CC1C0FFE42@net-swift.com/
> > 
> > I mean, I understand the NDOs were removed from the patchset (see more on
> > that below) but there needs to be a plan to support users of this device
> > in a meaningful way.
> > 
> >> 
> >> v5:
> >> - Add devlink allocation which will be used to add uAPI.
> >> - Remove unused EXPORT_SYMBOL.
> >> - Unify some functions return styles in patch 1 and patch 4.
> >> - Make the code line less than 80 columns.
> >> v4:
> >> https://lore.kernel.org/netdev/3601E5DE87D2BC4F+20240604155850.51983-1-mengyuanlou@net-swift.com/
> >> - Move wx_ping_vf to patch 6.
> >> - Modify return section format in Kernel docs.
> >> v3:
> >> https://lore.kernel.org/netdev/587FAB7876D85676+20240415110225.75132-1-mengyuanlou@net-swift.com/
> >> - Do not accept any new implementations of the old SR-IOV API.
> >> - So remove ndo_vf_xxx in these patches. Switch mode ops will be added
> >> - in vf driver which will be submitted later.
> > 
> > FYI, this policy was recently significantly relaxed [2]:
> > 
> > [2] https://lore.kernel.org/netdev/20240620002741.1029936-1-kuba@kernel.org/
> > 
> >> v2:
> >> https://lore.kernel.org/netdev/EF19E603F7CCA7B9+20240403092714.3027-1-mengyuanlou@net-swift.com/
> >> - Fix some used uninitialised.
> >> - Use poll + yield with delay instead of busy poll of 10 times in
> >> mbx_lock obtain.
> >> - Split msg_task and flow into separate patches.
> >> v1:
> >> https://lore.kernel.org/netdev/DA3033FE3CCBBB84+20240307095755.7130-1-mengyuanlou@net-swift.com/
> > 
> > ...
> > 
> > 
> 

