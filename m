Return-Path: <netdev+bounces-96598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740DD8C698E
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 17:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D42282546
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 15:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D76155757;
	Wed, 15 May 2024 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuq5qoCn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64414155747
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786543; cv=none; b=j03eb5X0qCBWWJHicY5UOJSlv3Mno2QGNpQOisLjjOYqoBXuuSCTCZT5PtiskRvoKWSbpb34UfIbgwFVJUUjb7DXUhEiz+5UV9iDoCfaaWzbTBgnDKTq+GJisNdU0srsWfYO26kelnaORQHVAHS27KTisaMId2bW5H8D9XQIKr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786543; c=relaxed/simple;
	bh=uTEiSuk5E+dWyxLcPbIy8dx10UjehGs78dILm+80nQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvdWgUWUBTd2uhXbApyAUqIuxAo1jvoxRaLJVcRSCNtel7z1Xrcgv6hdZmbtgFr/IxlTu2RsbkW7i94aRykjSuP+ooyw5OJM/V2lwhAHKsx/y94dVRuMBsMh74eBUlFPa6Dylk/PNOxiUnLbFR9rJay2Sk7SV6aw3Hd6vSmb7VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuq5qoCn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0090FC116B1;
	Wed, 15 May 2024 15:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715786543;
	bh=uTEiSuk5E+dWyxLcPbIy8dx10UjehGs78dILm+80nQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cuq5qoCnw1luL0QrIpK1WBC/b/0drd6DMmor6Ir0lB0psg1DIwRGFYKITfcC29d/y
	 se3AoC9gk6E7FCrp9F8zGeDYemv70cS1c6ThLelu+acKbefcZoFixD/K2LFwZ5/bVk
	 xGUYwARbi6fHHgDfUbAVBSMc5e7EPvwqMwErzHLYfHjsAVRdWkENervJiFCDpDclzj
	 jWkGRTDgJoR5QxVxMBhXbcruK4a/jVVGMpxT01uRWBfNVY4No2VOtyAp5ixF3gLfEG
	 QzZDvnApmpUyGSgsgkMXorHM5l/0CIL4sjXoqUkCrC+XI19WfgRJY1YCmS9PK///gq
	 c9QWvfx+bOOjg==
Date: Wed, 15 May 2024 16:22:20 +0100
From: Simon Horman <horms@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com
Subject: Re: [PATCH net-next v3 5/6] net: ngbe: add sriov function support
Message-ID: <20240515152220.GM154012@kernel.org>
References: <20240515100830.32920-1-mengyuanlou@net-swift.com>
 <15515521993762EE+20240515100830.32920-6-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15515521993762EE+20240515100830.32920-6-mengyuanlou@net-swift.com>

On Wed, May 15, 2024 at 05:50:08PM +0800, Mengyuan Lou wrote:
> Add sriov_configure for driver ops.
> Add mailbox handler wx_msg_task for ngbe in
> the interrupt handler.
> Add the notification flow when the vfs exist.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>

...

> +void wx_ping_all_vfs_with_link_status(struct wx *wx, bool link_up)
> +{
> +	u32 msgbuf[2] = {0, 0};
> +	u16 i;
> +
> +	if (!wx->num_vfs)
> +		return;
> +	msgbuf[0] = WX_PF_NOFITY_VF_LINK_STATUS | WX_PF_CONTROL_MSG;
> +	if (link_up)
> +		msgbuf[1] = (wx->speed << 1) | link_up;
> +	if (wx->vfinfo[i].clear_to_send)

Hi Mengyuan Lou,

i appears to be used uninitialised here.

Flagged by clang-18 W=1, and Smatch.

> +		msgbuf[0] |= WX_VT_MSGTYPE_CTS;
> +	if (wx->notify_not_runnning)
> +		msgbuf[1] |= WX_PF_NOFITY_VF_NET_NOT_RUNNING;
> +	for (i = 0 ; i < wx->num_vfs; i++)
> +		wx_write_mbx_pf(wx, msgbuf, 2, i);
> +}
> +EXPORT_SYMBOL(wx_ping_all_vfs_with_link_status);

...

-- 
pw-bot: changes-requested

