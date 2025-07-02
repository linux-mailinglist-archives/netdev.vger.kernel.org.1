Return-Path: <netdev+bounces-203439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA6FAF5F33
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 18:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4194A718B
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 16:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113292EF65A;
	Wed,  2 Jul 2025 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKlMaTth"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5533289E30;
	Wed,  2 Jul 2025 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751475237; cv=none; b=skSJO3bENTs8mBBJZn7c19QGmLCJg5r6GYqjzfdtB3/e9tbjJB3K7kLpZWrO6GLx3lUHGd+Zxa747LnA65nvbUiz7jbqq4y7FRkbTApp/KFiAXrhYhXD8dfEl7k2HlXr0KvKaYW1NVj2F098wThQ/v1vzqChJmh1uEdacibtT9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751475237; c=relaxed/simple;
	bh=SPe4Uai1bMQkO9HlAyYOM9wfRpZK1LE+tL6F2AD8u1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YU50kBNlwviTyW/2W+0qHAkTaE+NhsPR8SBFVB6Onv5WNfNENyseoV0rWhedxojf50kJcvjN1jD4b53uF3aOhxb8MJhZm38tqQitUDZnhcH3c8yUBfijNDyQWC0pkpttfFzFF9gjiFrA18Yk8VfFiq69WNvfWpewV76iRnOt8Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKlMaTth; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE08C4CEE7;
	Wed,  2 Jul 2025 16:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751475236;
	bh=SPe4Uai1bMQkO9HlAyYOM9wfRpZK1LE+tL6F2AD8u1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mKlMaTth9qVjFXD1OrmZjGPDo89B+QjHzvGZv11qCVAmnmt/fVk1mV1FCiB8JKdNf
	 D6Vro1jZ4YN3ADYJXKWzZZ0cMndBt84UGCpSFWW6ygeTgBzpcY3zazVZgGcp/pOmZn
	 ogalxEGv0qRjivDYljIcQikdjDt35QapyEsoKDEDNgjC1H5OZtoSx8r+0M/n89FHhv
	 0FYBMICOQWnsCj5jPKwA8Rc/Eab0BMqBGNMlX10Iu1ef++FnlKUjF7Yzo+gSzkKtv1
	 iie6R/1OsgeHiMDbSfpx/RKVgdJAKwTyD8furAM25FZyQPwLA+Gzt81wBv3ZltyBeM
	 R/NPEBCybHM9g==
Date: Wed, 2 Jul 2025 11:53:55 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Matthew Gerlach <matthew.gerlach@altera.com>
Cc: netdev@vger.kernel.org, maxime.chevallier@bootlin.com,
	Mun Yew Tham <mun.yew.tham@altera.com>, davem@davemloft.net,
	richardcochran@gmail.com, linux-arm-kernel@lists.infradead.org,
	pabeni@redhat.com, krzk+dt@kernel.org, devicetree@vger.kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
	conor+dt@kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	dinguyen@kernel.org, edumazet@google.com, mcoquelin.stm32@gmail.com
Subject: Re: [PATCH v7] dt-bindings: net: Convert socfpga-dwmac bindings to
 yaml
Message-ID: <175147523465.1908626.13539013933475728908.robh@kernel.org>
References: <20250630213748.71919-1-matthew.gerlach@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630213748.71919-1-matthew.gerlach@altera.com>


On Mon, 30 Jun 2025 14:37:48 -0700, Matthew Gerlach wrote:
> Convert the bindings for socfpga-dwmac to yaml. Since the original
> text contained descriptions for two separate nodes, two separate
> yaml files were created.
> 
> Signed-off-by: Mun Yew Tham <mun.yew.tham@altera.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> v7:
>  - Add compatible definition for Arria10.
>  - Update iommus to maxItems: 2.
> 
> v6:
>  - Fix reference to altr,gmii-to-sgmii-2.0.yaml in MAINTAINERS.
>  - Add Reviewed-by:
> 
> v5:
>  - Fix dt_binding_check error: comptabile.
>  - Rename altr,gmii-to-sgmii.yaml to altr,gmii-to-sgmii-2.0.yaml
> 
> v4:
>  - Change filename from socfpga,dwmac.yaml to altr,socfpga-stmmac.yaml.
>  - Updated compatible in select properties and main properties.
>  - Fixed clocks so stmmaceth clock is required.
>  - Added binding for altr,gmii-to-sgmii.
>  - Update MAINTAINERS.
> 
> v3:
>  - Add missing supported phy-modes.
> 
> v2:
>  - Add compatible to required.
>  - Add descriptions for clocks.
>  - Add clock-names.
>  - Clean up items: in altr,sysmgr-syscon.
>  - Change "additionalProperties: true" to "unevaluatedProperties: false".
>  - Add properties needed for "unevaluatedProperties: false".
>  - Fix indentation in examples.
>  - Drop gmac0: label in examples.
>  - Exclude support for Arria10 that is not validating.
> ---
>  .../bindings/net/altr,gmii-to-sgmii-2.0.yaml  |  49 ++++++
>  .../bindings/net/altr,socfpga-stmmac.yaml     | 166 ++++++++++++++++++
>  .../devicetree/bindings/net/socfpga-dwmac.txt |  57 ------
>  MAINTAINERS                                   |   7 +-
>  4 files changed, 221 insertions(+), 58 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml
>  create mode 100644 Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/socfpga-dwmac.txt
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


