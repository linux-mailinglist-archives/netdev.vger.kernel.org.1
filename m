Return-Path: <netdev+bounces-214410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E59AB294E0
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 21:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17FF4E4DEB
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 19:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6F91FF603;
	Sun, 17 Aug 2025 19:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WpvtdpdD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061DA12B73;
	Sun, 17 Aug 2025 19:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755459592; cv=none; b=clIKjUa0gNhF8UNoWXiuWnoxCsICMFC7liUAHEEEDPuqEFzvsnKs1ZdAI+x2eKQ9Okw04nPibGY+BLYYZq80XMLzDlU+Y0bdHE1ZLg+aKDHawx8cHxscVYPA/8OQrXahS+6e/HIv5G+ZWur+sj75haQsEi3dJ4By+1JOXGRTFX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755459592; c=relaxed/simple;
	bh=fm9MC9w71x2V6wUYh0NhquPACQ+eHjamPHK0Jmda5po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPVzbwEakLu2/fhAShGm+vDQiNn4vk78ozlZq/pmqkocnoamtwwFRlB1pVGeTqbOpmpKpSvn/RlHjO/9y7u61U7v9KZzfCD/iW5+w7HZSiGSbTaorDk/8fBN45th8JeggyAMDu9La7UNNuramrgWNl1lNRzQFa05lOihRN0IRIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WpvtdpdD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QO7IaYTt/6d2MUg1fvfXtUP6TpN6Oc9uIKuq9biZ7vo=; b=WpvtdpdDNDKoBlSSHEkaJM8Dlr
	YGhuW3iHT5E92MLMSSfcqS518WRFZvYdLHUl5HgGcxiA2A0njMq7fdgBEh4MCfCiIsvruIdk+uM3+
	DhvtMOTL9VxvAXs5XJI7lmh+Qxl/bfVPKl/xd+Wm7d/IfomQYJiKnRvccLK1ADgAPrvA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1unjE8-004z45-E5; Sun, 17 Aug 2025 21:39:36 +0200
Date: Sun, 17 Aug 2025 21:39:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rob Landley <rob@landley.net>
Cc: Artur Rojek <contact@artur-rojek.eu>, Jeff Dionne <jeff@coresemi.io>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] net: j2: Introduce J-Core EMAC
Message-ID: <bc31f53a-ba85-4580-add3-a287dca06661@lunn.ch>
References: <20250815194806.1202589-4-contact@artur-rojek.eu>
 <973c6f96-6020-43e0-a7cf-9c129611da13@lunn.ch>
 <b1a9b50471d80d51691dfbe1c0dbe6fb@artur-rojek.eu>
 <02ce17e8f00955bab53194a366b9a542@artur-rojek.eu>
 <fc6ed96e-2bab-4f2f-9479-32a895b9b1b2@lunn.ch>
 <7a4154eef1cd243e30953d3423e97ab1@artur-rojek.eu>
 <ee607928-1845-47aa-90a1-6511decda49d@lunn.ch>
 <9eab7a4ff3a72117a1a832b87425130f@artur-rojek.eu>
 <52aef275-0907-4510-b95c-b2b01738ce0b@lunn.ch>
 <d4f291e3-9d4f-4724-91de-742f9ace5b86@landley.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4f291e3-9d4f-4724-91de-742f9ace5b86@landley.net>

> My vague recollection is this SOC only implemented full duplex 100baseT
> because they didn't have any hardware lying around that _couldn't_ talk to
> that.

It is pretty unusual to find hardware, now a days, which only does
10Mbp. So it is a somewhat theoretical use case. And as you say,
100Mbps is plenty fast for lots of applications.

What we need to think about is the path forwards, how MDIO and PHY
support can be added later, without breaking DT backwards
compatibility.

What you would normally do if there is no access to the PHY is use
fixed-link. It emulates a PHY, one that is always up and at a fixed
speed. See fixed-link in
Documentation/devicetree/bindings/net/ethernet-controller.yaml

That allows the MAC driver to use the phylib API. The MAC does not
hard coded the carrier up, phylib tells the MAC link is up, and phylib
manages the carrier.

What this means is, if sometime in the future MDIO is added, and
phylib gets access to the PHY, there are no MAC driver changes. Old DT
blobs, using fixed-link still work, and new DT blobs with MDIO, a PHY
node, and a phy-handle have working PHY.

If you don't do this now, adding support later will be messy, if you
don't want to break backwards compatibility with old DT blobs.

	Andrew




