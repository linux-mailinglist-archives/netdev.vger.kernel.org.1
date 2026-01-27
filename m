Return-Path: <netdev+bounces-254013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMtXOf43eWkJwAEAu9opvQ
	(envelope-from <netdev+bounces-254013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:11:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 892AE9AEDC
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E22BF300B9FD
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 22:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD56032A3F3;
	Tue, 27 Jan 2026 22:11:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE9A21B185;
	Tue, 27 Jan 2026 22:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769551867; cv=none; b=RIeatL0CwH9dr6UjlnRSTlhXZBMMUzC5qwyJPhZWYt2YKpTUi0gFooI9RKmYexhTxjPdyouZwqJhDYZnqkRRdLAIjBwyz2LFzyUBdxTuDXZeOwWhMvUuSi58sc6XfvJn74mbmfVznkCaZMlv01vdin+Ev9dUK7BuSC8mzX/RIaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769551867; c=relaxed/simple;
	bh=HXOFUCcMmdKAZGPUTObNKRDSytW18UZt23vKcDslPh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xw3SAVfQ2SdIcFHTAeL9yMCDjxiu4jtSKOIO3BlIuGChyQjvZHENjV1u11oHymXwtCmTPTPgZWZixIx5P3E0VFFjt14JaeIzoo88AcqMdSkMZqz16G+5z8xU65V3gwWoriM6G0H+ZNN/IhqZNGu+9KGctFBNGGShfukCwptef0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vkrH3-0000000032J-2LNZ;
	Tue, 27 Jan 2026 22:11:01 +0000
Date: Tue, 27 Jan 2026 22:10:58 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: dsa: lantiq,gswip:
 reference common PHY properties
Message-ID: <aXk38o39i62SIq_K@makrotopia.org>
References: <cover.1769519758.git.daniel@makrotopia.org>
 <d9b6212ad5137feeb58b28e9b0784f1084c813df.1769519758.git.daniel@makrotopia.org>
 <20260127132919.xsvapgqc65f44iah@skbuf>
 <aXjGh1nzeAz8TQzH@makrotopia.org>
 <20260127150747.lzlfzhusywluuxhs@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127150747.lzlfzhusywluuxhs@skbuf>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254013-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,makrotopia.org:mid]
X-Rspamd-Queue-Id: 892AE9AEDC
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 05:07:47PM +0200, Vladimir Oltean wrote:
> On Tue, Jan 27, 2026 at 02:07:03PM +0000, Daniel Golle wrote:
> > Yeah, I thought about that, but it would be a lot of work to
> > let the driver expose and simple-bus as MFD with devices (clk controller,
> > reset controller, pcs, ...) sitting on register ranges. Imho not worth
> > the effort in this case, we discussed it.
> 
> Possibly so; I don't have access from this computer to my previous notes
> on this topic.
> 
> > However, even in that case imho it's fine to let it share the OF node
> > with the ethernet-port. Why not?
> 
> I don't have a good feeling of how reusable this PCS IP truly is.
> For example the XPCS gained DT bindings before I needed to customize the
> lane polarity for its SJA1105 instantiation, so now I have to work with
> and somehow adapt those.
> 
> If the PCS has a fixed mapping to that port then I suppose it can use
> its OF node space without any extra overengineering. There should exist
> ways to keep compatibility with this scheme even if there will be
> efforts to have a reusable driver later.

Taking a step back I noticed that we need to decide this also for
mt7530.

commit bde1ae2d52ab ("net: pcs: pcs-mtk-lynxi: pass SGMIISYS OF node to PCS")
currently doesn't pass any fwnode when creating the LynxI PCS.
> +               pcs = mtk_pcs_lynxi_create(priv->dev, NULL, regmap,
> +                                          MT7531_PHYA_CTRL_SIGNAL3);

However, each PCS does belong to a specific switch port, and it would be
advantegous and imho consistent to also assign the ports OF node to the
PCS, this would allow to configure the polarities also on the MT7530
SerDes ports.

Ie.

diff --git a/drivers/net/dsa/mt7530-mdio.c b/drivers/net/dsa/mt7530-mdio.c
index 11ea924a9f35..3da9f42cefcb 100644
--- a/drivers/net/dsa/mt7530-mdio.c
+++ b/drivers/net/dsa/mt7530-mdio.c
@@ -86,9 +86,16 @@ mt7531_create_sgmii(struct mt7530_priv *priv)
 	struct regmap_config *mt7531_pcs_config[2] = {};
 	struct phylink_pcs *pcs;
 	struct regmap *regmap;
+	struct dsa_port *dp;
 	int i, ret = 0;
 
 	for (i = priv->p5_sgmii ? 0 : 1; i < 2; i++) {
+		dp = dsa_to_port(priv->ds, i + 5);
+		if (!dp) {
+			ret = -EINVAL;
+			break;
+		}
+
 		mt7531_pcs_config[i] = devm_kzalloc(priv->dev,
 						    sizeof(struct regmap_config),
 						    GFP_KERNEL);
@@ -113,8 +120,8 @@ mt7531_create_sgmii(struct mt7530_priv *priv)
 			ret = PTR_ERR(regmap);
 			break;
 		}
-		pcs = mtk_pcs_lynxi_create(priv->dev, NULL, regmap,
-					   MT7531_PHYA_CTRL_SIGNAL3);
+		pcs = mtk_pcs_lynxi_create(priv->dev, of_fwnode_handle(dp->dn),
+					   regmap, MT7531_PHYA_CTRL_SIGNAL3);
 		if (!pcs) {
 			ret = -ENXIO;
 			break;


What do you think?

