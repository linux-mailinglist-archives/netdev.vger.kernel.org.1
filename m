Return-Path: <netdev+bounces-47796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB087EB640
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 19:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F102814C5
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 18:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED17033CDA;
	Tue, 14 Nov 2023 18:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M/1p3//l"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EB42FC42;
	Tue, 14 Nov 2023 18:15:29 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81585129;
	Tue, 14 Nov 2023 10:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uADPOJd28K7xeDwvDsxrux/EuRs6b2nWjJMNpQr42QE=; b=M/1p3//l7HqWAQx67iyrTANPVq
	gzv8D4LUWI6o8Dp92GGq/lM6hHjxXg1JaO8Ovp//XLS4u/Vu5DFHG+Ze2/npyRMPggBODCWP98DkC
	ywexobIpUMpt3iYcg9wcyb75i0ibTSKD54u3rRtRkdyUQk+cGWYfVdbq7oVg9issGdhU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r2xwY-000BJj-HP; Tue, 14 Nov 2023 19:15:22 +0100
Date: Tue, 14 Nov 2023 19:15:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: davem@davemloft.net, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Luka Perkov <luka.perkov@sartura.hr>,
	Robert Marko <robert.marko@sartura.hr>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH net-next v3 2/8] net: dsa: qca8k: Make the QCA8K hardware
 library available globally
Message-ID: <744b25ee-cbdd-48e3-86ab-92be412b32ae@lunn.ch>
References: <20231114105600.1012056-1-romain.gantois@bootlin.com>
 <20231114105600.1012056-3-romain.gantois@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114105600.1012056-3-romain.gantois@bootlin.com>

>  int qca8k_port_mirror_add(struct dsa_switch *ds, int port,
> -			  struct dsa_mall_mirror_tc_entry *mirror,
> -			  bool ingress, struct netlink_ext_ack *extack)
> +				 struct dsa_mall_mirror_tc_entry *mirror,
> +				 bool ingress, struct netlink_ext_ack *extack)

This looks like a whitespece change which should not be here.

     Andrew

