Return-Path: <netdev+bounces-293256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CWvLNL0GWrn0AgAu9opvQ
	(envelope-from <netdev+bounces-293256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:19:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF231608698
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C87F3002B5C
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95633A9D8B;
	Fri, 29 May 2026 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Bgux8Qcz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-244116.protonmail.ch (mail-244116.protonmail.ch [109.224.244.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2013E3AEF4C
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 20:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780085952; cv=none; b=cZg95guQ/zA8a8dfebesum77MyTWBgRHqirFCUx+cFQLZH+MpPLTw5gy7uvdXzLBb6FrHLGLv6WXkOCG/rCVvBGEoL4kelwKl14j6RTbIYKjz3o4sfeYwfHTaA2lJRtSYl/flEBI5rJRlyC86O5HAoNgqMHV0hcdKyMceaXU7L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780085952; c=relaxed/simple;
	bh=mnKQ0YjqMAADxs4LH9LKWAVTtFy3L+nSgOV3+OZtZLI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h9+Fr+sTJ9uD3+G0PNCrbKRne92Q9/D/oQQsNYq/oFlXOUK8CiNlMVaj81JhKzNgIo5HyxKOY/CjWdghjioagSpOzWSI8681/KjQ8Mu6u1tefRGEYp4q9khl1Ku72chBevHppXxwlN/bQFYuH4Tpq3syVFNXKp7z6TUP8HUDJaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Bgux8Qcz; arc=none smtp.client-ip=109.224.244.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780085940; x=1780345140;
	bh=mnKQ0YjqMAADxs4LH9LKWAVTtFy3L+nSgOV3+OZtZLI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Bgux8Qcz7/s4M32Fu+WzGfcw0TBNL4Me52Dr0Ms6FEOjJJemlZS7WuSNVgqReE8eM
	 DAXcZ0ZYZcUY8XBWdRCC6v6N57zZ72X8ZtFjc99QmQxx1h833CyWzNSqSB0MFRnLdB
	 TitdrDWCYGNx7rsBchLV5ATK3Zdox3QFROm8WEnwwQwfy3TT50K25kSIXTocr3vWg6
	 D6qpeezKlUeOuRmouLChJYlBp1t/7RPtPLkB7iX2+4XDVgvIqfH0o8E5MNaXMeDxyA
	 vkvIuYzAsRV0B9UkWU72kaISL70rMybSifXzs9xFuSpqHah52criJleh+qYo9nSJiz
	 2WOpm14AVkYAg==
Date: Fri, 29 May 2026 20:18:55 +0000
To: Stefano Brivio <sbrivio@redhat.com>
From: Tj <tj.iam.tj@proton.me>
Cc: =?utf-8?Q?=C3=8D=C3=B1igo_Huguet?= <ihuguet@redhat.com>, Thorsten Leemhuis <regressions@leemhuis.info>, Fernando Fernandez Mancera <fmancera@suse.de>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Yumei Huang <yuhuang@redhat.com>, Ido Schimmel <idosch@idosch.org>, Justin Iurman <justin.iurman@gmail.com>, David Ahern <dsahern@kernel.org>, David Gibson <david@gibson.dropbear.id.au>, Linux kernel regressions list <regressions@lists.linux.dev>, Beniamino Galvani <bgalvani@redhat.com>
Subject: Re: Problem with IPv6 privacy addresses in 7.0
Message-ID: <3f0d5431-60b0-42dc-8192-2f8a3c6da50e@proton.me>
In-Reply-To: <20260529220415.22d0be8d@elisabeth>
References: <ahnaz3ppxyVHl3xB@mail.iam.tj> <20260529220415.22d0be8d@elisabeth>
Feedback-ID: 113488376:user:proton
X-Pm-Message-ID: ab82acd7734c383f484903eb9e2baf365c68e3c4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293256-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,leemhuis.info,suse.de,kernel.org,vger.kernel.org,idosch.org,gmail.com,gibson.dropbear.id.au,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj.iam.tj@proton.me,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[proton.me:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,proton.me:email,proton.me:mid,proton.me:dkim]
X-Rspamd-Queue-Id: BF231608698
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 29/05/2026 20:04, Stefano Brivio wrote:
> On Fri, 29 May 2026 18:28:58 +0000
> Tj <tj.iam.tj@proton.me> wrote:
>
>> I believe I hit this on a router using Debian 13 with v7.0.* kernel this=
 week that
>> uses systemd-networkd to configure IPV6 RA and prefix delegation after
>> moving from v6.19.*.
>>
>> Symptom was the router could no longer reach public IPv6 addresses
>> itself but forwarding was unaffected.
>>
>> The ISP (Starlink) provides a /64 prefix via RA and a /56 via DHCPv6. ne=
tworkd
>> allocates a static suffix address from both to the WAN-side interface.
>>
>> I discovered after much experimentation that instead of the usual /56
>> address being the source it was choosing the /64 and failing.
> Do you really mean an address configured as /56, or a /64 address that
> systemd-networkd derives from a /56 delegated prefix?
Apologies - I should have been clearer. I meant addresses generated=20
*from the* respective prefixes - the addresses themselves are /64, yes!



