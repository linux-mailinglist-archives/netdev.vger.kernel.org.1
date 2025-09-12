Return-Path: <netdev+bounces-222471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972ABB54666
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 11:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A5216485A
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 09:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A96E26E16C;
	Fri, 12 Sep 2025 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+FbYwUd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACFE22F74A
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667824; cv=none; b=IM7FBWzs3mLlnrmkynUvSHFEsx1t8dsZVajla7OVHM9pwbtgMYxPUEcKD4opNo9+PqyKA0Dbs83T4qRzXldvtKo8AT+gxlmeSDddVSUR6S5kwSdkXffBRAQRBz5vnMSp9TC1L63mCo/VRqXldS5yDPmcwsnk3Vg/+Sdl3sqPZMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667824; c=relaxed/simple;
	bh=1dlRF1lAOSU3YZtQCMpzSHMErit4Ewn4JofzJYeYRKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vx7OBy9BZOKtHqucprCGH6mdd2mUlZn0eEUOsaMm6vcgXP3FTajsVmg+N8RTwPEdriPv45/I73lyTe4TLLs7PGACNiuISBOPLfB9ptDVTH62cP8uvn/xySeBMBFYxFbPt5N0hoZ1+bIWpQ2KD7CHYhiO61dAFpr2Zw6G2mqRdhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+FbYwUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE52C4CEF1;
	Fri, 12 Sep 2025 09:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757667824;
	bh=1dlRF1lAOSU3YZtQCMpzSHMErit4Ewn4JofzJYeYRKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G+FbYwUdWvxlSYV5YjgQM4Fbkz+6DzZX1dObtnZ6+HYXuI25jsyzevcM7g0DD8EJv
	 qzSdoEVH/9PB4Lwt4vZXObPmpf52gqol1rm2w/9MOMStNrHZ31yXqgWuoBDo4R9NUR
	 +9rPf5yw1nOm3KAyxl4NH+VVoqBrKzxMvk6MX8hozXOiWK4J6xq0ni8P25d2c7SdeO
	 dckIrgWsVWDyV1QE8tu2FBbDm0GhmkUtUSRlxnY8Otrss6D1rRqpZEaKxhq0nbDaQo
	 vajtLB+nMojncho+gJeLxwVy9uOF4/VeCI0+2jrIhB2afYY+J02ccfValADQbeChH+
	 hG1WFI7FXT9Zw==
Date: Fri, 12 Sep 2025 10:03:40 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, mschmidt@redhat.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Dan Nowlin <dan.nowlin@intel.com>, Qi Zhang <qi.z.zhang@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: Re: [PATCH iwl-next v4 4/5] ice: Extend PTYPE bitmap coverage for
 GTP encapsulated flows
Message-ID: <20250912090340.GX30363@horms.kernel.org>
References: <20250829101809.1022945-1-aleksandr.loktionov@intel.com>
 <20250829101809.1022945-5-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829101809.1022945-5-aleksandr.loktionov@intel.com>

On Fri, Aug 29, 2025 at 10:18:07AM +0000, Aleksandr Loktionov wrote:
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Consolidate updates to the Protocol Type (PTYPE) bitmap definitions
> across multiple flow types in the Intel ICE driver to support GTP
> (GPRS Tunneling Protocol) encapsulated traffic.
> 
> Enable improved Receive Side Scaling (RSS) configuration for both user
> and control plane GTP flows.
> 
> Cover a wide range of protocol and encapsulation scenarios, including:
>  - MAC OFOS and IL
>  - IPv4 and IPv6 (OFOS, IL, ALL, no-L4)
>  - TCP, SCTP, ICMP
>  - GRE OF
>  - GTPC (control plane)
> 
> Expand the PTYPE bitmap entries to improve classification and
> distribution of GTP traffic across multiple queues, enhancing
> performance and scalability in mobile network environments.
> 
> Co-developed-by: Dan Nowlin <dan.nowlin@intel.com>
> Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
> Co-developed-by: Qi Zhang <qi.z.zhang@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> Co-developed-by: Jie Wang <jie1x.wang@intel.com>
> Signed-off-by: Jie Wang <jie1x.wang@intel.com>
> Co-developed-by: Junfeng Guo <junfeng.guo@intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


