Return-Path: <netdev+bounces-253557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAN4O1Sld2lrjwEAu9opvQ
	(envelope-from <netdev+bounces-253557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 18:33:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7488B84E
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 18:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 280BD30146AA
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 17:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258B334D4CF;
	Mon, 26 Jan 2026 17:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pj/cAfSX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDA734107C
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769448780; cv=pass; b=sD6n3TkG6bUymv3vOw0pD0J8MJ2uiRKol4l3mO9QCQL9gvcecZfguC6oeq8SRn/wzfFBJ5RRY5JvvNwxp78Z0x+4q7RiX4rr0eKGUnbFhB+t3rgiuGvIK40l+Dp7lIlJP2BEtO5hnmmycLvHxTUUr30XadsgGF96+LqG5izJBhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769448780; c=relaxed/simple;
	bh=j00/Os78UBfYVsz1SyezoqO/zHdq/VpIh+6M3/JRjLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjKulaEyGcRKzcZuSiySByo71NZN9vPXPw1/82TfHRMnxa9oX1flZ/zco6PYB3aP8PHv9tgCnVbn7LOGim+Go5u+3YARHGX28YP5TCl8CXhccqxrGYr1xicBhGLUFXi024t8uH3lb9U6q4O/lbO4GLRbVIbyyrG/V4oEXitolls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pj/cAfSX; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-502f101d1cfso47768781cf.1
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 09:32:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769448777; cv=none;
        d=google.com; s=arc-20240605;
        b=Wf9W7+11/mT2dLgTzU4BBeSeoUtiHC7o/JGGesgvFBev6UyUpQYF9vZvM23B9vKGxu
         yVw3Q3lg63KhZtfCeyXhGKYhcdlA57RRaEZDfwPEOT3XGGxX3nCWdchmc+CjkSjbytyu
         PZdQE2gjilM2r60VGbto4h1bb9PDohJni6cVPpTrzVSwUIRHK/II5siJbJLtLbgNwt0G
         ON1r0oDA9gcDqhXoz5E8Qy6VQMzRlxqHB/9PXUZOukO5i/D2H7dKEm4EYKAE7CeFv5PU
         kAXPQ2DxWyFnRI96v+8QK1i7o8RzmIFrJRYLfuLn13ihYOw2q+3PUly4lfO2acOAHw+q
         IBBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mZeqaRnbISXit2kE4h2QnQgXueXMnyOi4SzhL+ieQ0g=;
        fh=USqBD812BmnKtdAMp2KdGcYtL/A7MTzXzp2C/jIZpXM=;
        b=Y6uhvbDI7kC0Vv4k31JQHkvv/rrJIPw2lOREQ8VBcbbJofOQyu68zJHin+RhlaBGZk
         0i9wq18I2KKgvU257thxR9Of/VEPTTc9T0hFN8h6VtGFgTqmqdRDgC54k4pBRJLauBv+
         NcX3a9DyWXYTEgw6DXiYp2SPktGeSI4HD01+DeRZmDXt0yiQqhvARNBp4E8n/QqyqUR3
         LtZnmOjA5d9DsLN6SUlXqyh24btclhmsempDzE743oZPc3P7R4SNfI9Jt4gPtnZi7Gh1
         2QPFuQcQPn75siK3AbqPxafB8tfK3tQTU2luJk6/sAos/hRpaWt6bQgk4ChckQDaDbiU
         iFuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769448777; x=1770053577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZeqaRnbISXit2kE4h2QnQgXueXMnyOi4SzhL+ieQ0g=;
        b=pj/cAfSXz3y41qNgzUTlEGyNYeenee17PGYhvIVwCrrHQYmDvawewrk6ql3MQZpcZw
         9yXn+iTPZGSW8XC4jVbDw20Wt2xGPwVu+Kh7A7MWAnaWSvk9HYOvJZXDKSJoBUEreoR1
         vNOI+dfyKHTY2G/OSYk7u1kVi9YDhrbY7YZyPIt9n7JQ/6waCaUMNnWv21KY+xjZj0lO
         EBu2fFQZ8orwZqBK+KZjVZnzPK2QwKbtjlp44mVGOECecj1oxJfOcbJoIiDdPO7QvLg6
         8wCTSWr5YcPXqubMk14RjT18NOpk8NIpVon43lCyniFmGkP78FhhP+uvmAgRit1r3Em+
         Fz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769448777; x=1770053577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mZeqaRnbISXit2kE4h2QnQgXueXMnyOi4SzhL+ieQ0g=;
        b=TQVvzcZ3NEXDMgcNV+ax8JvX7de0xcqHGJHs2vw9BEU8DVgDIEkzR8uhAduMGfib1i
         nYQiwgen91utR/Usq9/qbcXSQq+kVXDwW0aGe3aK6g7ru5MZdiyxr+dz5orOZr0WrR8S
         +S9w2vJFKFin6bXqy+KeV82Xwr0CIqUYY7bLscz4FTZokUzqTkHxCpKmMlz8dFG5qwvt
         F3PjVzE8kQ0J5qCgBat6ypNnw34o4xFWegsgV+snx+B+K9bqfIA8JcWUFzZf8ev350oO
         svmiGtzDSDrhCWqZQ2JSMBb7onCoHnlUlKtWsytBad21/qqMLv61vO8DH3WAcgIhIuny
         gewg==
X-Forwarded-Encrypted: i=1; AJvYcCXdUZRgRBpGidCPO6/t4gPuRlsPJsFoXLzjeJVfyamwxskkmjwA2l4dz7kz/JngGR++1Usm8WY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp6Ht7czAhes32QPwGiXoo387MhdCF8ND6oC4k3qY9EZFSoBKy
	Xsyis/MZjhMYwFFs1UwBZZP9WCPQcGO2qtDKVsCs+Rr6vYjl0spbyKiFrDg/LN58GMiqQiTM7H+
	zH78t3XbVOD70QUL5rXRc5O1IrdtTSDNnqfoq29KK
X-Gm-Gg: AZuq6aJot6Ii9HrPhzpi+JrBsiRtnzxEQd/5tm+7p6HDR8uE3uUplPI4tstUQTjRD4p
	Sy1i3wYly1GfHvmbv1ehlvQREqfbRMOQ4tN1g4FYHS2S1a4x6vg5f8iWKEJHJVDc2266sUUmRFE
	+NCkFG2JtVJyzLa3E78SYt5ILChdRbNuNVIXz8yO8o/y8Bs0rVlQkeRtGBxcKSRqDAVSk4WBuSP
	dkNxvn/t9azULkC/De8XS6WzN8n2BOXmgjQf8TTwc/oW7+paLMNI7EjDSX/Kmq95LMtAoycyV6B
	kubq
X-Received: by 2002:a05:622a:54d:b0:4ee:61f8:68d6 with SMTP id
 d75a77b69052e-50314c22e5amr69977351cf.6.1769448776554; Mon, 26 Jan 2026
 09:32:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aXeka0KYBnrkwUcF@sirena.org.uk>
In-Reply-To: <aXeka0KYBnrkwUcF@sirena.org.uk>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Jan 2026 18:32:45 +0100
X-Gm-Features: AZwV_QhJ1XWOboa8QHh50biVQXbAZiTroOGuwAauoOwEjG7FYW3G6KdVCm6ZYus
Message-ID: <CANn89iKf_4g=nT5YeVNbMBrLeXvhc6fJF9G_njoz=ZiqVfJYpQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the net-next tree
To: Mark Brown <broonie@kernel.org>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253557-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A7488B84E
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 6:29=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> Hi all,
>
> After merging the net-next tree, today's linux-next build (arm64
> defconfig) failed like this:
>
> /tmp/next/build/net/core/sysctl_net_core.c: In function 'proc_do_rss_key'=
:
> /tmp/next/build/net/core/sysctl_net_core.c:333:23: error: implicit declar=
ation of function 'hex_byte_pack' [-Wimplicit-function-declaration]
>   333 |                 pos =3D hex_byte_pack(pos, netdev_rss_key[i]);
>       |                       ^~~~~~~~~~~~~
> /tmp/next/build/net/core/sysctl_net_core.c:333:21: error: assignment to '=
char *' from 'int' makes pointer from integer without a cast [-Wint-convers=
ion]
>   333 |                 pos =3D hex_byte_pack(pos, netdev_rss_key[i]);
>       |                     ^
>
> Caused by commit
>
>    37b0ea8fef56c (net: expand NETDEV_RSS_KEY_LEN to 256 bytes)
>
> I have used the tree from 20260123 instead.

I will send this fix then, thank you

diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 0f761d4b9447..03aea10073f0 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/sched/isolation.h>
+#include <linux/hex.h>

 #include <net/ip.h>
 #include <net/sock.h>

