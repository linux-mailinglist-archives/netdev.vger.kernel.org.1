Return-Path: <netdev+bounces-151272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC889EDD76
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 03:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043FD1887004
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 02:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EDB13B29B;
	Thu, 12 Dec 2024 02:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSILkdTa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF7513AD38;
	Thu, 12 Dec 2024 02:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733969624; cv=none; b=bCR/xZ4Rn62o+76xsm6TZHTLPLs/HxKJlOnP+LovUIMTlCN+yK0CiA4pDThtsbpCTQgaAvLMc2XbGkBr4u+cw8Fyf3EwRqjdk5S/tDAyOnbNVU/EWITV0/b9rYOaaBueken18Ea4i59aUEPl6TAX1uasLanrddSx0gpvCluEE24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733969624; c=relaxed/simple;
	bh=WOJIxkXJBdrspcO3VMmxK/S//FZEKVoFBrjn6HEY44s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwTAKMgAsprMHuNeDoPfudij8srh6OSOjlmQPUWUuRuOJdeROE78gPUJRVVMxsidcrCtOUYSbBl958n64Ug5C7OieWcAs2DkmGE5eNjlIJ0x5PRqr2/MPVq05hfk8dWIHXXJ8vBJCbZwgJTslBVsUtL4DkEp9IR3r1j9T7+En0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSILkdTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6D6C4CED7;
	Thu, 12 Dec 2024 02:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733969623;
	bh=WOJIxkXJBdrspcO3VMmxK/S//FZEKVoFBrjn6HEY44s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aSILkdTaynAPT4X3BKGT5TM4VbpS7yk9SKMYOpPHZB4gVjqm3BSCeaIJynG6Dfo25
	 6zWR77afNbN7y6yxs6CNCOPwi8oz/3MkBvprKhOo2isSAJ7XE0cmCEFaENmmphrYTS
	 xlDarbTq8zC9qoo/zfvmtQycFpWf3Kqj84AnaO3Qb8Q4hxFrUkQyB1Ud0+geY74OId
	 j84w1/A7WAsJ4jPNXhodTPqdQTkirq1U4qjCDMLBis8LPpq3BgcFnMgr+0UM1JiiE1
	 1hFDTaYPfwaX3kD4ueM83sahQer3tGm7k5D6CVdB4E2vJ3X8rN4Oh4edzIry8VrN/l
	 tGxGRvN5oYpnw==
Date: Wed, 11 Dec 2024 18:13:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jan Stancek <jstancek@redhat.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, stfomichev@gmail.com,
 pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] tools: ynl: provide symlinks to user-facing
 scripts for compatibility
Message-ID: <20241211181342.31676ec4@kernel.org>
In-Reply-To: <CAASaF6wcW54MwR-CdR_bfXRJS+ar0y87g7FN1_T6qLVJX0Ti6A@mail.gmail.com>
References: <cover.1733755068.git.jstancek@redhat.com>
	<ce653225895177ab5b861d5348b1c610919f4779.1733755068.git.jstancek@redhat.com>
	<20241210192650.552d51d7@kernel.org>
	<CAD4GDZzwVhiJjJ=dqXMSqN39EeVBrUbO3QYB=ZhrExC86yybNg@mail.gmail.com>
	<CAASaF6wcW54MwR-CdR_bfXRJS+ar0y87g7FN1_T6qLVJX0Ti6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 13:42:28 +0100 Jan Stancek wrote:
> > > Did someone ask for this? Does everything work without the symlinks?
> > > If the answers are "no", "yes" then let's try without this patch.
> > > In tree users should be able to adjust.  
> >
> > I asked for the symlinks for cli.py and ethtool.py to avoid surprising
> > people when they move. The ynl-gen- scripts are primarily used in-tree
> > via Makefiles so I didn't think they should be symlinked. Happy to go
> > with your suggestion to drop this if you'd prefer not to have any
> > symlinks.  
> 
> I'll drop them, we can always add them later in case someone
> _really_ needs original script locations.

FWIW that's my thinking, too.

