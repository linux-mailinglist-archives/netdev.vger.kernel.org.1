Return-Path: <netdev+bounces-292897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +J0GInrUGGrSnwgAu9opvQ
	(envelope-from <netdev+bounces-292897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:49:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB255FB829
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 89C223018147
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D890340402;
	Thu, 28 May 2026 23:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="HNgiuo08"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1507925B099;
	Thu, 28 May 2026 23:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780012147; cv=none; b=llDwrZVneGQrIP0+Cb0tDI9XPEksxGjMHW9e2cDUknF+or+kNsGvpKOdZUx2/9TD3HzSK6Cqm5jOXYSPsVR8PgDAQkp6ILdSqMLOHsNRvB8EAo9Vh57pTXy3NhfJWk2Hvd9xOtqKV7JVUsFR7VT8KHi6Ty6dB0DxnECIVVL+aHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780012147; c=relaxed/simple;
	bh=f9++tn1uNPC5Mn11uf9IOU2WNtoxSDiUZabDIuTt0ZE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=df6JJzkuRw6SuiopWxussSEV5x3vsQLcvVcg83APEIsa3ELT+Jo1/MazaCqGZ3hlpCv5Ab6Y/7Ki2MIPWvkhOdVDMq0VyRLnO9P112M/TMwyuBrPlI7k9VoQLqohc4mfOe+f8sC2myUVDhW9Cn5SVM/hfvvU4F8UKjtD8foC9RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=HNgiuo08; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 64SNmive001407
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 29 May 2026 00:48:46 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 64SNmive001407
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780012130; bh=T+oFPHGI1ON8ErsrkM5XIqTSsN5NY6DvkvxM2h1TgLw=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=HNgiuo08TL4B2vePPJpMIf0wVzlRM/4AK46RAqOEQ+eeyOvshCSrRwhr5T8nF9SnM
	 0CJA95v1MAKrzi3d4zRiYfVql9H62soPp63qtSwPsKzrz+KM97jZh2mJ9FwOiQxc/2
	 6ZJqDQe2U2ve0oIj0JIgJNr5+x8gOoQL9fZ7FVNSKPFy/OzBzr+yrt6UIScEcZp+gp
	 WlaaoR3RkPFqbZEh2hI5hJNj86GuMAjTxrnc3b5RCe5FqODSH9+Tro5u0fiPYUA0yp
	 Tjr1vmmkDBz3hngboLMoPBzqVrbS8SeRKsAKkzdwLnY+D8+92z0mQ8+Fx3g3JJm5l5
	 LnTrl2azWvkIA==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next v4 2/2] net: dsa: mv88e6xxx: add support for
 credit based shaper
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <20260528-net-next-mv88e6xxx-cbs-v4-2-8bd13b906457@luminex.be>
Date: Fri, 29 May 2026 09:48:33 +1000
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        Cedric Jehasse <cedric.jehasse@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DA213B68-5654-498A-B688-B92703923CCE@padl.com>
References: <20260528-net-next-mv88e6xxx-cbs-v4-0-8bd13b906457@luminex.be>
 <20260528-net-next-mv88e6xxx-cbs-v4-2-8bd13b906457@luminex.be>
To: cedric.jehasse@luminex.be
X-Mailer: Apple Mail (2.3826.700.81)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292897-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[padl.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	APPLE_MAILER_COMMON(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[padl.com:mid,padl.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8AB255FB829
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Cedric,

Looking good!

> +static int mv88e6xxx_setup_tc_cbs(struct dsa_switch *ds, int port,
> +  struct tc_cbs_qopt_offload *cbs)
> +{
> + const struct mv88e6xxx_avb_ops *avb_ops;
> + struct mv88e6xxx_chip *chip =3D ds->priv;
> + const struct mv88e6xxx_qav_info *qav;
> + const struct mv88e6xxx_ops *ops;
> + int hilimit_reg;
> + int rate_reg;
> + u8 queue_bit;
> + u16 hi_limit;
> + u16 rate =3D 0;
> + int err;
> +
> + ops =3D chip->info->ops;
> + avb_ops =3D ops->avb_ops;
> + qav =3D chip->info->qav;
> +
> + if (!qav || !avb_ops || !avb_ops->port_qav_write ||
> +    !ops->port_set_scheduling_mode)
> + return -EOPNOTSUPP;

Only the first check should be necessary because the wrapper functions =
return -EOPNOTSUPP in the case of a NULL function pointer.

> + if (!(chip->ports[port].cbs_active_queues & ~queue_bit)) {
> + err =3D mv88e6xxx_port_set_scheduling_mode(chip, port, 0);
> + if (err)
> + goto unlock;
> + }

Missing a newline here after closing brace.

> + chip->ports[port].cbs_active_queues &=3D ~queue_bit;
> + goto unlock;
> + }

The control flow might be clearer were goto unlock only taken in case of =
error. i.e. wrap the CBS enable case in an else block.

> +
> + hi_limit =3D cbs->hicredit & qav->hi_limit_mask;
> + err =3D mv88e6xxx_port_qav_write(chip, port, hilimit_reg, hi_limit);
> + if (err)
> + goto unlock;
> +
> + err =3D mv88e6xxx_port_qav_write(chip, port, rate_reg, rate);
> + if (err)
> + goto unlock;
> +
> + err =3D mv88e6xxx_port_set_scheduling_mode(chip, port,
> + chip->info->num_tx_queues - 1);

For the 6020 (which you brought to my attention as only supporting CBS =
on half its four queues), should strict priority be enabled only on the =
CBS queues or on all queues? (I don=E2=80=99t know the answer, just =
asking.)

Cheers,
Luke


