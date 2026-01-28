Return-Path: <netdev+bounces-254057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDd2DMVqeWmPwwEAu9opvQ
	(envelope-from <netdev+bounces-254057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:47:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C73809C087
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2310A30053E0
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 01:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1201225F98A;
	Wed, 28 Jan 2026 01:47:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22681DF27F;
	Wed, 28 Jan 2026 01:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769564865; cv=none; b=lJgnGcQOxGRg7vEpYNPaNeuHpaxRK7bvELq6WpAW8vmyTTkAOQ8+XbQhM6nZPZQg2dXXbAp4qcUAJTvpNYnmbu4Hg8a67cGKXxkxjkcJOv440asWTMKXK8u9sntVjKJAqXHCSTYE5SvVQjyXYPj7SbUMS3wgLIxcftvzWLd9Jnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769564865; c=relaxed/simple;
	bh=fTVNm7RJn/zLdCsYOiWJcBt5708nRFKu+xaSA3n8PBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKPFfuFLtS72U56Dbi5SE13mbDlGLeYqrEP6i27tB+wCe6+2OYGi7CV2A65nP5JiP1Tmykw8QddgYJqT6fzt79xhhyP3Op/4hMc+TVOvwUY2f8ziyxHk2FwFpbFkknMd1APxtJ3NaH5KqZyJmWpfHmNxOWqNkwusbu0Dwmvflww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vkueh-000000003no-1wjr;
	Wed, 28 Jan 2026 01:47:39 +0000
Date: Wed, 28 Jan 2026 01:47:36 +0000
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
Message-ID: <aXlquKmPKzGPBudZ@makrotopia.org>
References: <cover.1769519758.git.daniel@makrotopia.org>
 <d9b6212ad5137feeb58b28e9b0784f1084c813df.1769519758.git.daniel@makrotopia.org>
 <20260127132919.xsvapgqc65f44iah@skbuf>
 <aXjGh1nzeAz8TQzH@makrotopia.org>
 <20260127150747.lzlfzhusywluuxhs@skbuf>
 <aXk38o39i62SIq_K@makrotopia.org>
 <20260127222508.gvky6smlrmnj3uix@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127222508.gvky6smlrmnj3uix@skbuf>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254057-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:mid]
X-Rspamd-Queue-Id: C73809C087
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 12:25:08AM +0200, Vladimir Oltean wrote:
> On Tue, Jan 27, 2026 at 10:10:58PM +0000, Daniel Golle wrote:
> > Taking a step back I noticed that we need to decide this also for
> > mt7530.
> > 
> > commit bde1ae2d52ab ("net: pcs: pcs-mtk-lynxi: pass SGMIISYS OF node to PCS")
> > currently doesn't pass any fwnode when creating the LynxI PCS.
> > > +               pcs = mtk_pcs_lynxi_create(priv->dev, NULL, regmap,
> > > +                                          MT7531_PHYA_CTRL_SIGNAL3);
> > 
> > However, each PCS does belong to a specific switch port, and it would be
> > advantegous and imho consistent to also assign the ports OF node to the
> > PCS, this would allow to configure the polarities also on the MT7530
> > SerDes ports.
> 
> mt753x_phylink_mac_select_pcs() returns either &priv->pcs[dp->index].pcs
> for TRGMII or priv->ports[dp->index].sgmii_pcs for the rest.
> 
> How would one know (generally speaking) if properties placed in the
> ethernet-port node are for the SGMII PCS or for the other one?

Because of the port number and a fixed assignment of possible external
interface types to each port: On MT7531, port 6 is always connected
to the SerDes PCS. On MT7531AE port 5 is another SerDes PCS, while
on MT7531BE port 5 is (the only) (T)RGMII interface.
So, just like with the MaxLinear GSW1xx port and PCS are tightly
tied together.

