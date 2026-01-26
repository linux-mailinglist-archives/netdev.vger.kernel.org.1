Return-Path: <netdev+bounces-253570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPYNIFu2d2n3kQEAu9opvQ
	(envelope-from <netdev+bounces-253570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 19:45:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 202138C300
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 19:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75A24302158C
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 18:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A80925BF13;
	Mon, 26 Jan 2026 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PafYqorl"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63EF8F5B
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769453139; cv=none; b=OkD5hDbb5IsxOCE1dFpLhX4yqIS3LDXVt4lRa/LdoJdtdURDr/VmIT0rYp7O30u/s2lEQeSxs9Nr/+Sysve5rJ22QvoJ1qMHnIRLlvQBBjxUtSre1AmnA+bIEerS6onp4SPvYAgV+gJX+Ln+2jonazCx2I3LG+UmdBxpSBXaALA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769453139; c=relaxed/simple;
	bh=WhQXw4JHbLWsW64Jp69XFlwCDuuVv0njTZH8hBYA18M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=YgDKuOS40QMPnAwgnw8sxFxfhCUQfEOe/0QDqeIRIjvFTjzOSpIHiVKB+cVWsOnDw2nktyRlc/yNTK8zk7Hgw9w0zKoPbI2Efg0r1wWS92FErD8i2DAWS7ao1udQjtgl/IomWfzIeaT1zgXvjWWNpk3qNqXSS0xw1/+Llmoj3bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PafYqorl; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2CFA94E422AD;
	Mon, 26 Jan 2026 18:45:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E13F060717;
	Mon, 26 Jan 2026 18:45:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C9B3D119A8652;
	Mon, 26 Jan 2026 19:45:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769453134; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BuSTLIZdsIKbxDUOqNbeY1fRUhRsulVmHEBjfsq+WaU=;
	b=PafYqorlWc3k/f2ENpMLkvRQl+pOrnDTkX9L9BMwGBb/QtWBqKglcXntT8vzMCtz2D6uvv
	/K3U32Yy+WT2bRDwc8/GmBMinPCuXGvwdTiwhD8NvQbY2pgJkrjHzUR2hDVYq6QnGWPIZh
	wIz4wT1cy1GTFu8INfO9TP/WKYmGd5iDWcSBRPp4vbpT6GSyv52ZvKlgkCO3HllOprdssc
	rkqWRVrTAZlgMwFw23AEEdoAreeKllCRGpbK/VmmPNIczgU/sZPtHu6K1PY3XDNBpQvsM0
	a+nSO0MQcpHB14+0gNL2gK1lTFtAEM+Qm1R07fmtpPmjPT1/gas+wqRtpPohrQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Jan 2026 19:45:29 +0100
Message-Id: <DFYQS9RIPCSY.25SHGGC3VM2M3@bootlin.com>
Cc: <netdev@vger.kernel.org>, "Nicolas Ferre" <nicolas.ferre@microchip.com>,
 "Claudiu Beznea" <claudiu.beznea@tuxon.dev>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Lorenzo Bianconi" <lorenzo@kernel.org>,
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
To: "Andrew Lunn" <andrew@lunn.ch>, "Paolo Valerio" <pvalerio@redhat.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 3/8] cadence: macb: Add page pool support
 handle multi-descriptor frame rx
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260115222531.313002-1-pvalerio@redhat.com>
 <20260115222531.313002-4-pvalerio@redhat.com>
 <4c74c2c4-7a47-45ff-be17-485e0702cc37@lunn.ch> <87cy315lru.fsf@redhat.com>
 <840fd286-779e-4130-b544-913116c97a29@lunn.ch> <87qzrdecs1.fsf@redhat.com>
 <b0bff7a8-a004-4eb7-bf1d-2137182e59f9@lunn.ch>
In-Reply-To: <b0bff7a8-a004-4eb7-bf1d-2137182e59f9@lunn.ch>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253570-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:url,bootlin.com:mid]
X-Rspamd-Queue-Id: 202138C300
X-Rspamd-Action: no action

On Mon Jan 26, 2026 at 3:29 PM CET, Andrew Lunn wrote:
>> > I was more interested in plain networking, not XDP. Does it perform
>> > better with page pool? You at least need to show it is not worse, you
>> > need to avoid performance regressions.
>>=20
>> I retested with iperf3. The target has a single rx queue with iperf3
>> running with no cpu affinity set.
>>=20
>> |              |  64 | 128 |
>> | baseline     | 273 | 545 |
>> | pp (page)    | 273 | 544 |
>> | pp (2 frags) | 272 | 544 |
>
> So no real difference. That is unusual, it is typically faster, or if
> it is always doing line rate, it uses less CPU time. That might
> suggest the page pool integration is not optimal?

One more data point. I get line rate with & without page_pool so below
are CPU times from /proc/stat:

         upstream    pp
user            1     1
system        179    91 (!!!)
idle         7874  7303
softirq        35    37

16K pages on Mobileye EyeQ5 (MIPS), 7 fragments per page.

Paolo shared 64 versus 128 measurements but I am unsure what those stand
for; I doubt it can be packet size as xdp-bench does not have it as a
parameter. https://man.archlinux.org/man/extra/xdp-tools/xdp-bench.8.en

Measurement incantation:

   cat /proc/stat > /tmp/a && \
   iperf3 -c $IP && \
   cat /proc/stat > /tmp/b && \
   awk 'NR=3D=3DFNR && $1=3D=3D"cpu" {user=3D$2;sys=3D$4;idle=3D$5;softirq=
=3D$8;next}
        $1=3D=3D"cpu" {printf "user\t%5d\n", $2-user}
        $1=3D=3D"cpu" {printf "system\t%5d\n", $4-sys}
        $1=3D=3D"cpu" {printf "idle\t%5d\n", $5-idle}
        $1=3D=3D"cpu" {printf "softirq\t%5d\n", $8-softirq}
   ' /tmp/a /tmp/b

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


