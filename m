Return-Path: <netdev+bounces-39238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C1E7BE66E
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 18:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6120281591
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 16:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EA81FC6;
	Mon,  9 Oct 2023 16:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fz2BZs33"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DC0A93D
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 16:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95873C433CB;
	Mon,  9 Oct 2023 16:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696869090;
	bh=oyRfyginZSVS30jDs8Ex2jwGfxU5fIbT3YRXKcD3Db0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fz2BZs33QzBXnkWSiMf9nL1iT0mhaBzsO35T411awbBw3kM50b/xHY1gtyz3NJnqY
	 97Fb78tfD67Sl+Ptpx16OqAmrfNBKOoffec0UgI7H2rWj299+sZx/6HHPZpKFOAWy/
	 8kzqFk4l8fG8Lbp5xws9YxilheDZgKUFkDIKYgm4Qgc/5zODLgEiu1I3w1DXBx5NC8
	 Z4D9oN8Syo4kSmMbmefl5dbgGFWN+iMeWxuNblJOuHlW6YVu0bno3VfQhbdy0Ya1GI
	 Is8BdWWky+a1sDPsvl53TkM3Y43nULvlpPhHX4vE9IAbfrkS55GDgX7x06Ceu29EpZ
	 r8nq4ok/2cuzw==
Date: Mon, 9 Oct 2023 09:31:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, gal@nvidia.com
Subject: Re: [patch net-next] devlink: don't take instance lock for nested
 handle put
Message-ID: <20231009093129.377167bb@kernel.org>
In-Reply-To: <ZSQeNxmoual7ewcl@nanopsycho>
References: <20231003074349.1435667-1-jiri@resnulli.us>
	<20231005183029.32987349@kernel.org>
	<ZR+1mc/BEDjNQy9A@nanopsycho>
	<20231006074842.4908ead4@kernel.org>
	<ZSA+1qA6gNVOKP67@nanopsycho>
	<20231006151446.491b5965@kernel.org>
	<ZSEwO+1pLuV6F6K/@nanopsycho>
	<20231009081532.07e902d4@kernel.org>
	<ZSQeNxmoual7ewcl@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Oct 2023 17:37:27 +0200 Jiri Pirko wrote:
> >I think kernel assuming that this should not happen and requiring 
> >the PF driver to work around potentially stupid FW designs should
> >be entirely without our rights.  
> 
> But why is it stupid? The SF may be spawned on the same host, but it
> could be spawned on another one. The FW creates SF internally and shows
> that to the kernel. Symetrically, the FW is asked to remove SF and it
> tells to the host that the SF is going away. Flows have to go
> through FW.

In Linux the PF is what controls the SFs, right?
Privileges, configuration/admin, resource control.
How can the parent disappear and children still exist.

You can make it work with putting the proprietary FW in the center.
But Linux as a project has its own objectives.

