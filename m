Return-Path: <netdev+bounces-59289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6972A81A387
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 17:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08EE0B20E95
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 16:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD774653F;
	Wed, 20 Dec 2023 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="qKECT4L1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="em/y0sMH"
X-Original-To: netdev@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704844BA8D
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 52E055C04F1;
	Wed, 20 Dec 2023 10:59:19 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 20 Dec 2023 10:59:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1703087959;
	 x=1703174359; bh=oI/QH5S7nCjmlTpTJ97qy9H+hwq2JcPi2QdVTYUDwuY=; b=
	qKECT4L1fgEZc8uzo2PFmDUDrz4Gg9dSLrRG2gf9c43u1UHuNTBVeSi9B1b0EjR4
	GuXH4JXGy83TrXLtO+nZvF0znJwB1YGHlZ4/24ZSj9VBOq7J/jNYwuzf0htxY5zJ
	9ydOXb9bGjfRk6nv5Rs5ROgHE+/dP3gQ6nyDN5vL+SrW6ox8vM0juNFhVra+mEMX
	tSp48tHPmumomZnObiEMHQdoKCRp8Ad+k7rOgjpeSvsDNQY51izHZpVtEVihitRp
	7OaViyNAQzOe4Y1PkFajUEUPj9RmmF32uMxdhBhARzimfEHmkmE5CUDPOdw65wuB
	a7xCzjmy2h8bTmceo5vH6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703087959; x=
	1703174359; bh=oI/QH5S7nCjmlTpTJ97qy9H+hwq2JcPi2QdVTYUDwuY=; b=e
	m/y0sMHfHHdjZxBbIfS/c5Q8dayStsZnLRw40kY+etWMq1npjxt5OSIVa6G1xqar
	LbbZljZUY+4JcCJySPJNaskYKwfOOq2y/mI+WZjAZH72IdgVWPVRI7IwoA6i+bn7
	3gJEikO4H/n25fAWPQguKwJ96aBmoC1tBaiPGG5UdT1UW83VTJPSu1ZjjTYnp8G3
	cCUEaPtye5EiGF4sLYQ6ZWmTWw/mqcM3+NrhnUYt9SFeOn69vM6+3roDMqF4qJIx
	NpGj1dzYwLHGAW6+JowCbTJhSrXJhwXyOyu+rv8ak5Hxh2ywnCYecr0UlTTkayvI
	qzfho+91dBNTZPBeBsdpQ==
X-ME-Sender: <xms:Vg-DZVp52OqdybEU0bK13V2uR_vb3aN5JTHOhnc7rdccU_6yufqXDQ>
    <xme:Vg-DZXqjIK6-VTsUc70ZdrD3Jz2TXcLvXElQpEBWBBIuGuUFDPHq6HLBByBk3Sc7w
    R8PiRMNIIuKw55cnRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepjeeghfeutdejjeehudevgeehveduffejkefhveefgfettdehgeeiledufeeu
    vdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Vw-DZSOPne77Cq0FxhJPxvU80Pr3T9l7n9UgE9x4ui3NelKk5zQaYA>
    <xmx:Vw-DZQ7Q1ro6c5F5lHoh7uvdVqsRv5uXAZVxbh9QnD3IfwG1YkoUkA>
    <xmx:Vw-DZU7ujrnQvllE7j4ObdolIPag8loK98D1mLzK63QtLyxmXzbAYw>
    <xmx:Vw-DZSn2JkIQrnzQqHBYklZZpr_8fuNqMwXscLafWDp8v2VpshphAQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D3ABFB6008D; Wed, 20 Dec 2023 10:59:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6a7281bf-bc4a-4f75-bb88-7011908ae471@app.fastmail.com>
In-Reply-To: <658302ffea24_1a4df629443@willemb.c.googlers.com.notmuch>
References: <a9090be2-ca7c-494c-89cb-49b1db2438ba@corelatus.se>
 <658266e18643_19028729436@willemb.c.googlers.com.notmuch>
 <0d7cddc9-03fa-43db-a579-14f3e822615b@app.fastmail.com>
 <bff57ee057bdd15a2c951ff8b6e3aaa30f981cd2.camel@mailbox.tu-berlin.de>
 <6582ffd3e5dc7_1a34a429482@willemb.c.googlers.com.notmuch>
 <658302ffea24_1a4df629443@willemb.c.googlers.com.notmuch>
Date: Wed, 20 Dec 2023 15:59:01 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 =?UTF-8?Q?J=C3=B6rn-Thorben_Hinz?= <jthinz@mailbox.tu-berlin.de>,
 "Thomas Lange" <thomas@corelatus.se>, Netdev <netdev@vger.kernel.org>,
 "Deepa Dinamani" <deepa.kernel@gmail.com>,
 "John Fastabend" <john.fastabend@gmail.com>
Subject: Re: net/core/sock.c lacks some SO_TIMESTAMPING_NEW support
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023, at 15:06, Willem de Bruijn wrote:
> Willem de Bruijn wrote:
>> J=C3=B6rn-Thorben Hinz wrote:
>>=20
>> __sock_cmsg_send can only modify a subset of the bits in the
>> timestamping feature bitmap, so a call to setsockopt is still needed
>>=20
>> But there is no ordering requirement, so the __sock_cmsg_send call can
>> come before the setsockopt call. It would be odd, but the API allows =
it.
>
> But no timestamp is returned unless setsockopt is called. So we can
> continue to rely on that for selecting SOCK_TSTAMP_NEW.

Ok, makes sense. In that case the one-line patch should be sufficient.

> Only question is whether the kernel needs to enfornce the two
> operations to be consistent in their choice between NEW and OLD. I
> don't think so. If they are not, this would be a weird, likely
> deliberate, edge case. It only affects the data returned to the
> process, not kernel integrity.

There is the one corner case where a file descriptor is shared
between tasks that disagree on the layout of the timestamp,
or is accessed from different parts of an application that
were built with inconsistent time32/time64 settings. Both of
these are already impossible to fix in a generic way.

      Arnd

