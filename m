Return-Path: <netdev+bounces-292646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIoJAyoWGGoBdAgAu9opvQ
	(envelope-from <netdev+bounces-292646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:17:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7954C5F0701
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98D20301548B
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31CE3783B5;
	Thu, 28 May 2026 10:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="T/0s6CcH"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BF335A393;
	Thu, 28 May 2026 10:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779963356; cv=none; b=AGQjGkR17ugTY3VkszmavoVmdvTiKbeYHoAwqdSwp36x9w4AZ//BKedENTFR34XXG4QM3qFUJA2ha50dE47r6Nxtzssmq+vvkNkfu/O1PuDvF9273YM2ovS4KISeuvqfAuo60OfW+jXKqfSfHWElNwGiV9hKr6vm0H8aQs41JUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779963356; c=relaxed/simple;
	bh=XM8DpW4h+wMcsepWr44xIqMGYIP8TRQ8/bVCkb5xKNc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NknbdF7puAoKVLnHn5HqwyKIb76mLch2runFEDhU1kzfTcYm+WDHrHEEvuDG6qtJfBse/VwFwA0j6CilXqrD9bx8IecP5mDOg53Iki727p/eTNKtZGxxR51+j4KFb+u7Z33HcN39AJn/JogOt5vPDAuXiyJY6v/bknMbs8JrafI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=T/0s6CcH; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 64SAFMoP023210
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 28 May 2026 11:15:25 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 64SAFMoP023210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1779963332; bh=h60D/yV7KdaM7yTghFlLY1DHeU7Jvgq4wTQYO8M7pfQ=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=T/0s6CcHP1n2HTaG7ILG6J+9CRMkDmNxV6PzxIOPQoYbA/VyqPtsV5Pm+fQghopCi
	 IiaRwh+Uiw4uki0SSYcV5Pd1rTVFc8eDID/ejbz9NcMnBYytQcRVMz1TCzUgcRXhe4
	 2/GuiyWmVV50ax21r2CaCAnT58CrWcIS6I4vjruISYRBvYUPAlPAqppaTbkf7mXtoF
	 ueOjyTlVgndxQPR+nPeJW1/RvWB5RvAlNJVZMvnbmTUnYi9pXBJn2FC56n8EN9FGeD
	 ztBXV5ZYuDXwkm5Idmr/s0rqVAyT5fyzkvS/M22RKGA4hx9uFha+h5E/OA7V2BGhgJ
	 b6VWNeevvq8fw==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: add support for credit
 based shaper
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <CABvLYuA85b1X9wHH073HPX=xv_1uZ2+anhcr+3MMkoVF-3DVcA@mail.gmail.com>
Date: Thu, 28 May 2026 20:15:10 +1000
Cc: Cedric Jehasse <cedric.jehasse@luminex.be>, Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kieran Tyrrell <kieran@sienda.com>, Max Hunter <max@huntershome.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2E4F8243-8687-4591-A03D-4402D4FBEC02@padl.com>
References: <20260522-net-next-mv88e6xxx-cbs-v1-0-c87a8e6bcc0c@luminex.be>
 <20260522-net-next-mv88e6xxx-cbs-v1-2-c87a8e6bcc0c@luminex.be>
 <C0F865AD-24CD-4EA7-B0AB-16D91914ABAD@padl.com>
 <PR3P194MB1505960E42BBFB9AD9E8B18DEA0B2@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
 <885A5B11-A34A-4F69-9E9F-ABF10159B789@padl.com>
 <CABvLYuA85b1X9wHH073HPX=xv_1uZ2+anhcr+3MMkoVF-3DVcA@mail.gmail.com>
To: Cedric Jehasse <cedric.jehasse@gmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292646-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[luminex.be,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,sienda.com,huntershome.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[padl.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,padl.com:email,padl.com:mid,padl.com:dkim]
X-Rspamd-Queue-Id: 7954C5F0701
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> On 28 May 2026, at 6:11=E2=80=AFpm, Cedric Jehasse =
<cedric.jehasse@gmail.com> wrote:
>=20
> On Thu, May 28, 2026 at 2:17=E2=80=AFAM Luke Howard <lukeh@padl.com> =
wrote:
>=20
>> This actually makes more sense also now that you pointed out that AVB =
mode is set on the ingress, not egress, port: configuring CBS should =
stay out of setting any of the AVB mode bits. Are you planning to submit =
a MQPRIO patch? If not, shall I just wait for your CBS patch to land, =
and then rebase my AVB patch series on top of net-next?
>=20
> No, I don't have changes to support MQPRIO in the driver.  I use the
> default FPri/Qpri mappings at the moment.

This is a salient point: in my MQPRIO patch series, offloaded TCs 2 and =
1 represent AVB classes (with 0 representing non-AVB traffic). This is =
the most natural mapping to take advantage of the switches=E2=80=99 =
native AVB support.

But there=E2=80=99s an alternate mapping where TCs represent switch =
queues and can be used to configure arbitrary FPri/QPri mappings.

It would be good to support both, particularly for switches with >4 =
queues. Maybe this can be keyed the presence of the DT property (now =
renamed, marvell,avb-mode).=

