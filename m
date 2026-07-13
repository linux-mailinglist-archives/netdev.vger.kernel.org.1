Return-Path: <netdev+bounces-307237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IS2bK98JVWoHjQAAu9opvQ
	(envelope-from <netdev+bounces-307237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 17:53:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A70F74D49C
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 17:53:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cMSCp5Vc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307237-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307237-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DDE630841EB
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 15:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BD22C15BB;
	Mon, 13 Jul 2026 15:51:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCFD2C11E7;
	Mon, 13 Jul 2026 15:51:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957911; cv=none; b=iiSt3JUGPbTaSB0yLyw/kf9kxD/4+t4s6SPyKQZB9Zq/ldSx36Qqv1aJ9YSiscfWjbcK4fd/w9lTcdhcx0k6W0k1S4MdsYQNJyBm/bVa+OAHyUF5Y7LaYBUbm+E2T9yKNOXUEVkafrse2IJyeMhW/vAmsOIVswKiOQsi1T1P69A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957911; c=relaxed/simple;
	bh=oh5JJ+vRvA4XiZYqddsdhR3AJx8YYN3HKpOpYUdpyv0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=OF/TL2C/xsVeqPx1N0jmZFIJhBzGrVEDQXkEfjTOwQGY5oFIEgdoBW939Qn5H97rcUUVusnQrda8MGNgRjTfBJxpv4AHZnZ8EiKv6f0lxt1adJAAahkPx/vzwb0Lk2CITrGLzCAOA4ukUB59m7jCVQvaRLfeT/nsz2bNu7PrUtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMSCp5Vc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC6B1F000E9;
	Mon, 13 Jul 2026 15:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783957910;
	bh=4z0DvFqx/iJAA9RVQDYzPx3oX7kj+IHkEFdBAiFF0aU=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=cMSCp5VcQrjJCardQtfHQvbeeapIF+qEKkw1vXvZrJPRKits4c1yuDMbLAMjvHc4M
	 /MKcBNqfm/yQoGOZs8BGKRuHMNNI8XrFZHvQ1DL2n8WbWooIrxUREnHiRY4NlhRpQe
	 /0it+sMvqqjMf4NC+sV/rmk8V+Jx7Hf0lF4aCMbLld1sQKtA+QbcIzbTR6I20YBBOf
	 WcKQLl2yvEc8rhx+P0kp00l0h5Q4TRG8tUfOK/43sWw2+6B4Wp7hcEwVv6QVMhWllf
	 8DUStBCX2zGAMh+c/QEJlMIlezNadzXdyrh/MCKGstE1hwzthtScg4J/I/eF2sh7Pr
	 bEjAIewHpx3RQ==
Date: Mon, 13 Jul 2026 10:51:49 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
 Heiner Kallweit <hkallweit1@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>
To: Artem Shimko <a.shimko.dev@gmail.com>
In-Reply-To: <20260713131223.279555-2-a.shimko.dev@gmail.com>
References: <20260713131223.279555-1-a.shimko.dev@gmail.com>
 <20260713131223.279555-2-a.shimko.dev@gmail.com>
Message-Id: <178395790977.1766225.3879416495765817501.robh@kernel.org>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: add DAPU Telecom
 DAP8211R(I) PHY binding
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307237-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:kuba@kernel.org,m:pabeni@redhat.com,m:krzk+dt@kernel.org,m:edumazet@google.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:davem@davemloft.net,m:hkallweit1@gmail.com,m:conor+dt@kernel.org,m:linux-kernel@vger.kernel.org,m:linux@armlinux.org.uk,m:a.shimko.dev@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,m:ashimkodev@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,redhat.com,google.com,vger.kernel.org,davemloft.net,gmail.com,armlinux.org.uk];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A70F74D49C


On Mon, 13 Jul 2026 16:12:22 +0300, Artem Shimko wrote:
> Add device tree binding documentation for the DAPU Telecom DAP8211R(I)
> Gigabit Ethernet PHY.
> 
> The PHY supports TX and RX clock delays in 150 ps steps from 0 to 2250 ps,
> with a default of 1950 ps if not specified. The tx-inverted-clk flag
> provides a vendor-specific extension for boards where PCB trace length or
> MAC requirements necessitate 180-degree clock phase shift.
> 
> Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
> ---
>  .../bindings/net/dapu,dap8211r.yaml           | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/dapu,dap8211r.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/dapu,dap8211r.yaml:78:7: [error] no new line character at the end of file (new-line-at-end-of-file)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260713131223.279555-2-a.shimko.dev@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


