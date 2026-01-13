Return-Path: <netdev+bounces-249615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA65D1B979
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 23:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D19CA30102BF
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 22:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27477350A28;
	Tue, 13 Jan 2026 22:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9UNEkrz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027C634EF05;
	Tue, 13 Jan 2026 22:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768343405; cv=none; b=ldper4yqBnj+CR3FLpTqBuXkeZFHDVDmyxNU7ZLb/AEXrt4UDle8XbCpMtQBpw94wRqq7ZzzxzC6aFTYlmjv8P7/0IJdTZMZvMPFluJwBeEMifMCGT2sZBJMiMF7BxD86NkEtXvXbUXyLSzRmcNbusF5SJzZuEbuItAm62HUJdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768343405; c=relaxed/simple;
	bh=HhYgya/+gHZZL3BnlzehiCFBNBYrrXdk9ohT+saOEB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/9iM77inlXQXZ344HQmGKmWtrxBQ7Rn1CreDeUYmjKjineuPjCa6OAXyWDjXucM8fzqap6qe0+LlS7jfH9xtw5KMTp1Y4lwTS2uCiFmm0dh5/mZsx02G/XxqiY0dNnHru4PTfe4gupD500QK0dhBb2m5VmTt7Iq/6VLXWmkIoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9UNEkrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62439C116C6;
	Tue, 13 Jan 2026 22:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768343404;
	bh=HhYgya/+gHZZL3BnlzehiCFBNBYrrXdk9ohT+saOEB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k9UNEkrzSjMl/w0ZA3UHVOgoZR6ZfgYF77Fdp1b6d5mcBmMTaPRQ1Yd25VgPUGyit
	 2HtjtFKjF0TQJdj7UuNrJqqPX4fKIq3v+VY3q4wNdvwKxTQZz/uCAxVQlswbTu0j69
	 13G1cMBRBsllf7Vtlt6fT2O7o4WBqaz0WZuZfA2gTP65PFBz4B/J3srLI0Wyy/fih+
	 72y4bN3s/RhYejt4JZCKArQfgFVMZ/EQywshTc11ff8fWgc+ZyFgDTMjh4H2Nrhh3e
	 1ACeuTDzMx97tDYgI+J6rWcSLStQlijzcKofHweCezpx/6Ofz0zDzV1UgIo4YiUxWf
	 d1uH3rLoSdV9A==
Date: Tue, 13 Jan 2026 16:30:03 -0600
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, arinc.unal@arinc9.com,
	Landen.Chao@mediatek.com, dqfext@gmail.com, sean.wang@mediatek.com,
	daniel@makrotopia.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH] dt-bindings: net: dsa: mt7530: Allow interrupts-extended
 dependency
Message-ID: <20260113223003.GA198961-robh@kernel.org>
References: <20260113110020.37013-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113110020.37013-1-angelogioacchino.delregno@collabora.com>

On Tue, Jan 13, 2026 at 12:00:20PM +0100, AngeloGioacchino Del Regno wrote:
> When the MT7530 switch is configured as an interrupt-controller it
> also needs an interrupt but, in this case, only "interrupts" was
> allowed.
> 
> Some devicetrees instead use the interrupts-extended property as a
> shorter form, and in place of "interrupts" and "interrupt-parent",
> as an equivalent.
> 
> For this reason, when interrupt-controller is present, depend on
> either `interrupts` or `interrupts-extended`; this also resolves
> some dtbs_check warnings.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/net/dsa/mediatek,mt7530.yaml       | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> index 815a90808901..ffeb8d5836fe 100644
> --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> @@ -279,8 +279,11 @@ allOf:
>          - resets
>          - reset-names
>  
> -  - dependencies:
> -      interrupt-controller: [ interrupts ]
> +  - anyOf:
> +      - dependencies:
> +          interrupt-controller: [ interrupts ]
> +      - dependencies:
> +          interrupt-controller: [ interrupts-extended ]

We already fixup this case:

dependencies:
  interrupts: ...

And there's a few other cases like yours. So I've pushed a dtschema 
change to handle this case.

Rob

