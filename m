Return-Path: <netdev+bounces-186231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A04A9D874
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 08:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A625A4F2A
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 06:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECD31A83E5;
	Sat, 26 Apr 2025 06:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lavabit.com header.i=@lavabit.com header.b="OREZaIN7"
X-Original-To: netdev@vger.kernel.org
Received: from lavabit.com (lavabit.com [46.23.82.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191CD1E1A3F
	for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 06:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.23.82.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745649096; cv=none; b=i06vvXY4ToGu2Uv0ksGV8O+RiR9h2utJItzGs6Pd8/szL1a+02Tl7bWkahPav/DQ97+vg89fyEdYGnkiS4NDnu7fURxox+pJ9qZu0sm4NDxmN6BGSLnYIiOLOelvvfDAKe0kg5A6nXj2RS1xZFQ/EoWw10GXZbLYrnYahrXsLis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745649096; c=relaxed/simple;
	bh=gC8dfZ4p6x/HwxsmsnxctrcwTMXDn6OlxRzmhtlleO8=;
	h=Date:From:Subject:To:Message-Id:MIME-Version:Content-Type; b=utaHKd2sgL1bVo7FbTE9W73o8AAQxQxr+W4KM9KjPXSdF5kPyvJfvvD0huuXmYefs2cZ10KmcCMK9X+Q2Rent3bgeJhJTENqlkH6BitBH9zOwICIP6GY32P9frdcWPbd/XOa9AbyG8iNf2KBFQJhK/m4aNPiQf0ou1xKarBKN24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lavabit.com; spf=pass smtp.mailfrom=lavabit.com; dkim=pass (2048-bit key) header.d=lavabit.com header.i=@lavabit.com header.b=OREZaIN7; arc=none smtp.client-ip=46.23.82.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lavabit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lavabit.com
Received: from lavabit.com (localhost [127.0.0.1])
	by lavabit.com (Postfix) with ESMTP id C1FD1407AA41
	for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 06:31:28 +0000 (UTC)
Received: from 192.168.1.6 (10-213-91-213-static.btc-net.bg [213.91.213.10])
	by lavabit.com with ESMTP id 4BV0EDS4ACG6
	for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 06:31:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lavabit.com; s=bazinga;
	t=1745649088; bh=gC8dfZ4p6x/HwxsmsnxctrcwTMXDn6OlxRzmhtlleO8=;
	h=Date:From:Subject:To:Message-Id:X-Mailer:MIME-Version:
	 Content-Type;
	b=OREZaIN7grqNXhwF+tUk5NrLKgMVtBHDhGBQVGtGnkXoFoi27DYpnOdJHeRrDnWLa
	 /OJbvj/k0nhz4jDoMRBTr2Docsm27wW11wV0dTJT9QRJNSt6nOIh7pIt4wwDGIcZM7
	 6+RJH3RJ9qtSci9haQQqkUlZ2DWEfZ2ScDS9o4F7Erf79JZ/Zd+6EW8PYOHPVdfY5M
	 NRQ+p2KaufkbMcsJTlUlEXIkFCjXalXtxYKz4p0ou51Fj5tHLf5zXSM7nmDoa7xRWV
	 cbzDYKpoyCe1r3RILZHWgvS3DzRpV9iPpXZvqL+G2Z9KJ4x2oLO+auI5eeHWmWDgeM
	 fyQ7DoiFrzdMw==
Date: Sat, 26 Apr 2025 09:31:21 +0300
From: =?iso-8859-5?b?stDb1eDYILLb0NTV0g==?= <vdev@lavabit.com>
Subject: [RFC] Simple Path Compression Algorithm for Network Routes
To: netdev@vger.kernel.org
Message-Id: <9GBBVS.PKEI5BX1FR3T@lavabit.com>
X-Mailer: geary/43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-fQCCuy4QhAbdUpPk1GZl"

--=-fQCCuy4QhAbdUpPk1GZl
Content-Type: text/plain; charset=iso-8859-5; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello netdev,

Following my previous email, I'm sharing a simplified C implementation=20
of a path compression algorithm, designed for compact storage of=20
network routes or similar sequences. It uses bitmasks (letters_table)=20
and a skipping mechanism (count_uper_bits) to reduce memory usage.

Key features:
- Inserts paths (e.g., [0,1,2]) with weights (e.g., latency).
- Compresses shared prefixes for efficiency.
- Licensed under GPL v2.

Potential applications:
- Network routing tables (e.g., BGP).
- Sequence storage (e.g., dictionaries).

The code (pathcomp.c) is attached. It's minimal to encourage community=20
feedback and extensions, such as adding search, deletion, or=20
optimizations for large networks.

I'd appreciate any comments or suggestions for integration in Linux=20
networking projects.

Thanks,
=B2=D0=DB=D5=E0=D8 =B2=DB=D0=D4=D5=D2 <vdev@lavabit.com>



--=-fQCCuy4QhAbdUpPk1GZl
Content-Type: text/x-csrc
Content-Disposition: attachment; filename=pathcomp.c
Content-Transfer-Encoding: base64

LyoKICogQ29weXJpZ2h0IChjKSAyMDI1INCS0LDQu9C10YDQuCDQktC70LDQtNC10LIgPHZkZXZA
bGF2YWJpdC5jb20+CiAqCiAqIFBlcm1pc3Npb24gaXMgaGVyZWJ5IGdyYW50ZWQsIGZyZWUgb2Yg
Y2hhcmdlLCB0byBhbnkgcGVyc29uIG9idGFpbmluZyBhIGNvcHkKICogb2YgdGhpcyBzb2Z0d2Fy
ZSBhbmQgYXNzb2NpYXRlZCBkb2N1bWVudGF0aW9uIGZpbGVzICh0aGUgIlNvZnR3YXJlIiksIHRv
IGRlYWwKICogaW4gdGhlIFNvZnR3YXJlIHdpdGhvdXQgcmVzdHJpY3Rpb24sIGluY2x1ZGluZyB3
aXRob3V0IGxpbWl0YXRpb24gdGhlIHJpZ2h0cwogKiB0byB1c2UsIGNvcHksIG1vZGlmeSwgbWVy
Z2UsIHB1Ymxpc2gsIGRpc3RyaWJ1dGUsIHN1YmxpY2Vuc2UsIGFuZC9vciBzZWxsCiAqIGNvcGll
cyBvZiB0aGUgU29mdHdhcmUsIGFuZCB0byBwZXJtaXQgcGVyc29ucyB0byB3aG9tIHRoZSBTb2Z0
d2FyZSBpcwogKiBmdXJuaXNoZWQgdG8gZG8gc28sIHN1YmplY3QgdG8gdGhlIGZvbGxvd2luZyBj
b25kaXRpb25zOgogKgogKiBUaGUgYWJvdmUgY29weXJpZ2h0IG5vdGljZSBhbmQgdGhpcyBwZXJt
aXNzaW9uIG5vdGljZSBzaGFsbCBiZSBpbmNsdWRlZCBpbiBhbGwKICogY29waWVzIG9yIHN1YnN0
YW50aWFsIHBvcnRpb25zIG9mIHRoZSBTb2Z0d2FyZS4KICoKICogVEhFIFNPRlRXQVJFIElTIFBS
T1ZJREVEICJBUyBJUyIsIFdJVEhPVVQgV0FSUkFOVFkgT0YgQU5ZIEtJTkQsIEVYUFJFU1MgT1IK
ICogSU1QTElFRCwgSU5DTFVESU5HIEJVVCBOT1QgTElNSVRFRCBUTyBUSEUgV0FSUkFOVElFUyBP
RiBNRVJDSEFOVEFCSUxJVFksCiAqIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFIEFO
RCBOT05JTkZSSU5HRU1FTlQuIElOIE5PIEVWRU5UIFNIQUxMIFRIRQogKiBBVVRIT1JTIE9SIENP
UFlSSUdIVCBIT0xERVJTIEJFIExJQUJMRSBGT1IgQU5ZIENMQUlNLCBEQU1BR0VTIE9SIE9USEVS
CiAqIExJQUJJTElUWSwgV0hFVEhFUiBJTiBBTiBBQ1RJT04gT0YgQ09OVFJBQ1QsIFRPUlQgT1Ig
T1RIRVJXSVNFLCBBUklTSU5HIEZST00sCiAqIE9VVCBPRiBPUiBJTiBDT05ORUNUSU9OIFdJVEgg
VEhFIFNPRlRXQVJFIE9SIFRIRSBVU0UgT1IgT1RIRVIgREVBTElOR1MgSU4gVEhFCiAqIFNPRlRX
QVJFLgogKi8KCi8qKgogKiBNaW5pbWFsIHBhdGggY29tcHJlc3Npb24gYWxnb3JpdGhtIGZvciBu
ZXR3b3JrIHJvdXRlcy4KICogQ29yZSBpZGVhOiBVc2UgYml0bWFza3MgKGxldHRlcnNfdGFibGUp
IGFuZCBiaXQgY291bnRpbmcgKGNvdW50X3VwZXJfYml0cykKICogdG8gY29tcHJlc3Mgc2hhcmVk
IHByZWZpeGVzIGluIHNlcXVlbmNlcyAoZS5nLiwgcm91dGVzIFswLDEsMl0pLgogKgogKiBVc2Ug
Y2FzZTogRWZmaWNpZW50IHN0b3JhZ2Ugb2YgbmV0d29yayBwYXRocyBpbiByb3V0aW5nIHRhYmxl
cy4KICogRXh0ZW5zaW9uczoKICogLSBBZGQgc2VhcmNoIHRvIHJldHJpZXZlIHBhdGhzIGFuZCB3
ZWlnaHRzLgogKiAtIFN1cHBvcnQgZGVsZXRpb24gb3IgZHluYW1pYyB1cGRhdGVzLgogKiAtIE9w
dGltaXplIGZvciBsYXJnZSBuZXR3b3JrcyAoTExBID4gNjQpLgogKiAtIEludGVncmF0ZSB3aXRo
IExpbnV4IG5ldHdvcmtpbmcgKGUuZy4sIGlwcm91dGUyKS4KICovCgojaW5jbHVkZSA8c3RkaW8u
aD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3RkaW50Lmg+CgojZGVmaW5lIExMQSA2
NCAvLyBNYXhpbXVtIGVsZW1lbnRzIChsaW1pdGVkIGJ5IHVpbnQ2NF90KQoKc3RydWN0IG5vZGUg
ewogICAgdWludDY0X3QgbGV0dGVyc190YWJsZTsgLy8gQml0bWFzayBmb3IgZWxlbWVudHMKICAg
IHN0cnVjdCBub2RlKiBuZXh0OyAgICAgIC8vIE5leHQgbm9kZQogICAgdWludDMyX3Qgd2VpZ2h0
OyAgICAgICAgLy8gV2VpZ2h0IChlLmcuLCBsYXRlbmN5KQp9OwoKLyoqCiAqIENvdW50cyBiaXRz
IHNldCBmcm9tIHBvcysxIHRvIExMQS0xIGZvciBwcmVmaXggY29tcHJlc3Npb24uCiAqLwpzdGF0
aWMgaW50IGNvdW50X3VwZXJfYml0cyhzdHJ1Y3Qgbm9kZSogaSwgaW50IHBvcykgewogICAgaW50
IGNvdW50ID0gMDsKICAgIGZvciAoaW50IGogPSBwb3MgKyAxOyBqIDwgTExBOyBqKyspIHsKICAg
ICAgICBpZiAoaS0+bGV0dGVyc190YWJsZSAmICgxVUxMIDw8IGopKSB7CiAgICAgICAgICAgIGNv
dW50Kys7CiAgICAgICAgfQogICAgfQogICAgcmV0dXJuIGNvdW50Owp9CgovKioKICogSW5zZXJ0
cyBhIHBhdGggd2l0aCBwcmVmaXggY29tcHJlc3Npb24uCiAqIEBwYXJhbSByb290IFBvaW50ZXIg
dG8gcm9vdCBub2RlLgogKiBAcGFyYW0gcGF0aCBBcnJheSBvZiBlbGVtZW50IElEcyAoZS5nLiwg
WzAsMSwyXSkuCiAqIEBwYXJhbSBwYXRoX2xlbiBMZW5ndGggb2YgcGF0aC4KICogQHBhcmFtIHdl
aWdodCBXZWlnaHQgKGUuZy4sIGxhdGVuY3kpLgogKi8Kdm9pZCBpbnNlcnRfcGF0aChzdHJ1Y3Qg
bm9kZSogcm9vdCwgaW50KiBwYXRoLCBpbnQgcGF0aF9sZW4sIGludCB3ZWlnaHQpIHsKICAgIHN0
cnVjdCBub2RlKiBpID0gcm9vdDsKICAgIGZvciAoaW50IGsgPSAwOyBrIDwgcGF0aF9sZW47IGsr
KykgewogICAgICAgIGludCBwb3MgPSBwYXRoW2tdOwogICAgICAgIGktPmxldHRlcnNfdGFibGUg
fD0gKDFVTEwgPDwgcG9zKTsKICAgICAgICBpbnQgbiA9IGNvdW50X3VwZXJfYml0cyhpLCBwb3Mp
OwogICAgICAgIGlmIChuID4gMCkgewogICAgICAgICAgICBmb3IgKGludCBqID0gbjsgaiA+IDA7
IGotLSkgewogICAgICAgICAgICAgICAgaSA9IGktPm5leHQ7CiAgICAgICAgICAgIH0KICAgICAg
ICB9IGVsc2UgewogICAgICAgICAgICBzdHJ1Y3Qgbm9kZSogbmV3X25vZGUgPSBjYWxsb2MoMSwg
c2l6ZW9mKHN0cnVjdCBub2RlKSk7CiAgICAgICAgICAgIGlmICghbmV3X25vZGUpIHsKICAgICAg
ICAgICAgICAgIGZwcmludGYoc3RkZXJyLCAiTWVtb3J5IGFsbG9jYXRpb24gZmFpbGVkXG4iKTsK
ICAgICAgICAgICAgICAgIGV4aXQoMSk7CiAgICAgICAgICAgIH0KICAgICAgICAgICAgc3RydWN0
IG5vZGUqIHRlbXAgPSBpLT5uZXh0OwogICAgICAgICAgICBpLT5uZXh0ID0gbmV3X25vZGU7CiAg
ICAgICAgICAgIGkgPSBpLT5uZXh0OwogICAgICAgICAgICBpLT5uZXh0ID0gdGVtcDsKICAgICAg
ICB9CiAgICB9CiAgICBpLT5sZXR0ZXJzX3RhYmxlIHw9ICgxVUxMIDw8IExMQSk7CiAgICBpLT53
ZWlnaHQgPSB3ZWlnaHQ7Cn0=

--=-fQCCuy4QhAbdUpPk1GZl--



