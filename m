Return-Path: <netdev+bounces-209889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46485B1133D
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 23:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00D157A4E0F
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 21:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B47123A98E;
	Thu, 24 Jul 2025 21:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6xneH2l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FC521858A
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 21:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753393248; cv=none; b=WzEVv3XpnIRtsxuLqEYV076XtAaLXsWkgiyPXPc/79YWS3DxASA85zJB5nyAPdTSRb4lYxP6RAdl5JI9OTiK3Zi3JHrrHbBopuB0D8T2JU3tV8YHbJH55pS3Vop9g9C8s/pW+hDAtSt0+G4hAqzVGfl46/ozmYdRbz9lrGWb4dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753393248; c=relaxed/simple;
	bh=MoCMnJLji+Sf7mQ/n/4Eczfk3vdYbBh5Cr7va86s5So=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2Lo63Sdke1ok1qQ99IRofYKspUCBjxtj+NQB1gPwrdiaxXU8XBlj/r5q0Um/dn6gsyj91BeV36B0l3hcBnsdPhzZExQcI9GnwPxj2VtU5JO2vIzSjqD4l6EEzsVrwlPUeGNx+BCsfvyufGcd5nEPexpGoEWe0luIoiHeOtXhy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6xneH2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65001C4CEF4;
	Thu, 24 Jul 2025 21:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753393247;
	bh=MoCMnJLji+Sf7mQ/n/4Eczfk3vdYbBh5Cr7va86s5So=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e6xneH2lYd99YDN5jXEBmeoAkGfDtW3lt/KY6uMEh3ObHUS79stFm1I2gCqj1rYwl
	 9PhGzj1UZ5Lo+eopYraXYaL8haTQhNT5YhJz0TmJblgt/F2mXqgtdXn3+vHCPS4knt
	 yLLW+BqT8iNYmO9qOe305figs2hB4lcee414qJhVrdqHN4A76ando29sGiCb7LAZlm
	 cGVQ91j+u7p0a4pt69JlCcUgG0y15cgSe+Kf26CpM/NJ07lI8CRzJOrUar/A0+kru6
	 CzFMzE6hQl87FRXFBDj+iNSxaw2xdIWXcXw1ahZHll8oZSWfI5bLb2qXB6YOmIyprY
	 9/sd9htFCe3/g==
Date: Thu, 24 Jul 2025 14:40:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 1/6 net-next] net: uapi: Add __kernel_sockaddr_unspec
 for sockaddr of unknown length
Message-ID: <20250724144046.36dd3611@kernel.org>
In-Reply-To: <20250723231921.2293685-1-kees@kernel.org>
References: <20250723230354.work.571-kees@kernel.org>
	<20250723231921.2293685-1-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 16:19:08 -0700 Kees Cook wrote:
> I added this to UAPI in the hopes that it could also be used for any
> future "arbitrarily sized" sockaddr needs. But it may be better to
> use a different UAPI with an explicit size member:
> 
> struct sockaddr_unspec {
> 	u16 sa_data_len;
> 	u16 sa_family;
> 	u8  sa_data[] __counted_by(sa_data_len);
> };

Right, not sure how likely we are to add completely new future APIs 
that take sockaddr directly. Most new interfaces will be wrapped in
Netlink. I may be missing the point but the need to add this struct
in uAPI right now is not obvious to me.

