Return-Path: <netdev+bounces-43533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C27A7D3CA7
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 18:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51842B20D64
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 16:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FC61B266;
	Mon, 23 Oct 2023 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/HTBh29"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44860208B3
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 16:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368E8C433C8;
	Mon, 23 Oct 2023 16:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698078816;
	bh=iatCpzjSjYhZBmCgGmBhqgE2u8WzpQ+9KXZYbkYH6LQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a/HTBh299ChYxhImN3R8po4A50IGmUBXFUp0rQbWRjKNjZ5SIKyOPMRp6wwCMCnNi
	 wDJ/vz8nfIV3ZBzUwBkx+LR4Xg0fdvQXur968aEmQNNhT0db8KCdBqL6lmgRlSRG7c
	 KeoFEYZF/RZE9NFdaVCFnfUG7JKB3/+UsRzLwTly6sBlDj3p1T6zpKC2ptp/9teQWb
	 uiOoiAbpo6vuNjssck+2cDWlRRNBo87iLC7SzC+MwxEFmdRlrAFdW8EIBZX59Q2eC0
	 P3rNzcF1qYd+VN+tRWycVvCjaNn4HQ5poKUWDE31vsoFw3gHDAEbqautrWaLDwI8IO
	 8ub9narOYRtdA==
Date: Mon, 23 Oct 2023 09:33:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward AD <twuufnxlz@gmail.com>
Cc: wojciech.drewek@intel.com, davem@davemloft.net,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, reibax@gmail.com,
 richardcochran@gmail.com,
 syzbot+9704e6f099d952508943@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net] ptp: ptp_read should not release queue
Message-ID: <20231023093334.3d6cda24@kernel.org>
In-Reply-To: <20231023095549.719099-2-twuufnxlz@gmail.com>
References: <MW4PR11MB57763BDD2770028003988D8AFDD8A@MW4PR11MB5776.namprd11.prod.outlook.com>
	<20231023095549.719099-2-twuufnxlz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Oct 2023 17:55:50 +0800 Edward AD wrote:
> Signed-off-by: Edward AD <twuufnxlz@gmail.com>

We need a legal name for the signoff, not initials.

