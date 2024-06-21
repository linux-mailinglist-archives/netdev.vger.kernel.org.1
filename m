Return-Path: <netdev+bounces-105556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9190F911B91
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 08:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3993E1F21A46
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 06:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8209A167290;
	Fri, 21 Jun 2024 06:21:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9BA158206
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 06:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718950906; cv=none; b=NXMRgtSIwUv7XVOHCgHS5MXyvcez+vIozUC2ibZDVRzK7c49p9KNli+8k5qN8UrYoRGg2J530cJCuoS3oO5CTW1EuGocHXUZ3VEmewDn3Z1d1MAYYLdYlC2Yno7xW9ZHKKb5X3+wwi1iB+fNIrhD7m34tQQ2mGQZfm017q8vFP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718950906; c=relaxed/simple;
	bh=u57FyeN4yXEi543jN5gw5XXDtHFLHwnOdJ8bk5RideY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qV3tVCmRFvDVEGJgHf+FtgKRMpzCybwdcHYMaSCZ9J6MluTdCHBCnGLbjynjAa2qscGFkEX7eq9ASLE9mzLALMheDQANfZYLRdjXqY5BJvKrZJAfezhrICFA+8nL3xSCyHtr5WgCSgwqwDweOH14JETmI3IiXaZUmtbw6Fm9zBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"hengqi@linux.alibaba.com" <hengqi@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [????] Re: [PATCH] virtio_net: Use u64_stats_fetch_begin() for
 stats fetch
Thread-Topic: [????] Re: [PATCH] virtio_net: Use u64_stats_fetch_begin() for
 stats fetch
Thread-Index: AQHawfQooceI1YM1lUOLDiZ4kyQEFrHQLNAAgAGUPLA=
Date: Fri, 21 Jun 2024 06:20:45 +0000
Message-ID: <b9f5b5f86b994729a0c408b84fc01ec2@baidu.com>
References: <20240619025529.5264-1-lirongqing@baidu.com>
 <20240620070908.2efe2048@kernel.org>
In-Reply-To: <20240620070908.2efe2048@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.56
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 52:10:53:SYSTEM

> Did you by any chance use an automated tool of any sort to find this issu=
e or
> generate the fix?
>=20
> I don't think this is actually necessary here, you're in the same context=
 as the
> updater of the stats, you don't need any protection.
> You can remove u64_stats_update_begin() / end() (in net-next, there's no =
bug).
>=20
> I won't comment on implications of calling dim_update_sample() in a loop.
>=20
> Please make sure you answer my "did you use a tool" question, I'm really
> curious.


I have no tool, I find this when I investigating a DIM related issue.

Thanks



