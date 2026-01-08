Return-Path: <netdev+bounces-247948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A46FD00C0C
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 03:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0103B3001605
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 02:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FCE271476;
	Thu,  8 Jan 2026 02:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TchdeuRY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C81626B2DA
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 02:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767841181; cv=none; b=FnT1m5C/SYDIpfshfYabWVlqhjH6lil61BQ+WYrQ3GdLIqMZ/DFP85bo7gOOICQioPoa/GTPQSQLGr3ClefT8Z+GlBNJkMT845BEuUQ15Rkn5HdhRSOXdVU9RAKaxj8oJRd6sWMxvJ4cGLve4BAE3etSIz+A/M1vB4hq2JOuw9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767841181; c=relaxed/simple;
	bh=+LILPT9wLbAT/UWPMuAt68UAKN/zBs7JVAfx11iwUCg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDXYq9SmgFs7A6/JPyxv6y8ek4bRFvgm3v79uS3vnSExdMK6+cBQ/ECgwG75mJK4cAQgMFNq4p2YP8T10M7pxgu2qlL6Quvs/awcuE9zYrPlA+MiKIGs+UCacYZNTVz3lcKPR3V+fGCuhBeuOIoKmwpfmK7lZjKuFNdLe91deX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TchdeuRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4C8C4CEF1;
	Thu,  8 Jan 2026 02:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767841180;
	bh=+LILPT9wLbAT/UWPMuAt68UAKN/zBs7JVAfx11iwUCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TchdeuRYpLSNMpxDUWg/hN08NLr/7TTW54RixZhzMBp/gLuYA+3wYf0R4QX5/uOLJ
	 Kd704prfX7uv20VkI3830RsfOsjh6uowHD6eOJwDWtFAlxXnQUir8obaVItQPJJ1lN
	 UqY9K7gZqniQax9YhUH4z7tync2D1zjkVbBVwzAQsQ3wWta1XLjcbeVYqErsC3W09w
	 AJrdiSWX8rHenWjKwzjVMf1hf/cuN3KAi+y6AiE0gyP7hdw0LANe+NfgHZYKFU09PJ
	 MVwe8+YljAFAoxbSSYq9MG0LqiFAE8qKc8tR1eUagP1aCwa6ia3yDW4gyagBALSu1h
	 W93gRipqDy0YA==
Date: Wed, 7 Jan 2026 18:59:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: usb: introduce usbnet_mii_ioctl helper
 function
Message-ID: <20260107185939.56164605@kernel.org>
In-Reply-To: <20260107065749.21800-1-enelsonmoore@gmail.com>
References: <20260107065749.21800-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Jan 2026 22:57:48 -0800 Ethan Nelson-Moore wrote:
> Many USB network drivers use identical code to pass ioctl
> requests on to the MII layer. Reduce code duplication by
> refactoring this code into a helper function.

Please remember to add the Reviewed-by tags you already received to
the patches when reposting. We're expecting all the patches you
submitted yesterday to be reposted with the appropriate folks on the CC.

