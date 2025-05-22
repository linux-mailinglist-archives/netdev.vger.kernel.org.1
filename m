Return-Path: <netdev+bounces-192676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5E7AC0CEA
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F4E170827
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD25828BA99;
	Thu, 22 May 2025 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ro2bnwly"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8548C3010C;
	Thu, 22 May 2025 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747921058; cv=none; b=WP6CBB7zxoHSiTDx8+LDFW4jugs3iBLBxa+b47mbkAdB28n45lGZF+LALtCy1BzuWbv5iFmb0Kk/mJTJALKA2lcNvKUJctgpw9LBe3NynMFGJ2crwsILMTS9H58hr3XbH564hfuBENDKlM5aJnBOxanpIPjaCNee1RnrsB8ufkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747921058; c=relaxed/simple;
	bh=xgvDD8ANcZWr7OKpt36kQ4qPO0NpYVOorGuzFibhgUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGiGrwOJJrQySE64Oe5ZOPca6jtzlIW8caVaVK/a3/AEWcrdL3zMMQpN8uWkfMv0iIS915ftEPIOq0oj88cEJybPLY7s/YkuOFjs1w0aXyyi1j3wl7LvKULB87CYigi/9ZUAbwB7tNXWNgw0mcMYSJRIg26geQ3wApoPSwA2AK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ro2bnwly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96093C4CEE4;
	Thu, 22 May 2025 13:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747921058;
	bh=xgvDD8ANcZWr7OKpt36kQ4qPO0NpYVOorGuzFibhgUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ro2bnwlyDybSKkER1vd0NxNkUFOExxdructoa9s9gDa1M/gr9xKxMBzI2MrEPfSeZ
	 Nls37IGt0Miv5R5awEE/Wrk/dR3Gnh9g3d9qbp9URVmNIvZEcaMTG5WlGqJ0LqV90c
	 Ziy29SWmGSWMqH16AM2QXYodX+2IenvAfQPm2QjJam3b8QaQvOiLI4jXCPPzjawANu
	 qZzsPmDjtoOkX9egXtklqGGcqJruHnv+tZqjKHiSfhDGe9Si0mXxRqeGk1XeA7JCy0
	 y91wgYg2Qwv+BpVW715/oiIBHsdT9dBJU/oJOZs5F+Hh53jzpFv7H6rGqM+Z3vSfGO
	 raQaZH16WJftQ==
Date: Thu, 22 May 2025 14:37:33 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/4] net: airoha: Do not store hfwd
 references in airoha_qdma struct
Message-ID: <20250522133733.GC365796@horms.kernel.org>
References: <20250521-airopha-desc-sram-v3-0-a6e9b085b4f0@kernel.org>
 <20250521-airopha-desc-sram-v3-2-a6e9b085b4f0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521-airopha-desc-sram-v3-2-a6e9b085b4f0@kernel.org>

On Wed, May 21, 2025 at 09:16:37AM +0200, Lorenzo Bianconi wrote:
> Since hfwd descriptor and buffer queues are allocated via
> dmam_alloc_coherent() we do not need to store their references
> in airoha_qdma struct. This patch does not introduce any logical changes,
> just code clean-up.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


