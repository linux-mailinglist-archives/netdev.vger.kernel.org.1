Return-Path: <netdev+bounces-73084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF0B85AD04
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 21:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D9D11F2583B
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 20:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA928535D1;
	Mon, 19 Feb 2024 20:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJ/WFCn8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D90535DE
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 20:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708374040; cv=none; b=a7+7hbfIqoTxOdiqDgcE3Qm7rO7Yt6moXG9Adg1vdxqtHBVcaK5CUWlSyzW4x7rUxm3r89Ent+fWiOxW9hyOOpXWLDW19a2Ued0QkFuEUgNjxwf+Ugx414gmugNsj0mVpDVyI6LNr2sR1QaqtESgx1PS2bV8izqxRxeMs2u90ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708374040; c=relaxed/simple;
	bh=YROhBUjPOy5Wm8c9dWqzNXOWeMitIWi5M+foKSlKNF4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b7ATU3rM6+lLydil7xb7Ftu/zXSmUfSKuuVQCWmk/s0yq5qLyMGhFNRgF6/igBg39WHYfJ5UpSMhkaYEcdHxrNpAXMXeMIK6zWeRJfFmYh33+Mo4z/5l+N4YTy27s5URXZiMqjrlUduZ+1Xh+/rQ9o3R/kbLoLEqfG9xpyWXEFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJ/WFCn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB4BC433C7;
	Mon, 19 Feb 2024 20:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708374039;
	bh=YROhBUjPOy5Wm8c9dWqzNXOWeMitIWi5M+foKSlKNF4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nJ/WFCn8DlPImTmyKlnUQYz/gHT/HaJK+gR8cvxzvFANT2HGGw4cNrODBrfsDNS8k
	 Wtk4Orkcz3PSAp45l4akTYA0s2Ufs7fqzC3TvRBqCxRyPyiaAz8IiAnF40Cgv07FjF
	 2R5B/Fnf/rEfFxK+wr6737GRAV0HnMf353C9/pzWjjbMfV8qDarH/65R1M6ruhPLyp
	 QcOpy3gO3uXy+YfYUQU4hnVxPBtOFowJ3//PpjvNiFTu1fKtHvgPZPe5f6Ys0VfaqG
	 FlpPaKkBPNZnib/X04mxZbjQqT9H0focilYJNcLBulKtDjq3rPTTcLPtikzgPwya+L
	 Tkzw//fOQu75w==
Date: Mon, 19 Feb 2024 12:20:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 pabeni@redhat.com, davem@davemloft.net, edumazet@google.com
Subject: Re: [patch net-next] devlink: fix port dump cmd type
Message-ID: <20240219122038.5964400d@kernel.org>
In-Reply-To: <20240219151343.GC40273@kernel.org>
References: <20240216113147.50797-1-jiri@resnulli.us>
	<20240219151343.GC40273@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 15:13:43 +0000 Simon Horman wrote:
> > Fix it by filling cmd with value DEVLINK_CMD_PORT_NEW.
> > 
> > Skimmed through devlink userspace implementations, none of them cares
> > about this cmd value. Only ynl, for which, this is actually a fix, as it
> > expects doit and dumpit ops rsp_value to be the same.  
> 
> I guess that in theory unknown implementations could exist.
> But, ok :)

I'd also prefer Fixes tag + net. YNL is user space, even if current YNL
specs don't trigger it (I'm speculating that that's why you feel it's
not a fix) someone may end up using YNL + YAML from 6.9 and expect it
to work on 6.6 LTS.
-- 
pw-bot: cr

