Return-Path: <netdev+bounces-171051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676EBA4B4AC
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 21:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F302169FD1
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 20:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD551EB192;
	Sun,  2 Mar 2025 20:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="KjHb07zs"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB384288B1;
	Sun,  2 Mar 2025 20:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740947437; cv=none; b=I5Gje6zcz9Rhi6b84MxrL9leUifBAFxlqPJL+LvqlfEC0fAFJgBLnlt8XjYZcpdw+zgN3jk6mv4Xp4yngszk7nr857bcuHNmuqy2ijm0QMZGqvaNR0XCfhNEOt+FwLx2QnOsQqhMnN0czH8aCRs0v2nrVlkudUyuxcXXFneEMeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740947437; c=relaxed/simple;
	bh=qu5KI8fMONBhzkGxAIHlBQNJ7CFJHqifoEwRmhHdgvA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PZWSzLLcmAhLQU4EYspFGdVYbq/IPMfrJH2uF6nwQgp5ayiTy3VxpseqbOmc8Iw9UK8B9yf+SDzQC3f/fH40H+7hyNFB55ub6KEC+2XocEsLotOZtwfPLMBI/j703a0JEeRz+iVl7x8H5T/w4EC28Y/kibZ2F99ieVh1Z7TJE4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=KjHb07zs; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740947430; x=1741552230; i=markus.elfring@web.de;
	bh=t03/rLM9FaNUTzDcuwCiZRSRsDm9yDnbuOT4YqKcuUI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KjHb07zsBfKJpgfl64Y7NEN2CovaV+QPdTEU3U5b8HypgSfj/LY1GmhfBqm1U2Od
	 Q+CZVrXWjRGvt+0Lrq/cmXontkm5Xm/+zgMeotWeBWGITbZrvLNLFD67UfYe4PJfs
	 fXvUutsoj13p4l6Qj/TJ7kx/D9edZWZut4SG/D10Lxosg5nJ4RIt44Jl2vKt3KdZA
	 IJq4hIn1GZEBOJ6d5qHQohUp1Gb4g3zekpuYCy40x0/QeMstPIaVZSpNZjL1XwG1s
	 bVx42f9+UiC/EhWxidBedJ1zceEWKPtdPXqcLwMDHx9UbgyKQubJZx5egdpuOWfWe
	 STH2lqbmZ9c3ZbAbVQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.30]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MOlwp-1tdb8T1ROh-00Uw3f; Sun, 02
 Mar 2025 21:30:30 +0100
Message-ID: <08fe8fc3-19c3-4324-8719-0ee74b0f32c9@web.de>
Date: Sun, 2 Mar 2025 21:30:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?=5BPATCH_RESEND=5D_tipc=3A_Reduce_scope_for_the_variable_?=
 =?UTF-8?B?4oCcZmRlZnHigJ0gaW4gdGlwY19saW5rX3RubF9wcmVwYXJlKCk=?=
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jon Maloy <jmaloy@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Tuong Lien <tuong.t.lien@dektech.com.au>,
 Ying Xue <ying.xue@windriver.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <624fb730-d9de-ba92-1641-f21260b65283@web.de>
