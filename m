Return-Path: <netdev+bounces-223796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E84B8058C
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 283F07AE8CA
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB0C28CF42;
	Tue, 16 Sep 2025 23:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/VyDMQ1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C521A9F86;
	Tue, 16 Sep 2025 23:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066882; cv=none; b=Ic88+fC8IfRlF7Jd744XOcy3YrUkRr5RZfQ7DSws74npKj+gFN2x4GAmWbVG/Tn/yJkBPaaFQiGyCmuLxQXKVq2xqYRjLxsAK0m/9I444KbQZmEqzbhWNI7uAwt5KKJA9sVmAH/dUuuEMqPvTomBrvxt+WyBNwA1tLKgeo/1bKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066882; c=relaxed/simple;
	bh=Y+tPfvJVVYGlAcY7y107Sa9854mjgV5kRi5vGaZ+aM4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rFOh95YRFcmEPz8eXYUCYAkDwjtHOWyCdYarq/aPWohEiRpemePAqISZGwIFoJBSb+w1ZMNMJdUoLjNnwZltGxXYdJdZgXTlUcpmGbZXlSpeb4rs14vdyif0Hulj7Wfr2OqIU02WMyaudgSTY+StVODm+3o+pKQihbmt1JEnPxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/VyDMQ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B89DC4CEEB;
	Tue, 16 Sep 2025 23:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758066881;
	bh=Y+tPfvJVVYGlAcY7y107Sa9854mjgV5kRi5vGaZ+aM4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P/VyDMQ1IrauQVwoVCYdxeCl0OPm4zgcatmsizn569t5sIEB8yPvGkAoJzvtRS4dn
	 s5Ktw1cgKCn9irL8jrxoliIp9kKBfUjhMRlUZpFY5fZzs08kXz4dsJ5hH142XNgi6v
	 Tq/86p/Zv1WZl0512E4jWdHJvteTa1EGdibhJQaBwE8liKxZOyVSF7P3W0wQZiygry
	 SsCXWThK4945VABj021U+u80xrSoMcF9vZOKajdwPi0iwXfeJcFSbpRV9lqt4EsCt5
	 PWd+tVtJWZILVQ7ASFSxNxtiPYfbsNuIn6pCk0b4vvGhGeRKQgWJDBibc569hzQqkM
	 v6RKqctFE6ELQ==
Date: Tue, 16 Sep 2025 16:54:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>,
 kernel@pengutronix.de, Dent Project <dentproject@linuxfoundation.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-doc@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>
Subject: Re: [PATCH net-next v3 0/5] net: pse-pd: pd692x0: Add permanent
 configuration management support
Message-ID: <20250916165440.3d4e498a@kernel.org>
In-Reply-To: <20250915-feature_poe_permanent_conf-v3-0-78871151088b@bootlin.com>
References: <20250915-feature_poe_permanent_conf-v3-0-78871151088b@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 19:06:25 +0200 Kory Maincent wrote:
> This patch series introduces a new devlink-conf uAPI to manage device
> configuration stored in non-volatile memory. This provides a standardized
> interface for devices that need to persist configuration changes across
> reboots. The uAPI is designed to be generic and can be used by any device
> driver that manages persistent configuration storage.
> 
> The permanent configuration allows settings to persist across device
> resets and power cycles, providing better control over PSE behavior
> in production environments.

I'm still unclear on the technical justification for this.
"There's a tool in another project which does it this way"
is not usually sufficient upstream. For better or worse we
like to re-implement things from first principles.

Could you succinctly explain why "saving config" can't be implemented
by some user space dumping out ethtool configuration, saving it under
/etc, and using that config after reboot. A'la iptables-save /
iptables-restore?

(I'll apply patch 3 now, looks like a nice cleanup)

