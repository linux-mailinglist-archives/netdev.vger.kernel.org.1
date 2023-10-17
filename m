Return-Path: <netdev+bounces-41959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654C47CC70A
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 17:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684061C20A0D
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 15:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7CE44474;
	Tue, 17 Oct 2023 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xqs1UEHJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4AE1F5FA
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 15:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BDAC433C8;
	Tue, 17 Oct 2023 15:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697555278;
	bh=k2PnmI/pDMiyxCR4MSR3ZYTYM+9EpX8aJD7pUDRIYvs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xqs1UEHJJAC+y0GCzzu5AY9AxNJ2BR9cYVCt7s6UZfFjuzb3uDGpLLZm4t2y2mKOi
	 YxOxrYvAIXP7CWXz+NjM2awqG+WUw/+7c2iny679azmb2QpeiXrJNLyyNJlRDpk+kg
	 AX63j2k27/KA19dkUylP/E1q2+4clHtU2cPlNEhMrtfelUEAMUyUjnyRbGfNfZ0ccf
	 K8PBWgxo/vCeTQnDLBKLIpfqbaUP4kws74pQmJJol7+o4wp0G6Qr1RZKX0iqn7odwq
	 NhSFjg3+z1c1EtCUKmhpiGMVd97TZFwdXh2Ajrs0rYDHV9GsC6Vj4cMTbuDJWMYbRV
	 AqDhHcFzuGZUw==
Date: Tue, 17 Oct 2023 08:07:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com
Subject: Re: [patch net] netlink: specs: devlink: fix reply command values
Message-ID: <20231017080757.266b1617@kernel.org>
In-Reply-To: <ZS40gkrsa6fIBbor@nanopsycho>
References: <20231012115811.298129-1-jiri@resnulli.us>
	<ZS40gkrsa6fIBbor@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Oct 2023 09:15:14 +0200 Jiri Pirko wrote:
> Guys, when do you plan to merge net into net-next?

Thursday night (your time).

