Return-Path: <netdev+bounces-13318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C61573B427
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 11:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA652819D1
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 09:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A73B5246;
	Fri, 23 Jun 2023 09:52:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BA2523A
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 09:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD003C433C0;
	Fri, 23 Jun 2023 09:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1687513976;
	bh=pGamjcIe+8ovwyOvPBVtIx0PXFJ60YVVTdwGMF+RyRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qBIT3gydqRtFxDfzaV2TrpVPZ8tjZX1GmC3tIsVLXNPcSO78r9QN0/OkhhcLoHOix
	 0d2oKsD0N3gOlKEEyp+fjWZs381uwgwXjAKhN3U1RiMraxtm9cK/xiGwK+8tiTM1lu
	 awT5XKF5gm/Ej471uqCJel42r+wNPXV050dq2OqM=
Date: Fri, 23 Jun 2023 11:52:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: stable <stable@vger.kernel.org>, netdev <netdev@vger.kernel.org>
Subject: Re: Request for "ip_tunnels: allow VXLAN/GENEVE to inherit TOS/TTL
 from VLAN" in v5.4 / v5.15
Message-ID: <2023062335-slogan-requisite-c8db@gregkh>
References: <f220c0e0-446c-58bd-eabb-0dee9819dd53@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f220c0e0-446c-58bd-eabb-0dee9819dd53@6wind.com>

On Fri, Jun 23, 2023 at 11:43:24AM +0200, Nicolas Dichtel wrote:
> Hi,
> 
> I would like to request for cherry-picking commit 7074732c8fae ("ip_tunnels:
> allow VXLAN/GENEVE to inherit TOS/TTL from VLAN") in linux-5.15.y and
> linux-5.4.y branches.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7074732c8fae
> 
> This commit has lived since a long time in upstream (11 months), the potential
> regressions seems low. The cherry-pick is straightforward.
> It fixes the vxlan tos inherit option when vlan frames are encapsulated in vxlan.
> 
> The kernel 5.4 and 5.15 are used by a lot of vendors, having this patch will fix
> this bug.

You forgot about 5.10.y :)

Now queued up for all 3, thanks.

greg k-h

