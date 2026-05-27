Return-Path: <netdev+bounces-292128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCYAE1KZFmq1ngcAu9opvQ
	(envelope-from <netdev+bounces-292128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:12:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1725E044F
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C40B300B44C
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58AB28D8DB;
	Wed, 27 May 2026 07:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JPbwt2ao"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4421522370A
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 07:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779865736; cv=pass; b=shY1dW8DOEvdIUayeNMRFD8lHrDJkq/pdbPueYkGFNFNd6/mNyGdAC9yOZVukyjjL3ZkZrSOkI9cgOVVUi653eECk10bnEXHGm9aJrv/FQBk9z6uwv5cjBYOo9YKCwfUaUin5UA+oCXtSW2kaRW75jV3ji3+99XBuVHg8Ndbo9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779865736; c=relaxed/simple;
	bh=3TpiT1mb6sr9d46VO0aesQKhmiWFV0Y9KXiKQ2q0UyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uVm1CFYq6LdbU4ByfJdL+zvboIUiV5tYr9WIzyHXqnmnmsHv+pJPCKjgd3YjT6KoFKsVWHK1RMV10EoiYMG0ZilRQCyg/AoOqWwMOCk6QbGYbMofzUjldzNT9VvnlzP3R3e30lGw1x+8RQQ4wSZRlaQXB8iZr/biNFXTs4oOmZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JPbwt2ao; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-137335bc3caso1948881c88.0
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 00:08:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779865734; cv=none;
        d=google.com; s=arc-20240605;
        b=OE2DaPjmfSDEYeHx8dPJIwWBVTl9c4ClMXan9PgsR51GAKwrSaBg6a9osHkPMy4aXF
         fV/L11Q5jidG6+DdoRwtwttlRddIPl5r+rvIujf4nlxcFgKTwL/OQlJv403HHEIuisEy
         AYPkw+2Z84V0uJU7E9A4IleR9oeppoG9Pl2YKaAIw9BjwAhgvDmVrTsJXL7v4eCehyAP
         JUc2VDJ5/4kHjInNDyhnUFT8c+nRcXASxA7zAft1pmnaT4NfohaF8C7Omg/T3e8UJDf5
         2bo6A+siRtfcQ1fp+qgnzcR/S0pFZ0B6Es8igU9VjT0yaALf+vuJX91NiL8F/4VDBhWN
         qvQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E7EtLrm4qyx4UR7+1AqIfVutIT+2VaYgwter3Xw/cxI=;
        fh=JgOBDWRxat/LXaGYjriwb7xkjqoIfQW4MfsQubXj5E4=;
        b=J+3/Gd1idOK34ucHI/LACfOn66mtsGeWkF30hSwcL1ZmUNn5uth3vnODS8L4aRd9YN
         hRZ1jT3O1wwiUG/Fzazlg/s0K0wVhMrAM0R7Lqz79XoDo2xc2IvyxTM1pC0hUvrMIe4z
         iXZuE3zUD1xJsFeWEnggtst+HBRIR3OcDEu+/jf1CZaZJ21rF44IfgWlNecpZdxsltSh
         et3K5KJlUdTlsJphi/+HoZSg+qcKlkTiEXtuqhwEvHR16tHAUA+g7C6+q78yx8onflFc
         GSoQoO78nM3adv0fQz0sZdvD+KGLbcHw11QKAhBDq1QeQIn3bzeJ4Sotlpa34qTgiPNE
         Zlog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779865734; x=1780470534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7EtLrm4qyx4UR7+1AqIfVutIT+2VaYgwter3Xw/cxI=;
        b=JPbwt2aoBRBIx8W4QUSyX0kQt1Ptg0nejITBhrsuZ8OynjvpuRI7GFb4KB4wXGGK8X
         QzywhAtktSkIkp/Qeeosjc0XnJuL8SPyVIZ6I4+yRvXeRasVyK0zhQHgFnlavzwlSy2Z
         9y7z6cLndSf9Mguj0RZUHiE+ahbML2pUGROH/0Ta5aJum7ORaxSnRL2/3KxED9CCrLJZ
         iggjIXO6uzKDWVlMpeUHHGqrct0x0AEBsAjzkhYFlX5J11p+rkXjcF7uTGdXl+7ahxeT
         dEES+Z/CTeVY/zwolRBPcEeLm01ZS4EYSKnIFuxP8k827p4QzFymfQTktDIv43aHiFe5
         I0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779865734; x=1780470534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E7EtLrm4qyx4UR7+1AqIfVutIT+2VaYgwter3Xw/cxI=;
        b=mV2DsEQ/pCNhSP8kU48Fu/SVJpz2R4PGqhQbblMWDROQVRxKZiqfos4Bl/fims2gun
         jKT5JIzXNByxOXq7AYvkEAef/59XFm4wOIyTf57wvzKW/aGOnxWa4DCyuoBiPxhfTWU5
         jhQpiyugxNUayOVzMhT6NMxLfO4GrrQTm2iZ0E9h5J03Fd17wTL9aFrhd1cvjO8k2ZEB
         odqgQuMhMBndHShn5LOgqCzGCZrFr8q7VmZL5qOrJ/58MPwd9gGco00ou3NiT5b66kMZ
         /RG/RE3cYdOYeEhpi/nmQARpekwKTK9K10f88yTY1cvHUzB7STsZm2BfVO91D5DS/NLO
         NOHg==
X-Forwarded-Encrypted: i=1; AFNElJ/dha6fwkMZ0YJBcTIagBRSWtf5hNoPXEmw68yGG+7/nkyI2/5d8SHyMLfZo3cFfniEl8WFzPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXA9DyAt3FqOShMvGDChMwFap8y52WX3mWQAo8NOurzcwEwLCJ
	jR/fTNetuUP4MjmeWRPaXaK4j4P4mtPPkCZVx+8IdhXkWYhn79Lqpzz/j92Soe2kGPXFu06RMFI
	jXOP4hogcV6z/JMKBbELkdI41oYocAS9KAOvwcXrR
X-Gm-Gg: Acq92OFXEbiKGRccNcWKsM0LllVIvVchFG8k2P/qhwibZZMpDrlQ2GQ+zrG/Wl4W59y
	XCR9yMIHoGiZEzLFkOVLhOz2oqwhZny+uezbt+4zoRQ3I5fSFakB4KuDPYmdYMpiG5imEtDPnQx
	96O/J+OdvJcAZQ7XzWM6NZEgiWBBNTLnl5TBXdyhtKFeC2zQ+QgWZ8MaLDhcya0vTUvLQCOKLB/
	HOjI9UGwtlYsyjo1GsQVmV8ys15arL21d79FvXkEArSrgSqDCy01ISjhhHRavD5Ai4zzKfDqrsx
	lpbOkU9l+c2UIXlAzcvLNidF0W99ge7t2cAllI4C5ojBItZMf7B4eTRfHSXaSmhod2WSgXV3lEE
	KB00cr5riS2KV8vWUlcyLRA7k7RaddyLT2e56+dLG7pV/gQe6xXt8QmH/Q8s3ew==
X-Received: by 2002:a05:701b:2212:b0:135:d7ab:7ebb with SMTP id
 a92af1059eb24-1365fb502d8mr4877414c88.29.1779865733747; Wed, 27 May 2026
 00:08:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527065342.2463433-1-jianyu.li@mediatek.com> <20260527065342.2463433-3-jianyu.li@mediatek.com>
In-Reply-To: <20260527065342.2463433-3-jianyu.li@mediatek.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 27 May 2026 00:08:42 -0700
X-Gm-Features: AVHnY4Jop-otkFqmrrH1KvdqYtvDb-zIjJYDkqXsJ4QU5G4-4D_yhrgNhStUgRY
Message-ID: <CAAVpQUCCS+oA8E_aFn7ozkwsgA-zsfnwHSZGWi9o01wnQCmgPQ@mail.gmail.com>
Subject: Re: [PATCH net v1 2/2] af_unix: Add test for SCM_INQ on partial read
To: jianyu.li@mediatek.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	black-ch.chen@mediatek.com, ivan.tseng@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292128-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mediatek.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9B1725E044F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 11:54=E2=80=AFPM <jianyu.li@mediatek.com> wrote:
>
> From: Jianyu Li <jianyu.li@mediatek.com>
>
> Add test to verify that when a skb is partially consumed,
> unix_inq_len() return correct remaining byte count.
>
> Before:
>
>   #  RUN           scm_inq.stream.partial_read ...
>   # scm_inq.c:165:partial_read:Expected remain (512) =3D=3D *(int *)CMSG_=
DATA(cmsg) (768)
>   # partial_read: Test terminated by assertion
>   #          FAIL  scm_inq.stream.partial_read
>   not ok 2 scm_inq.stream.partial_read
>
> After:
>
>   #  RUN           scm_inq.stream.partial_read ...
>   #            OK  scm_inq.stream.partial_read
>   ok 2 scm_inq.stream.partial_read
>
> Signed-off-by: Jianyu Li <jianyu.li@mediatek.com>
> ---
>  tools/testing/selftests/net/af_unix/scm_inq.c | 54 ++++++++++++++++++-
>  1 file changed, 52 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/af_unix/scm_inq.c b/tools/testin=
g/selftests/net/af_unix/scm_inq.c
> index 3a86be9bd..84a742e69 100644
> --- a/tools/testing/selftests/net/af_unix/scm_inq.c
> +++ b/tools/testing/selftests/net/af_unix/scm_inq.c
> @@ -8,8 +8,9 @@
>
>  #include "kselftest_harness.h"
>
> -#define NR_CHUNKS      100
> -#define MSG_LEN                256
> +#define NR_CHUNKS                      100
> +#define MSG_LEN                                256
> +#define NR_PARTIAL_READS       3
>
>  FIXTURE(scm_inq)
>  {
> @@ -120,4 +121,53 @@ TEST_F(scm_inq, basic)
>         recv_chunks(_metadata, self);
>  }
>
> +TEST_F(scm_inq, partial_read)
> +{
> +       char cmsg_buf[CMSG_SPACE(sizeof(int))];
> +       char buf[MSG_LEN * NR_PARTIAL_READS] =3D {};
> +       struct msghdr msg =3D {};
> +       struct iovec iov =3D {};
> +       struct cmsghdr *cmsg;
> +       int err, inq, ret, i;
> +       int remain;

While at it, please sort these vars in the revese xmas order.

and before posting v2, please wait 24h from this revision.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

> +
> +       err =3D setsockopt(self->fd[1], SOL_SOCKET, SO_INQ, &(int){1}, si=
zeof(int));
> +       if (variant->type !=3D SOCK_STREAM) {
> +               ASSERT_EQ(-ENOPROTOOPT, -errno);
> +               return;
> +       }
> +       ASSERT_EQ(0, err);
> +
> +       ret =3D send(self->fd[0], buf, sizeof(buf), 0);
> +       ASSERT_EQ(sizeof(buf), ret);
> +
> +       msg.msg_iov =3D &iov;
> +       msg.msg_iovlen =3D 1;
> +       msg.msg_control =3D cmsg_buf;
> +       msg.msg_controllen =3D sizeof(cmsg_buf);
> +
> +       iov.iov_base =3D buf;
> +       iov.iov_len =3D MSG_LEN;
> +
> +       for (i =3D 0; i < NR_PARTIAL_READS; i++) {
> +               remain =3D MSG_LEN * (NR_PARTIAL_READS - 1 - i);
> +
> +               memset(buf, 0, MSG_LEN);
> +               memset(cmsg_buf, 0, sizeof(cmsg_buf));
> +               ret =3D recvmsg(self->fd[1], &msg, 0);
> +               ASSERT_EQ(MSG_LEN, ret);
> +
> +               cmsg =3D CMSG_FIRSTHDR(&msg);
> +               ASSERT_NE(NULL, cmsg);
> +               ASSERT_EQ(CMSG_LEN(sizeof(int)), cmsg->cmsg_len);
> +               ASSERT_EQ(SOL_SOCKET, cmsg->cmsg_level);
> +               ASSERT_EQ(SCM_INQ, cmsg->cmsg_type);
> +               ASSERT_EQ(remain, *(int *)CMSG_DATA(cmsg));
> +
> +               ret =3D ioctl(self->fd[1], SIOCINQ, &inq);
> +               ASSERT_EQ(0, ret);
> +               ASSERT_EQ(remain, inq);
> +       }
> +}
> +
>  TEST_HARNESS_MAIN
> --
> 2.45.2
>

