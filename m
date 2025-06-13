Return-Path: <netdev+bounces-197550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E39AD9201
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 17:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718EB16E5FB
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 15:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A801FDE1E;
	Fri, 13 Jun 2025 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hZXefQ1z"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06DF1FC7D9
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749829941; cv=none; b=N3zBp79j575rgOGvXzHM1CvWDoUuS5MhSaG/ClglHMlF/E4faLc5KQxe/YPdt5Uo2Zpk0UkAGguDr4lRpcIc7nR70etJKgSlBXQN948kPqoFyKiRXbZkzEIsAthBb5W15Vcrj6fSS4Rih+FUIfIo+KXVKTB0S9e0JkC7F7Xdsgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749829941; c=relaxed/simple;
	bh=Kev/MH7b3XzfIbzkgR1o2iu55NK3f5nafOrGO/KhEwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYqoGCLPXjYaA01mamI9oKIvwJATo11Tx57zFTpILc2+Ict0Iqyt8w5yCM76ti6mxIqJ03eUh8KTINpI1egcyYDsH8yTT+A6plGO+HM0BiY33VyyHAIpmumuaORHH7ugo0kYoz8j7tj7t+MKwWlOo2UHdaFtPYxcZledxVy8eFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hZXefQ1z; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2ac62524-e45f-4ef6-a8b4-01adfd1391c2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749829927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yV1sWZeZVf/FIQXque4O5JP0sG577Rz8Lj6jjxTnW8c=;
	b=hZXefQ1zsdCjt1DrWrZaHhu7+CM+Ie5JgTIalZx7nqY2js+eUhbVLFm+cSahtcLnRIBMtM
	6Sz8pXb9SRPlAlw2wYYU4/SHhLiAkOSjhVDfP9VYIdDUZ9PPtKK+y8h7nhiqz3VPpTXXrV
	dwMnBcwhhkVjWndrPKIgkldwS4zTTlA=
Date: Fri, 13 Jun 2025 16:52:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v6 0/3] dpll: add all inputs phase offset monitor
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, aleksandr.loktionov@intel.com,
 milena.olech@intel.com, corbet@lwn.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org
References: <20250612152835.1703397-1-arkadiusz.kubalewski@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250612152835.1703397-1-arkadiusz.kubalewski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/06/2025 16:28, Arkadiusz Kubalewski wrote:
> Add dpll device level feature: phase offset monitor.
> 
> Phase offset measurement is typically performed against the current active
> source. However, some DPLL (Digital Phase-Locked Loop) devices may offer
> the capability to monitor phase offsets across all available inputs.
> The attribute and current feature state shall be included in the response
> message of the ``DPLL_CMD_DEVICE_GET`` command for supported DPLL devices.
> In such cases, users can also control the feature using the
> ``DPLL_CMD_DEVICE_SET`` command by setting the ``enum dpll_feature_state``
> values for the attribute.
> Once enabled the phase offset measurements for the input shall be returned
> in the ``DPLL_A_PIN_PHASE_OFFSET`` attribute.
> 
> Implement feature support in ice driver for dpll-enabled devices.
> 
> Verify capability:
> $ ./tools/net/ynl/pyynl/cli.py \
>   --spec Documentation/netlink/specs/dpll.yaml \
>   --dump device-get
> [{'clock-id': 4658613174691613800,
>    'id': 0,
>    'lock-status': 'locked-ho-acq',
>    'mode': 'automatic',
>    'mode-supported': ['automatic'],
>    'module-name': 'ice',
>    'type': 'eec'},
>   {'clock-id': 4658613174691613800,
>    'id': 1,
>    'lock-status': 'locked-ho-acq',
>    'mode': 'automatic',
>    'mode-supported': ['automatic'],
>    'module-name': 'ice',
>    'phase-offset-monitor': 'disable',
>    'type': 'pps'}]
> 
> Enable the feature:
> $ ./tools/net/ynl/pyynl/cli.py \
>   --spec Documentation/netlink/specs/dpll.yaml \
>   --do device-set --json '{"id":1, "phase-offset-monitor":"enable"}'
> 
> Verify feature is enabled:
> $ ./tools/net/ynl/pyynl/cli.py \
>   --spec Documentation/netlink/specs/dpll.yaml \
>   --dump device-get
> [
>   [...]
>   {'capabilities': {'all-inputs-phase-offset-monitor'},
>    'clock-id': 4658613174691613800,
>    'id': 1,
>   [...]
>    'phase-offset-monitor': 'enable',
>   [...]]
> 
> v6:
> - rebase.
> 
> Arkadiusz Kubalewski (3):
>    dpll: add phase-offset-monitor feature to netlink spec
>    dpll: add phase_offset_monitor_get/set callback ops
>    ice: add phase offset monitor for all PPS dpll inputs
> 
>   Documentation/driver-api/dpll.rst             |  18 ++
>   Documentation/netlink/specs/dpll.yaml         |  24 +++
>   drivers/dpll/dpll_netlink.c                   |  69 ++++++-
>   drivers/dpll/dpll_nl.c                        |   5 +-
>   .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  20 ++
>   drivers/net/ethernet/intel/ice/ice_common.c   |  26 +++
>   drivers/net/ethernet/intel/ice/ice_common.h   |   3 +
>   drivers/net/ethernet/intel/ice/ice_dpll.c     | 193 +++++++++++++++++-
>   drivers/net/ethernet/intel/ice/ice_dpll.h     |   8 +
>   drivers/net/ethernet/intel/ice/ice_main.c     |   4 +
>   include/linux/dpll.h                          |   8 +
>   include/uapi/linux/dpll.h                     |  12 ++
>   12 files changed, 384 insertions(+), 6 deletions(-)
> 

Acked-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

