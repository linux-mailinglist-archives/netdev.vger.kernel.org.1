Return-Path: <netdev+bounces-222611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C10B54FC6
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 15:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB9533A819E
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 13:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2003009F0;
	Fri, 12 Sep 2025 13:38:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3564227BF99
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684316; cv=none; b=fY/5v0N9V4vyJR/Qu+iiMi5jh2V2+5Qp5OABjaBQYIZjpc0rwvmBplICWmwOw6Btmq1AOA7xFswW7hyWJy5hlgGFQaLKGnvnnyL86o+q8Fd0CbXLxi9D+rhFQAVs6pWmHSQegpFnH3x44iQerFQt5i2jPXKCW2CK6NgaVfv4jDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684316; c=relaxed/simple;
	bh=m8hDtabwL7VKyzBqF0KTgZUZXggY8uR3cgcOA0ZDG3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHakkxpUkbX9YZ3OfrcM1K5nOajO6CCOi9vLXqdUeXeIYOyqIlCb4XfPV/pOgSNtu16GXSuDGUwfpnlhBiSpapFM8gwj3JyxZK8/SEPPItSWvepz7xwHcwxQ0woMmz+cVFCpI73zLAjJfn8etcXOIXVa93iFt74HtI/Cv1jM2k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3DBE260288278;
	Fri, 12 Sep 2025 15:37:45 +0200 (CEST)
Message-ID: <96bda8cf-a1c8-4492-b4f0-d2783b8880b0@molgen.mpg.de>
Date: Fri, 12 Sep 2025 15:37:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 0/9] ice: pospone service task
 disabling
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
References: <20250912130627.5015-1-przemyslaw.kitszel@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250912130627.5015-1-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Przemek,


Thank you for the patch. A small nit for the title/summary: Pos*t*pone


Kind regards,

Paul

