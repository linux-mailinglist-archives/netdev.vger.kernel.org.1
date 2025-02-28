Return-Path: <netdev+bounces-170869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C31DA4A58D
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 23:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8993B21A2
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 22:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3DF1DBB3A;
	Fri, 28 Feb 2025 22:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPZ7Yg+w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BC81C700A;
	Fri, 28 Feb 2025 22:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740780181; cv=none; b=jVdYxt8BZUj7kjNrVXwn+QBh1RS8huI7biGbsMh4WFkORiX4mrW/YI38Zqz/rxgvMls4gBI7Nx40HTHeHZwdi0Mf3l/bBFuzlRUkSKFc6GSobOmZObKiqxonDMWlX7OTUE/H4LKtReU0kOJtxgBVGdVSEQtM/7igox3vbQkdiyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740780181; c=relaxed/simple;
	bh=AeQ9O6FSeUJE9ZlcsbT7G7CmyhH4Bd6I7HLsZ+f5Bic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuku9BM59D1cK/tH46VPAFOAt4WdR8aZQhdz0inaLxC02lYUSz0usrgOowFR8c1qzR5P/5VlkmQCuYu3nPWXweqQHcF09IHS9EQzaDZPfmP5kQGB20G5Fox6hkOyzZ6SbfApdrhvU0haJS/eJXfkERiJgeMIKwmLsHfNztpiDlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPZ7Yg+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881EAC4CED6;
	Fri, 28 Feb 2025 22:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740780180;
	bh=AeQ9O6FSeUJE9ZlcsbT7G7CmyhH4Bd6I7HLsZ+f5Bic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LPZ7Yg+wnWw15XwdEmlqwsWeh961RJBNFovyyhw0OeBkZjsi3tN2I/qeAyNYvrXSZ
	 QhaLm98ULQ5CMLsw5yZHuxc2ahLjQVMZ4LC569S4AmSoCb+oPbhugvsLymBCo7M/Qi
	 wjDGrsTFhCBFIdrMH3fO5wFxeQMaOFqQKAswqMzZZQU33rXblq/1RfXvXlEFt2jXAz
	 nGdOxLPusgSMQ6JbKFiRc3Nk/dWZSe0+hhYrWtjzyFSJp5kKO4A4LpdwO9bh1PdK6q
	 KR1IXzMeFuK4KU3IsLld2OJtSJJmMOLLuQnvL7Tq0ySezOgYseXE1lcbZ8xQSxopFb
	 gkOqYXmARpkNA==
Date: Fri, 28 Feb 2025 16:02:58 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Claudiu Manoil <claudiu.manoil@nxp.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: net: Convert fsl,gianfar-{mdio,tbi}
 to YAML
Message-ID: <174078017764.3770987.9221130026754237775.robh@kernel.org>
References: <20250228-gianfar-yaml-v2-0-6beeefbd4818@posteo.net>
 <20250228-gianfar-yaml-v2-1-6beeefbd4818@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250228-gianfar-yaml-v2-1-6beeefbd4818@posteo.net>


On Fri, 28 Feb 2025 18:32:50 +0100, J. Neuschäfer wrote:
> Move the information related to the Freescale Gianfar (TSEC) MDIO bus
> and the Ten-Bit Interface (TBI) from fsl-tsec-phy.txt to a new binding
> file in YAML format, fsl,gianfar-mdio.yaml.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
> 
> V2:
> - remove definitions of #address/size-cells (already in mdio.yaml)
> - disambiguate compatible = "gianfar" schemas by using a "select:" schema
> ---
>  .../devicetree/bindings/net/fsl,gianfar-mdio.yaml  | 113 +++++++++++++++++++++
>  .../devicetree/bindings/net/fsl-tsec-phy.txt       |  41 +-------
>  2 files changed, 115 insertions(+), 39 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


