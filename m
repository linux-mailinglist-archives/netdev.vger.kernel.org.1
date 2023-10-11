Return-Path: <netdev+bounces-39779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 128B47C4738
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 03:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC5B2812D7
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 01:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52266814;
	Wed, 11 Oct 2023 01:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="B9uIJsB/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B05803;
	Wed, 11 Oct 2023 01:25:59 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FED8F;
	Tue, 10 Oct 2023 18:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jrBARauvKO5bXj4/z3JabNLTPC5n3Bm+xpPysDJ+pI4=; b=B9uIJsB/DtjzIKSFaoJWTj2obe
	w27vMYq7GufA8gdAaNleiqpJMpuKvQJe5LBk+lY1Jw35b1Ii/7YL2IgqKGVujLYO/1qQA27gRrYIR
	CVdbgPENQnJ9rrwywzDo+/rMuzuZtsiZOF5LFax5HzTjldGI5q9EDaLD5Qdo4qeMzQ+Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qqNyu-001PlJ-TW; Wed, 11 Oct 2023 03:25:48 +0200
Date: Wed, 11 Oct 2023 03:25:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] net: dsa: Rename IFLA_DSA_MASTER to
 IFLA_DSA_CONDUIT
Message-ID: <9fd77135-22df-4d3f-a0a5-9548829d4124@lunn.ch>
References: <20231010213942.3633407-1-florian.fainelli@broadcom.com>
 <20231010213942.3633407-3-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010213942.3633407-3-florian.fainelli@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>  enum {
>  	IFLA_DSA_UNSPEC,
> -	IFLA_DSA_MASTER,
> +	IFLA_DSA_MASTER,	/* Deprecated, use IFLA_DSA_CONDUIT instead */
> +	IFLA_DSA_CONDUIT = IFLA_DSA_MASTER,
>  	__IFLA_DSA_MAX,
>  };

Minor point, but maybe it seems better if we flip this around?

 enum {
 	IFLA_DSA_UNSPEC,
-	IFLA_DSA_MASTER,
+	IFLA_DSA_CONDUIT,	
+	IFLA_DSA_MASTER = IFLA_DSA_CONDUIT, /* Deprecated */
 	__IFLA_DSA_MAX,
 };

 Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

