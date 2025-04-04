Return-Path: <netdev+bounces-179333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F62EA7C04E
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 17:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0CD189AC43
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 15:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5982E1F4193;
	Fri,  4 Apr 2025 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tbJh3/Fg"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10691EFFB4
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743779534; cv=none; b=mXbVDBBTEl9PGR2D2/M+PxtRm0BVsfGA9MGiV4Qoq+AlSBX7Sf2GGKRRayiANRUVgiSfH9m/JL6Hii6FdDALQHP4M71+8hfDgwndaMDJr59RUNq7nrPiAy4dn/CyM1Zs7G1fa2zJ1gDE9COiqIVKRt/TrJQRXlNWhh54IPzVxkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743779534; c=relaxed/simple;
	bh=KCreTXWymrecjtmPS3L+e7hwdFIM1EdwxQRvo86EOwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVw0WHoCvZH0FYuYEM3WxWOkWDY1O/vXPirX3kO2IR46ruRvpjkdYeuGFhaTzOCfUfkaix4SpvxBVFVo8oSn0dFne927C0nN+AG9fs89XMM5OFt5FvPPoKz6K34xOPrs4/tpQhwS85rKs7mcNOXpgSod8YUirG9XoMH/4Wj/psE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tbJh3/Fg; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fd379fac-dbf8-4976-8f23-6202d488b262@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743779528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fmFbXTDoFw2W47L5foiUWbOD7ozmpdIO22Jr4A2duwQ=;
	b=tbJh3/Fg0I3QaJE7qJnm0rsYxRsteme9jDC4vYOJBYNmG5FChxRQQYC4+Hn81aX3sLMv28
	ElV2hGVdt7V8gJSsPuVjeFxi3rWu2w9xh6wFb+ZWNwyS21ElFYj3xYVNLiPV1X3B3vC8g8
	jGmO0uNV9iScl3zdOf/NLL4jHfMObVQ=
Date: Fri, 4 Apr 2025 11:12:00 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC net-next PATCH 01/13] dt-bindings: net: Add binding for
 Xilinx PCS
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, Christian Marangi <ansuelsmth@gmail.com>,
 upstream@airoha.com, Heiner Kallweit <hkallweit1@gmail.com>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Rob Herring <robh@kernel.org>, Robert Hancock <robert.hancock@calian.com>,
 devicetree@vger.kernel.org
References: <20250403181907.1947517-1-sean.anderson@linux.dev>
 <20250403181907.1947517-2-sean.anderson@linux.dev>
 <20250404-tench-of-heavenly-beauty-fb4ed1@shite>
 <b4e2db47-eb56-4a9d-bcd7-52b23450ae48@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <b4e2db47-eb56-4a9d-bcd7-52b23450ae48@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/4/25 06:39, Krzysztof Kozlowski wrote:
> On 04/04/2025 12:37, Krzysztof Kozlowski wrote:
>>> +  pcs-modes:
>>> +    description:
>>> +      The interfaces that the PCS supports.
>>> +    oneOf:
>>> +      - const: sgmii
>>> +      - const: 1000base-x
>>> +      - const: 2500base-x
>>> +      - items:
>>> +          - const: sgmii
>>> +          - const: 1000base-x
>> 
>> This is confusing. Why fallbacks? Shouldn't this be just enum? And
>> where is the type or constraints about number of items?
>> 
> I just double checked now in dtschema and latest next - there is no such
> property.

OK, so you would prefer xlnx,pcs-modes?

--Sean


