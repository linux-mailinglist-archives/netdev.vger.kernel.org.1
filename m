Return-Path: <netdev+bounces-78023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A4F873C55
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102951C209CB
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A7B137C3D;
	Wed,  6 Mar 2024 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTHVy4O1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60DB132C16
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709742803; cv=none; b=Pm9dPqejAd7PARHyjywoLODBbyuogdnaUjp/5WxlEnv3/Ak3SviPjFC1ZpS2gw4uHU+USu5+HlIpdYYzsnv2J9dNtcWoIiHABH7jHOvnSneYgyjmJIInBBBDaOsD23xasgK1xEF+uthCIEIAkvD/GFijoi+eopl47CIwgRxtDqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709742803; c=relaxed/simple;
	bh=NMp5czpSu7H9TKRU6xdaTs4cW76iJkTV9KiY6a4F1xg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XuQCTl+/xPaW2F/68m3xfE+ivWVCYQOWVoZGFYsdYFJonAP0VNyD+6ddkrVVtF0mtDlcjb3ppAl3bvNXhODkh5sZlQzlNVr9tY61+ZAYkTjR4KRp25zF8w9FX92+OncaqsRwzgFcY5jPdwEbmc2GtRYLOksxHdlYAcM2gB4Tsnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTHVy4O1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F86C43390;
	Wed,  6 Mar 2024 16:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709742803;
	bh=NMp5czpSu7H9TKRU6xdaTs4cW76iJkTV9KiY6a4F1xg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dTHVy4O1ua86e8s5s3QgmaH/o7ZdjePQSaHT6vd+9tU+Ptj51kC3XYu2qfheh03jH
	 1CR/1bdu1s83lnNA+tJMFcfX+MOq9xWdX2YCxqURKdlH18hBaDhAvJ49iHeezoK8PK
	 oYW0jRBJj+4Og+9VSyMJX8A/n0K8z2M4tFY1iZ9Wd0j5knrLxzA5SPXz02jIUuEWZI
	 mgjHaL5io862kiEY4qk0GWSOugHsCg9rj4YNl0yYfp/NIC9woWGh+zVO8doOVYeEpy
	 TMHTj/Q0v6h8FHaGiyGvL3Yd6BbVhUgKLLZoDZ74a8W4XR8b+sywcPL6bb6suDWeY9
	 p9hzQzhS1ukyg==
Date: Wed, 6 Mar 2024 08:33:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jacob
 Keller <jacob.e.keller@intel.com>, Jiri Pirko <jiri@resnulli.us>, Stanislav
 Fomichev <sdf@google.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 1/5] tools/net/ynl: Fix extack decoding for
 netlink-raw
Message-ID: <20240306083322.73fa19d3@kernel.org>
In-Reply-To: <20240306125704.63934-2-donald.hunter@gmail.com>
References: <20240306125704.63934-1-donald.hunter@gmail.com>
	<20240306125704.63934-2-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Mar 2024 12:57:00 +0000 Donald Hunter wrote:
> Extack decoding was using a hard-coded msg header size of 20 but
> netlink-raw has a header size of 16.
> 
> Use a protocol specific msghdr_size() when decoding the attr offssets.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

