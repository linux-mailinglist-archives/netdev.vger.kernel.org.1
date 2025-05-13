Return-Path: <netdev+bounces-190171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2967EAB568B
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D38863015
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 13:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEA028F937;
	Tue, 13 May 2025 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UvzYMTzx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31C728D827;
	Tue, 13 May 2025 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747144507; cv=none; b=M7+uGvRCphJ/WJr6TNtYTru31J/5JGsvsm1gngOga41NBVP8rQg/GZ0k+OpLj6qTJEMUEbxZnwO5wXk098G7058cXZp6c6WcghiiqLtEYO0dLcNigVQ+Nx23pfIvHvQajUHlrmF6pX7HSScsa+7m9oGfOcNtFbSnwD/C2hk2m4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747144507; c=relaxed/simple;
	bh=kKIjOmw+tzOAdv1WgTckM5jUXEQMA06F5Lq5DwBDtnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TpnzcvqFWKpRfvRl/UKgi17lNbbYeqbSF6Qq69atgwOMFYjGANTW80CWedlnM+U809GY4Ggs3o8sxVDx9Q5h3zUZRzLggyAz3GS09qvjpiotz7t0NGEmPW6o2+YYy0cQBGAKXCd8PMhoIhB4Qy8n4Y8NBDZh5l0jVuEfOt/MrPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UvzYMTzx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747144506; x=1778680506;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kKIjOmw+tzOAdv1WgTckM5jUXEQMA06F5Lq5DwBDtnM=;
  b=UvzYMTzxM77+JjPozqRyuk2QTZS3RB0+44Fw76D+ne1CfdagPyxtg6mU
   YsPls7t7Eb3v+Koiu6VRqGqOlzRZdwkgYlY/MCxsTb2+aZ/hkbC5wHPaH
   bySYOW5AwVJ02/uXiY0PqjrDyzyxrKV2Z+SidlUeFbpr7AwsM0d+bQb9v
   UABRSIEiQdg8Y5QLuDVqGS/t8uoNs1rqyHrP5Coz++HXSPFWSRFQvMzrm
   eRvzY8RnM0HZHYx4ycj1iQ3UOv1dPKlkBmK7oqJ9MaYKqXl49hs8guLSE
   piX/g7CnNqcA50TkPaSJL9pYqHZzZEsNiEl9CZDh2X9DVhz+n5zAq4Kjy
   w==;
X-CSE-ConnectionGUID: HRaNtO5MSDiAiaF3tjgCLA==
X-CSE-MsgGUID: r5qlCw3ASMiDKccbN2qFVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="49108497"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="49108497"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 06:55:05 -0700
X-CSE-ConnectionGUID: 7XxQKHkaTE6S7XI3NYacNA==
X-CSE-MsgGUID: 0AYzIPiiTZKaWICIsKL6IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="168649104"
Received: from soc-5cg4396xfb.clients.intel.com (HELO [172.28.180.78]) ([172.28.180.78])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 06:55:02 -0700
Message-ID: <a5274434-83db-4fa7-b52d-a0ca8dd16a68@linux.intel.com>
Date: Tue, 13 May 2025 15:54:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ixgbe/ipsec: use memzero_explicit() for stack SA structs
To: Zilin Guan <zilin@seu.edu.cn>
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net,
 edumazet@google.com, intel-wired-lan@lists.osuosl.org,
 jianhao.xu@seu.edu.cn, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, przemyslaw.kitszel@intel.com
References: <170f287e-23b1-468b-9b59-08680de1ecf1@linux.intel.com>
 <20250513133152.4071482-1-zilin@seu.edu.cn>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <20250513133152.4071482-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-05-13 3:31 PM, Zilin Guan wrote:
> If this change is required, should I submit it as a new standalone patch,
> or include it in a v2 of the existing patch series?

I think you could include it with the v2, as it touches the same stack 
SA structs (if you decide to reuse memzero_explicit() on them).

Thanks,
Dawid

