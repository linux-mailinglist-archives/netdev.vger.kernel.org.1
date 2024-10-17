Return-Path: <netdev+bounces-136769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9169A3172
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 01:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B149D1F225B3
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 23:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446F720E30A;
	Thu, 17 Oct 2024 23:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DJYiwnev"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6942E20E302
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 23:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729208310; cv=none; b=RPED47iPt3k7pkXGJ+gY6TvPiGXXzNuDvewaH8CzA/4vNPd+ZeFSzAznFgTd8SBGGAeFfdJYgxNRYlJS+x2UP1DK4cPigQiljPs525NAnK3MQeDV1+pTkZBrR09uSIROkDXwR5eWz382mnCTUEegIB+tTFHohN6Js4PZrnXH6dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729208310; c=relaxed/simple;
	bh=RY9jgdBrDAzCz3+ixeKHMGe7x7hDmSHm/tRdSOZXLYw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pbnpAXLlr0vySCmkyireSEbPzSX3wY0SlhvovO6VrRNCk59LXIQr2CpVGbbp19ebQKga68fGUoqva0RricQBFNUd/LB24oN1+cNUV3e93k6kqXc8bEwyoHZADG75P5Q1LOYQE7CQ710rzD3hkwA8+S/m5g1UVYje8TJiO+DgRtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DJYiwnev; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729208308; x=1760744308;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=RY9jgdBrDAzCz3+ixeKHMGe7x7hDmSHm/tRdSOZXLYw=;
  b=DJYiwnev6bL9FFHqvN2VPggimTkw5yiEjNf+48Ed8FymCng1Mlndaq+H
   bC6P+i1hxlKkHr5TFsjuXuvs1POQ1/msojzt6HbluQqFyAOl5oBvMm6+h
   vLsHngsK0wEBn9Rws7oOwps0+dLvOgVowoLwGnh8jVngV/YUTW7tQg90z
   2MLisw2Xe4eyYs1tcMvLzzcSZerJ2dIsurNUS0rIWAkUDOUAomKqzDYU4
   CjRjaRPrA7p4RXpkQ8n0PXvEkeLxGex4K6Ekcsiz8A/fHbylGI4ijqSe/
   0wg34A1k8F2Wt0SXKss2brRJEsk1xydUZRav86k2tbjcxwt0SN2rBPKzZ
   Q==;
X-CSE-ConnectionGUID: 8/txB3r7TkOfFuq13F8iBg==
X-CSE-MsgGUID: S8c4n5viQoKvDaxZwhlmgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46185190"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46185190"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 16:38:26 -0700
X-CSE-ConnectionGUID: JaNmBY9aRDaEvGeDVvoMSg==
X-CSE-MsgGUID: ej+BuXEATr6Pkiwzs5zBTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78613563"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.222.240])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 16:38:27 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: Pending taprio fixes
In-Reply-To: <20241017112546.208758-1-dmantipov@yandex.ru>
References: <20241017112546.208758-1-dmantipov@yandex.ru>
Date: Thu, 17 Oct 2024 16:38:25 -0700
Message-ID: <87a5f2cnbi.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Dmitry Antipov <dmantipov@yandex.ru> writes:

> Just one more friendly reminder.
>

Taking a look at:

https://patchwork.kernel.org/project/netdevbpf/list/?series=900198

A couple of process related things jump up:

  1. The subject prefix was not set in the "cover letter", so perhaps
  people/tools didn't see them as patches that should be considered,
  also the lack of "net" in the subject prefix, made patchwork to guess
  wrong, that this is targetting net-next;
  
  2. You missed people from one of the patches CC list, running
  get_maintainer.pl on the patches helps here;
  
  3. You didn't add my "Acked-by" to this version;

Most probably, a mix of (1) and (2) was the reason that no one else
reacted to v5. I should have been more clear about those.


Cheers,
-- 
Vinicius

