Return-Path: <netdev+bounces-89793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 292DC8AB91E
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 05:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4101C20DDF
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 03:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1EC79DD;
	Sat, 20 Apr 2024 03:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBd1Ual8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F243201;
	Sat, 20 Apr 2024 03:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713582086; cv=none; b=CfL0oPOuCyGsKGHqKQP+M/K14j6alC0ZHdlN0CUmMMVZVWZPX/pmz3FUBHj05KGzqi5khI3NF1w5bnlSdUvSPTLao9XW03rZvh5/YPpWPO02AqlNbmWc/5V2YJ9R5SDK2K3Z+3leBYUhEusiMDLx5N8mNf4kMGP0+SJJphhqjro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713582086; c=relaxed/simple;
	bh=/4CgFITbRMHOdV44xzuGxYYt/KHDnmu5af3/NTvQg+s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CR/xxcfJKpG9BUZVFAoUdncXuTplLlu5tVbfEsKx253+cYVR8hH5cLGbb6RqM3W+OJVeY278Jj/b5fmDMaU3Ver+x5DgpLiivwxcSZv9NQLb7mZphgAGshMiF7/YgP/TXeGHVKy6pX5kZxaOTXYcPdxfdD3qhHKNGCDUHGJmF1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBd1Ual8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A932C072AA;
	Sat, 20 Apr 2024 03:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713582085;
	bh=/4CgFITbRMHOdV44xzuGxYYt/KHDnmu5af3/NTvQg+s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tBd1Ual8Tvlj6bYSGtfgNwpqM49JI90/L7xD7R3ORXK7+xwL/hPuQt0Tx2Xb5XrOo
	 q4lNpLYdg5UYgwJh4OBQIuVtSzC6tevXHaCYwX4C2sQOb1V265aYEAV3UN5XQFPIWn
	 e4HkvI2dp7rJKTdY6XVxSsY02Jb6afwdNSS0BafEgTR7YDjRb5MYNfWmB2osPBnpQq
	 t1JiIaSp0JUr9y3lo/3mw4rLTYX12TctA31sTEK3enMuIKTuFbfHAJIs1orPjeZI7N
	 O5DUBqFnG4Do5FT5Z/vAthG4RizgOU8exT7BMqr5iylvrsJljmKiHGA6DjCrYD2ewS
	 t0U6dASnc6ocw==
Date: Fri, 19 Apr 2024 20:01:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jun Gu <jun.gu@easystack.cn>
Cc: dev@openvswitch.org, echaudro@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: openvswitch: Check vport netdev name
Message-ID: <20240419200124.701cafb0@kernel.org>
In-Reply-To: <20240419043133.117295-1-jun.gu@easystack.cn>
References: <20240418023242.259542-1-jun.gu@easystack.cn>
	<20240419043133.117295-1-jun.gu@easystack.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Apr 2024 12:31:33 +0800 Jun Gu wrote:
> From: "jun.gu" <jun.gu@easystack.cn>
> 
> Ensure that the provided netdev name is not one of its aliases to
> prevent unnecessary creation and destruction of the vport by
> ovs-vswitchd.
> 
> Signed-off-by: jun.gu  <jun.gu@easystack.cn>
> Acked-by: Eelco Chaudron <echaudro@redhat.com>

I said: When you repost, start a new thread, do not post new version
in-reply-to.

If you don't understand what something means - ask :|
Now try again.
-- 
pw-bot: cr

