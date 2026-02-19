Return-Path: <netdev+bounces-259517-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAoSGklAl2lXwAIAu9opvQ
	(envelope-from <netdev+bounces-259517-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:54:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F5B160D57
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C82AA3035017
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 16:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9093934D4FE;
	Thu, 19 Feb 2026 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aUUac6CL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181F134CFCB;
	Thu, 19 Feb 2026 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771520040; cv=none; b=u1EcwDv4fSuc5Qk3q1APS7C9v6uNtb9Z+kC5PIFk8AtwEptHg+QXn1hqAkvtbMtcWLqP+AHOtgeAp5bPSzbyoXcRTVK7uU2tIUTvnG7jXU5D+GWnbeHJdVb+sLj4LWWsUmH4ZZXoQGkQsaI5F4BNoFrzCa26KCxuzY5qlf9GMe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771520040; c=relaxed/simple;
	bh=p+tUXB3Qji9LNhxxmlLdCEuFkWLVEAKpcxmSjcIqAUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgNr7nYavKzPonfwFSk6QZkoJIykiyEOT7tcYZla+UhRCCXd+u62X61BhflLhAYuucUewyw0vEGGNJBVJVTsFwCx2yhX3o4gFd265uxh9BYMPfoaNISwugJv9zb+pRkqAPvAtmeFD3ujQMW3imPSbhshecczr1ffVEBhbqswc5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aUUac6CL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NqNSewweIKFfCmLrQgWQ7akHkJKLSCW09XG4EmRHUr0=; b=aUUac6CLUXaq7d2aPoJC01PxD+
	YVDK70ivOhzz2+bcc2WE720b7dBz5Dsn1eOubCpXqN8MKeW9BpQBSwr1upT5ce+YMCSX03wJF/XKo
	J7mKaZglQ+JQ+XhgLMllxR2fv7lqzcQf8nNSIBxk+siRabMz/VKpVFq8l7cByG8DMHL4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vt7Hi-007wWF-9A; Thu, 19 Feb 2026 17:53:50 +0100
Date: Thu, 19 Feb 2026 17:53:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Srinivas Neeli <srinivas.neeli@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, git@amd.com
Subject: Re: [RFC PATCH 1/8] dt-bindings: net: Add TSN Endpoint Ethernet MAC
 support
Message-ID: <76c811a7-d081-4238-bf6a-0226e867560a@lunn.ch>
References: <20260219054911.2017362-1-srinivas.neeli@amd.com>
 <20260219054911.2017362-2-srinivas.neeli@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219054911.2017362-2-srinivas.neeli@amd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259517-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,amd.com,gmail.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.148.112:email,0.0.78.32:email,0.0.0.1:email,0.0.62.128:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,lunn.ch:mid,lunn.ch:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,4.197.80.64:email]
X-Rspamd-Queue-Id: C7F5B160D57
X-Rspamd-Action: no action

> +examples:
> +  - |
> +    tsn_ip: tsn@80040000 {
> +        compatible = "xlnx,tsn-endpoint-ethernet-mac-3.0";
> +        reg = <0x80040000 0x40000>;
> +        clocks = <&misc_clk_2>, <&misc_clk_2>, <&misc_clk_1>, <&misc_clk_1>, <&misc_clk_3>, <&misc_clk_0>;
> +        clock-names = "gtx", "gtx90", "host_rxfifo", "host_txfifo", "ref", "s_axi";
> +        dmas = <&axi_mcdma_0 0>, <&axi_mcdma_0 1>, <&axi_mcdma_0 2>, <&axi_mcdma_0 3>,
> +               <&axi_mcdma_0 4>, <&axi_mcdma_0 5>, <&axi_mcdma_0 6>, <&axi_mcdma_0 7>,
> +               <&axi_mcdma_0 16>, <&axi_mcdma_0 17>, <&axi_mcdma_0 18>, <&axi_mcdma_0 19>,
> +               <&axi_mcdma_0 20>, <&axi_mcdma_0 21>, <&axi_mcdma_0 22>, <&axi_mcdma_0 23>;
> +        dma-names = "tx_chan0","tx_chan1","tx_chan2","tx_chan3","tx_chan4","tx_chan5","tx_chan6",
> +                    "tx_chan7","rx_chan0","rx_chan1","rx_chan2","rx_chan3","rx_chan4","rx_chan5",
> +                    "rx_chan6","rx_chan7";
> +        xlnx,num-priorities = <8>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges = <0x0 0x80040000 0x40000>;
> +        xlnx,tsn-tx-config = <&tsn_tx_config>;
> +        tsn_tx_config: tx-queues-config {
> +            queue0 {
> +                xlnx,dma-channel-num = <0x5>;
> +            };
> +            queue1 {
> +                 xlnx,dma-channel-num = <0x4>;
> +            };
> +            queue2 {
> +                 xlnx,dma-channel-num = <0x3>;
> +            };
> +            queue3 {
> +                 xlnx,dma-channel-num = <0x2>;
> +            };
> +            queue4 {
> +                 xlnx,dma-channel-num = <0x1>;
> +            };
> +            queue5 {
> +                 xlnx,dma-channel-num = <0x0>;
> +            };
> +        };
> +        // MAC 1 Node
> +        mac1: ethernet-mac@0 {
> +            reg = <0x0 0x14000>;
> +            phy-mode = "rgmii-id";
> +            phy-handle = <&phy0>;
> +            mdio {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            phy0: ethernet-phy@0 {
> +                device_type = "ethernet-phy";
> +                reg = <0>;
> +            };
> +            };

Two } at the same level means your indentation is broken.

So each MAC has an MDIO node?

> +        };
> +
> +        // MAC 2 Node
> +        mac2: ethernet-mac@20000 {
> +            reg = <0x20000 0x14000>;
> +            phy-mode = "rgmii-id";
> +            phy-handle = <&phy1>;
> +            mdio {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            phy1: ethernet-phy@1 {
> +                device_type = "ethernet-phy";
> +                reg = <1>;
> +            };
> +            };
> +        };
> +
> +        // Endpoint Node
> +        ep_mac: ep-mac@16000 {
> +            reg = <0x16000 0xa000>;
> +        };

Except the Endpoint MAC does not have MDIO?  Or does it have an MDIO
bus, and you have simply not listed it?

> +
> +        // Switch Node
> +        tsn_switch: switch@38000 {
> +            reg = <0x38000 0x8000>;
> +
> +            ethernet-ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +                    ethernet = <&ep_mac>;
> +                };

So this looks like a DSA switch.

> +
> +                port@1 {
> +                    reg = <1>;
> +                    ethernet = <&mac1>;

If you look at Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
you see this node is derives from ethernet-switch-port.yaml, and that
derives from ethernet-controller.yaml. All the MAC properties you have
above actually belong here.

	Andrew

