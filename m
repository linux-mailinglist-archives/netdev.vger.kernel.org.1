Return-Path: <netdev+bounces-291334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDn0IyZZFGofMwcAu9opvQ
	(envelope-from <netdev+bounces-291334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:13:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E91845CB9E4
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 644E930315ED
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA3438657D;
	Mon, 25 May 2026 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b="IXduTA2s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED2D386578
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 14:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779718075; cv=none; b=tvSrfSbe745T5gcDhIJRFZLOwgVH1X4IVCLTQH/QXiF+qlWzOO9bTZ0Aol+mQDV4RL1d7Oa0hViO2Q+N8ckEGQG8zymk6SN/eFLdgrVwQkWT7f4wgj72ohwp3vjgndJnG8G+ZVBoCM07rLRONc7zOkakJBxZsEK77QZoJAGjVrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779718075; c=relaxed/simple;
	bh=2Ho2IoV59LwkMD+Wa6e3K4Vn8fLL93pSqnoD57gbJEU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=jhESMjkImtREvmS3sSjb7fGDX3B+SRqfBkUiNR5MGUPWBgNEwfMOu2B2KxzXfZx8nzxGFiWIhn8oILd4OhwXgMYXbUGeDE0pV6JmNy8rPcaTFpF938wAxVifBV1k1UwacpawSNkb3DUm4ngYdarYkL4j4RhBTTWfBWFlfFNnZaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com; dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b=IXduTA2s; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: Subject: Cc: To: From: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1779718073;
 bh=2Ho2IoV59LwkMD+Wa6e3K4Vn8fLL93pSqnoD57gbJEU=;
 b=IXduTA2s4V4sLkEQHkNFX2pXACy/KU9cYjEMOU5bWy+lFNVbZKI+qc09amJw+lSWrWNvGqyrt
 +dLXVeo2M1ZImCGKq3WojKgvP/DZaxqJ31Mfl9dHQEcwem4SUnCzsDU9DSTklbRRHhVhXc4YlVB
 5pk2SLqLCr35q5HlJDMY1wHeZE6aSziUiHNmxe55z5nrivtcp+RpX1H0NRR3ymCcuI9Dc6axoRj
 19kAas8i8JbYu67GV9Z/sPddqucXxhK8c3NXM8xk3tYJW6glFrUVqSQIOsCYXRX+463uIkzqoPU
 VlU3Z0IJSc6FIX66ekrcNV53Pbwe3I8ovikh2hiQ+knw==
X-Forward-Email-ID: 6a1457b79efc2641fb7d3a63
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.8.15
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Mon, 25 May 2026 10:07:50 -0400
Message-Id: <DIRTEIGVL56X.1W49YU67DXNUQ@ubuntu.com>
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: "Sasha Finkelstein" <k@chaosmail.tech>, "Joshua Peisach"
 <jpeisach@ubuntu.com>
Cc: "Sven Peter" <sven@kernel.org>, "Janne Grunau" <j@jannau.net>, "Neal
 Gompa" <neal@gompa.dev>, "Marcel Holtmann" <marcel@holtmann.org>, "Luiz
 Augusto von Dentz" <luiz.dentz@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, <linux-kernel@vger.kernel.org>,
 <asahi@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <linux-bluetooth@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v3] Bluetooth: Add Broadcom channel priority commands
X-Mailer: aerc 0.21.0
References: <20260525-brcm-prio-v3-1-6259e10233f8@chaosmail.tech>
 <DIRT7260SRQZ.1BFF8CX3FJ57G@ubuntu.com>
 <172D11E7-AF98-43F8-B41B-907738749EA5@chaosmail.tech>
In-Reply-To: <172D11E7-AF98-43F8-B41B-907738749EA5@chaosmail.tech>
X-Spamd-Result: default: False [5.34 / 15.00];
	SEM_URIBL(3.50)[ubuntu.com:email,ubuntu.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MV_CASE(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-291334-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[ubuntu.com:s=fe-953a8a3ca9];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,jannau.net,gompa.dev,holtmann.org,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ubuntu.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jpeisach@ubuntu.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[ubuntu.com,none];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	TO_DN_SOME(0.00)[];
	NEURAL_SPAM(0.00)[0.476];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ubuntu.com:email,ubuntu.com:mid,ubuntu.com:dkim]
X-Rspamd-Queue-Id: E91845CB9E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon May 25, 2026 at 10:05 AM EDT, Sasha Finkelstein wrote:
>
>> On May 25, 2026, at 15:58, Joshua Peisach <jpeisach@ubuntu.com> wrote:
>>=20
>> On Mon May 25, 2026 at 8:11 AM EDT, Sasha Finkelstein wrote:
>>>=20
>>> + cmd.enable =3D !!enable;
>>> +
>>=20
>> Probably a dumb question, but worth asking - what is the purpose of the
>> "!!"? Wouldn't just passing "enable" be sufficient?
>
> This is a way to enforce that the value is exactly 0 or 1, not 0 or non-z=
ero.
>
>>=20
>> Also, currently, cmd.enable seems to just be set and used in the case
>> of boolean conditions. Would it make sense for the enable field in
>> brcm_prio_cmd to be a bool or does it not really matter?
>>=20
> Opposite, actually, this struct is fed to firmware, and it needs to be
> specifically a u8.

Got it, thanks!

Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>

