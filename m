Return-Path: <netdev+bounces-204584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E354AFB3E0
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5C31619BF
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 13:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE9929B23B;
	Mon,  7 Jul 2025 13:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XJjnYEq9"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB4529ACDD
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 13:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751893390; cv=none; b=Vd829sgT43F8cnyN7kElcKDVElo8KG//zz0W0mHWG5vzqNTYekK/dV3cYLPwons6OHSNc+f6jTYkIqQZbH9WRRdinMqkByWRvxGNPSLxX3JsDeEQRYkR0LsAhEIr+RjIuzEhONGJqbBSlthGdZFolJ7jY+DlayFsNd55tjiEmVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751893390; c=relaxed/simple;
	bh=mrnFaKGus2WtvZtHVXHa7d0mdUSaJF5FamWa4/acV0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMOGi9hZaWI+Ub3YX/orZXasy1TW9HuGEar9NHbqnWwnGztnCBUlv4/6TJ0Rdmct5nVyf6vkM36RjyiTVVNmVTOhRwj74kEyhys8j7ntWAUsAsiGBdTcsxbB4Yjh5JFMHXeSoNTfzPIGB6RlbIIh8ka04o73b4P6U4yfUJq/1G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XJjnYEq9; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <25360415-bd91-4523-b0a6-664d22ba9f37@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751893376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TCV91GQv8wBvsbXZEB5eJKaglsk0gzDKuhgyVMjdx3A=;
	b=XJjnYEq9/siVHn71lng8+uLXl175KinoAbXFrTaCEjpz6PRRF2Xxne+MqqiEQ/y2Bdwxjd
	yN11QmxAwrC6UiaLw8KksCdGpny4IojU4uqD9jIYT+v9CqKsJObD8rrnxXPEAGQBROYwE9
	yaD86UXkxrjlkXuZQDuJBZmoFfrz2N4=
Date: Mon, 7 Jul 2025 14:02:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v13 12/12] dpll: zl3073x: Add support to get/set
 frequency on pins
To: Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>,
 Shannon Nelson <shannon.nelson@amd.com>, Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
References: <20250704182202.1641943-1-ivecera@redhat.com>
 <20250704182202.1641943-13-ivecera@redhat.com>
 <idzmiaubwlnkzds2jbminyr46vuqo37nz5twj7f2yytn4aqoff@r34cm3qpd5mj>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <idzmiaubwlnkzds2jbminyr46vuqo37nz5twj7f2yytn4aqoff@r34cm3qpd5mj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 07/07/2025 09:32, Jiri Pirko wrote:
> Fri, Jul 04, 2025 at 08:22:02PM +0200, ivecera@redhat.com wrote:
> 
> [...]
> 
>> +static int
>> +zl3073x_dpll_input_pin_frequency_set(const struct dpll_pin *dpll_pin,
>> +				     void *pin_priv,
>> +				     const struct dpll_device *dpll,
>> +				     void *dpll_priv, u64 frequency,
>> +				     struct netlink_ext_ack *extack)
> 
> Unrelated to this patch, but ny idea why we don't implement
> "FREQUENCY_CAN_CHANGE" capability. I think we are missing it.
> 
Do you mean that some DPLLs may implement fixed frequency pins and
we have to signal it back to user-space?

