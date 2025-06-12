Return-Path: <netdev+bounces-196857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22802AD6B69
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA7E52C069D
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 08:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617A11F4CAB;
	Thu, 12 Jun 2025 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c6+a28KT"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584231DF75A
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 08:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749718329; cv=none; b=jYtEHMysGEPJwIFJWd+3cjSa2r0NLlqIHJR3k84P27uEH9Ix3kan0NAh/0kZ1GRxbDJl9Luf9io5/t/qUJ8FxdGD4CKw9SpmG7GMrlaxtQyk5PXTifnws5eJ+gX5uagCR0ny8mZnbMPWHev2RedHx68r6Njkm4ZOwVERSHR5zpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749718329; c=relaxed/simple;
	bh=H0VCAnV+60G/axqZge8syCzBtfm8tXNe14T0UBegxF8=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=nfDl7m7OBK9oS07SSsID/+tfMy+b4iBpl9cHWxQ2KSDHKqOuyRHSZ5952VaAcs0NzhlGjTMv8b997/hodChMUFctRELTsSPS0nUV15TQ587nU3isrBYx5bxJ2HUW04sj7Pc23EEPpN5i0Ss1YAmubLsJv0Goo+x47xRwA+VGm28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c6+a28KT; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749718314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1fNjU9Jt2dl9a4ozW6RxgvUD+U87qbNB3Y48ndzwkqw=;
	b=c6+a28KTWcxU/nQnzd1YNpZV62zUXn3MurB9aDU9I9dTDixL12OoyBdQNZuQ6v/nDhAyFf
	XmWjDbK00zwdPaJQXNEV3Rznmk4RH9dE76l0gII6HetSWTr8F0SdMmW/6QowSHr1oMmedu
	HV5hnmXCdaPhUZy+91ALLVuLzvVLFqE=
Date: Thu, 12 Jun 2025 08:51:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <be52bdf3f1f4786f73b618369f63ce035ce8b955@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net-next v2] net: sysfs: Implement is_visible for
 phys_(port_id, port_name, switch_id)
To: "Paolo Abeni" <pabeni@redhat.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <10a15ca4-ff93-4e62-9953-cbd3ba2c3f53@redhat.com>
References: <20250521140824.3523-1-yajun.deng@linux.dev>
 <10a15ca4-ff93-4e62-9953-cbd3ba2c3f53@redhat.com>
X-Migadu-Flow: FLOW_OUT

May 27, 2025 at 2:08 PM, "Paolo Abeni" <pabeni@redhat.com> wrote:



>=20
>=20On 5/21/25 4:08 PM, Yajun Deng wrote:
>=20
>=20>=20
>=20> phys_port_id_show, phys_port_name_show and phys_switch_id_show woul=
d
> >=20
>=20>  return -EOPNOTSUPP if the netdev didn't implement the correspondin=
g
> >=20
>=20>  method.
> >=20
>=20>=20=20
>=20>=20
>=20>  There is no point in creating these files if they are unsupported.
> >=20
>=20>=20=20
>=20>=20
>=20>  Put these attributes in netdev_phys_group and implement the is_vis=
ible
> >=20
>=20>  method. make phys_(port_id, port_name, switch_id) invisible if the=
 netdev
> >=20
>=20>  dosen't implement the corresponding method.
> >=20
>=20>=20=20
>=20>=20
>=20>  Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> >=20
>=20
> I fear that some orchestration infra depends on the files existence -
>=20
>=20i.e. scripts don't tolerate the files absence, deal only with I/O err=
ors
>=20
>=20after open.
>=20
>=20It feel a bit too dangerous to merge a change that could break
>=20
> user-space this late. Let's defer it to the beginning of the next cycle=
.
>=20

Ping.

>=20Paolo
>

