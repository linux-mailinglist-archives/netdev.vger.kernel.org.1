Return-Path: <netdev+bounces-137344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A14759A58D3
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 04:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B95F1F213AC
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 02:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BD0282F4;
	Mon, 21 Oct 2024 02:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sfFPVkXw"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F9612E7E
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 02:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729477403; cv=none; b=bNp58A/rjH8TYmmucoLJg47tKiaubuAEjIeHO8Wp8mo62TLR/n1H96ofyHdPvneuDr3uU7xraRVfOqQnVm2XCvdf+ak9mcxHMJi/6/BYZez5CdkMMWKY17haQ/N303sPzMH8mCg1+ZImitV+Hk6hQJymUobRKpgCQqucWXJX+2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729477403; c=relaxed/simple;
	bh=8YaLhFa3jny6vw8aAJQ4SYVgKkm1ICP9Pf0Qx0UAoIw=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=CEmGw4LO3wtzNU6SmMJAg/Fyc8xYZwNgUV195NT+2O45diDW/AoQ555mhgk/2fRWfC7vO+e2zhROpsJTNQjP5SbKcW5Y42jjZHbzzSE4mIeIe9nBiXCOq3VMuAO+m6DT2XBkiVjn5nSzeuVgKYYA7UFIx+TlpHh5X9rg9BVQjzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sfFPVkXw; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729477392; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YHT6vg/+2MSt8QxyhBRwiFWAVKo3U+sWohVAUGnEi8=;
	b=sfFPVkXw5Wni23pmFokSbnb8Ahq1t4siCBdT54B/ldyzvYCskGROiKrbiSDgDIOCn9Z9DP
	YK9ZrkrFxXRbKIciW7EXtMdZ0xkGuuLaD7iJ7uzUF5lB2V8XT7OAt8FGR6vnDAknVF4b+B
	n7tm5H9VjToYLiXs3S04d2wrIGLKTIk=
Date: Mon, 21 Oct 2024 02:23:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <7af6a933e6b7e2e4bb18b049870860bf84fd77b0@linux.dev>
Reply-To: lenbotkin@zohomail.eu
TLS-Required: No
Subject: Re: [PATCH v3 net-next] net: vlan: Use vlan_prio instead of vlan_qos
 in mapping
To: "Ido Schimmel" <idosch@idosch.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <ZxT3oVQ27erIoTVz@shredder.mtl.com>
References: <20241018141233.2568-1-yajun.deng@linux.dev>
 <ZxT3oVQ27erIoTVz@shredder.mtl.com>
X-Migadu-Flow: FLOW_OUT

October 20, 2024 at 8:29 PM, "Ido Schimmel" <idosch@idosch.org> wrote:



>=20
>=20On Fri, Oct 18, 2024 at 10:12:33PM +0800, Yajun Deng wrote:
>=20
>=20>=20
>=20> The vlan_qos member is used to save the vlan qos, but we only save =
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
>=20
> Not sure I understand the motivation.
>=20
>=20IIUC, currently, struct vlan_priority_tci_mapping::vlan_qos is shifte=
d
>=20
>=20and masked in the control path (vlan_dev_set_egress_priority) so that
>=20
>=20these calculations would not need to be performed in the data path wh=
ere
>=20
>=20the VLAN header is constructed (vlan_dev_hard_header /
>=20
>=20vlan_dev_hard_start_xmit).
>=20
>=20This patch seems to move these calculations to the data path so that
>=20
>=20they would not need to be performed in the control path when dumping =
the
>=20
>=20priority mapping via netlink / proc.
>=20

Yes,=20you're right about that. But there's another case.=20
Not=20all callers need to get the vlan qos, but some callers need to get =
the
vlan priority (get_vlan_ndev_tc/irdma_iw_get_vlan_prio/irdma_roce_get_vla=
n_prio)
in irdma.ko and rdma_cm.ko.
These callers and vlan_dev_set_egress_priority are opposite operations.
If we use vlan_prio, we can save these two opposite operations.


> Why is it a good trade-off?
>

