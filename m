Return-Path: <netdev+bounces-211625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBE2B1A942
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 20:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C222189F4ED
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 18:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D784C1DF258;
	Mon,  4 Aug 2025 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="S/qNRyHO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF5D1B6D06;
	Mon,  4 Aug 2025 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754333121; cv=none; b=Yc9kpzs8maZy0AK8z3k4WgXYxHVYM25oMPdT+Pc0Amruo34Qqk3dbkDOOULqqvoFjZZt0gHGBdpxf9bpH10t6Y1YKWtUTHDZzKCVC6IW+YbYUeFlRGKt+I0CoHwxibUXSL4fSJcQBthSUrf+eOGGFsLSdH+2emEgU//ERomZj54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754333121; c=relaxed/simple;
	bh=rCHXXNdpkcJiBsgVoWsJ5vVB4UmsYjtQbJYvAuwkKS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDqjXrV+AdAipuZPGuWi7EwTWOqooaPV44kXwUb/vLK5fA7bfWSUlBdyAQokaOJ8Rtw1JQiC+CZ0fJMBCS77h5JD0vJWBlux269Q9XU+u1sXSEJ6xjgkeDsvNr3H+pXNtcy0oJZL/h0uuOdkGaHNiPxswD+lIJLTlUCT4t4XVIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=S/qNRyHO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cIXfpbELo7S5Ma6kNEHmduu6tJrsk3tl7WgR7nkYNeE=; b=S/qNRyHO5dOMC8M6ZLhYLce0HU
	YkwpeIgj42pq+hEkqzsT14p6FuZ+5P5gCeIza/UPqzD7WVcrZO4jrQEw2mZxt8sLTifW6jntTS2ij
	ysKe/txFLmA/k+GkTKpWGPbkIAYBea6IZc5rt6COEVevHKlyHaBo3h4eKqnMsUSS66KM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uj0BF-003jbX-B2; Mon, 04 Aug 2025 20:45:05 +0200
Date: Mon, 4 Aug 2025 20:45:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
Subject: Re: [PATCH net-next 1/2] dt-bindings: dpll: Add clock ID property
Message-ID: <1419bca0-b85a-4d4b-af1a-b0540c25933a@lunn.ch>
References: <20250717171100.2245998-1-ivecera@redhat.com>
 <20250717171100.2245998-2-ivecera@redhat.com>
 <5ff2bb3e-789e-4543-a951-e7f2c0cde80d@kernel.org>
 <6937b833-4f3b-46cc-84a6-d259c5dc842a@redhat.com>
 <20250721-lean-strong-sponge-7ab0be@kuoka>
 <804b4a5f-06bc-4943-8801-2582463c28ef@redhat.com>
 <9220f776-8c82-474b-93fc-ad6b84faf5cc@kernel.org>
 <466e293c-122f-4e11-97d2-6f2611a5178e@redhat.com>
 <db39e1ff-8f83-468c-a8cb-0dd7c5a98b85@kernel.org>
 <f96b3236-f8e6-40c1-afb2-7e76894462f9@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f96b3236-f8e6-40c1-afb2-7e76894462f9@redhat.com>

> Let's say we have a SyncE setup with two network controllers where each
> of them feeds a DPLL channel with recovered clock received from some of
> its PHY. The DPLL channel cleans/stabilizes this input signal (generates
> phase aligned signal locked to the same frequency as the input one) and
> routes it back to the network controller.
> 
>     +-----------+
>  +--|   NIC 1   |<-+
>  |  +-----------+  |
>  |                 |
>  | RxCLK     TxCLK |
>  |                 |
>  |  +-----------+  |
>  +->| channel 1 |--+
>     |-- DPLL ---|
>  +->| channel 2 |--+
>  |  +-----------+  |
>  |                 |
>  | RxCLK     TxCLK |
>  |                 |
>  |  +-----------+  |
>  +--|   NIC 2   |<-+
>     +-----------+
> 
> The PHCs implemented by the NICs have associated the ClockIdentity
> (according IEEE 1588-2008) whose value is typically derived from
> the NIC's MAC address using EUI-64. The DPLL channel should be
> registered to DPLL subsystem using the same ClockIdentity as the PHC
> it drives. In above example DPLL channel 1 should have the same clock ID
> as NIC1 PHC and channel 2 as NIC2 PHC.
> 
> During the discussion, Andrew had the idea to provide NIC phandles
> instead of clock ID values.
> 
> Something like this:
> 
> diff --git a/Documentation/devicetree/bindings/dpll/dpll-device.yaml
> b/Documenta
> tion/devicetree/bindings/dpll/dpll-device.yaml
> index fb8d7a9a3693f..159d9253bc8ae 100644
> --- a/Documentation/devicetree/bindings/dpll/dpll-device.yaml
> +++ b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
> @@ -33,6 +33,13 @@ properties:
>      items:
>        enum: [pps, eec]
> 
> +  ethernet-handles:
> +    description:
> +      List of phandles to Ethernet devices, one per DPLL instance. Each of
> +      these handles identifies Ethernet device that uses particular DPLL
> +      instance to synchronize its hardware clock.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +

I personally would not use a list. I would have a node per channel,
and within that node, have the ethernet-handle property. This gives
you a more flexible scheme where you can easily add more per channel
properties in the future.

It took us a while to understand what you actually wanted. The ASCII
art helps. So i would include that and some text in the binding.

	Andrew

