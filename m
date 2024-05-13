Return-Path: <netdev+bounces-96070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D86188C4372
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 16:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8BF285ADF
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 14:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DB21C01;
	Mon, 13 May 2024 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJR5ZPv6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846DA17E9;
	Mon, 13 May 2024 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715611543; cv=none; b=Da6yNtN0IpAr6uXui+9cKb8aqB35FU9+AK9zCh7a2S7akywoBm+FI0kh3qRpJVx2z5SDMv7xGgGMkL0QgTZUE2C4SmNljA+mrSnto+31TI6drf6eUB1VRfuSdP8VdxuMeWdRntKXup8uOcyav45onQVmfwSXts4JesYXMILjF8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715611543; c=relaxed/simple;
	bh=UTDWmhibw40wrJxd0qE69FWWlql8iuQLSMqXuReqqHk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSH9yFGRWv3NIELMqDdAawIIY+/M02jNu7pThr4Vg2IPto5RgHOyeG3c3nwVVAMvXe1G+FDEMsrU1nbBphDm3cVv0uu+lJiWaVQylaA6Mhh6k0qaAfOo2Su+SJdT0P/wwsWXR6qxR4eT8ungMbZf5bLQCLYtE50G3ilxtOex6dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJR5ZPv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0DFC113CC;
	Mon, 13 May 2024 14:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715611543;
	bh=UTDWmhibw40wrJxd0qE69FWWlql8iuQLSMqXuReqqHk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tJR5ZPv69tehJFx2Lf9zjTWpCQNVy2VGY1OVcTuYd/cMiOdOowdd5SOjYX1mZdATH
	 4KP9G1j0mAUPE1HW6G+ICmTMAiDJFyDNdunzh1st3I7ghGzx9CBuf+SjzCTNMQdUEb
	 CkSeJ7VL+PMDlmguVQj9DiA+ZJINdwZbjM6G/r+cnu3gtCkdy8zkg2INAcVkSiKS4y
	 74Ng9qpMHEBJ4Iu7XMyl0Dpbc00EQ/L+AovSQJue9sWjXKOzSxp2MScWjQmjtcFUBY
	 aLnzQf+T+1Q30qj09H56CiLJsHNgbNJOzbXbbsoAwGu7xyz2eWNyDZvsgzLAtw02Jc
	 nGP2hLTcN5iug==
Date: Mon, 13 May 2024 07:45:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] tulip: eeprom: clean up some inconsistent indenting
Message-ID: <20240513074541.09744f80@kernel.org>
In-Reply-To: <20240511021448.80526-1-jiapeng.chong@linux.alibaba.com>
References: <20240511021448.80526-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 May 2024 10:14:48 +0800 Jiapeng Chong wrote:
> No functional modification involved.
> 
> drivers/net/ethernet/dec/tulip/eeprom.c:179 tulip_parse_eeprom() warn: inconsistent indenting.

We don't accept pure formatting or checkpatch "fixes" in networking.
Especially for ancient HW.
-- 
pw-bot: reject

