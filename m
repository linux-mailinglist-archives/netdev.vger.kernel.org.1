Return-Path: <netdev+bounces-281875-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPG0KKW18GlwXgEAu9opvQ
	(envelope-from <netdev+bounces-281875-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:27:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F10E3485D16
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17881328B3FB
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893A944CF54;
	Tue, 28 Apr 2026 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="reZe0jAT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0786544BCB4
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382063; cv=pass; b=EC8y4QHZpyZwmtxOniqyEqUqpaYm8ToSzjb+OrbeYD3IofTiM0/3Aohp1jR27yMWtgtiPi4YmxvTeg1c6p0BySjgzgLzS2TitVl+/2RvLN2L0mZ+xl7rElbLrfKFc8VkpMCvHqLgOxNcKYVKEsMtpTu/qQWd6PwoLZKdVBs99PM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382063; c=relaxed/simple;
	bh=/pvgQuL7vphU/72KVdYS4OQfN6TiaqXigEAuLe2ShgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6Mvpreeq/NAB5fr29zSd95kRD7sIQy02ZN7Vq5IYXala8DFAW4uBUz4gwgcs4y/0/aSc9r1gi/uIeJ/R91Bh1ML4LV96GOmWk9IhOQ2OsxGHTYZmYd0tSoLpzQkfxI/lpTh7/qoqhSSRBYUudTmX6ne1p7KDIYtL3MT6GKigZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=reZe0jAT; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50d75bfb259so82766321cf.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 06:14:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777382061; cv=none;
        d=google.com; s=arc-20240605;
        b=h6NP7KlCkxU/6VGnogVerzWprzOhF58tZgeF4Avbyd9tRoT4n7fogLuT+TvrUlwbVF
         E52/QAc45qems3w9K1YNe1chZ461QJ+ZEFuMKWw/6kriq7dddoaMAm6iNn6STW4zv6qy
         90jvU5G8tpaq9T5irEsIq93Tg+wyp21fPjX0f3vgVJShES3GCStCZu0PTyRg5e4mExF+
         UVEbKsR3uNPYjfmxHK3Sno4ACMOIo8Nn4rs+kafozLxKkkjE95HBGNSqPWC5mGcpR24M
         5cxPdOI8zf3Gci9BByafUzCAwA+N+nuymwIv5LDomC86NVbbITLuwKBLK8wdn80Gkpvm
         T0kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ph2KGeZYvECiBIV5t/7ReHLKmIw+/jWyacMkZ2Q4W34=;
        fh=We58ljgs20Tw4fhTmZLMDU27g6aRAlHw/PmVlsA9kW4=;
        b=J5/0m95xYo7tB3BSWSp+aIEcrlZp7jo83jY1RWWKoK1eV6ALH5CJaI8Rcfh0nzdLuP
         TgfNqLAMrO4oZr3yslHMIHL0lSCQq3VY3CaSj4ZZk1p9UgOFSeLgw1Q6Eh3EFdkfi0sa
         fQUsqiyJ1D7vIEIkVI39FkZ5HibgwVyZe8Qr1Q3sUNgYh6H/6KdM73584QVHyE6Ef7en
         7k+G329sGZGObJg9rTRlYJu4WFBmgIO/i9BltbUk90WtbBwsHxBNKJnXctNbFDMmTt+H
         i8moPAXpQxxs95T5pfZ64tcXPq4io7EHq7Pz5QHCyeFvaI+JMJryA9I9ULKUxcpgIhoR
         fbng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777382061; x=1777986861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ph2KGeZYvECiBIV5t/7ReHLKmIw+/jWyacMkZ2Q4W34=;
        b=reZe0jATazrMApqmiPvLGnAqHzfZjSc/RL6VJ83Ano0FRokYM2BRE8ifJOh6QnlAtt
         qdUDoW+SKeiBa3V1yUVGpeMKSn0pmk7ghCNxj8/3E32DI+ET/TQNCA6VaeWTh+vuCRh3
         wFUpIwQGBzMuZByVU+D9VkMAxWKs0hw/+tlZwBrCAyNFjJyAtMIOTFk7uyKNZg3cRHSP
         o/T5ZiGkxZd6xSSuIV+DxbJkIB8auE5zbPx+As0aOmJr274No9oCtVR/qKjIjlr9+sJm
         dxyKSDyKJSyNhhx+TulZe6QspC2QMzcnE2SGIr5DM5UpJFGyPIajbaPaCXdMDeEF53PI
         HU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777382061; x=1777986861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ph2KGeZYvECiBIV5t/7ReHLKmIw+/jWyacMkZ2Q4W34=;
        b=SVz68N7bNnMeWRMOHjtgcCt8fpmBd1DMwDCC6KgjXoimVBgSDELrkLduKHRQzEa0KI
         Ges9daNqmI8E49NByXH9wI2SFbSyPWueXS3WutK9mTh1qxJZIEooHklb6DC7LOkq/DlK
         G3M57VfNXT7WDfkWPS+P4hHKiumM4nuVlOA1bEgIPziCVtH7HND74FPl69fP8blrKzm2
         zjVNixvkV3FP2ESL/YktS7inS2OR1D2ciB8h79xCvnMi2/INRdU46Miws4TIV1bfT/9H
         4BZZh/k0t9ERblqYysL1xBIhJxTU1y8y7DvNHm9vItntzUnJSAqHHD5AhGenBs3u+gFm
         DXnA==
X-Gm-Message-State: AOJu0YzoRF4BcUXdtr/FUxI9S+uhi95lxRv4TL3mf+0qIYSTYsSljOso
	RSKbAWHPe3l5lKNoVJGWme/hrnTBYJA2bYNJW8f9Oz60ncjHAJefjBWxGIzvfmErljFdfPbO165
	rF2ZrGrnh6bQNO2bUZ1rzzBPuYi0r3s+RtxmNnVl5
X-Gm-Gg: AeBDievzQPsiSlXgyscxJcyMVzIV9QZFAlUSGdJAOfn3eiuClemfqaM4qb/2UOO6afl
	DNyITeZtllcRjcn8dcwk3Z2d98CTsSDVHi1w81LPczeC56JfprK0qQjjg/ZdbHazhoZpO6CyMdS
	gOE6yrJovy7WFO9DjCQhc6CJvOvkD4sbBejJ4IY/1FU0T7oEpSvSsy2nNFA9esW2vQdVEd9vwCj
	1CCAc/5hUpXf6wAFsAxdE2t/pprKWrAAkjITK0CXgkgRxSfYNXRW7KwMMQYGQAwZ1qTMTmkij7g
	o+Mxeed9iL/+42DKoOQIX5uTwSjIv5TtvSCWYIBzbaVueev83O7InssPhJj8gHeTYUv+VQIgbXE
	Xw4QFXSK8
X-Received: by 2002:a05:622a:1983:b0:50d:cd5a:577b with SMTP id
 d75a77b69052e-5100e1a909dmr38694301cf.35.1777382060204; Tue, 28 Apr 2026
 06:14:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428110713.2550315-1-maoyixie.tju@gmail.com> <20260428110713.2550315-2-maoyixie.tju@gmail.com>
In-Reply-To: <20260428110713.2550315-2-maoyixie.tju@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Apr 2026 06:14:09 -0700
X-Gm-Features: AVHnY4Kj1O8tIjZZ71KmG_lSdWiR9NSfHmQ-lGRQOFxJHis0DQ-Gr4cC4qnWSpg
Message-ID: <CANn89iLa2+B2oZOpcShPDfaAmtJ6jUnEABVFim2fkyPTi=QK5w@mail.gmail.com>
Subject: Re: [PATCH net 1/2] ip6: vti: Use ip6_tnl.net in vti6_changelink().
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: netdev@vger.kernel.org, kuniyu@google.com, shaw.leon@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F10E3485D16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281875-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,gmail.com,davemloft.net,kernel.org,redhat.com,ms2.inr.ac.ru];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 4:07=E2=80=AFAM Maoyi Xie <maoyixie.tju@gmail.com> =
wrote:
>
> From: Kuniyuki Iwashima <kuniyu@google.com>
>
> ip netns add ns1
> ip netns add ns2
> ip -n ns1 link add vti6_test type vti6 remote ::1 local ::2 key 7
> ip -n ns1 link set vti6_test netns ns2
> ip -n ns2 link set vti6_test type vti6 remote ::3 local ::4 key 9
> ip netns del ns2
> ip netns del ns1
> [  132.495484] ------------[ cut here ]------------
> [  132.497609] kernel BUG at net/core/dev.c:12376!
>
> After commit 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of
> rtnl_link_ops"), vti6_newlink() correctly resolves the per-netns vti6
> hash via link_net. vti6_changelink() and vti6_update() were not
> converted in that series and still read dev_net(dev) /
> dev_net(t->dev), which diverge from the device's creation netns
> after IFLA_NET_NS_FD migration. The result is a stale per-netns hash
> entry; cleanup_net() of the original netns then walks freed memory.
>
> Reachable from an unprivileged user namespace ("unshare --user
> --map-root-user --net"); cross-tenant scope on container hosts.
>
> Fixes: 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of rtnl_link=
_ops")
> Reported-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
> Cc: stable@vger.kernel.org # v5.15+
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

