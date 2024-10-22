Return-Path: <netdev+bounces-137697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9216A9A95AD
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 03:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A952846C0
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 01:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F3613A256;
	Tue, 22 Oct 2024 01:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ky+N3LX9"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E739136330
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 01:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729561692; cv=none; b=RTIGBqJkW+gncS7qNuuLMdM9QVsofQld2uZZzUp7k1nBfw1o8wH5lKYmMvNug2KrEpH+vowV3/hgYVGStaolfWzufwmbsnO9LDwYlmWyD3qDI1sjTH7W4wH/iTvVGthCv/Slog07ptoCkyCRZilKsHZGe/GvL9R74+PzXLK4rjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729561692; c=relaxed/simple;
	bh=J2ule95uDA2lxZeFteLQ1CcacbCf1RwSzS2Cn3CQpuM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Xah5CZ5FZkvXtLNXVOmVSGqDDIjiLJk1YyjMpsQATA8cJtswrTc4VT3ksS+zludzph8ENaQT5ZGBDUWDOP4XoXnNjf58AE4ymv1Zc5thgwlRFcwxIHKNMqH0zkBxZU/5QLJIG93t8/2yoMO1G4JjjeX7tjqw5oLjTagPyoNw7RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ky+N3LX9; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729561687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4eiZ6r3xpWFSBdkJCU0cQjDHtryYalZj0OvrUsR7hSE=;
	b=ky+N3LX9IeLVQ+qmbPb47voiVKu56MJtKGKIfPPdF5UU3pn3SxeUqT0q5R2MtdA4/g9X71
	I3tZEH7GHsxSEWC3oCUo4stbNQkO83kbxzxyTaemLv2QrCLAE7VA8He0rF0O0gk3cD48cC
	0Si8daj92f412lgLUCMQf5vb+R7/89g=
Date: Tue, 22 Oct 2024 01:48:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <4275a6d14b8e209331251fa7a3a1f3094ee60915@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v3 net-next] net: vlan: Use vlan_prio instead of vlan_qos
 in mapping
To: "Guillaume Nault" <gnault@redhat.com>, "Ido Schimmel" <idosch@idosch.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <ZxaA/6zaqgbrcHX/@debian>
References: <20241018141233.2568-1-yajun.deng@linux.dev>
 <ZxT3oVQ27erIoTVz@shredder.mtl.com> <ZxaA/6zaqgbrcHX/@debian>
X-Migadu-Flow: FLOW_OUT

October 22, 2024 at 12:27 AM, "Guillaume Nault" <gnault@redhat.com> wrote=
:



>=20
>=20On Sun, Oct 20, 2024 at 03:29:21PM +0300, Ido Schimmel wrote:
>=20
>=20>=20
>=20> On Fri, Oct 18, 2024 at 10:12:33PM +0800, Yajun Deng wrote:
> >=20
>=20>  The vlan_qos member is used to save the vlan qos, but we only save=
 the
> >=20
>=20>  priority. Also, we will get the priority in vlan netlink and proc.
> >=20
>=20>  We can just save the vlan priority using vlan_prio, so we can use =
vlan_prio
> >=20
>=20>  to get the priority directly.
> >=20
>=20>=20=20
>=20>=20
>=20>  For flexibility, we introduced vlan_dev_get_egress_priority() help=
er
> >=20
>=20>  function. After this patch, we will call vlan_dev_get_egress_prior=
ity()
> >=20
>=20>  instead of vlan_dev_get_egress_qos_mask() in irdma.ko and rdma_cm.=
ko.
> >=20
>=20>  Because we don't need the shift and mask operations anymore.
> >=20
>=20>=20=20
>=20>=20
>=20>  There is no functional changes.
> >=20
>=20>=20=20
>=20>=20
>=20>  Not sure I understand the motivation.
> >=20
>=20>=20=20
>=20>=20
>=20>  IIUC, currently, struct vlan_priority_tci_mapping::vlan_qos is shi=
fted
> >=20
>=20>  and masked in the control path (vlan_dev_set_egress_priority) so t=
hat
> >=20
>=20>  these calculations would not need to be performed in the data path=
 where
> >=20
>=20>  the VLAN header is constructed (vlan_dev_hard_header /
> >=20
>=20>  vlan_dev_hard_start_xmit).
> >=20
>=20>=20=20
>=20>=20
>=20>  This patch seems to move these calculations to the data path so th=
at
> >=20
>=20>  they would not need to be performed in the control path when dumpi=
ng the
> >=20
>=20>  priority mapping via netlink / proc.
> >=20
>=20>=20=20
>=20>=20
>=20>  Why is it a good trade-off?
> >=20
>=20
> I agree with Ido. The commit description doesn't explain why these
>=20
>=20changes are made and I also can't see how this patch can improve
>=20
>=20performances.
>=20
>=20If it's about code readability, why not just add a helper that gets a
>=20
>=20struct vlan_priority_tci_mapping pointer as input and returns a __u8
>=20
>=20corresponding to the priority? This way, the /proc and netlink handle=
rs
>=20
>=20(and other potential users) wouldn't have to do the bit shifting and
>=20
>=20masking manually.
>

Okay, that's a better way.

