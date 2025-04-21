Return-Path: <netdev+bounces-184474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63638A959D7
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 01:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D73F167E7F
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 23:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D3D22CBE2;
	Mon, 21 Apr 2025 23:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwerwgBN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185E9219A68;
	Mon, 21 Apr 2025 23:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745278998; cv=none; b=NPUJrAjlKn1cheK8CbyX2ZkjDU++9nXckwkuGfeBdApamJYSEswn6DxLCdLiOcnFZxdCj/w2hr9Gj2T3Q+6UFjy0zTJ1HCBdjvai8Q0SFQ5OCYpVilS3i7Rg7K6JxoERF/JojHU2fByVnokVQdqLocN8PMfNgQtMTa+u0+pZfl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745278998; c=relaxed/simple;
	bh=xeeOHiQmCewMvU5/2XDoaHNz2BGzcdbJPohQiaaKAgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WdnQpPHOJs4T0z8FwS9kKw6f3auFwaOmCGir+wkCQgnaKNvhOB3b9/cU3uCBgOtlhRbaJOlVkz60rigiA9FWvjpmvkpIdU+bIHig/xVNO4dtQf5zFXRw/YVSBA3sb3QBbhlonzHXQetkrudJfKkYrrhpxHW7c/utw/XtXdCUxFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwerwgBN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D67C4CEE4;
	Mon, 21 Apr 2025 23:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745278996;
	bh=xeeOHiQmCewMvU5/2XDoaHNz2BGzcdbJPohQiaaKAgQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lwerwgBNrKIM3h4p8C8Oc1iW4eOmXCmgBpjmITGovIDzIP/5hOod1SE5na8L11kU4
	 ZNSuobcDDE4PshrcRGARzTJ/ekBNhdpZCOhufVnZlDnhR9G7LgGikTFBHVKKYmssKG
	 e+Mw7mYLrkvaj7LRzYx6hNMmh7WxosKRhzg39SYFVKqiREhqvew6hGGFJ5yXs00FAO
	 zd+JLST472pk8jx2sG21RoafSCjEXThOoJzlOVX4mTUBi5m+I3Fw28Yq8zotQ0Y/JF
	 jtDsJXtOAoLxcJwTZZQGV9W47/AOHRjfxMokI98jl6Ql/i12Igbpvfp3kItEeWQVC2
	 pA55EzrncJ0Cw==
Date: Mon, 21 Apr 2025 16:43:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
Cc: Colin Ian King <colin.i.king@gmail.com>, "Pandey, Radhey Shyam"
 <radhey.shyam.pandey@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, "Simek, Michal" <michal.simek@amd.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "kernel-janitors@vger.kernel.org"
 <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] net: axienet: Fix spelling mistake "archecture"
 -> "architecture"
Message-ID: <20250421164315.5e09f02d@kernel.org>
In-Reply-To: <BL3PR12MB6571DC0AA8A521078E442E48C9B82@BL3PR12MB6571.namprd12.prod.outlook.com>
References: <20250418112447.533746-1-colin.i.king@gmail.com>
	<BL3PR12MB6571DC0AA8A521078E442E48C9B82@BL3PR12MB6571.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Apr 2025 05:34:01 +0000 Gupta, Suraj wrote:
> Please add Fixes

Fixes tags are for code bugs, FWIW, no need here

