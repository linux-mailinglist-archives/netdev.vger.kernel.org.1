Return-Path: <netdev+bounces-116188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 566BC94967F
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 19:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86CA01C22CDF
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 17:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F6D44C81;
	Tue,  6 Aug 2024 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwyejW6u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9E82C6A3;
	Tue,  6 Aug 2024 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722964625; cv=none; b=qL4o/XbBZTkbyGZhbtoNSqpXi1NcJCYrI0xNabLDSVwf3izyeHM9eOLVl7C4gczk0JIeHx+zit8+Hqj4QSHbeUrapDQANIV8aqU4dsDIckpIgm6fqyLDqMkHlU/EU7DErzdzy4j1ZgrovzA2eWtt0eHTjV43ehH4WrZro5v5zDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722964625; c=relaxed/simple;
	bh=2dexpxqJ3hR7+zqRpHFSZ4sIodK4Nzhm1LkJuXgmyNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAjlPcAgqzHUVU8cXrtz0QTe/A4H74m9exBy9FZs/laEAXoOknG2OE5YufM7DdHq0oR3JkW/x6/zdD/ARDvVHe6i+QeJB702HX5wLNRVqo6v5gvPUXBMK1uFUsGVmU03PQtxV9yrx0di7RxtKEel33o+WZ92M9m26xS0yflus34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwyejW6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C42C32786;
	Tue,  6 Aug 2024 17:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722964625;
	bh=2dexpxqJ3hR7+zqRpHFSZ4sIodK4Nzhm1LkJuXgmyNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hwyejW6uSQqgJsiUyDK1ivc/j+i3vFzw1FxAqDZB6Tn7ZtvNM6foPvRWodMxZeeP3
	 FZs1egLtux74Oa0Ea1SMQCTBuWq8eY2qfTnA/X9O8GHQB/hz2ME8CFKvW00MxGuRDi
	 6cEe3aMiTjRS87Rj56wt1Dtoh3kqu6ETHkQmvpQcpLobMpP2D1P/DGfZexcjwsCt/V
	 8JxMKQ3CcG8omVTnSPjm0vLWW5PM3yntsk59NC76sz+O7Y74q7/50L0KgL3Vo4yN1y
	 2iFWccR4clYVWbZ8+NV+TrYSjpbU87bhz0wMYcLx/qzHpBXmfShsK7YMgPgHiDmtTa
	 zPCS62RLjAIxg==
Date: Tue, 6 Aug 2024 11:17:04 -0600
From: Rob Herring <robh@kernel.org>
To: vtpieter@gmail.com
Cc: devicetree@vger.kernel.org, woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	o.rempel@pengutronix.de,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: dsa: microchip: add
 microchip,no-tag-protocol flag
Message-ID: <20240806171704.GA1749400-robh@kernel.org>
References: <20240801123143.622037-1-vtpieter@gmail.com>
 <20240801123143.622037-2-vtpieter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801123143.622037-2-vtpieter@gmail.com>

On Thu, Aug 01, 2024 at 02:31:42PM +0200, vtpieter@gmail.com wrote:
> From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> 
> Add microchip,no-tag-protocol flag to allow disabling the switch'

What is the ' for?

> tagging protocol. For cases where the CPU MAC does not support MTU
> size > 1500 such as the Zynq GEM.

What is "switch tag protocol"? Not defined anywhere? Is that VLAN 
tagging?

It seems to me that this doesn't need to be in DT. You know you have 
Zynq GEM because it should have a specific compatible. If it doesn't 
support some feature, then that should get propagated to the switch 
somehow.

Rob

