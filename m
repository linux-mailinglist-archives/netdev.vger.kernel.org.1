Return-Path: <netdev+bounces-267074-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFoeKUjEsmmvPAAAu9opvQ
	(envelope-from <netdev+bounces-267074-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:48:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 326B4272E0E
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D267D3029252
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E82C351C37;
	Thu, 12 Mar 2026 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AN6+VsgP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6522D97B7;
	Thu, 12 Mar 2026 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773323311; cv=none; b=i02quiATI7ws0PrGTlDJOAeIV7kspxt0DB6pO4ORcWibJR+uJ812v+gQ2o4O6mIhH80ysYJbceOQUT9VVeswHR28o2NVXt+6KxlZlhWIRCwH0iT7dMO/r93q8ql7GPS4JsPqCzHUGcOqx0BWnHU611CLhaIJY1G8G4OLTSy7+f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773323311; c=relaxed/simple;
	bh=hcAPt99+1FVBi2us+P3Rabs49pP9IyapSrVjbDkk1dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpbMw0i8p4yDteJggipfXInFcBXxBQQcheN1afKb0RFo+yju1NVv9k5jqKztIhy3jLzMvawuZ5PlARtDr9kSMOs8IHHejKTESNI0XuOAG7cMf8Oaw0VpkcwBZziSSrMpKesNxMEj/+8aUc+epV7RSb+x2ZcWmxPERgepXO5/sh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AN6+VsgP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD00DC4CEF7;
	Thu, 12 Mar 2026 13:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773323311;
	bh=hcAPt99+1FVBi2us+P3Rabs49pP9IyapSrVjbDkk1dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AN6+VsgPxg7z6yjxM0AzUPLK0tr3TY1t+CVdtXMKx9gCqygejoDStChHpikQhSPvu
	 1kuuPyE8kCoIEVpeI7KkPIIQ3/7AMG1HCc9obe+YLaLzmsyYYa/l5bKlzNHY3sp4Ts
	 Ob+TvU3svpa8BO1XfpPB2p49uRSJ1XwYCzFYU1xE3WfDWTPHCkpu2XhvdV8rBOTt6z
	 VAz9ffpUb2BNCz3n6QdlxTs+Xtr89ork8F0nDcU5OFXOTPkU6yn6tZHR2nWsqGfUAk
	 N/yJR5mJjHQdhTBerG47JPk0ySEzhSvZzhLMgiRjv9zaNxh3ksYdI9Bhka29EwfX3O
	 zXw/8BUSvMr9Q==
Date: Thu, 12 Mar 2026 08:48:30 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"David S. Miller" <davem@davemloft.net>, kevin-kw.huang@airoha.com,
	matthias.bgg@gmail.com, Heiner Kallweit <hkallweit1@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	macpaul.lin@mediatek.com, devicetree@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, kernel@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Andrew Lunn <andrew@lunn.ch>,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: Add support for Airoha
 AN8801/R GbE PHY
Message-ID: <177332330960.2900818.4098843765589208189.robh@kernel.org>
References: <20260304-add-airoha-an8801-support-v1-0-0ae4ee5a2f9d@collabora.com>
 <20260304-add-airoha-an8801-support-v1-1-0ae4ee5a2f9d@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304-add-airoha-an8801-support-v1-1-0ae4ee5a2f9d@collabora.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,collabora.com,davemloft.net,airoha.com,gmail.com,redhat.com,mediatek.com,kernel.org,lists.infradead.org,google.com,armlinux.org.uk,lunn.ch];
	TAGGED_FROM(0.00)[bounces-267074-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 326B4272E0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, 04 Mar 2026 10:35:28 +0100, Louis-Alexis Eyraud wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Add a new binding to support the Airoha AN8801R Series Gigabit
> Ethernet PHY.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
>  .../devicetree/bindings/net/airoha,an8801.yaml     | 81 ++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


