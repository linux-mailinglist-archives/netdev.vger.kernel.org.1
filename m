Return-Path: <netdev+bounces-229104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 637EBBD8341
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B19E44FAB7A
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B127930F925;
	Tue, 14 Oct 2025 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DV0LB6QE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B0230E0CB;
	Tue, 14 Oct 2025 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430947; cv=none; b=sqx36S89fSb8yXYKsC/ey7dft+2sr8WrsB67zQz7xa6UG6wU9QMdBKC4s8N4OELS1nYC2XxpTPTSWyYBn1mCSPqdGACEL32iuywlYGZpqrYSSy0XfJ2TFEuFxD4lfo9Eq0Anx20EGhTyRiqmKoYoHmbLWvcWmMo3QkfUVpjy2X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430947; c=relaxed/simple;
	bh=oIVvBDJ/3Y6oHKEA/tnipAXLIxVldUvt/b92nJT1Fy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=js/g2D78ygzoSjShxFLlhxQ/b8ZGPjlAldktTBbDh2aPG/oafZ33D7C1uofArGQC6Cx3h8Se8+8ddDyfHc05eMuSecHv+V/ayFTDpavmLwIEXzJbqtNmtXCv7qFSEipBZCA01QdWkujlQY0aYhXX8Rmk8i4W9Z3UTNeY9zPOsyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DV0LB6QE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A2CC4CEE7;
	Tue, 14 Oct 2025 08:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760430947;
	bh=oIVvBDJ/3Y6oHKEA/tnipAXLIxVldUvt/b92nJT1Fy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DV0LB6QEef72tfYVDZxGyT+02KnMDyVQ8tAEpyXdjnvqyuMH32hD9tYpE9roWV1Ur
	 goCnXs1/x6bHx2NIFnN8Y3VF/gTJsyF4SEXn2x8jnznMKBo8mbxsUvPgHZ385hGFWs
	 YD13rJzyzooBmDtAs3yVEOLmiv4zyvipeyogpXO0zQdN2ciOk70HAip9zlDc1gU2Q5
	 S/P9MLqN55pnfSjSwtxangJoeQFvKAdzOQvdcpgrrXvCSbW73WXunJD0jqmgzKEpDP
	 /4I4hem1GSrWmSm3ArcGwbaxaKTlDA5tmsYKY8RNaW1vwE99kVc61CndW33t45tGpq
	 FIkyrsLiDi7Tg==
Date: Tue, 14 Oct 2025 09:35:42 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v3 3/3] net: airoha: npu: Add 7583 SoC support
Message-ID: <aO4LXqpL8dVQ-QG6@horms.kernel.org>
References: <20251013-airoha-npu-7583-v3-0-00f748b5a0c7@kernel.org>
 <20251013-airoha-npu-7583-v3-3-00f748b5a0c7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-airoha-npu-7583-v3-3-00f748b5a0c7@kernel.org>

On Mon, Oct 13, 2025 at 03:58:51PM +0200, Lorenzo Bianconi wrote:
> Introduce support for Airoha 7583 SoC NPU selecting proper firmware images.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


