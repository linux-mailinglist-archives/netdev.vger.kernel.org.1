Return-Path: <netdev+bounces-105499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1071A911844
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 04:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9511C21C47
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 02:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3A44F1E2;
	Fri, 21 Jun 2024 02:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWNKR457"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315BB620;
	Fri, 21 Jun 2024 02:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718935382; cv=none; b=CMPs0zpwgGXF32KoLobLCBmgbxcIHVilvSvCEv3wr9xi6dlp725m8JqZHgidKB0XYLvdw3sjavgSyEXRGljNK5nXk9cZIb3+42mlyoe1wO0EtpGFgl79cl6TL3J63hwil9fO0FbG1olfBJWQ5z4H6RAhNsXg8+Bqv7W07yvEMtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718935382; c=relaxed/simple;
	bh=91yDbI/hirCIT5wJXLloNI7RVmiNpNjFgNnjAl944B0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qAJ5rjmmCBmT7nlhLcBhOB1hHiQIBentbQIJAULx6yaKa3w6HBIQ48qaqOBrj/mGYm6m5sE9x3FZzclncSh/bJdOII0vnkEUUGWhqynsYNkKcnLIWIU2k+aU/SzsUSSUW533zDMVb7UXLyi66TKQpeAw/mc2zCQcH6qi9zGeyBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWNKR457; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB4AC2BD10;
	Fri, 21 Jun 2024 02:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718935381;
	bh=91yDbI/hirCIT5wJXLloNI7RVmiNpNjFgNnjAl944B0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lWNKR457w8/T1Cdm916JpoMonR4vu5Jc8N/ZdpX//vRo6nrQNG+PDA1m+H1bEvu9b
	 cZeWoYwI4IJsuD1ZUEFgLKDkBdOeDd5S3/O7/oIhaOeDzcZFjjp6kkzqptWxxPd5WP
	 eanHr3TBJdCAATVf+U0wYt+ZrRV0bT+uX7IRuMGlO0U3zde6Qy/bVvQXFDSRaSTt49
	 O4QFW1sfXc+D0HcTtOIMGqH/YZFtNFIN/PU95zq10FJYSd/Y2GvhREo5SJeyFTgx8p
	 WPJUbXTsHT/Qv7NSZYrDlGrKTGC0SXO1XlnTGgLOkCT+Rwpof4yJrpoCfgS9Pin+EJ
	 CHXmGKlgWrRNQ==
Date: Thu, 20 Jun 2024 19:03:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Jose Abreu <Jose.Abreu@synopsys.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] net: dwc-xlgmac: fix missing MODULE_DESCRIPTION()
 warning
Message-ID: <20240620190300.784ea7a3@kernel.org>
In-Reply-To: <4a401305-c21c-417c-8280-82bb1ce1d379@quicinc.com>
References: <20240616-md-hexagon-drivers-net-ethernet-synopsys-v1-1-55852b60aef8@quicinc.com>
	<ZnAYVU5AKG_tHjip@nanopsycho.orion>
	<20240617171430.5db6dcd0@kernel.org>
	<4a401305-c21c-417c-8280-82bb1ce1d379@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jun 2024 16:41:04 -0700 Jeff Johnson wrote:
> > I've been applying these to net-next lately, TBH.
> > Judging by the number of these warnings still left in the tree we are
> > the only ones who care.  
> 
> I'm trying to get rid of these tree-wide.
> Hope I'm not just tilting at windmills...

Not at all, it's a lot of work but new ones don't get added very often
so there's a light at the end of the tunnel..
It'd be great if an incremental W=1 build didn't spit out 400+ warnings.

