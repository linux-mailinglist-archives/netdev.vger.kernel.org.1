Return-Path: <netdev+bounces-153155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 811789F7162
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 01:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87F8B7A0230
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 00:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDAEB676;
	Thu, 19 Dec 2024 00:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUaGFXk7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273F7320F
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 00:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734568511; cv=none; b=et+uF+oKLvg6/8RQiW+IeddydLXt13L6ULQgpM0h0/CmIM02scG2EmnravlLOoJsfbjTTVMxOyq9cxMWfcbOfl8ixe/UKwncCRXskZ8Dc2JV0WXbSWiSf+ySh9nJI11UjuSUl1Cwwmm+MrZNWPleff0ZGB41UDQcIecW6K2S5r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734568511; c=relaxed/simple;
	bh=TP3oPZc3J/eJr6O/WkLeZ2SOZM65kL+9NMxMFhQ0YwA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ETjObkGtpFZslqWbJ4qadKMa4I3SxwH6PIzC0h55XeFhhcgQ5GxAWoHU/KPY2pRhLyMBmLwvOoe5Pp5LQyaTEeLqIYu5GQ6McPryVptfz9scKzPy3vtURwR3+gRbLaU5dZ2B2Y8fgYtyMUJvdOMtHZeon3H5vwuYuI17u62kVC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUaGFXk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C68C4CECD;
	Thu, 19 Dec 2024 00:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734568510;
	bh=TP3oPZc3J/eJr6O/WkLeZ2SOZM65kL+9NMxMFhQ0YwA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NUaGFXk7sQIPy9cI698sBh3tTH39iARBuAHQ99kGH6M6E/RcHrdyjcCYVwnVjdM3Z
	 nl8TIUOhfx9mMfHOXeprmrVm/NFzUho02Dds0ww0GrboTrjZnS1FFvK8kabL+GLELM
	 jleK5ph7JzkM8DsN5rw713sYBO/VfTmT6VyNX0qxphYu5Sflhl2OWrvG9KG8Tqtp6N
	 J97Xb3/CC1eodoY5Ae3lGCM4o3RvbxppIsIUpDkMZNRRq2m3oIXfLP8siWYmOcXPvS
	 T99GIa+DVYZVhxNEVpaClnpMx5NIO+JdacJ1SUcGswCQn2+ktB+qo1Psc+0Vt8H1CW
	 EdTUKZb96m+wg==
Date: Wed, 18 Dec 2024 16:35:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Xin Tian" <tianx@yunsilicon.com>
Cc: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <pabeni@redhat.com>,
 <edumazet@google.com>, <davem@davemloft.net>,
 <jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>,
 <weihg@yunsilicon.com>, <wanry@yunsilicon.com>
Subject: Re: [PATCH v1 00/16] net-next/yunsilicon: ADD Yunsilicon XSC
 Ethernet Driver
Message-ID: <20241218163509.008d1787@kernel.org>
In-Reply-To: <20241218105023.2237645-1-tianx@yunsilicon.com>
References: <20241218105023.2237645-1-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 18:51:01 +0800 Xin Tian wrote:
>  45 files changed, 12723 insertions(+)

This is a lot of code and above our preferred patch limit.
Please exclude the last 3 patches from v2. They don't seem
strictly necessary for the initial driver.

