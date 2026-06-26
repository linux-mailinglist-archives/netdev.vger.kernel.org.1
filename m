Return-Path: <netdev+bounces-302137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K9DsDmZPPmr+DAkAu9opvQ
	(envelope-from <netdev+bounces-302137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 12:07:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEBC6CBECD
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 12:07:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=mchp header.b="d8M/HeC8";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302137-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302137-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FBB2300D6B6
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 10:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5073EB118;
	Fri, 26 Jun 2026 10:07:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB333EB0ED;
	Fri, 26 Jun 2026 10:07:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782468451; cv=none; b=uHfmWIrzy5zKF8sYUK3sFNuUPgYsNZmeBWT7RA2AeLHjzu6fTFGU5lLCGE0mWN+bpFEgRPKkaZrB5QjnmlqYjAerXlmEH0397tqrNalxrM5Va+WHY/5gMgTLxVzzEoJaQZ38x1voGBjHzVXr8H8//G6Kisjxp1s+va5CiDPF3Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782468451; c=relaxed/simple;
	bh=mWD9mCGrzZWHZ7x0PPyvacdrsovHQpw623DcM+HA8P0=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d0AuBul7nl1kpEw6QPLcjQQXUvS/t5++FtAZ8dgT637n7PfpqoBqCbHHF/uX03K1Tzzbxd2AK6tTPMNvGF/QNtJjySgi8mRiBUc67Z7L2YR+NhJv/HyeAJWDaSURlFMYMFNn8CbcTNWuvaZrklVlGSUWBirSk5yeLluuxliqx9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=d8M/HeC8; arc=none smtp.client-ip=68.232.154.123
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782468450; x=1814004450;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=mWD9mCGrzZWHZ7x0PPyvacdrsovHQpw623DcM+HA8P0=;
  b=d8M/HeC8C9HRycqeqtFVHAwBo/Q2lQu5y/Riou5fjyy+3VMa3lMk0Jjc
   LizIVutdNInHShpq7wWlugQ8y8EuUKnEdrwC/wGP8kCeEN4b54wudV9Rf
   BGZOMU8k1D8cwcminkBKrebCSyw9GYs5EU9+Ju5Tvy43F4ouFr1+Hajb/
   v5DMmce9FNJHldVFQN0Z61sus0wMyqkWLC7vvEdzr7GYyHM+RryBY0MqW
   qSlEpg2E4nctALkCBJ/v5LqV7BWL4S/fqvAAhjl2voBuA2biLF0nthf4v
   BB7DHitNpIoHyxwuDt6Ct+9VQHAT8ldpuuUro+rxoxTAO8UCvnY5x6/hp
   w==;
X-CSE-ConnectionGUID: KlKLWQ5ZT9mmykJiUVRU5w==
X-CSE-MsgGUID: SxoojhgbT/G54j0UDE7HWw==
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="60080065"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Jun 2026 03:07:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 26 Jun 2026 03:07:28 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 26 Jun 2026 03:07:25 -0700
Message-ID: <fc2d818282656906dc264f286c4a10c24f77f1d7.camel@microchip.com>
Subject: Re: [PATCH net-next 1/9] net: microchip: vcap: fix rule move for
 rules of coprime size
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <horatiu.vultur@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <daniel.machon@microchip.com>,
	<Steen.Hegelund@microchip.com>, <kees@kernel.org>, <gustavoars@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-hardening@vger.kernel.org>
Date: Fri, 26 Jun 2026 12:07:25 +0200
In-Reply-To: <20260615233845.1042219-1-kuba@kernel.org>
References: <20260612-sparx5_l3_routing-v1-1-fc3c10160f49@microchip.com>
	 <20260615233845.1042219-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302137-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:horatiu.vultur@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:daniel.machon@microchip.com,m:Steen.Hegelund@microchip.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-hardening@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6AEBC6CBECD

On Mon, 2026-06-15 at 16:38 -0700, Jakub Kicinski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> Subject: net: microchip: vcap: fix rule move for rules of coprime size
>=20
> This patch addresses a discrepancy in how software and hardware move rule
> addresses on insert and delete for the LPM VCAP. It introduces a uniform
> offset computation aligned to the least common multiple of all rule sizes
> in a block. This ensures that hardware and software representations remai=
n
> synchronized and all rules land on correctly aligned addresses.
>=20
> > diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api.c b/drivers/n=
et/ethernet/microchip/vcap/vcap_api.c
> > index 0fdb5e363badc..6946fd7384581 100644
> > --- a/drivers/net/ethernet/microchip/vcap/vcap_api.c
> > +++ b/drivers/net/ethernet/microchip/vcap/vcap_api.c
>=20
> [ ... ]
>=20
> > @@ -2275,8 +2336,7 @@ int vcap_add_rule(struct vcap_rule *rule)
> >                      __func__, __LINE__, ret);
> >               goto out;
> >       }
> > -     if (move.count > 0)
> > -             vcap_move_rules(ri, &move);
> > +     vcap_move_rules(ri, &move);
> >=20
> >       /* Set the counter to zero */
> >       ret =3D vcap_write_counter(ri, &ctr);
>=20
> [Severity: High]
> This is a pre-existing issue, but does vcap_add_rule() leak the newly
> duplicated rule if operations like vcap_write_counter() or
> vcap_write_rule() fail later on?
>=20
> If a failure occurs, the code takes the goto out path:
>=20
> vcap_add_rule() {
>     ...
>     ret =3D vcap_write_rule(ri);
>     if (ret) {
>         pr_err("%s:%d: rule write error: %d\n", __func__, __LINE__, ret);
>         goto out;
>     }
> out:
>     mutex_unlock(&ri->admin->lock);
>     return ret;
> }
>=20
> This seems to exit without reverting the earlier list insertions and
> hardware moves.
>=20
> Could this leave the software and hardware states permanently inconsisten=
t
> and leak the newly duplicated rule?
>=20

