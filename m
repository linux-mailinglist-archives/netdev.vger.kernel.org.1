Return-Path: <netdev+bounces-143430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 949AB9C26A6
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 21:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31389B23927
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 20:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B34A1D0F6C;
	Fri,  8 Nov 2024 20:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dmJygNtt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED631198A37;
	Fri,  8 Nov 2024 20:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731098146; cv=none; b=td7E9W5AeGO4FbUxlMNefGwdtnqVMeNvy2IOM6HyLQh5Xlve7e2ljW4Bk/lPe5KwJUPJ6qfAvl7A4BAPHM62UVFra3cumiqUJ7eREJWsAiW3+bvb5gjgCG1CKxoOdqlZEAzueKsgnUTEce+iWAsr6p3jTDZr9c1LdWRuVIbvKNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731098146; c=relaxed/simple;
	bh=xh5OLB3np4ZtUX02MQvBFI2l23HkszoXhvW2j5MOnjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzcXEGi+lAbiONyOfZfkqQSy9rUG2w7Sv9pc/Kqf6IhQLkKnQxGBc8gvsqtYqxLtqOdXAohk4HOXHBUZ5mCyPhNBzddlsBIE/ZElkjgOQCt8TnE++NSJ4ibA8x7mqQ5l2SV7VLvO5BJ2wWbgESKCr0IhiFagr0E7+sl6a/cXfUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dmJygNtt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lLvn3RM57bm0NtxPWZZjJxSzU5eVmQ9pfII4g477icc=; b=dmJygNtttriQsY4vPFCq5CcQoL
	R3mP7ChVU0yN0TL9smzOPr6KjPgdrZZ8RHqpOvfGE+usirusbG8TGQp91nzyhyjY6v9laWZgmpEx+
	fkEJasSxdRx2W+TG3wEEcsvY6Q0RjLObENQ1xYQZvlMs8QhEr4CxdqQDxYj68mmqseo8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t9Vhc-00Cdwm-Ug; Fri, 08 Nov 2024 21:35:32 +0100
Date: Fri, 8 Nov 2024 21:35:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [net-next PATCH] net: dsa: add devm_dsa_register_switch()
Message-ID: <af968377-d4c4-4561-8dc6-6f92ff1ebbf4@lunn.ch>
References: <20241108200217.2761-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108200217.2761-1-ansuelsmth@gmail.com>

> +int devm_dsa_register_switch(struct device *dev, struct dsa_switch *ds)
> +{
> +	int err;
> +
> +	err = dsa_register_switch(ds);
> +	if (err)
> +		return err;
> +
> +	return devm_add_action_or_reset(dev, devm_dsa_unregister_switch, ds);
> +}
> +EXPORT_SYMBOL_GPL(dsa_register_switch);

This looks to be the wrong function name.

    Andrew

---
pw-bot: cr


