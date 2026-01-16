Return-Path: <netdev+bounces-250402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA5AD2A463
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E1163012A52
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 02:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8465338925;
	Fri, 16 Jan 2026 02:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oED/Xl1X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9448A338920;
	Fri, 16 Jan 2026 02:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768531436; cv=none; b=Fw/Pne94sjeRrHH0bsP3keGDybDkqglIn98tCJinVKzNk1kDajaW8+Dp5laY5+9LqeGgLcvfeVg56QiCE+w5p/nqS2fQYso/wyYwY4gyZAL2D7gzN0hgg54Y5uU3i//czXMFL0iQ7+QCwm2H025Dnr07xbRle/E4vbwxt3kEBc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768531436; c=relaxed/simple;
	bh=HnFx0WtFt9Deh/PFDnmBauXLNGIOgaT+pj23iARpuGc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQryz7f2c05A2p1EGvWTCce+GFbDCbbaA5GfF205OMZDmku4mVbeZuZI79wrm50Eg8/d/cFFbUe7nV9OAzqrRk5n8rLz3NXTcBrHzLYPW9y8luwD6svaeV6AOzAvxT7TkFCNkzcDmXm5bviR2Lb7RZCh+UOizG9iebL9+xA/1MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oED/Xl1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B3EC19421;
	Fri, 16 Jan 2026 02:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768531434;
	bh=HnFx0WtFt9Deh/PFDnmBauXLNGIOgaT+pj23iARpuGc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oED/Xl1XmDR4zsnx54w/QL4FQPbC/ioUIy+daiF19ZItPIV51WwfwSG8g/UefSWQO
	 E23kN8JvktyIxSx2tILMOO18GSIHpjbkZdSg+1nTk93L8Zkbfe2WLpw6uQAYbehKkb
	 cgl+u9UAc9rUdpDHgRK4Pxs44kK38eKDn1xR12r10v39c1Z7uvkHu9CYVYuXK2ieUg
	 e0iJuj62krH25/+mN+W1ObpjSkGPT7jf0CpHP+QN/199XbEWpJSAZHxvGl9ewv1JB4
	 JajovEvkaMWAU4cFyY3vRcpvinX2jiDqD3+gYulJxylASRyoYsiAVeosL8Da6OjHqM
	 h156s2Qx9ftrw==
Date: Thu, 15 Jan 2026 18:43:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Slark Xiao <slark_xiao@163.com>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, mani@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next v7 0/8] net: wwan: add NMEA port type support
Message-ID: <20260115184352.6dd62bb6@kernel.org>
In-Reply-To: <20260115114625.46991-1-slark_xiao@163.com>
References: <20260115114625.46991-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 19:46:17 +0800 Slark Xiao wrote:
> The series introduces a long discussed NMEA port type support for the
> WWAN subsystem. There are two goals. From the WWAN driver perspective,
> NMEA exported as any other port type (e.g. AT, MBIM, QMI, etc.). From
> user space software perspective, the exported chardev belongs to the
> GNSS class what makes it easy to distinguish desired port and the WWAN
> device common to both NMEA and control (AT, MBIM, etc.) ports makes it
> easy to locate a control port for the GNSS receiver activation.

I'm going to release the results of AI code review. Since you ignored
the reposting period with this version please do not post v8 until
next week.

