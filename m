Return-Path: <netdev+bounces-245611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD7CCD36B1
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 21:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7ABC2300DA61
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 20:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124C726C3AE;
	Sat, 20 Dec 2025 20:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="dmKRf6xD"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9793F70824;
	Sat, 20 Dec 2025 20:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766263028; cv=none; b=Emo9m+q6u/fw1hKlP/loTfC4f02VRlGjCtXolEqPlxX2Uk2dd3uIWpgLC9MMyFBa8GNcnOr6qwkDq7pMJMxZ9ieARMpYiV/A8D/rxKJaLrZbjBeihG0GQEg8JaUBnMqY9zWDnhZ8wmgHHL4zK2pR5D5RJmdz/6GTbmgTG7gcAkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766263028; c=relaxed/simple;
	bh=A/GsheEnsB6XrrveXZGICgS4Byb1YZbjIlolJT2oNps=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=oIk8RoHS80F77luxSFU0cOXmmXt9+Pjw66152A1VXwDNphiC7Mi6CIXaND0oTBJwr5Wny2xu04C4mpIioTsoHjdT/oQlRJdC1oVQGU+GdmSWGpnyHXGqwnDBdNZmIkQsnmU+4HaSxf3IWq028K9sTWdWJaAvSng8JJj2O5z9wpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=dmKRf6xD; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1766263018;
	bh=bsQXBHkkrK4vUhqDCFv1RWqVqLSZxU0jiDpYnVwwFog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dmKRf6xDXyyZc3Q/er7KztuMMtfakxip3JxZBA7cZl1TgpRMRqQ6D9si1RKgfgd/r
	 fU7pp/aAUurG8hVtJwJY0qT9EJQCE01qzYZXhAP0WTf1GxReh6OYcOLr16pZqKixWI
	 hJJniI/85A5JSJpiw7sXUeyvZbRi4OvH6PSgLDU8=
Received: from 7erry.customer.ask4.lan ([31.205.230.119])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 9331D0B7; Sun, 21 Dec 2025 04:36:51 +0800
X-QQ-mid: xmsmtpt1766263011txsud4g0z
Message-ID: <tencent_EF65B9D0760ACECA83817F30AE262884DC0A@qq.com>
X-QQ-XMAILINFO: MeukCuWaRbQl+Aei9+39on8QftQsCXlS/JQ48q6gB88kgWRJjhpgqTWedIuJ45
	 VHtZBEabZkO/l0Xh/RUa+JHjYa2E+4TknC59+xwvHkfByo0CVd/gtSW7gGqrODD9FMIx9K5TE90y
	 N+tQqZgzfEpi/zuXM6ITW2xB/0SwY1ZO96tm/7hErA8GfYlIQiatSvm0knhgSVVfwUvrqC/LbYWd
	 S+WUgk9khStviZ2D6Yot1Y3rF3LKeEc3MTBPaGH0GROswEQVLum5zo4A+yf/CY+8Ny1N+A6tDmOP
	 GVm19pVAUPsvXDDDvRSf4bnDhf3dmsiBfsRFTUgprW4k1jpEVOdgM7mI65rih4zuKQKqhTC9G8n6
	 TVGO9F13qfq3ezxj6awGDPobZXmkU4Kvzz1vBfmfM88UYUxJhEqSXVgDift7qXU8p3Nmr0s+Eq+V
	 OPWUUIf3ruQ8xUD43aOYagdumj/lYuf7Bt+Rpv+qU+ZMsyRVYEgbETf1QO5EtfHOPeR+lOCCZ1Xj
	 jAUx7xr/k/hbHjt3jAljJ4AeK+ciMUiHvJmzCcsJebNYIiESh2bx+ZubfuwS6mvt+FUDebV+1swO
	 8Psiz7NS3jYXc3ovB93UC5SaAm6mHYAy4Fh6jzfqibFh78WGWxyjy/kidtsu/DKThvkcvtAvBdKw
	 3tbMigGgBVVQBImwf6aeF9V54BjMIMY/bizpRwBTNkNbAOKFC8rsraAjgG89/01VxcWE+3H/SnlU
	 VnRjUAEwuWfE+kPKVNlYsJ1abBR0H1BNoBTrmsmqUbjjYl/48fjL3xeyyQx5ydv0B29GwTbmqbP1
	 JMjHVNcLrzA0nt4WOsQHbgzBaFDmNg1qNLTjf/ZweRDuJ4VDBNGgGjnELBmX5vjffy6WreHM7pCg
	 kuSjgZRSR8fugrmMN5ma0Smyx8B5Ay9VYnBPX0/8NALjKoo2VlSMPD6GXOZgsxkRUKW73bhx61+t
	 8IzRlAcalZcYiRtiLk+hJSkXK84RVP4sPPxg5z0dXXliyfGFnDA5PKIyFXiIbKhGI5gPVUll2DA8
	 SyXPu77uGgHlGUq9mo3oBGyYVyI62INM43qFVNgheS0Bf63oAmDPFR1gOd2GhxGy/PmA6xEpohQ+
	 Ir4CQMxJDyfxmdoLvacy5VhajZrn4eItTaMuTz
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Jerry Wu <w.7erry@foxmail.com>
To: christophe.jaillet@wanadoo.fr
Cc: UNGLinuxDriver@microchip.com,
	alexandre.belloni@bootlin.com,
	andrew+netdev@lunn.ch,
	claudiu.manoil@nxp.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	vladimir.oltean@nxp.com,
	w.7erry@foxmail.com
Subject: Re: [PATCH net v2] net: mscc: ocelot: Fix crash when adding interface under a lag
Date: Sat, 20 Dec 2025 20:36:14 +0000
X-OQ-MSGID: <20251220203614.9548-1-w.7erry@foxmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <df7cc79c-0f46-4346-a016-1b208346bdf5@wanadoo.fr>
References: <df7cc79c-0f46-4346-a016-1b208346bdf5@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear Linux Kernel communities,

On Sat, Dec 20, 2025 at 20:00 UTC Vladimir Oltean Wrote
> The 4th item in maintainer-netdev.rst is "don't repost your patches
> within one 24h period". This would have given me more than 4 minutes
between your v2 and... v2 (?!) to leave extra comments.

> The area below "---" in the patch is discarded when applying the patch.
> It is recommended that you use it for patch change information between
> versions. You copied a bunch of new people in v2 which have no reference
> to v1. Find your patches on https://lore.kernel.org/netdev/ and
> https://lore.kernel.org/lkml/ and reference them, and explain the
> changes you've made.

Thank you for your kind suggestion. I'll learn to leverage it in my future
contribution. And I want to explain that the repeated patch was sent due
to some network issues as I thought in first email failed. The latest
patch is the correct one.

The context link is
https://lore.kernel.org/netdev/20251220180113.724txltmrkxzyaql@skbuf/T/

> Because the "bond" variable is used only once, I had a review comment in
> v1 to delete it, and leave the code with just this:

> bond_mask = ocelot_get_bond_mask(ocelot, ocelot_port->bond);

> You didn't leave any reason for disregarding this element of the feedback.

Sorry for the missing. I reserved the `bond` variable as near line 2355

>		for (port = lag; port < ocelot->num_phys_ports; port++) {
>			struct ocelot_port *ocelot_port = ocelot->ports[port];
>
>			if (!ocelot_port)
>				continue;
>
>			if (ocelot_port->bond == bond)
>				visited |= BIT(port);
>		}

I noticed that the bond variable would be used again so reserved it.
Sorry again for any inconvenience caused. If there is any information
needed or improper contribution practice from me please let me know as
I also found some other issues, being preparing to continue reporting.


