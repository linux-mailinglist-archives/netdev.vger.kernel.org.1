Return-Path: <netdev+bounces-96458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C89F8C600D
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 07:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8F71C20C58
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 05:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9435038FA3;
	Wed, 15 May 2024 05:09:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E54381B9
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 05:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715749764; cv=none; b=SrG4cwpYEQmlv2nminNFyloeKGjHqckWRLx3U4JKyG/UyDWM1Mvtl9zSb2kD10Txs+j/ADlNxd5pbEIQh0wEPCa4XBuzxKDi3dpEXzgeu3h3W67OimZrvcPd9qsusgzlVfa3nz+p1MVRFOjlPKuXQ7ZOKFhfBZ/dXFuVvIFEm4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715749764; c=relaxed/simple;
	bh=D9Je+R5rW7M6q7FkZECThPUxC6VeJiboQJ02QDX/4Eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNXC92z5ABAT/NaeL3wJAqoL03B17KVfFHhFRossItmGZelKu9G/uNTQiCcgx5MyaTcF9IjEoP6k1Uvv1yLpaPrdbJRYfxgt8Zwnb58LFU3XMi5W8NIESX4TeXAvu9Fw3PRgSUcn6ET8hfyZx2kDyK0tIIV/spsiLQLfZBLhf8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af258.dynamic.kabel-deutschland.de [95.90.242.88])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7A16B61E5FE07;
	Wed, 15 May 2024 07:08:38 +0200 (CEST)
Message-ID: <275f19df-f0c2-405c-9a99-7776a8565532@molgen.mpg.de>
Date: Wed, 15 May 2024 07:08:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net V3, 1/2] i40e: fractoring out
 i40e_suspend/i40e_resume
To: Thinh Tran <thinhtr@linux.ibm.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com, przemyslaw.kitszel@intel.com,
 horms@kernel.org, edumazet@google.com, rob.thomas@ibm.com,
 intel-wired-lan@lists.osuosl.org, pabeni@redhat.com, davem@davemloft.net
References: <20240514202141.408-1-thinhtr@linux.ibm.com>
 <20240514202141.408-2-thinhtr@linux.ibm.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240514202141.408-2-thinhtr@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Thinh,


Thank you for your patch. Two minor comments for the title: Please use 
imperative mood and fix a typo:

Factor out i40e_suspend/i40e_resume


Kind regards,

Paul

