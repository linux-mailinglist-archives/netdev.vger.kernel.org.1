Return-Path: <netdev+bounces-248545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 01785D0B084
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 16:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B759303EE8B
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 15:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356E935CB7A;
	Fri,  9 Jan 2026 15:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EEALnieZ"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C63C313540;
	Fri,  9 Jan 2026 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767973617; cv=none; b=Y5J23c+7bTkPheIVdlBz8R1EOJ8aBexLzxPd2htpS9UKJu0hQGPIrgjjVNarTDuEuq4SEme7374I7cUvZjlRTiZrSnyvYZ91ZzPQPdXFBeIfg2fuVzt1x1e96QdFuzbg/zW2D9KmG5LewvX3gZFzgKPBI653GrT3vyDWmGvjDLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767973617; c=relaxed/simple;
	bh=lfUPqQ9+MiHYF8jxiM3CAd6qlZGyfNo22wgMcy8ioAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+Nyq+OEoAHeFrgtUMFEy2Eo9FkNMv089yDXNy5BEOsKg5PGMKyuSUGuYpDKvOMarHegyYhARhGCo6Gl5LtH1cgBcR7IPylJ2OvRLGTxCaviHsLUzz9Wt9sBxzNFI2d48IiL2ohuMLXPQp9qbwbXK7B+k+UXDO04K+4du8DcJ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EEALnieZ; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <65404ab2-b67d-4138-9aa4-b29fc77ed345@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767973613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vc/maUPZAp7DIDSLo/uhhCaMc9Kvj50L6oY3J/L/BcQ=;
	b=EEALnieZjoGdn0FT7Y3lAyTtqq85oEfoigG7XF/sAByqQBj32pHzi3niAOJD87Vo1R2a+g
	q9huNKPRLv1ccFn+YYBoqNjg1RNTksB63JyaVhLDXiPh7bFPkotHE2rLtRcz6LdFgt0mjR
	/zDy9q4V/fekD1h38aUIg9rmLfm/HiY=
Date: Fri, 9 Jan 2026 15:46:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 02/12] dpll: Allow associating dpll pin with a
 firmware node
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>,
 Grzegorz Nitka <grzegorz.nitka@intel.com>
References: <20260108182318.20935-1-ivecera@redhat.com>
 <20260108182318.20935-3-ivecera@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260108182318.20935-3-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/01/2026 18:23, Ivan Vecera wrote:
> Extend the DPLL core to support associating a DPLL pin with a firmware
> node. This association is required to allow other subsystems (such as
> network drivers) to locate and request specific DPLL pins defined in
> the Device Tree or ACPI.
> 
> * Add a .fwnode field to the struct dpll_pin
> * Introduce dpll_pin_fwnode_set() helper to allow the provider driver
>    to associate a pin with a fwnode after the pin has been allocated
> * Introduce fwnode_dpll_pin_find() helper to allow consumers to search
>    for a registered DPLL pin using its associated fwnode handle
> * Ensure the fwnode reference is properly released in dpll_pin_put()
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
> Changes:
> RFC v2:
> - dpll_pin_fwnode_set() helper to set firmware node without touching
>    dpll_pin_get()

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