Content-Language: en-GB
In-Reply-To: <624fb730-d9de-ba92-1641-f21260b65283@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/FibXadHneYGmAU6eIftjav2n1PX9JJV/0o1094/4mzs4YX73ZT
 RGDGo8GNthY0AZ8lx8FIHi6QHRC/guk94wbYT6BXKibSlqnB6AoZviyXW4tvaywOIzIXZfG
 FtG59s7INUZYU+nE6n5o548/Qmj3uN//G2fzNVngxWNNRJcMf1vlVohaGe642J0H90g+28u
 zAFXpRpACnEKLFSZgJY5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HfsN25LJsaA=;VIrrRgS4ncXO7iy+hD6iUtBt+bN
 BUe1tb8yhRkBVWsE8D/CuIWzfW1zSZQ0RcExrmpuBHM4ZKOH6lIkq/yYujLP/wAruqJ7eHRiX
 2duxGSXMYciSixYEG73TCtvxMMfKcBsxNKCVM7AVQ9EYgOxKLskUA0ah+LSGhUGPSM8I4vuLz
 Q73MjDowI4jFHWD37W6zC/QfDivAyWPL/sOkKzOleWZ52TkfQTn4smEpidzsQVrfBpIbWeBJ1
 9SFTt3713LPLRXnBA8vglR38wWI20PDlSLqEvMr7uYwt5B/yFhwEO1t5eXps2IvxrnHsvDo7R
 nFuSrcnNJpBCH4WyvpAyr9f6XbumAbgnPQci3RIrGMlX+c4eoea8jK7zQmKYrSGL0xoJEhqB8
 7Z1af6JDSMUKzQkPONBvDm5F5G+Qk+UPbOUso2T55MLzM9pBbOZzSYtxSQOr8ejbnPllGoMd7
 D56PYHHFdkrN4CxTZ0Nt2gHR2RV249BvcRhI/NA7G5xOmwTBzNTDor9fz0d+7oOLLBhiORj0d
 oJwONMxqg4Aqj9clb5R0su7jd8S7MEBaNqjJGWYAEApB4qEsvIo4NjE+oz52KpSvZL12ROjz+
 9CKcuRycUSXcpqaMcHU4FLEwAQKey/XVKNAjwq2at7LnvI8/ADlUuycOXmoWS0X0u5iXl6D1N
 emFVvN8e5bJUmmgGBWCR2TJ3/w71ZmreC16T6t6DVok8zuoEQCunliY8v1uYySa8+ylBXI7Ue
 /b+RpX7oVqRA8Bhp2AXXtuBTstPpzmUmDC3ObfvLpTRLWGqEIDRzbD1+A/0HuRpaYm7eskikZ
 uXek1qEgN/JpUqZit7eZM5y4ts3DMR2Tl6gnGrXtq1WgXaseBwWPUcYkLkCwN+wECm2p+8IB6
 5aBthztPX2MWRYfUDejWEhlkUnCeQXczvy+Z3B9iR1qWJJUNGz0WPHctm7hC1BZaTqvNvXlWy
 g3OcShZigPrxrXXvcT2s2uyamUnHxAHrKjFKHVcPGNG3T/g+UFc5SxDd4Kh9qoksdALBBKOsz
 mzB7qZfPo8zyBydGhe6a60Tn4O2HEZ2PRyKLgfGYqgp99lQpb5J4T5s/oYdF9lb20eu8dykCF
 Q8NBcjX9hbUM3qz9IfaF19KCnuXQVOxecGrscPRbo9wMwWvC4TEjxnAa3+Z+qwbE371MwrMtz
 R/R+A2amH5pWDC+a5zt6BlZGhs6zqlkUVRrRuBJNbnXVsQhVRU1LbURl+j4ij3KVn/Wh8o+YW
 UnPxrN2PL1U7crglFAS/tZzE7RLUjWI1HMlPo1BWDgp8REKeUCZnYpks5PAmFNONZWs6kLBUG
 Y1MSyuzPvwMh3VAUgvlD5zwdgXdrmcv0SNjQsOd+tzGPGLKjSXMr2noo/PVwomcgHonbi3hle
 PN9FR0h276FnYqe0bby0PGGStSD1RqJiu1oQRJfajILkAUsSm0vFCM9F/OJAcSk81Qdb8eX9e
 biNvoqhd3JcmXpE1UQIIRoB4ZPj4=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 13 Apr 2023 17:00:11 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Ctipc_link_tnl_prepare=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the definition
for the local variable =E2=80=9Cfdefq=E2=80=9D into an if branch at the en=
d.

This issue was detected by using the Coccinelle software.

Fixes: 58ee86b8c775 ("tipc: adapt link failover for new Gap-ACK algorithm"=
)
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 net/tipc/link.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index b3ce24823f50..5aa645e3cb35 100644
=2D-- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1973,7 +1973,6 @@ void tipc_link_create_dummy_tnl_msg(struct tipc_link=
 *l,
 void tipc_link_tnl_prepare(struct tipc_link *l, struct tipc_link *tnl,
 			   int mtyp, struct sk_buff_head *xmitq)
 {
-	struct sk_buff_head *fdefq =3D &tnl->failover_deferdq;
 	struct sk_buff *skb, *tnlskb;
 	struct tipc_msg *hdr, tnlhdr;
 	struct sk_buff_head *queue =3D &l->transmq;
@@ -2100,6 +2099,8 @@ void tipc_link_tnl_prepare(struct tipc_link *l, stru=
ct tipc_link *tnl,
 	tipc_link_xmit(tnl, &tnlq, xmitq);

 	if (mtyp =3D=3D FAILOVER_MSG) {
+		struct sk_buff_head *fdefq =3D &tnl->failover_deferdq;
+
 		tnl->drop_point =3D l->rcv_nxt;
 		tnl->failover_reasm_skb =3D l->reasm_buf;
 		l->reasm_buf =3D NULL;
=2D-
2.40.0


