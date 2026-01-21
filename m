Return-Path: <netdev+bounces-252012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHXwD4olcWl8eQAAu9opvQ
	(envelope-from <netdev+bounces-252012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 20:14:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A112B5BEAF
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 20:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E1F457010B
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 17:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A545E4C6EFD;
	Wed, 21 Jan 2026 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEaPKSmG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2724C6EF3;
	Wed, 21 Jan 2026 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014689; cv=none; b=iOuH6cF6jvtOez7kIrXAyYaw3LB5S7cJFVF1EFipeQbI3nq6LRkBAbhJyITsLW+XFYe0diZElOBNTOxk52vMDINBElQIgERGGt9YqisCq+UYjEYVhp/njQ9O6L/Pu6U2CP03/ahQJTep85AriVe1wQB4Vqz1K2zybe6krBHGRE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014689; c=relaxed/simple;
	bh=8mVm4qk4DUumclESly4z3e748Q+xyMOgnnuV9PRkTWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBLYhFQ6KVxrXPLbiphbqvpAG6aDUAqdniZYz8pdItti+npwJsfP773gLZ3JnhI+1iibYvwIqP7d/NeAGM/blyW9TOsnEktsP4hPgaKTVMA2us5hZBrTkNTjcdKUd+tlpd6e8pgfk0Q3EztlrILVbCEmt9qhBubppnR3ORcn4WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEaPKSmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DB8C4CEF1;
	Wed, 21 Jan 2026 16:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769014688;
	bh=8mVm4qk4DUumclESly4z3e748Q+xyMOgnnuV9PRkTWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FEaPKSmG7mqv4htn3odBzDvoMYxCrf8wG8nuzuGjOj6gVzwHQOhDSB+9e88aTciYT
	 qsu3TFfUeJKMPV2hl7D3ZgJtNrcGc3ooptrzOM5+46CqLcBVgFzEtcYpVfSselbW3v
	 LbPhZb34uOnmEddhlMMgzYgWnb6VlwxQAUQfyU1C84VTklD5wr2PMB6+fqeWS2rnpF
	 tVyEMTiCfVbJqSb/Nyr219PVtkQ8mMUcyHiPRz93Gt8EL+smnmj/pAXj92D3o6x7KN
	 45A+s9l0zPddJwiDwxajKdiJxDbRp923bkhLt2vSVGvtxqRH29uoMNzKIeCPcz7lNm
	 FkCSlEhTfGVIg==
Date: Wed, 21 Jan 2026 10:58:07 -0600
From: Rob Herring <robh@kernel.org>
To: Akiyoshi Kurita <weibu@redadmin.org>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch,
	olteanv@gmail.com, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: dsa: fix typos in bindings docs
Message-ID: <20260121165807.GA3453180-robh@kernel.org>
References: <20260121130704.2236452-1-weibu@redadmin.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121130704.2236452-1-weibu@redadmin.org>
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-252012-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A112B5BEAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 10:07:04PM +0900, Akiyoshi Kurita wrote:
> Fix "alway" -> "always" in lan9303.txt and marvell,mv88e6xxx.yaml.
> 
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
> ---
>  Documentation/devicetree/bindings/net/dsa/lan9303.txt         | 4 ++--
>  .../devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml        | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/lan9303.txt b/Documentation/devicetree/bindings/net/dsa/lan9303.txt
> index 94f4f286cef9..46a732087f5c 100644
> --- a/Documentation/devicetree/bindings/net/dsa/lan9303.txt
> +++ b/Documentation/devicetree/bindings/net/dsa/lan9303.txt
> @@ -16,9 +16,9 @@ Optional properties:
>  Subnodes:
>  
>  The integrated switch subnode should be specified according to the binding
> -described in dsa/dsa.txt. The CPU port of this switch is alway port 0.
> +described in dsa/dsa.txt. The CPU port of this switch is always port 0.
>  
> -Note: alway use 'reg = <0/1/2>;' for the three DSA ports, even if the device is
> +Note: always use 'reg = <0/1/2>;' for the three DSA ports, even if the device is
>  configured to use 1/2/3 instead. This hardware configuration will be
>  auto-detected and mapped accordingly.

Please don't send further fixes to .txt bindings. If you are interested 
in fixing them, convert them to schema.

Acked-by: Rob Herring (Arm) <robh@kernel.org>

