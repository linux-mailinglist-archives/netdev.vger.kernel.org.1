Return-Path: <netdev+bounces-300240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 29/CHloHM2qz8gUAu9opvQ
	(envelope-from <netdev+bounces-300240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 22:45:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE7B69C66C
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 22:45:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=foYNpM6N;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300240-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300240-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FD14304814C
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 20:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956503CC33F;
	Wed, 17 Jun 2026 20:45:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AAA36F91C;
	Wed, 17 Jun 2026 20:45:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781729107; cv=none; b=L4rL5f17zvMSzKWMBTWDQnrFvDAtOmtfeP93uhNezlf8pwemOlN2pu/aeoHQJ5HH/pYbDfM9p6lEWIe6BiN3d9qcf4Fk+orshEk1p/G4Ke+/wlJfcIlhfvJD10uB6RzGeqbb6qGkGanXzCMD2sL2PGlO2Lq2BnPME9sKA9px23I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781729107; c=relaxed/simple;
	bh=xGPx+X0RFl0bqs278ZjvITbFt/H8mQ/Pik0MZ7xR6bw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViHbQ+EQ5Y+4yBERaonvcu+RSk+E4v+nMI7DOs2/Kf+JT1fJSvZk5mAsybSfVcj03EnGtS7cdk2PiI5J1TXgUtDlUkLLHm/HEeBv+xdA1LFx1YXlnhRqB5BZuIrsd85i3MPZoz4+uDxZnOCTE3MINoMXajsvT4TJ/ag0JguDDYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foYNpM6N; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53C11F000E9;
	Wed, 17 Jun 2026 20:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781729106;
	bh=pWLcFg98iVgWXU5jkY3pU2Pt0E9oVrM3Uc2cwNvuEK0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=foYNpM6NmTxMBAWqSQ1AmxjNb9e6ZBaw9oacl1EomZvRPdZhlXOC5d0HF1n7jR84e
	 hmUUW70AmdOw/RsNBIV62ovUHSl3MiaDyVBk2LCm24JYxVIfV9FekhokRTrjcHbAB4
	 wIzOJGQBNcnLhuYt7ogEDNeldaGK/9qkyUUN4oVqpfqxospwYpPgj2fk0wTfy/NyQl
	 /v6+Y6xjisBfUyymu3gBCrCBSM6A3m/R9NMYEf+pr7Jxaeady3n9HAX0TSmQ4KvxtS
	 MuxGPPU22DWtH9V1+QOWlOFH94B9XKXYtrMBldhIsnxW/IxgNOwLuRt3i2Q6yo+imC
	 tSO0ScjKSkV+A==
Date: Wed, 17 Jun 2026 13:45:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yibo Dong <dong100@mucse.com>
Cc: Andrew Lunn <andrew@lunn.ch>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaojun@mucse.com
Subject: Re: [PATCH net] net: rnpgbe: fix mailbox endianness handling
Message-ID: <20260617134505.57fea1be@kernel.org>
In-Reply-To: <5249B5A1F6CD9ACB+20260617140530.GA278329@nic-Precision-5820-Tower>
References: <20260617083531.251119-1-dong100@mucse.com>
	<bf5366c5-88ae-418c-9c5d-b2249a7f43fc@lunn.ch>
	<0C93ADB24CB93157+20260617114614.GA273003@nic-Precision-5820-Tower>
	<26517b8f-33b7-4de7-8fe8-c7dca5fa7a4b@lunn.ch>
	<5249B5A1F6CD9ACB+20260617140530.GA278329@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300240-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dong100@mucse.com,m:andrew@lunn.ch,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:vadim.fedorenko@linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yaojun@mucse.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CAE7B69C66C

On Wed, 17 Jun 2026 22:05:30 +0800 Yibo Dong wrote:
> On Wed, Jun 17, 2026 at 02:09:00PM +0200, Andrew Lunn wrote:
> > > My understanding is as follows:
> > > The firmware structures are defined with__le16 / __le32 for wire form=
at,
> > > but the original code cast these struct pointers to u32 * before pass=
ing
> > > them to the mailbox read/write routines:
> > > - Send path: (u32 *)&req -> msg buffer -> writel()
> > > - Receive path: readl() -> msg buffer -> (u32 *)&reply
> > > Sparse only sees pure u32 =3D u32 assignments here, so no type mismat=
ch is
> > > reported. =20
> >=20
> > Can the code be changed so that it does not need the cast? Casts are
> > bad, as you have just shown. This is something i try to push back on,
> > it makes you think about types and avoid issues like this.
> >=20
> > 	Andrew
> >  =20
> Thinking... Yes. A few possibilities:
>=20
> 1. Make all fields __le32, then extract via shifts:
>    struct mbx_fw_cmd_req {
>        __le32 word0;  // [15:0]=3Dflags  [31:16]=3Dopcode
>        __le32 word1;  // [15:0]=3Ddatalen [31:16]=3Dret_value
>        ...
>    };
>    But that's painful =E2=80=94 le32_to_cpu(req.word0) >> 16 vs req.opcod=
e.
>=20
> 2. Use a union to keep named fields while also exposing __le32[] access:
>    union mbx_fw_cmd_req_u {
>        struct mbx_fw_cmd_req req;
>        __le32 dwords[sizeof(struct mbx_fw_cmd_req) / sizeof(__le32)];
>    };
>    union mbx_fw_cmd_reply_u {
>        struct mbx_fw_cmd_reply reply;
>        __le32 dwords[sizeof(struct mbx_fw_cmd_reply) / sizeof(__le32)];
>    };
>=20
>    The transport interface becomes:
>    int mucse_write_mbx_pf(struct mucse_hw *hw, const __le32 *msg, u16 siz=
e);
>    int mucse_read_mbx_pf(struct mucse_hw *hw, __le32 *msg, u16 size);
>=20
>    Callers would use:
>    union mbx_fw_cmd_req_u cmd =3D {};
>    cmd.req.opcode =3D cpu_to_le16(...);
>    cmd.req.flags  =3D cpu_to_le16(...);
>    mucse_write_mbx_pf(hw, cmd.dwords, sizeof(cmd.req));
>=20
>    If the transport layer forgets le32_to_cpu(), sparse would catch it
>    because msg is __le32 * and mbx_data_rd32() returns u32.
>=20
>    The downside is an extra union wrapper and an extra level in field
>    access (cmd.req.opcode vs req.opcode) =E2=80=94 a minor inconvenience.
>=20
> Do you have a preference between these, or another approach?
>=20
> Thanks for the feedback.

3. Maybe use memcpy_toio() to transfer the data without any byteswaps?

