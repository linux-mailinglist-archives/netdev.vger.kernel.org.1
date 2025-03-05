Return-Path: <netdev+bounces-172018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D9CA4FECB
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 13:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEFA13A82F8
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 12:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C0B245024;
	Wed,  5 Mar 2025 12:37:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406C6248892
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 12:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741178278; cv=none; b=pM+HrWWjIy5H+3CkeMJJG4KLzYcbk79UHMLc/3xH+1ysF3X0G1TkHLPNVoF1s25AH8BE/uH7EvKsPtJKj+c+3AJXdZpbtHn0jBkhKHiOmcHR813XvtlGNYbe5QD9yAYdIV9yebKpi+nFm/oY5rhlKaJFq9h1VOyQfyBU1klZ4fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741178278; c=relaxed/simple;
	bh=atbo+Sw+ywEjXYbDqhJ7fHwRDqekYLT15511ErIShro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+QRNEaL4wLyulTOv9NAC5hnGUuWLFwKDy6jyTVirpnTLNW7wXP14hIJKnnpjqREmNAI0OVdiOg+9ooNm9zjd2B3BbXHEam1bzx+cJPG7/zjXMRuq9D07GuJ1NrHxIvc2f2zD0BzVzYIXyCvNwHouDtcoIiujUxs3ga/BreSH8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tpo0P-0003XA-U0; Wed, 05 Mar 2025 13:37:45 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tpo0O-00495a-0K;
	Wed, 05 Mar 2025 13:37:44 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tpo0N-00ERN3-37;
	Wed, 05 Mar 2025 13:37:43 +0100
Date: Wed, 5 Mar 2025 13:37:43 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Woojung Huh <woojung.huh@microchip.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, devicetree@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: sound: convert ICS-43432 binding to
 YAML
Message-ID: <Z8hFlwK27AM4d17b@pengutronix.de>
References: <20250305102103.1194277-1-o.rempel@pengutronix.de>
 <20250305102103.1194277-2-o.rempel@pengutronix.de>
 <174117806721.1245382.8322491579922154490.robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <174117806721.1245382.8322491579922154490.robh@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Mar 05, 2025 at 06:34:27AM -0600, Rob Herring (Arm) wrote:
> 
> On Wed, 05 Mar 2025 11:21:00 +0100, Oleksij Rempel wrote:
> > Convert the ICS-43432 MEMS microphone device tree binding from text format
> > to YAML.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> > changes v4:
> > - add Reviewed-by: Rob...
> > changes v3:
> > - add maintainer
> > - remove '|' after 'description:'
> > changes v2:
> > - use "enum" instead "oneOf + const"
> > ---
> >  .../devicetree/bindings/sound/ics43432.txt    | 19 -------
> >  .../bindings/sound/invensense,ics43432.yaml   | 51 +++++++++++++++++++
> >  2 files changed, 51 insertions(+), 19 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/sound/ics43432.txt
> >  create mode 100644 Documentation/devicetree/bindings/sound/invensense,ics43432.yaml
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/invensense,ics43432.yaml: maintainers:0: 'N/A' does not match '@'
> 	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
> 

Sorry, i picked the old version...

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

