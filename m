Return-Path: <netdev+bounces-228999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E591BD6E3D
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 02:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13FA64E1188
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 00:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1651DF256;
	Tue, 14 Oct 2025 00:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkWzlATB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B8734BA45
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 00:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760402605; cv=none; b=a+6CJykofvHyjsfDDiDQizYZRwpvXdLNE0NGa0VWCWXARyQEffsjfkqToinw4GkDIqcEwfn1csypHPoah2WbCaJW0cSKR1EnzvDBTyP7UIJySl8NBOumKkbSSNSfKASt+8puB+MIv4ctVd6GAVCQ/zAOSfzuFV5OjBBWJek3Gdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760402605; c=relaxed/simple;
	bh=i0ZQc4FeGJYeBiqxvsz8IBpcRryS2crIq9CSFWVGYe8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VgwcEJtaBZiw3YTVM1VSYZsDBNjRvrL6c8cF0U3Uz/i+ZhRTPSJPFVRKwi+LCaRYGAanNTQ7xs4gjN+NgdS5kvunGkbpJh8R9zsuRbOOKqlcULH5UJ/0bjZL29wCfK5R9VW7ZAZAXZDuMdjpDmGMaUd8A4n/UpCKVbMCSZpIiog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkWzlATB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C68C4CEE7;
	Tue, 14 Oct 2025 00:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760402603;
	bh=i0ZQc4FeGJYeBiqxvsz8IBpcRryS2crIq9CSFWVGYe8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UkWzlATBP+g3a0DrMY3gzC/alWY2H/BVpEydx+xaoa2KWuFrnII30TyeJn0aQOqXH
	 UlidPcMEpt6rSKaAEIGTOc8m/Sg7oQux4hMv+mrzvrmYduYBOTNeh8/C/bxgcu4h+O
	 BhyPC0WkGy1dpSP2egTKId4crQzjQOi6ZmEFx40l2Zb+GycvuZkKKP+Jc0wdtY1MOQ
	 DoUQYaafBxwjaSFmQWA0hcxkTA7v0gB8voli4SJpLNKMpx/VcEiaY76U/K9TV0hP6q
	 2kAtgyZDUwKS5kVtGpOUm6naXOPkxv6AEGXRAolCrcCtFtX6gh/OfmxZO7Q4qA233l
	 hCWVRBp4kGM8A==
Date: Mon, 13 Oct 2025 17:43:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kamil =?UTF-8?B?SG9yw6Fr?= - 2N <kamilh@axis.com>
Cc: <florian.fainelli@broadcom.com>,
 <bcm-kernel-feedback-list@broadcom.com>, <andrew@lunn.ch>,
 <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net v3 1/1] net: phy: bcm54811: Fix GMII/MII/MII-Lite
 selection
Message-ID: <20251013174322.1cbffbb8@kernel.org>
In-Reply-To: <20251009130656.1308237-2-kamilh@axis.com>
References: <20251009130656.1308237-1-kamilh@axis.com>
	<20251009130656.1308237-2-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 9 Oct 2025 15:06:56 +0200 Kamil Hor=C3=A1k - 2N wrote:
> Signed-off-by: Kamil Hor=C3=A1k - 2N <kamilh@axis.com>

If "2N" is a company name - going forward please use the preferred
format which is round brackets:

Quoting documentation:

  The canonical patch format
  --------------------------

  From Line
  ^^^^^^^^^
 =20
  The ``from`` line must be the very first line in the message body,
  and has the form:
 =20
          From: Patch Author <author@example.com>
 =20
  The ``from`` line specifies who will be credited as the author of the
  patch in the permanent changelog.  If the ``from`` line is missing,
  then the ``From:`` line from the email header will be used to determine
  the patch author in the changelog.
 =20
  The author may indicate their affiliation or the sponsor of the work
  by adding the name of an organization to the ``from`` and ``SoB`` lines,
  e.g.:
 =20
  	From: Patch Author (Company) <author@example.com>
 =20
See:
https://www.kernel.org/doc/html/next/process/submitting-patches.html#the-ca=
nonical-patch-format

