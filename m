Return-Path: <netdev+bounces-76476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D672286DE48
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 10:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2C9281263
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 09:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7D26A337;
	Fri,  1 Mar 2024 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dip+FC0n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD922EB0E
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285365; cv=none; b=QgSfBhwJ4sPqsfjsmzc1VqsVRGN6B9UQPNwhfwTmT529aZEJpPYQJQ2Gas955ze2j5qEg1LoCWnkgNOp4+0jeWACSz3MS9y3U9O/Tkahp0pyT6zc/0k2yz/uvnFvSPdZpqxm68hNyf5mlrymiIXPXb6PwQ4Kx/ZiQi3MwjQfPX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285365; c=relaxed/simple;
	bh=fS4gMp0xIvUnIK1yMcnq0c3usucpTMO/KzzLNrOSvhs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mts1nDTjVTQvvHBOMbpIgqLCF7GiECVUW0/ux1uWO+Uq5pj9UpFxUR0GaSwvxYJlUVSaaf6x0su9UaHL7/7Y7JXPjcm94KFs3OnjT5hE5hDQPWCbiS/+AXPCzqYHd6iVfcV+LvbZHKn5xBocmgvmhaDPcPIQYdkWXL39KEixaQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dip+FC0n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB22C433C7;
	Fri,  1 Mar 2024 09:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709285364;
	bh=fS4gMp0xIvUnIK1yMcnq0c3usucpTMO/KzzLNrOSvhs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dip+FC0n8pJM5We2H9b3r7I26RtV6/FQrR/vq0S7Yv+AEN8RI6OvniGhp51dHTWLd
	 FvjXlW7EBbuYpbYNoyrI0vu9BsbAG5BUwG37KbFi+QQ+Qh03QKVQNHzD34a32pTmHD
	 jMQQLP6uLeo/viv0Kb+xL4BFZiaGgxWeBLNkZV0lkxgvB26PFFHOtRctbdQeAYoX2d
	 sGBGNblX6ozgfUYpmisoKedJiNzyume7I2jNwb/yRBKaog2NO/jsNfAdHSOhO/CuKU
	 gU1wnWrT6w2WErfafwV5CP7+Set0SqPkqHWHLrWFgUmbczRYEAwCKXAnTTEeQLVEr0
	 u29hrNqCNuRsA==
Date: Fri, 1 Mar 2024 10:29:19 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Frank Wunderlich"
 <frank-w@public-files.de>, Daniel Golle <daniel@makrotopia.org>,
 netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 4/6] net: phy: realtek: Add driver
 instances for rtl8221b/8251b via Clause 45
Message-ID: <20240301102919.6c858bb1@dellmb>
In-Reply-To: <20240227075151.793496-5-ericwouds@gmail.com>
References: <20240227075151.793496-1-ericwouds@gmail.com>
	<20240227075151.793496-5-ericwouds@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Feb 2024 08:51:49 +0100
Eric Woudstra <ericwouds@gmail.com> wrote:

> Add driver instances for Clause 45 communication with the RTL8221B/8251B.
> 
> This is used by Clause 45 only accessible PHY's on several sfp modules,
> which are using RollBall protocol.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

Hi Eric,

this patch seems to be a squash of patches 10, 11 and 12 from my series
  https://lore.kernel.org/netdev/20231220155518.15692-1-kabel@kernel.org/
and then modified, if I am looking correctly.

If that is the case, please set me as the author and add a mention of
how you changed it before your signed-off-by line, similar to how it is
done in patch 1/6.

Marek

