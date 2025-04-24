Return-Path: <netdev+bounces-185461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA3AA9A78C
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 11:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CFD23A861D
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 09:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E0A1EA7C1;
	Thu, 24 Apr 2025 09:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dPU29toD"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6599D528
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745486375; cv=none; b=pesyNAkCRHcMznJCTHQ7QM8Mjtdh5e/nee+pO6l8hScFBEuDsn80KpiYFNamYSSCZ7JrrJ3tRYnSMS98HYNJeCU75shNR+fOE975yJnPXv21pofK5LfjqpHeS9j1fQzEwG6WN1Pzx8wIpmAB9darKftNy/BeWff+nC+KMaG0k24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745486375; c=relaxed/simple;
	bh=WD6Ff4on3gMXSvQb82UdayrkaTp2LKo8STmvaYTquPk=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=F8wZyFEQbd3dqSI7p4WktdLtfKYVnIQDr7NVDr7Mskr/n0pDdpqisgob6ikzZMoAoTH2Vr7eVwGuClU4P49jeACKrkBKLUyb1dxdKvEH7sopq1zHBNZUOGAklNA6lLnG49W+gnqRP3kCE2ZeoPPnsSVv7cSbOec+2pCcjOFYY44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dPU29toD; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745486370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lsifh0qg1ETcVD6N2Oh5iR/tKrplPyYEmImPJnlsTSw=;
	b=dPU29toDEYXeQGvicYDT3fMKS6gTIShnuS14kkbKpGZcF1/X24kzMReG/Ft3/A/gsYB4hM
	8EkmP9C0fTXl8GSRpJzMjTg5mpD+lHtzGykMVc3tQTzxoAKO3v18iPb12gI0QzdKb9RSsa
	ItMwoHumt3M/KA5b18V44bZlz9godwU=
Date: Thu, 24 Apr 2025 09:19:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <978f0f1e4ab0c8f46820af305f5efb00cf94ffd2@linux.dev>
TLS-Required: No
Subject: Re:
To: "Cong Wang" <xiyou.wangcong@gmail.com>
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org
In-Reply-To: <90f887391cff690e883e40cbb67a9614e7757295@linux.dev>
References: <aAmIi0vlycHtbXeb@pop-os.localdomain>
 <90f887391cff690e883e40cbb67a9614e7757295@linux.dev>
X-Migadu-Flow: FLOW_OUT

April 24, 2025 at 08:59, "Jiayuan Chen" <jiayuan.chen@linux.dev> wrote:

>=20
>=20April 24, 2025 at 08:40, "Cong Wang" <xiyou.wangcong@gmail.com> wrote=
:
>=20
>=20>=20
>=20> netdev@vger.kernel.org, bpf@vger.kernel.org
> >=20
>=20>  Bcc:=20
>=20>=20
>=20>=20
>=20>  Subject: test_sockmap failures on the latest bpf-next
> >=20
>=20>  Reply-To:=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>  Hi all,
> >=20
>=20>=20=20
>=20>=20
>=20>  The latest bpf-next failed on test_sockmap tests, I got the follow=
ing
> >=20
>=20>  failures (including 1 kernel warning). It is 100% reproducible her=
e.
> >=20
>=20>  I don't have time to look into them, a quick glance at the changel=
og
> >=20=20
>=20>  shows quite some changes from Jiayuan. So please take a look, Jiay=
uan.
> >=20
>=20>  Meanwhile, please let me know if you need more information from me=
.
> >=20
>=20>  Thanks!
> >=20
>=20>=20=20
>=20>=20
>=20>  --------------->
> >=20
>=20
> Thanks, I'm working on it.
>=20

After=20resetting my commit to 0bb2f7a1ad1f, which is before my changes, =
the warning still exists.

The warning originates from test_txmsg_redir_wait_sndmem(), which perform=
s
'KTLS + sockmap with redir EGRESS and limited receive buffer'.

The memory charge/uncharge logic is problematic, I need some time to inve=
stigate and fix it.

Thanks.

