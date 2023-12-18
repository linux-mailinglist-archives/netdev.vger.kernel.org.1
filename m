Return-Path: <netdev+bounces-58669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C50817C9C
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 22:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36FC61F23EDD
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 21:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCFF7409E;
	Mon, 18 Dec 2023 21:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=corelatus.se header.i=@corelatus.se header.b="mXXh6UtI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yEBqUg/t"
X-Original-To: netdev@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA1842361
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 21:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corelatus.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corelatus.se
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 078005C03CA;
	Mon, 18 Dec 2023 16:28:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 18 Dec 2023 16:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=corelatus.se; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1702934930; x=1703021330; bh=b3PDwCj9W7
	k5W473CsFdWaBtVeiECx5bTgcFflVPyuo=; b=mXXh6UtIESD2sXaS3iMNZu26C3
	8hmSSymnZ/hJ7hXycBJSBW20McRqIDvlHuew+8TJgR/Rttt28c9IbZKYZJUf1QXN
	Tu9CN3waEWLNymmDywUHsEovxdu//2HF2W485tYJB6cbCKeCMcIkng4GZRyih4dS
	gRKQzjcmReQctuPOiS0xnBqnOUv6DJhhH7mkbNNqRHmBhiVDFUibe1LrOyJD0McM
	er02yZots1H2o+sDDobSGFmTbof93Wt+6uxtSWtDy8kLkfMdJL3HAA3daGYqW6vp
	e55bXT4JdCH4RinSiI3Cb5q2ROsiRVXJSSqRxHsJOkfhAYvQDusX/ODwB1iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702934930; x=1703021330; bh=b3PDwCj9W7k5W473CsFdWaBtVeiE
	Cx5bTgcFflVPyuo=; b=yEBqUg/t1gjuO+demerJGLRkwwnFvPx9HvwU8dwb22NE
	35xJOD7Pnsy7uVWhDPQXghtpoNKmEvMfGcur49Nt20LGLzvjZ22AInjFr1GqfFtx
	ygMf2zCi/8e7FgugeJGBV1ia5ZSVARNgdETXgTbhgorniNeRaJHbsLySVEOKG0z7
	L8ByAq3D77d0MicncyV8plafzdHvCcaTW1febTBDTfjKaLX6RlvOz46HkKzjKn/L
	hD7KTixclwfPTNsbaYXVU/hb53dV+w2Vomj3Pfk/GKEcPmEUQq49We40/GDwVOVd
	tJ2KlCLvbYKH42VhxFqtRwPVeINMqBw77pvXO6YFaA==
X-ME-Sender: <xms:kbmAZRNjrcw8fTnIYAnIldMilipdIYUyaQOo3BFVhiG5WtUmjL1dOA>
    <xme:kbmAZT9dUAQVeIg7y61yPYOYb2QtTyVbsNSFCHtDkp_Z0kAgVJCAbcfgN6sqA__RD
    mXPIp2t0Y1aHSC4fg>
X-ME-Received: <xmr:kbmAZQSmcpnFSYhlsd3MO85P5zdjUv23an9EZWKynEhpHyFjo7QTN2AFzylK4EhL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtkedgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepkfffgggfvffhufgtgfesthejre
    dttddvjeenucfhrhhomhepvfhhohhmrghsucfnrghnghgvuceothhhohhmrghssegtohhr
    vghlrghtuhhsrdhsvgeqnecuggftrfgrthhtvghrnhepvdevteekieehhfekjedtgfdvhe
    ekheeiieelvdeiieevgeelhfetkeetkeevieehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssegtohhrvghlrghtuhhsrdhsvg
X-ME-Proxy: <xmx:kbmAZduzix-eXEnmWXJOlzWR10_eUNv57JrtHZwot3l60nSWuGw6OQ>
    <xmx:kbmAZZcaOubCWAbQehFRr6OHFRmonL9o3K3al09WNEbtFbUZ5WTI0w>
    <xmx:kbmAZZ2YuzDmSfBgd6VreNLLs56Faolz-6qxHXOpNP2PUt_KXqWzBw>
    <xmx:krmAZZn_xJ9sLN1OWmiSKVlBBxm1HOi-7hq1Gdl3kstWkaEZj91TSQ>
Feedback-ID: ia69946ac:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Dec 2023 16:28:49 -0500 (EST)
Message-ID: <a9090be2-ca7c-494c-89cb-49b1db2438ba@corelatus.se>
Date: Mon, 18 Dec 2023 22:28:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org
Content-Language: en-US
From: Thomas Lange <thomas@corelatus.se>
Subject: net/core/sock.c lacks some SO_TIMESTAMPING_NEW support
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

It seems that net/core/sock.c is missing support for SO_TIMESTAMPING_NEW in
some paths.

I cross compile for a 32bit ARM system using Yocto 4.3.1, which seems to have
64bit time by default. This maps SO_TIMESTAMPING to SO_TIMESTAMPING_NEW which
is expected AFAIK.

However, this breaks my application (Chrony) that sends SO_TIMESTAMPING as
a cmsg:

sendmsg(4, {msg_name={sa_family=AF_INET, sin_port=htons(123), sin_addr=inet_addr("172.16.11.22")}, msg_namelen=16, msg_iov=[{iov_base="#\0\6 \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., iov_len=48}], msg_iovlen=1, msg_control=[{cmsg_len=16, cmsg_level=SOL_SOCKET, cmsg_type=SO_TIMESTAMPING_NEW, cmsg_data=???}], msg_controllen=16, msg_flags=0}, 0) = -1 EINVAL (Invalid argument)

This is because __sock_cmsg_send() does not support SO_TIMESTAMPING_NEW as-is.

This patch seems to fix things and the packet is transmitted:

diff --git a/net/core/sock.c b/net/core/sock.c
index 16584e2dd648..a56ec1d492c9 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2821,6 +2821,7 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
                 sockc->mark = *(u32 *)CMSG_DATA(cmsg);
                 break;
         case SO_TIMESTAMPING_OLD:
+       case SO_TIMESTAMPING_NEW:
                 if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
                         return -EINVAL;

However, looking through the module, it seems that sk_getsockopt() has no
support for SO_TIMESTAMPING_NEW either, but sk_setsockopt() has.
Testing seems to confirm this:

setsockopt(4, SOL_SOCKET, SO_TIMESTAMPING_NEW, [1048], 4) = 0
getsockopt(4, SOL_SOCKET, SO_TIMESTAMPING_NEW, 0x7ed5db20, [4]) = -1 ENOPROTOOPT (Protocol not available)

Patching sk_getsockopt() is not as obvious to me though.

I used a custom 6.6 kernel for my tests.
The relevant code seems unchanged in net-next.git though.

/Thomas

