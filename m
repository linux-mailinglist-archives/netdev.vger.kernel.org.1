Return-Path: <netdev+bounces-246137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E7BCDFC48
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 13:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA6BF301E585
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 12:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C933346A6;
	Sat, 27 Dec 2025 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oz9VZtTN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45474324B0A;
	Sat, 27 Dec 2025 12:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766838579; cv=none; b=Qi1oDZ6wqVPUHQJ7a8f1mMnRwL8djmXfTozLm0lHEgPGiWXwxqOUsAGHbBXusoiGvkl7P2IVddRqqM5iPtn395KykqmERr94sWYDRLQwlIUEUmiJ+u2YsJeSwityJF64vknj8th5fjIkwYEtuW4m5lqA44NxXzYTcsssQl1Dmx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766838579; c=relaxed/simple;
	bh=okqOYN2Xw9qQ/xkSF06ArzAodMAkpQa+jOeYFI3UY9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEkd7sf7+Xuz9DhAw3BvlWyn15suGuBRuglfAXDvDmjGELnclfFMho4WNAAFAlifDJ83F34mNUP13u2i88sHp/cKt+zhEsSwH2Z9HxTAt7odFrREBtE8XOtI+k4peTcMuuqHzMyiK5E/lsPinlwc/PRmt1dLOXzmSWvDisRxS5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oz9VZtTN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E50DC4CEF1;
	Sat, 27 Dec 2025 12:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766838578;
	bh=okqOYN2Xw9qQ/xkSF06ArzAodMAkpQa+jOeYFI3UY9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oz9VZtTN3izEgjQ9u57p1cn0K500+iFjCMxJUslZxAl4hgWxhVvixAwU2Il1fkp+q
	 z8ICPTFB4B+8toFBHG1Uq2UgZ1KIP6Z1QN1A4ZvwJkFWB4Y++Y23Ia5tRlYiEZeBYq
	 sLZKXdf6Zcfd4jFF2LFg/i0ZIdO2hx5BKz1ST6zojoa000CbHbt9cMunamF+4gcbA7
	 5vfcO6hh7JCAIAii/KId+Bewwlon0R59m54jRWlvdbdtO99A4/v31Fv9BMC0yeCPls
	 zqvhp0IZeHpzNHrBbFcGtL+kgr7JAYEC5NaEJJPXLnwe8sOSPrkLYZesm8vfwD/YC8
	 QgSCp8/78F69g==
Date: Sat, 27 Dec 2025 13:29:36 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Osose Itua <osose.itua@savoirfairelinux.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michael.hennerich@analog.com, 
	jerome.oufella@savoirfairelinux.com
Subject: Re: [PATCH v2 2/2] dt-bindings: net: adi,adin: document LP
 Termination property
Message-ID: <20251227-perfect-accomplished-wildcat-4fcc75@quoll>
References: <20251222222210.3651577-1-osose.itua@savoirfairelinux.com>
 <20251222222210.3651577-3-osose.itua@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251222222210.3651577-3-osose.itua@savoirfairelinux.com>

On Mon, Dec 22, 2025 at 05:21:05PM -0500, Osose Itua wrote:
> Add "adi,low-cmode-impedance" boolean property which, when present,
> configures the PHY for the lowest common-mode impedance on the receive
> pair for 100BASE-TX operation.
> 
> Signed-off-by: Osose Itua <osose.itua@savoirfairelinux.com>
> ---
>  Documentation/devicetree/bindings/net/adi,adin.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/adi,adin.yaml b/Documentation/devicetree/bindings/net/adi,adin.yaml
> index c425a9f1886d..d3c8c5cc4bb1 100644
> --- a/Documentation/devicetree/bindings/net/adi,adin.yaml
> +++ b/Documentation/devicetree/bindings/net/adi,adin.yaml
> @@ -52,6 +52,12 @@ properties:
>      description: Enable 25MHz reference clock output on CLK25_REF pin.
>      type: boolean
>  
> +  adi,low-cmode-impedance:
> +    description: |
> +      Ability to configure for the lowest common-mode impedance on the

Either this is ability or you configure the PHY, as written in commit
msg. The latter suggests that's a SW property, not hardware, thus not
for bindings.

If the first, then why it is not implied by PHY itself - the compatible
(which is missing which makes this binding not selectable).

Best regards,
Krzysztof


