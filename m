Return-Path: <netdev+bounces-183433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7B2A90A49
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75B2A19063AD
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C73C217673;
	Wed, 16 Apr 2025 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NXjEZauz"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61612185A8
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744825191; cv=none; b=lugGqNAaPQTXqxONxkTUtONrbCYXzmH/LXKqvityv2JrIVD0QWPacvxozLvw2ofe3d12XHnTGzYN6i/wHW4Pqx3k2ZKFo2yxyazKYr61HPq0XqvhHXliHFUo05RXNvklRtWJQkCr6nE9SHoREPsr0NfOvZEke+5MOBEIMBSuk5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744825191; c=relaxed/simple;
	bh=5EihlJmz+hvtbqHQQxm4bPuIUsPwHTbMU80S2BJiEe4=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=DjC1Oe6suwV54pezWLR1nEHCGwpQRmk14NY5ztUZfqQK2JMBHhIYCGJV9TYcAqwVcBSld6cqwwWdk5Q01fGBarT4cuIzuZBqS/S7/xuwMOJgQBlzrjcwRSs5HW8/130n37AAWZBJhhIJUpiHFNhwtKjZFJsaLALFHbI2Hvla/po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NXjEZauz; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744825186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AyaRmSc9rZnSG9+LAZtlagv4GDwAQvHnpIqE9kkvxHs=;
	b=NXjEZauzAIHCl827H0c0PclzIHhPXSuxHlT/+ZBrnVpviV/+S996ghCARO2YBY/LkLWIuD
	y9+Rp7lrttf4GjOA4lHJJX5lMTsSbsrYzp/TJ4mAca1yq0LDeLAXSI8l/pcKVUVFyVDclr
	e2HsqrF3dGW6cmPvhf6OY0SvE8BvOcM=
Date: Wed, 16 Apr 2025 17:39:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <edd05a3ce17ed40c179a076750261f02cb3e314e@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf] selftests/bpf: mitigate sockmap_ktls
 disconnect_after_delete failure
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org,
 pabeni@redhat.com, mykolal@fb.com, kernel-team@meta.com
In-Reply-To: <20250416170246.2438524-1-ihor.solodrai@linux.dev>
References: <20250416170246.2438524-1-ihor.solodrai@linux.dev>
X-Migadu-Flow: FLOW_OUT

April 17, 2025 at 01:02, "Ihor Solodrai" <ihor.solodrai@linux.dev> wrote:

>=20
>=20"sockmap_ktls disconnect_after_delete" test has been failing on BPF C=
I
>=20
>=20after recent merges from netdev:
>=20
>=20* https://github.com/kernel-patches/bpf/actions/runs/14458537639
>=20
>=20* https://github.com/kernel-patches/bpf/actions/runs/14457178732
>=20
>=20It happens because disconnect has been disabled for TLS [1], and it
>=20
>=20renders the test case invalid.
>=20
>=20Removing all the test code creates a conflict between bpf and
>=20
>=20bpf-next, so for now only remove the offending assert [2].
>=20
>=20The test will be removed later on bpf-next.
>=20
>=20[1] https://lore.kernel.org/netdev/20250404180334.3224206-1-kuba@kern=
el.org/
>=20
>=20[2] https://lore.kernel.org/bpf/cfc371285323e1a3f3b006bfcf74e6cf7ad65=
258@linux.dev/
>=20
>=20Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Thanks.

> ---
>=20
>=20 tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c | 1 -
>=20
>=20 1 file changed, 1 deletion(-)
>=20
>=20diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/=
tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
>=20
>=20index 2d0796314862..0a99fd404f6d 100644
>=20
>=20--- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
>=20
>=20+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
>=20
>=20@@ -68,7 +68,6 @@ static void test_sockmap_ktls_disconnect_after_dele=
te(int family, int map)
>=20
>=20 goto close_cli;
>=20
>=20=20
>=20
>  err =3D disconnect(cli);
>=20
> - ASSERT_OK(err, "disconnect");
>=20
>=20=20
>=20
>  close_cli:
>=20
>=20 close(cli);
>=20
>=20--=20
>=20
> 2.49.0
>

