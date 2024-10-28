Return-Path: <netdev+bounces-139695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CDD9B3D8D
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F2B1C212A2
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 22:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAED1E0B63;
	Mon, 28 Oct 2024 22:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dvu2pS70"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57C118B470
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 22:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730153735; cv=none; b=tU2BYlgpfg4mTEbdTa5PMgk+Uf/k1SftlEmaPH1Knkg5ZhRV+70OMocNAXVbewhxvfSNwB1cypv8VW0+gkAxXIxkrEh/3DF3lptQe7X2XgpBWojQIV7p8guUZsasbeJmd5mLEIV8t7TmKwD5HUKoj1BpAe6/c+Atn/jON7RADOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730153735; c=relaxed/simple;
	bh=yC3uMB4IvAISf1xUimggzDlBTy7QE3Th9oPhs1924bw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YT3CnPk/XZh2lbAcJBDvCwbsyHuikorOQUy95KIacX1ShgnP87diJVrH5mxfd+nFyFT7OoMRJ/EAkVSIc++bPyQawVBARAUK5FpAyAefcaLiA6G07rksJCFoG+LbnO+Xqv0DxS2npRjwcGkWDdLBMipMrcLTlbCOw8UtznRH2fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dvu2pS70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAA8C4CEE4;
	Mon, 28 Oct 2024 22:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730153735;
	bh=yC3uMB4IvAISf1xUimggzDlBTy7QE3Th9oPhs1924bw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dvu2pS70srLcWwwpFz/GTV4qQZz/27zKM3CwKXxRVv0V28UO2B/ZXl4NIFu4sZYHm
	 KPhp/jtzwDGHfwGr+1Q7mfXIBAThOl++Vcp4EJWMXjyfh6Hhz3Rg1PTtFgmRp1/nhE
	 n/NLbqln+//mcuIhRXX7tsW9zMO+uvJmZUe82jx+gUXvkkVlJJEknP/w+dQJWdYPYJ
	 ztRTgtZftexydD+SB7kGrKCpGx28csf6pV4XmZ9MpJjGRnBqWR2lBHuTi9N3DnK0Vf
	 88ItTbjbCCmyQG1p9DNQVhqQ/EjlyvPBMInxoe/cLX6zZ3fO99FHqSKEYIZ1E3b2Uy
	 0yh1c5BUZPB7A==
Date: Mon, 28 Oct 2024 15:15:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Joe Damato <jdamato@fastly.com>,
 Stephen Hemminger <stephen@networkplumber.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: yaml gen NL families support in iproute2?
Message-ID: <20241028151534.1ef5cbb5@kernel.org>
In-Reply-To: <845f8156-e7f5-483f-9e07-439808bde7a2@kernel.org>
References: <ce719001-3b87-4556-938d-17b4271e1530@redhat.com>
	<61184cdf-6afc-4b9b-a3d2-b5f8478e3cbb@kernel.org>
	<ZxbAdVsf5UxbZ6Jp@LQ3V64L9R2>
	<42743fe6-476a-4b88-b6f4-930d048472f9@redhat.com>
	<20241028135852.2f224820@kernel.org>
	<845f8156-e7f5-483f-9e07-439808bde7a2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 15:29:35 -0600 David Ahern wrote:
> On 10/28/24 2:58 PM, Jakub Kicinski wrote:
> > I was hoping for iproute2 integration a couple of years ago, but
> > David Ahern convinced me that it's not necessary. Apparently he 
> > changed his mind now, but I remain convinced that packaging 
> > YNL CLI is less effort and will ensure complete coverage with
> > no manual steps.  
> 
> I not recall any comment about it beyond cli.py in its current form 
> is a total PITA to use as it lacks help and a man page.

I can only find this thread now:
https://lore.kernel.org/all/20240302193607.36d7a015@kernel.org/
Could be a misunderstanding, but either way, documenting an existing
tool seems like strictly less work than recreating it from scratch.

