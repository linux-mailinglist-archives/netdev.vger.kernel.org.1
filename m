Return-Path: <netdev+bounces-149640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049CA9E68EB
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 09:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B25282BE0
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 08:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1151E0DE6;
	Fri,  6 Dec 2024 08:30:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621011DFE0C
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 08:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733473800; cv=none; b=pJ+vlSyFiW7JgcvpD+ld0seskL+YuDDxx1Iu6cefbMZi8Fp/G/HkJE34WMBHNUlsR58NhQIk8FyjPGmepKULn22VDUmyTrWM9J92Iyetht3NTwb0KXsMT4ugZKk+jzdGhR7g3007y7Lcxuexx/hAtgeNHL+JgruBpdrlHxd/riM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733473800; c=relaxed/simple;
	bh=8+yEJ4VEr39pVuOoqokIdkLg+hEpjU4YH8nfKNLr/6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c3FQIkhDsOLPYS0RjjG/FLS3WcyJJXyz9nXqkst+KbRkljJNAI7pzuJz+8wZ9JrS3YS5EGGfC4FTuxxFW295a2YR5TuH57MiP8/eyPvgpX+5NLW7uc4wgbrOwNQ1XFj+acax/W2ua+dBSUoIYXQlFzRTDxCs1ZA6ayD5PRnHroA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5ae850.dynamic.kabel-deutschland.de [95.90.232.80])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1CA7F61E5FE05;
	Fri, 06 Dec 2024 09:29:31 +0100 (CET)
Message-ID: <c011ef8d-04c0-485e-8fd9-e05952bfef82@molgen.mpg.de>
Date: Fri, 6 Dec 2024 09:29:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH RFC net-next 2/2] idpf: use napi's irq
 affinity
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20241206001209.213168-1-ahmed.zaki@intel.com>
 <20241206001209.213168-3-ahmed.zaki@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241206001209.213168-3-ahmed.zaki@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Ahmed,


Thank you for your patch.

Am 06.12.24 um 01:12 schrieb Ahmed Zaki:
> Delete the driver CPU affinity info and use the core's napi config
> instead.

Excuse my ignorance, but could you please state why? (Is the core’s napi 
config the successor?)

> Cc: intel-wired-lan@lists.osuosl.org
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf_txrx.c | 18 ++++--------------
>   drivers/net/ethernet/intel/idpf/idpf_txrx.h |  6 ++----
>   2 files changed, 6 insertions(+), 18 deletions(-)

[…]


Kind regards,

Paul

