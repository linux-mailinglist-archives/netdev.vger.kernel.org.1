Return-Path: <netdev+bounces-76265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEF686D0AA
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 18:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CAF1B2508F
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 17:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752786CC0A;
	Thu, 29 Feb 2024 17:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnwAUUS3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DBF6CC02
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 17:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227856; cv=none; b=rCadXWzfVeJbyDnbO1MLXzVYVi+LDuMiIc1AjTpIPW4MpFqrDXfrH3Ri4YcYaip2elIsxLZ9yWDAii8kjGYgdwsVQVttLWUtlc54EKJUjch7sm7HMFb4rj6jmcVipVO1NttpG5FHX09k9H8gOTnIPLWeqrzt/NwMacgqQGPoleM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227856; c=relaxed/simple;
	bh=G7v78iLu3i6MjA2J/u2To+nA+Q0OZPSFGund0Z5H1m0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGn3+hDIFMgLf+rZrofOQMOWnujaHL7pvBT5tMS+It3wYg0UONYoK6h+Ey3b7fsUtkkwRZtB5u2qlWl2mpjj2oaWH2ZrxZnr7SZox9JtTx7B3wwmMKp7eZVb6csUyKaLyYddzrE/unSpmgnb72RN5TJZqmRlsHAl+YP9b/lcvBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnwAUUS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AABC433C7;
	Thu, 29 Feb 2024 17:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709227855;
	bh=G7v78iLu3i6MjA2J/u2To+nA+Q0OZPSFGund0Z5H1m0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CnwAUUS3XLlT5BwMYksV4I3lGAO7+LAXSLuexo+zWKBbp8hVpZBN6bLCPjg7cFKay
	 aTOHbRu7KEiLfJ8HCkBdHdZ0O04PsuaY7MZ7kzt9NG3TUtbpGdOmJE5a+v/YUsPEfx
	 jjHxgjkCIF30+0RUxmt9/PBDNVsMj4Oq2wRXZ661vedJ/SV3SeMp6/5L/NqoHym7XX
	 rBgRwft2S83QQcWS1GjuAfbSFHHDpdueIcPsMqoqvzHausijJ8P9wWAJgESdg+uZtR
	 GccXp3w+L4b3cij+eVSIYUq4mnX2wFMAB9rUHOJQc5CjF4TZfeTr3KLzxpZm3V/i8p
	 R7k1RqL3xVF1w==
Date: Thu, 29 Feb 2024 09:30:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
 richardcochran@gmail.com
Subject: Re: [PATCH net-next 1/2] bnxt_en: Introduce devlink runtime driver
 param to set ptp tx timeout
Message-ID: <20240229093054.0bd96a27@kernel.org>
In-Reply-To: <ZeC61UannrX8sWDk@nanopsycho>
References: <20240229070202.107488-1-michael.chan@broadcom.com>
	<20240229070202.107488-2-michael.chan@broadcom.com>
	<ZeC61UannrX8sWDk@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Feb 2024 18:11:49 +0100 Jiri Pirko wrote:
> Idk. This does not look sane to me at all. Will we have custom knobs to
> change timeout for arbitrary FW commands as this as a common thing?
> Driver is the one to take care of timeouts of FW gracefully, he should
> know the FW, not the user. Therefore exposing user knobs like this
> sounds pure wrong to me.
> 
> nack for adding this to devlink.

+1

BTW why is the documentation in a different patch that the param :(

> If this is some maybe-to-be-common ptp thing, can that be done as part
> of ptp api perhaps?

Perhaps, but also I think it's fairly impractical. Specialized users may
be able to tune this, but in DC environment PTP is handled at the host
level, and the applications come and go. So all the poor admin can do
is set this to the max value. While in the driver you can actually try
to be a bit more intelligent. Expecting the user to tune this strikes me
as trying to take the easy way out..

