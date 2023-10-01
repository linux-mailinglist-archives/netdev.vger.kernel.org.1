Return-Path: <netdev+bounces-37308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0044E7B4974
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 21:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 168B01C204F5
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 19:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7433A19478;
	Sun,  1 Oct 2023 19:47:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CD41946A
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 19:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6754BC433C8;
	Sun,  1 Oct 2023 19:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696189651;
	bh=DN2hN7meQ6DYGeJl4taTidBevp+JrcBNFzPmwT2iE3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mdnwntEU9MEecMilBq7ZCfkcEiuJ7V+6vRkRT/Vgp4WRYzzfq02Xio8zh8mugnpdx
	 e3Fyn4EFSvWDW1GdZ1/JhhXO0gWluaO652t3hAMrxi9u/xLpy42JhFTXTKpr6XnCww
	 xKOSyPe5ZmH9XrOPBzBYx0CzVXcZNh/KZ4+rB4MUSXW8qu7br9iUULdaWW+3hgPPqM
	 +/3DvyHHDS/sSiDosXVFnJbD/qWCJUdemvojuJTk/VHRsRRb/aDO+rcru0su77gKF4
	 oHt2yAK/uAiuB8VXkktHVDowcBuR5eq9NtYNAMsGD6+Q9XcO8txOupheH6ziFodHei
	 jxnUXLEAU+ILA==
Date: Sun, 1 Oct 2023 21:47:03 +0200
From: Simon Horman <horms@kernel.org>
To: chenguohua@jari.cn
Cc: 3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atm: Clean up errors in atm_tcp.h
Message-ID: <20231001194533.GW92317@kernel.org>
References: <32b04d0b.86a.18ad54f1174.Coremail.chenguohua@jari.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32b04d0b.86a.18ad54f1174.Coremail.chenguohua@jari.cn>

On Wed, Sep 27, 2023 at 02:24:03PM +0800, chenguohua@jari.cn wrote:
> Fix the following errors reported by checkpatch:
> 
> ERROR: space required after that ',' (ctx:VxV)
> 
> Signed-off-by: GuoHua Cheng <chenguohua@jari.cn>

Hi GuoHua Cheng,

unfortunately, patches that only contain checkpatch clean-ups
for Networking code are not accepted.

pw-bot: rejected

