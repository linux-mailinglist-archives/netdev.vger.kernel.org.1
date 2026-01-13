Return-Path: <netdev+bounces-249621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 793C1D1BA6E
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 00:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 519FC302CDDA
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 23:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C68034F461;
	Tue, 13 Jan 2026 23:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fH+fP20y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E995232B9A2;
	Tue, 13 Jan 2026 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768345746; cv=none; b=KMbhte+u9Xv+lApoWwE86ZhkDJHUh1mUACWvSKc8NQJIAqNNppJD29n9QfCUAclykQm0KHKatSEDSlv56r9w8DGfaq2Ly1GnJ7AqrOxsSaqVMsZ5TlFFddm58HQrPmhJuLacYiqqbDCTLCxDb7jZB+6mJ0LGJTurZ7zCsmc+pBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768345746; c=relaxed/simple;
	bh=zQtXhTyN6gQvPSxw0ZNMyPiQd9Mr5FYPVkHhHlUibzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keBa1UZ/D3U5VR2WXar8FVxhib1udqx6S/L4JBYK2tsWDCGtoaSAG7sbpFnCTw1OhRihes8gcZrzRh3NakeUuqXupzuRBFNzjTWcDoUAvo62M4uDIOWmjK2aiPqEq0ZSZVGv7NfnRy9tGm4xgsCmP67mhW9VOeFKK9UvFoZZpDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fH+fP20y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C4CC116C6;
	Tue, 13 Jan 2026 23:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768345745;
	bh=zQtXhTyN6gQvPSxw0ZNMyPiQd9Mr5FYPVkHhHlUibzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fH+fP20yKjimxJNfOCZRYwhmRFjboPaPOnvr5/fLk1U+a7+tet0IcuBV0xxWG0wN4
	 rbdcWORD1asXtxBrv9WdTjjaYKXjP2ucZCGK0udY/QYgBN2M+Gg21tVNiw5KU/IOtK
	 bfOLyaKzm8z24NoD2eGKbXiZINQ28r5kBhpByRSHzISCMlueK284aoNf+R+Dj6Uv1S
	 wxW/ZXVvNyUwzbgQgWDDEcJuN3nPiD4XgK2J46Zna7aWmUXR3/Ioth2tZ7O3txxtje
	 +HV6R5F18U5uMVK5ODK6ooTICpwlAh/hYXZXfKdDqkYv8knYTBpxESWAG/Jq8I/Yfz
	 CsOdGjeh32ohw==
Date: Tue, 13 Jan 2026 17:09:04 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
	kuba@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	edumazet@google.com, krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v2 2/2] dt-bindings: net: micrel: Convert
 micrel-ksz90x1.txt to DT schema
Message-ID: <176834574375.421000.5101201792766699774.robh@kernel.org>
References: <20260108125208.29940-1-eichest@gmail.com>
 <20260108125208.29940-3-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108125208.29940-3-eichest@gmail.com>


On Thu, 08 Jan 2026 13:51:28 +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> Convert the micrel-ksz90x1.txt to DT schema. Create a separate YAML file
> for this PHY series. The old naming of ksz90x1 would be misleading in
> this case, so rename it to gigabit, as it contains ksz9xx1 and lan8xxx
> gigabit PHYs.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> ---
>  .../bindings/net/micrel,gigabit.yaml          | 253 ++++++++++++++++++
>  .../bindings/net/micrel-ksz90x1.txt           | 228 ----------------
>  2 files changed, 253 insertions(+), 228 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/micrel,gigabit.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


