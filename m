Return-Path: <netdev+bounces-181762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F117FA86691
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 21:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138F28C2B6F
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 19:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DA927F4F9;
	Fri, 11 Apr 2025 19:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEMe1x//"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4680278E78;
	Fri, 11 Apr 2025 19:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744400588; cv=none; b=PwYBpCrqTiops2b4DABHHunKMqnWbhtDRoSOB5M6pu2skTBj2PwV8k6kxnlWVlArrC/1dtZZMlxDEGumR6joNDoxiPuZAbj841296qmnieJhWbE/ayct7xClHkonILW2/TEPE+jqL7Rk0jyGHxMO5FKkzrgZAe0f4yw0YUutA4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744400588; c=relaxed/simple;
	bh=l+zuBJVUVXugPuAtOEyHQU4jkNgPH01OJPZVhK8ffEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/4W5f+mLD38ZQMOnuEci6cgHDW6plzPyr+JJKoaUacVoPv+R7n2ilumPGiDidZqijk861aYDbrk/6C7zgYvdR4M4SJ3x4pfstuBJVG11Ld0CpMlufY3wrvfuDQBYIz7KLqyfkOoYfAmAhc0cat8eGKjTi2VidJzGJ3X+tekEOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEMe1x//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25207C4CEE8;
	Fri, 11 Apr 2025 19:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744400587;
	bh=l+zuBJVUVXugPuAtOEyHQU4jkNgPH01OJPZVhK8ffEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WEMe1x//h+7hOdU8H9mh/6Lbl1reu5FKI11OMis3mRIA5yScPeyHxXukfExTrZYU2
	 Cv5PqMyVVCR5va+D/Tkwi2SO2L5zJzRluueGWig3qBg709oDPEVK6tHGj2nM9ZNdtP
	 jVuI2CsCFMOWCWi9H7FG0xIexyZt9z4nZIJFQfcwrzpxVQ4ntDC0+Bct0UxhAs9pUG
	 3wfdoielgPaIBg78aG1Hb17RbJ8D1rwwhX+GeWKZRq8kguQJHrz/gEibrk6bU1aT7I
	 +A9GW0tE+N6OQbpMlFh5zrFzPGX1XudAIFlGhnt3j6hgzbmo6jI9ZcnYOtgT0Z6SSm
	 LkdUrAv8745mA==
Date: Fri, 11 Apr 2025 14:43:06 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: andrew+netdev@lunn.ch, edumazet@google.com, devicetree@vger.kernel.org,
	kuba@kernel.org, krzk+dt@kernel.org, pabeni@redhat.com,
	rogerq@kernel.org, davem@davemloft.net,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	conor+dt@kernel.org, srk@ti.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: ethernet-controller: add
 5000M speed to fixed-link
Message-ID: <174440058556.3779501.5440005311652027542.robh@kernel.org>
References: <20250411060917.633769-1-s-vadapalli@ti.com>
 <20250411060917.633769-2-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411060917.633769-2-s-vadapalli@ti.com>


On Fri, 11 Apr 2025 11:39:16 +0530, Siddharth Vadapalli wrote:
> A link speed of 5000 Mbps is a valid speed for a fixed-link mode of
> operation. Hence, update the bindings to include the same.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  Documentation/devicetree/bindings/net/ethernet-controller.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


