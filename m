Return-Path: <netdev+bounces-222610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F741B54FC4
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 15:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA991189C2EE
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 13:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949003009F0;
	Fri, 12 Sep 2025 13:38:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F87296BD0
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 13:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684281; cv=none; b=rNKzRmxEl3pH+RSZqxNQlhKMnPc69yy+AhomkI1r7FbEI7oLqIKDd90rqxoaF20fnXh+mIH8K1pV5nNhgxPgGvabRz2t4o6satdh4sJpnCCIzFZcyq8NJKhI4ewJEu/Hs2iqiCh9kh8xlbhb9ilJKExosPUcXS5cLDKIoK2p2Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684281; c=relaxed/simple;
	bh=xVb33XAMUaUSqsZIrrpQg9ovlvXW4WU2Epbr5zau7JA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qIUIBAY2vFMW/k6YQQFYmSvZpzEN+VnpipSAM9ZPqD1LECYK11KdvF6xc3hMhalGtIzcJ+E5O2a7zqlUe8CTSgfsp+QFfdDQfsx5/ukmqZkzVHruIPObcQfzOgIksm77bkRT8QsRPxL0aNkGa08Uv2sQFsWNMcUF3f5wWXoQuag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id AC59C60288277;
	Fri, 12 Sep 2025 15:37:27 +0200 (CEST)
Message-ID: <0438e3b9-4ada-4dc7-9ecb-e5e6a69db027@molgen.mpg.de>
Date: Fri, 12 Sep 2025 15:37:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 1/9] ice: enforce RTNL
 assumption of queue NAPI manipulation
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
References: <20250912130627.5015-1-przemyslaw.kitszel@intel.com>
 <20250912130627.5015-2-przemyslaw.kitszel@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250912130627.5015-2-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Przemek,


Thank you for the patch.

Am 12.09.25 um 15:06 schrieb Przemek Kitszel:
> Instead of making assumptions in comments move them into code.
> Be also more precise, RTNL must be locked only when there is
> NAPI, and we have VSIs w/o NAPI that call ice_vsi_clear_napi_queues()
> during rmmod.
> 
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> CC:Larysa Zaremba <larysa.zaremba@intel.com>

That address is not in Cc.

> ---
>   drivers/net/ethernet/intel/ice/ice_lib.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

