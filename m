Return-Path: <netdev+bounces-191593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D657DABC5C0
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 19:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E5163A8670
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 17:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A3A20F077;
	Mon, 19 May 2025 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lanTct7j"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3AA2746A
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747676640; cv=none; b=qMwZ1pttrTNnbEpC3Y4frN4DlUSeTYdiN5Kqlk9vYWfUXX7M9iktqufIHv72AfTnVqHaO6hsqEDUGOqjjSSmvnSS31ZL6T7MQ02niAI55zH7DUqkFqrLEs4yPsDLwiazR939NKgJSfhkKBN+ZCMFAEnMCVqxrBXvrqW886lSYMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747676640; c=relaxed/simple;
	bh=GPH/JGjMKwBbqLkI2zaPDUJu1O/BDdi/vvWvKaatj7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mv6hDW3AViExqnHNUQ90BzIlK4CP5x2/LO6ynUL/wMUhSuKD7AOX4ncIqQX/1y9T/Y3QZMjqkrZ3Fm2Hb8fX9mlwG/Ik+P0WQTSnD07rytjFS4YS9TCCVnT2+BrQXCKJX9yRN/4Z29JtOtiKD7xCXj3eEes0FYuN6K3RGwjSnLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lanTct7j; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4556e55b-2360-4780-a282-b2f04f5cc994@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747676634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m762w739aYcjooTcsDf99wyNdsQelKHCbQzPuQVX6aE=;
	b=lanTct7ji1scWd+9vLDdf7RvpoxphxgLOWtDBbO0Dw8PJoIn1ezVP6A0wYpYt/+g6p81i6
	U6k+d4uaCDOCrptYcIIjs7ghu5JWy92AFFummMKr179zrYFvLR8gEA/mm61SXayU9R+Q0N
	+/PYeJSMQ0lpMu9SEf4KPV2jI7AknH8=
Date: Mon, 19 May 2025 13:43:48 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next PATCH v4 03/11] net: pcs: Add subsystem
To: Lei Wei <quic_leiwei@quicinc.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>
Cc: upstream@airoha.com, Kory Maincent <kory.maincent@bootlin.com>,
 Simon Horman <horms@kernel.org>, Christian Marangi <ansuelsmth@gmail.com>,
 linux-kernel@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20250512161013.731955-1-sean.anderson@linux.dev>
 <20250512161013.731955-4-sean.anderson@linux.dev>
 <e92c87cf-2645-493c-b9d3-ce92249116d1@quicinc.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <e92c87cf-2645-493c-b9d3-ce92249116d1@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/14/25 12:22, Lei Wei wrote:
> 
> 
> On 5/13/2025 12:10 AM, Sean Anderson wrote:
>> +/**
>> + * pcs_register_full() - register a new PCS
>> + * @dev: The device requesting the PCS
>> + * @fwnode: The PCS's firmware node; typically @dev.fwnode
>> + * @pcs: The PCS to register
>> + *
>> + * Registers a new PCS which can be attached to a phylink.
>> + *
>> + * Return: 0 on success, or -errno on error
>> + */
>> +int pcs_register_full(struct device *dev, struct fwnode_handle *fwnode,
>> +              struct phylink_pcs *pcs)
>> +{
>> +    struct pcs_wrapper *wrapper;
>> +
>> +    if (!dev || !pcs->ops)
>> +        return -EINVAL;
>> +
>> +    if (!pcs->ops->pcs_an_restart || !pcs->ops->pcs_config ||
>> +        !pcs->ops->pcs_get_state)
>> +        return -EINVAL;
>> +
>> +    wrapper = kzalloc(sizeof(*wrapper), GFP_KERNEL);
>> +    if (!wrapper)
>> +        return -ENOMEM;
> 
> How about the case where pcs is removed and then comes back again? Should we find the original wrapper and attach it to pcs again instead of creating a new wrapper?

When the PCS is removed the old wrapper is removed from pcs_wrappers, so
it can no longer be looked up any more. I think trying to save/restore
the wrapper would be much more trouble than it's worth.

--Sean

