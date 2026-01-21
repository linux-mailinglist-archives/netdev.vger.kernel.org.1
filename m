Return-Path: <netdev+bounces-252014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FVqGIgNcWlEcgAAu9opvQ
	(envelope-from <netdev+bounces-252014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:31:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C45A35A8EB
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB32276FE5C
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 17:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0903A8FF4;
	Wed, 21 Jan 2026 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dkczaqt9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEA7337BA6;
	Wed, 21 Jan 2026 16:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014777; cv=none; b=CMGiF3drPfUkEJLoGrB45AMzWVWBj+gvfTOpumIjZZCNnR33zh6t5F41ttxqpOBTPKv8afcOamBB7jYoc2YVMuySVUgCYqeR5EbxmMx9tGM1KH/kolVCrSL5kMijvnk7ynHBLhwpfpJXxoXXuLnhVwrcSyLgP/VvBp+tmEYZShc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014777; c=relaxed/simple;
	bh=ruJcwsyHlH9v6pfiG+6Y7INjT5x/5/341UtTiiGk9QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HScQJl3/W8ttBB0hl8hEMW4DjASBCtoZbGU13J5g1pBOpmGcbN23ohDX+1UXaxNL3tHOhy+KxiXs1fcQfxV6ptrEW3QzEEtuzc3iZZnJI3IJhJxP8fdVaZZ8Cj9oEN8jcAfmyhvivQebMvODPmAJFdBO6ZPHuRbsBLqg3YVUvhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dkczaqt9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A076FC4CEF1;
	Wed, 21 Jan 2026 16:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769014776;
	bh=ruJcwsyHlH9v6pfiG+6Y7INjT5x/5/341UtTiiGk9QY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dkczaqt9URThweOArTTVF9tgMo8wL7yk4qz8J8GHzRixXbqTpRMpQ8sMCRN6JGphh
	 6Hu2/qQUC9kgvRzs/JwFfxkabaqUSx17/HVb5P/NYsrbDKqPpEpvKY37oxRn9qECZO
	 vA7XWcIUdjrg50dpDWeuODPXyvNKkeX60rvaPhLmvkbD0TZq2KtvYm1VMIR0peV+Dl
	 KicHYz9GrEFZOYquGPSBMtAWPGCFQKRUVlKAC5KWmP6zx9FN0HDgfhXYyXEag6MH6n
	 xTD753x3paV9ANUYP1AQrGrTkT8x2s2JkBypZ2s6QpVbfARVIqaVq7f03efFBC6jAV
	 slq+aHnkjVQZQ==
Date: Wed, 21 Jan 2026 16:59:29 +0000
From: Simon Horman <horms@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH v7 net-next 4/4] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <aXEF8elDd4GmyziX@horms.kernel.org>
References: <cover.1768707226.git.daniel@makrotopia.org>
 <15b0adf5074c601e033fd2338fb27fb666b5d16b.1768707226.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15b0adf5074c601e033fd2338fb27fb666b5d16b.1768707226.git.daniel@makrotopia.org>
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	TAGGED_FROM(0.00)[bounces-252014-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,horms.kernel.org:mid]
X-Rspamd-Queue-Id: C45A35A8EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Jan 18, 2026 at 03:46:07AM +0000, Daniel Golle wrote:

...

> +static int mxl862xx_isolate_port(struct dsa_switch *ds, int port)
> +{
> +	struct mxl862xx_bridge_port_config br_port_cfg = {};
> +	struct mxl862xx_bridge_alloc br_alloc = {};
> +	int ret;
> +
> +	ret = MXL862XX_API_READ(ds->priv, MXL862XX_BRIDGE_ALLOC, br_alloc);
> +	if (ret) {
> +		dev_err(ds->dev, "failed to allocate a bridge for port %d\n", port);
> +		return ret;
> +	}
> +
> +	br_port_cfg.bridge_id = br_alloc.bridge_id;
> +	br_port_cfg.bridge_port_id = DSA_MXL_PORT(port);
> +	br_port_cfg.mask = MXL862XX_BRIDGE_PORT_CONFIG_MASK_BRIDGE_ID |
> +			   MXL862XX_BRIDGE_PORT_CONFIG_MASK_BRIDGE_PORT_MAP |
> +			   MXL862XX_BRIDGE_PORT_CONFIG_MASK_MC_SRC_MAC_LEARNING |
> +			   MXL862XX_BRIDGE_PORT_CONFIG_MASK_VLAN_BASED_MAC_LEARNING;
> +	br_port_cfg.src_mac_learning_disable = true;
> +	br_port_cfg.vlan_src_mac_vid_enable = false;
> +	br_port_cfg.vlan_dst_mac_vid_enable = false;
> +	br_port_cfg.bridge_port_map[0] = DSA_MXL_CPU_PORTS(ds);

Hi Daniel,

.bridge_port_id, .mask, and elements of .bridge_port_map[]
are little-endian integers. But are being assigned host byte-order
values here and elsewhere.

Flagged by Sparse [1].

[1] This particular commit, from Al Viro's tree:
    https://git.kernel.org/pub/scm/linux/kernel/git/viro/sparse.git/commit/?id=2634e39bf02697a18fece057208150362c985992
    To address this mess:
    https://lore.kernel.org/all/bf5b9a62-a120-421e-908d-1404c42e0b60@kernel.org/

> +
> +	return MXL862XX_API_WRITE(ds->priv, MXL862XX_BRIDGEPORT_CONFIGSET, br_port_cfg);
> +}

...

-- 
pw-bot: cr

