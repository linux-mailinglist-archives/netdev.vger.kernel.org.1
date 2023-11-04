Return-Path: <netdev+bounces-46033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1CE7E0F96
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 14:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59363281BE3
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 13:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD5218B1A;
	Sat,  4 Nov 2023 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/jkbv8t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01871A281
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 13:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322F8C433C8;
	Sat,  4 Nov 2023 13:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699104603;
	bh=HfpAese7HNiucJjcRMtNzyEWq/Bw/yqeBhgi075sAv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d/jkbv8trJ9USolJjhEX4II5rBo0nPFIqmpLykt47y89Z1mnGhh+We1jMv9mt56jV
	 D4LDzS+nHV6EO/XRdSwrLDDZuBCDQ4/6idCpsM/n64X98CtwiUSlxThLBdsduINUnG
	 nW0E60HQtdQmArGIWPLy5KdKEEn5w4A6FBF8I/tW7o3FjK6tGymXhH+Fh0y+aNd/iY
	 F5u61sCoy1E2JaPKpVk6VP4CSZ8FOYtdrmawyjkwJ5MlE5HZc5P3FknX/WbzEcL/f7
	 A82NvatnYfWZ/qiU6K3XFFmnXyfd+G3C5I8OXA6K4m9p2YJOL0dVPwt87qI8ULnM4y
	 agZscCiZ1FZ1w==
Date: Sat, 4 Nov 2023 09:29:47 -0400
From: Simon Horman <horms@kernel.org>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: netdev@vger.kernel.org, Dave Ertman <david.m.ertman@intel.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net] ice: lag: in RCU, use atomic allocation
Message-ID: <20231104132947.GC891380@kernel.org>
References: <20231023105953.89368-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023105953.89368-1-mschmidt@redhat.com>

On Mon, Oct 23, 2023 at 12:59:53PM +0200, Michal Schmidt wrote:
> Sleeping is not allowed in RCU read-side critical sections.
> Use atomic allocations under rcu_read_lock.
> 
> Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for SRIOV on bonded interface")
> Fixes: 41ccedf5ca8f ("ice: implement lag netdev event handler")
> Fixes: 3579aa86fb40 ("ice: update reset path for SRIOV LAG support")
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


