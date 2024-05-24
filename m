Return-Path: <netdev+bounces-98032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 412668CEAF8
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 22:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72E721C20BAE
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 20:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E6E71747;
	Fri, 24 May 2024 20:43:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882B62C6BD
	for <netdev@vger.kernel.org>; Fri, 24 May 2024 20:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716583433; cv=none; b=pj1JMrGM5q1zVQH0yhTgTbTFv1uBuxZ2Xq6uk1XjqnXiR22c4H+7naGR15GrLmlNPoRxa9F1LJSzlQMBfMYhrvn89BGD+V1BuZRZzP3pd1hU+M0gkwDuAiSqhZHj6l/qP+LGWQLCJNhvvK2kayqmiHuyoj/ii3xvxQDrLnUj7n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716583433; c=relaxed/simple;
	bh=Y1xGltmnHHOM1bOPqx6u+x1XnNWXGSyiVw1PfsLIvb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mxGY4zQJ0gDClZ9OxKmLsaVx9HORp62Vgk13jYSklr3/19iakw8exP5KHlXgLRUz/VgaAlCHx0DTtWLub/rCEtlP2ZmSH45WS6BvSI5rcwVtPDSk8JSjppoU52kBS811n/qo5Ig3uhL4odSUBbqnRYEOjF/sQgy2NwBEywkq/68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.3] (ip5f5af1fe.dynamic.kabel-deutschland.de [95.90.241.254])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5A82861E646D0;
	Fri, 24 May 2024 22:43:12 +0200 (CEST)
Message-ID: <de98ffb7-91fa-4629-8429-8699c9ddea87@molgen.mpg.de>
Date: Fri, 24 May 2024 22:43:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3 1/3] ice: Extend Sideband
 Queue command to support flags
To: Anil Samal <anil.samal@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 lukasz.czapnik@intel.com, leszek.pepiak@intel.com,
 anthony.l.nguyen@intel.com, Simon Horman <horms@kernel.org>,
 przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com
References: <20240524135255.3607422-1-anil.samal@intel.com>
 <20240524135255.3607422-2-anil.samal@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240524135255.3607422-2-anil.samal@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Anil,


Thank you for your patch.

Am 24.05.24 um 15:51 schrieb Anil Samal:
>      Current driver implementation for Sideband Queue supports a
>      fixed flag (ICE_AQ_FLAG_RD). To retrieve FEC statistics from
>      firmware, Sideband Queue command is used with a different flag.
> 
>      Extend API for Sideband Queue command to use 'flags' as input
>      argument.

Please use `git format-patch`, and not `git show` to send patches. At 
least that is what I assume the unwanted indentation comes from.

[…]


Kind regards,

Paul

