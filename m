Return-Path: <netdev+bounces-207154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA42B060E9
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144645A3B19
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 14:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84942EA49A;
	Tue, 15 Jul 2025 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBeuho25"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49F52EA46C
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587976; cv=none; b=mRbcKPiA5yGRnwdaQgsrvPm4SJhnCpyzgCTAM5YO/kUo9iMPMgVdMzUppK/1ojYIgTdeFKfNGfwybI9+K2tzl580OjbdwjSGmJbpTIrSAeC9FZ+cWoTLnsKYphk05qI0mptNFchE9dasdRA0Zwha/avaPSUp6vrn+yVyJ1Ie+6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587976; c=relaxed/simple;
	bh=OZ1hiqZeBKgUIMkAXqi7zCNzjqlLMQ1sScP7GggRFQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kH/Wt0XgW8ZzrVI02adk5wrhvWv8CmcoM7IQE2nLaVr2cEk4NDR74wy5o5xFgCiSh74uZalfR1y8NrdEhdBGF4F4WegG5vqC/liQSWG6qCbsSb3ejvxMpicUiyEKGP7Y44OMzIzLweRWf+T1Pr8JW1TZJWGg98byjt8dakOR4iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBeuho25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CDCC4CEE3;
	Tue, 15 Jul 2025 13:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752587976;
	bh=OZ1hiqZeBKgUIMkAXqi7zCNzjqlLMQ1sScP7GggRFQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qBeuho256xmpmRgnuaGI4r9cWmmNlWETKmY8pP8Jq6lebcXDNOJvCvezyBiR32iM7
	 2SvkYlMS1SZ1yvI3fCN1L3KT0ySZNEAfCYNO/qAAh+9WjffOd8NaWxfqoid5o+pKmK
	 xCeRHhS3ZXe/EK0/lAdpXEK5xLdqPaEK54QSZImbVdSAyJScaATaZKLTPRILx5AA30
	 usSAMfGkYLS6LKK4G2TyQz9GdkDUvNmz2zqLBjEIRwW+hSaKlGSkhsJZXvOkOfX6ex
	 BCUzORUgxp41hpQ34r6/5WyV3047MSup2xdaiFQF5vmB9HJ877i2Puji/DxrnEv3ci
	 tKB2hEu9vkzpw==
Date: Tue, 15 Jul 2025 14:59:32 +0100
From: Simon Horman <horms@kernel.org>
To: David Wilder <wilder@us.ibm.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, pradeeps@linux.vnet.ibm.com,
	pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
	haliu@redhat.com
Subject: Re: [PATCH net-next v5 7/7] bonding: Selftest and documentation for
 the arp_ip_target parameter.
Message-ID: <20250715135932.GZ721198@horms.kernel.org>
References: <20250714225533.1490032-1-wilder@us.ibm.com>
 <20250714225533.1490032-8-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714225533.1490032-8-wilder@us.ibm.com>

On Mon, Jul 14, 2025 at 03:54:52PM -0700, David Wilder wrote:
> This selftest provided a functional test for the arp_ip_target parameter
> both with and without user supplied vlan tags.
> 
> and
> 
> Updates to the bonding documentation.
> 
> Signed-off-by: David Wilder <wilder@us.ibm.com>
> ---
>  Documentation/networking/bonding.rst          |  11 ++
>  .../selftests/drivers/net/bonding/Makefile    |   3 +-
>  .../drivers/net/bonding/bond-arp-ip-target.sh | 179 ++++++++++++++++++

Hi David,

Perhaps this has already been covered, but if not,
please run shellcheck over bond-arp-ip-target.sh and
see if any of the issues it flags can reasonably be resolved.

Thanks!

