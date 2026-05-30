Return-Path: <netdev+bounces-293342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIAGEqrHGmpn8wgAu9opvQ
	(envelope-from <netdev+bounces-293342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 13:19:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA3860C69C
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 13:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2898D300A5BD
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 11:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339DA3932CD;
	Sat, 30 May 2026 11:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSIvlAk/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29950156661;
	Sat, 30 May 2026 11:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780139938; cv=none; b=OEVzBvYWCngIhyzhlLeaVInr3RPUZ66MWjq8pju/M3Ck9Kog9hGDoXs7fR9N9kv3IRM+8n0Vj+ua8JrRK2vVIyemVkSaL8cGOeyY23ZTiEt5pVrcO+Q1lig+GLyGHIcmx0OOTfAcr2X3kyAMxG6XuuLXiOi+Pyiv3V5MUPVyJso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780139938; c=relaxed/simple;
	bh=8v+e2ZGDGrTXFpXKP5t0RjHdeCDeVVmxokNCH29rLHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9BVaEnAEfPv4Y2r+84JYNAzE4KXMG5rjgitO6CJRCTmFfFffwnYw0VK5B7P5pbwU7cokqu3K1n6Fi356oBOZlQY59YX/ItyPYlHKPiBTaJeppRoY9fK5V6RMFkZ0Je5vsr88Ebz61pFuxkpWl5czxQExH9DNjz2U0UPdNxcyT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSIvlAk/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3DC1F00893;
	Sat, 30 May 2026 11:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780139936;
	bh=Qvc4sHNsIEjfe2ZxRJAsYr7M3r1LFYtT3I1rdHEm+1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WSIvlAk/VnoqVkiFIODjIUTOsx8myoIztBl3WAXLp9zxzchP0zGiP6YGRi8ja3dZv
	 7rwODwpIH/GFQr9PqNm5GOccQSEgw+DOcNMlm9J7fimTGIEPc77yQUu2xgwZBSMYSp
	 9Qta2HF7xeFZ60W1RdA1NBLaDWX12RTVXqgPpa8ohttsRgFrD1BrhiBdHloTdlf59F
	 O6k36RLxATHKJ1a3l2l1Ue102KM28YPhbJB1sPG34cozAyXdnUwrI+pnVHab8D4fW0
	 2UVrRpidun9a/9RKk0LtwIj2N9F6OkkAxGtrGsxrrCTyCfnlyXdZJrPaoqOXGG42Eb
	 tAlkQ69sc5urw==
Date: Sat, 30 May 2026 13:18:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: lizhi2@eswincomputing.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ningyu@eswincomputing.com, linmin@eswincomputing.com, 
	pinkesh.vaghela@einfochips.com, pritesh.patel@einfochips.com, weishangjuan@eswincomputing.com, 
	sashiko-bot@kernel.org
Subject: Re: [PATCH net v1] dt-bindings: ethernet: eswin: fix hsp-sp-csr
 backward compatibility
Message-ID: <20260530-hysterical-oyster-of-skill-0c93cb@quoll>
References: <20260525052441.1637-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260525052441.1637-1-lizhi2@eswincomputing.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293342-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,eswincomputing.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4AA3860C69C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 01:24:41PM +0800, lizhi2@eswincomputing.com wrote:
> From: Zhi Li <lizhi2@eswincomputing.com>
> 
> The previous change added two optional cells to

What is previous in this context? There is no previous commit here.

> eswin,hsp-sp-csr, but omitted minItems: 4.
> 
> As a result, dt-schema implicitly required all 6 cells,
> breaking backward compatibility with existing 4-cell
> device trees.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

> 
> Add minItems: 4 to preserve backward compatibility.
> 
> Fixes: c36069c6f46c ("dt-bindings: ethernet: eswin: add optional TXD and RXD delay register offsets")
> Reported-by: Sashiko AI <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260519022334.35742C2BCB7@smtp.kernel.org/
> Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
> ---


With fixed commit msg:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


