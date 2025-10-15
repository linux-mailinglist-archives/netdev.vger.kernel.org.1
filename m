Return-Path: <netdev+bounces-229665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D493BDF8D5
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CA6A4E63AD
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908BE2FCBF0;
	Wed, 15 Oct 2025 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9lNOVsO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DD02BE632;
	Wed, 15 Oct 2025 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544449; cv=none; b=ty5JDMaKsijcWy9eMMLKEA5uRsqx6yFdaBHmJ3/vvXtWcKrDiBCW9ejAPgbZbK0t93J2yfy9PakV+FhtwaWgdtDvilVCa96f1HVYnW92ZrrG73j7ULsqbp21mZu29ViEYNUbO1w/14+QvmB0Ld5no6ONICPsm78KUfhJtUDpxZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544449; c=relaxed/simple;
	bh=vW+sUqrp42QvWqx+pFlrtwbxBhUYUL98Q1Hm7OK3wwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiujKf3JGxS/DFkOBldjKnn4mfDLpmLmlcY6hBucU71F3usij6bJreS6nwJDtbUdwv5ynMiUEe6kp4xX7sLCAUCJm5ngGc6vMzqA8UGjDdgwot+pqNLi1yUzTKD0AWlPeJojERKYDmrp4+6Rk+LvAe9wznAmugASdHDIOeC7WGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9lNOVsO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532F7C4CEF8;
	Wed, 15 Oct 2025 16:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760544449;
	bh=vW+sUqrp42QvWqx+pFlrtwbxBhUYUL98Q1Hm7OK3wwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t9lNOVsOfjmvGhrXJ4X7cwbwUH7x5nW0C/MWkNdc11xqCnZ1nv3gpWEOFbqodRCuo
	 tkpOP3XyDb7qVRzYCdM6BPa3MhqkCXMADNBnSy0Hr8/cGrShlq5lThwaxrKhATWc7r
	 DtPxQXKfK0roluCy1CT2cJVJKEPzJse8cC6lF4+anD/NG21rBzD3SXF1Dy0K85vHxi
	 x6h+sVahinXaLnJuKV1293SZBrBqHEqGDY1MP1FFgHXAJ6oREC1m4LAsBAh8jeKBdY
	 NsoD8UHMdey+moNo2jqKhdZrIGw/K0VuDQy2Op85id/m5kctpjjVkkdAmIZy7v8CeG
	 +Nu7LsFurf7hQ==
Date: Wed, 15 Oct 2025 17:07:24 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 06/12] net: airoha: ppe: Move PPE memory info in
 airoha_eth_soc_data struct
Message-ID: <aO_GvFhcfw39Y1He@horms.kernel.org>
References: <20251015-an7583-eth-support-v1-0-064855f05923@kernel.org>
 <20251015-an7583-eth-support-v1-6-064855f05923@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-an7583-eth-support-v1-6-064855f05923@kernel.org>

On Wed, Oct 15, 2025 at 09:15:06AM +0200, Lorenzo Bianconi wrote:
> AN7583 SoC runs a single PPE device while EN7581 runs two of them.
> Moreover PPE SRAM in AN7583 SoC is reduced to 8K (while SRAM is 16K on
> EN7581). Take into account PPE memory layout during PPE configuration.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