I think this is latent, and not actually reachable by current callers.

1. vcap_write_counter always returns 0
2. vcap_encode_rule can not error if vcap_val_rule is called before vcap_ad=
d_rule
3. vcap_write_rule can not error if vcap_val_rule is called before vcap_add=
_rule

So I propose this is fixed in seperate series.

> [ ... ]
>=20
> > @@ -2488,59 +2548,52 @@ int vcap_mod_rule(struct vcap_rule *rule)
> >  }
> >  EXPORT_SYMBOL_GPL(vcap_mod_rule);
>=20
> [Severity: High]
> This isn't a bug introduced by this patch, but does vcap_mod_rule() disca=
rd
> the active software rule pointer and overwrite hardware with stale addres=
ses?
>=20
> Looking at vcap_mod_rule(), the function validates the rule using
> vcap_get_locked_rule() but ignores the returned pointer:
>=20
> vcap_mod_rule(struct vcap_rule *rule) {
>     struct vcap_rule_internal *ri =3D to_intrule(rule);
>     ...
>     if (!vcap_get_locked_rule(ri->vctrl, ri->data.id))
>         return -ENOENT;
>     ...
>     err =3D vcap_encode_rule(ri);
>     if (err)
>         goto out;
>=20
>     err =3D vcap_write_rule(ri);
> }
>=20
> Because the function continues to use the caller provided copy ri, it
> doesn't see updates to the real rule in the admin->rules list.
>=20
> If the real rule's hardware address was previously shifted due to inserti=
ons
> or deletions, could writing to the stale address in ri->addr corrupt othe=
r
> rules in the hardware VCAP?
>=20

This is also true but latent again. To trigger this we would need concurren=
cy
against the same vcap instance. Before this series vcap_mod_rule was only
called under rtnl. This series introduces a call outside rtnl, but the new =
LPM VCAP
is not usable by tc only the routing module, which serializes everything un=
der
one mutex.

So I think this should be fixed in a seperate series.

> [ ... ]
>=20
> One other pre-existing issue noticed while reviewing this subsystem:
>=20
> [Severity: High]
> This is a pre-existing issue, but is it safe to iterate over the admin->r=
ules
> list across different VCAP instances without acquiring admin->lock for
> each instance?
>=20
> In vcap_rule_exists():
>=20
> static bool vcap_rule_exists(struct vcap_control *vctrl, u32 id) {
>     ...
>     list_for_each_entry(admin, &vctrl->list, list)
>         list_for_each_entry(ri, &admin->rules, list)
>             if (ri->data.id =3D=3D id)
>                 return true;
>     return false;
> }
>=20
> If another thread is concurrently inserting or deleting a rule on another
> VCAP instance while holding that instance's lock, could this unprotected
> concurrent access encounter a data race and dereference a poisoned pointe=
r?

Yes this becomes reachable with this series, due to calls outside rtnl.
It is a symptom of a wider issue with the per instance locking in the VCAP
api. Sashiko found another existing bug with the shared SUPER vcap register=
s
also caused by this, and that one is reachable in mainline, so I will send =
a
fix to net for the vcap locking which will also fix this problem, then send
v2 once that is settled.

> --
> pw-bot: cr


