Return-Path: <netdev+bounces-292477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PDtBuyDF2rJHggAu9opvQ
	(envelope-from <netdev+bounces-292477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 01:53:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE525EB0F0
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 01:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1946F302FCF5
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 23:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F723B3C06;
	Wed, 27 May 2026 23:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="sYGMh5qL"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F4D2F12CE;
	Wed, 27 May 2026 23:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779925990; cv=none; b=EBRoxWggr1+u2gh8C1bCbQQcLho04EDD1S+y0xXiBQ7hA8BvU44XNKtF2MLA1TCGciq4LACfx76XuJUroXmMZFAe6HAOYPs15rND7nyqqvlz5H3t93KZFRqnYTjVutImeAz6R8r2EqdcXUBfI9KvLsFUpW01UPWw9EYjE7O8CpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779925990; c=relaxed/simple;
	bh=FiRCXE+ry0UYOfyR61+hOQdaVSijUZEI/X5/4ZSjh0M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=IZWB1Yd7uLJRJXQihOsRsC1HNBGuD4BjUZauwzBtiESNTQud7qjE+hq1qpzGLkdDrmsw/fjJf9tCT5YnOUH/aYBIiwkafSLO3bwj7HWhGkivarQn0pnGMGNuDpBKdQIrQZks7xR2dF8tMNIh4GZTB+Cofvd9UkcHlMDyHy2gcWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=sYGMh5qL; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 64RNqcur012679
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 28 May 2026 00:52:40 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 64RNqcur012679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1779925964; bh=dY+koG+rDbK6oNNjTIXhpa7guFcKUU2M2+I70SQwZ+w=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=sYGMh5qL/5YHjyaAkO3LoafY9T4EODUiVKNsmk2rHpXVaFjRd7PCTmKO3ijkxvhKi
	 jZRDS7GWYVwZvGf5taK9DhecfjpdYZah3m7oA/59GPhEwuBNYRdc9Mhwc7UT45o7ah
	 PTkyCXjcVpaZ9ukCzfSB/D1ZW1jNmSQEfq/UbWsnhfnKGWtABMh26M5o/rPxeKspsu
	 7/BE2j8uldMevFRafe28V0+SB2HOGQmMjhr6AvuUowMoydtDad/rKyKyAoHDgXq/1Y
	 phL2ES6/WyeWNYIgJC+3bCOlA1UrJhUbTrkAeuyF5leY1OIbNAr1JThFfy5QkAWMA+
	 /n7Q197m3r8ig==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: add support for credit
 based shaper
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <20260522-net-next-mv88e6xxx-cbs-v1-2-c87a8e6bcc0c@luminex.be>
Date: Thu, 28 May 2026 09:52:27 +1000
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0FB1CAF0-D30C-4A24-A684-1D1DBEE52FA5@padl.com>
References: <20260522-net-next-mv88e6xxx-cbs-v1-0-c87a8e6bcc0c@luminex.be>
 <20260522-net-next-mv88e6xxx-cbs-v1-2-c87a8e6bcc0c@luminex.be>
To: cedric.jehasse@luminex.be
X-Mailer: Apple Mail (2.3826.700.81)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-292477-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[padl.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	APPLE_MAILER_COMMON(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6EE525EB0F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Cedric,

In anticipation of potentially rebasing my MQPRIO patch series upon this =
patch, I have some comments. (My MUA appears to have ruined the =
indentation, apologies.)

> Some of the chips supported by this driver have credit based shaper
> support. Support is added for the 6352, 6390 and 6393 families.

Would also be good to add support for the 6341, which as 4 queues but =
uses the same Qav multipliers as the 6390.

> + if (cbs->enable) {
> + if (cbs->idleslope <=3D 0 ||
> +    cbs->idleslope > qav->max_rate ||
> +    cbs->sendslope >=3D 0 || cbs->hicredit <=3D 0 ||
> +    cbs->hicredit > qav->hi_limit_mask)
> + return -ERANGE;

Other drivers (e.g. felix_vsc9959) round up and clamp, rather than =
validating. I would consider whether this validation is necessary at =
all, and/or whether it would suffice to omit the idleslope check and =
check only rate_mask. The idleslope and sendslope zero validation might =
be better placed in sch_cbs.c.

> + if (!cbs->enable) {
> + err =3D avb_ops->port_qav_write(chip, port, rate_reg, 0);

The convention is to provide a wrapper function, e.g. =
mv88e6xxx_port_qav_write(), returning -EOPNOTSUPP if the function =
pointer is NULL.

> + if (!(chip->ports[port].cbs_active_queues & ~queue_bit)) {
> + err =3D ops->port_set_scheduling_mode(chip, port, 0);
> + if (err)
> + goto unlock;
> + }
> + chip->ports[port].cbs_active_queues &=3D ~queue_bit;
> + goto unlock;
> + }
> +
> + hi_limit =3D cbs->hicredit & qav->hi_limit_mask;
> + err =3D avb_ops->port_qav_write(chip, port, hilimit_reg, hi_limit);
> + if (err)
> + goto unlock;
> +
> + err =3D avb_ops->port_qav_write(chip, port, rate_reg, rate);
> + if (err)
> + goto unlock;
> +
> + err =3D ops->port_set_scheduling_mode(chip, port,
> +    chip->info->num_tx_queues - 1);
> + if (err) {
> + avb_ops->port_qav_write(chip, port, rate_reg, 0);
> + goto unlock;
> + }
> + chip->ports[port].cbs_active_queues |=3D queue_bit;
> +
> +unlock:
> + mv88e6xxx_reg_unlock(chip);
> +
> + return err;

This may not matter in practice, but SMI errors will leave the register =
state in an inconsistent configuration. I would consider having multiple =
cleanup handlers that revert the state to that on function entry.

With respect to cbs_active_queues, my personal opinion is to not cache =
state both in the driver and registers where possible (to avoid the =
possibility they may get out of sync), but it is true that on a device =
with many queues, determining the CBS state dynamically would be =
expensive. I would be interested in others=E2=80=99 opinion here.

> +struct mv88e6xxx_qav_info {
> + u32 max_rate; /* in kbps */

Per above comment, perhaps consider whether max_rate is required. Also, =
queue_mask can be determined dynamically from chip->info->num_tx_queues, =
so can be elided.

Cheers,
Luke=

