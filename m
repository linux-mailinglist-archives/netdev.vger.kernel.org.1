Return-Path: <netdev+bounces-112495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC5293985D
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 04:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EB7E1F224A9
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 02:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2140213957B;
	Tue, 23 Jul 2024 02:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjugBwRp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E788F1304B7;
	Tue, 23 Jul 2024 02:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721702569; cv=none; b=Vavw1cbTFtAzgcjykfXYrDw6SVBYUsQ3ZBOf325kmeha0/bYIlxyanLlqptBn34V9jg1u2+ja1h21HE/T5us0/gxO3sPph5d2tpgRXtBxDqeL0z2MztWNBHaIb9QoebNOzmgHzXi3RVQIMH8mkgwEhmSW8AA4260L9QdnsWvopw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721702569; c=relaxed/simple;
	bh=+XGv2Uo883KvnzldHChxsIjKnzoCyuv2VzOs9EVk240=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGv8cXxUDPM+1xCEPNMc6+5sz4tWga7G8IA93oBW3zaMixTsE80gWGc0i8ELBCUMPS1ob0wq8musIJAspiqB1yb6jdGiW1XjRc1HUM0M5clfeR9vH6EwRlZhDWMov8NBt8JF45hQFzgnu6vC/MHAfFjOQhfDl3ZkaY0NNg2akDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjugBwRp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB5CC116B1;
	Tue, 23 Jul 2024 02:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721702568;
	bh=+XGv2Uo883KvnzldHChxsIjKnzoCyuv2VzOs9EVk240=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KjugBwRpwQ5wk04NsOR5b5m69YTK4zdtXmSpQ2jolZIJz+7kFUrVH2oQCmQB26kKc
	 2ULdSDhWgMIBJkORAktnHsqfd07C/3FO6TwyclECOSooqWxpaCaGU7damcnjPSehmS
	 BdChvJg1UEHNHG/r6bozS9JtyePlALym8XSTvghNoaeaM8qoFdEAQx4mieh09cqdhP
	 WtzYSghc2ALH5dXkLGjqIrmo3gWyH5tak/8xxaHnyV7pesELe+4SPdTT82emY6Tql9
	 cz3l/t0pM7xLwnGtJM2E0BUG0Co0SpbPTZezpJl0dpKet183x11p0+9G3W4LW+Gz+p
	 sUfFR4Qo+QFdg==
Date: Mon, 22 Jul 2024 20:42:45 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: vtpieter@gmail.com
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, o.rempel@pengutronix.de,
	woojung.huh@microchip.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH 1/4] dt-bindings: net: dsa: microchip: add
 microchip,pme-active-high flag
Message-ID: <172170256455.191976.17827079027323392985.robh@kernel.org>
References: <20240717193725.469192-1-vtpieter@gmail.com>
 <20240717193725.469192-2-vtpieter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717193725.469192-2-vtpieter@gmail.com>


On Wed, 17 Jul 2024 21:37:22 +0200, vtpieter@gmail.com wrote:
> From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> 
> Add microchip,pme-active-high property to set the PME (Power
> Management Event) pin polarity for Wake on Lan interrupts.
> 
> Note that the polarity is active-low by default.
> 
> Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> ---
>  Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


