Return-Path: <netdev+bounces-255582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDBaIjIMf2lziwIAu9opvQ
	(envelope-from <netdev+bounces-255582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 09:17:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F042C53A0
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 09:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B68AB30046A8
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 08:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3798C307AD5;
	Sun,  1 Feb 2026 08:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XGFfZBC5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1042E7F2C
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 08:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769933867; cv=pass; b=sGhP7FEbNVgHrV/dN1KpTQqQkirermJ51mAYUzn0HjjbWsbwXhFpxF/2pgy2eMjy7TYIxPWzeGBZ6Ep5Pv4ofzG+bN5R9Fg5Qtib4nNKv2k1XGFEKIAubowzk2i8eFRwAY+yjNUGshO+ahGuaabo27aMFYecSfp1g+vUa0zIGJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769933867; c=relaxed/simple;
	bh=3re9rxV/8dh5KL5dWJSWC+HvSoBzJ1kgExDXoj22Fd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+NJBOIa8D7+rtnb1jgUZ0LkXy9yD/xv8A/vk8d3qI5xjNcFxgmuuBm5+xRL0AY7Ew0iYqb2xnK+GqUwYJK1kdN6E8OJ+Yvk8a41Rz7pfWDm/yA7Admv/3q9WaayxYrc8b8AzaObygl7fR4TQH8kYh/HV2aOWXV+WgwS1wJWUH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XGFfZBC5; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50146483bf9so40602271cf.3
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 00:17:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769933864; cv=none;
        d=google.com; s=arc-20240605;
        b=LAd3L5U7N0xb6uFixh1es0iu9bKCOCvnew8hMFlHAazXVJLaYPrvewmTRJ+oCEMfUj
         n7csglTcwO/Y48zcdUiz3Op5S1YHrbujd3s/9EdmYY56rg4jEMG7A76Mn4v7TV1XD9N8
         O1+WT3tt5RKwvQL/zTY2yy/BJ5IlAOZGUXdziMcEMKBt+r6j34xpnIJuSazJX06wJiFy
         5uG8OQYovij/fIKiELozkc4W8RgR4coRtsZnfzcoVEBvyBa9bH1M8bXUMLF0Eb6KJmn9
         gVK7E6I3fNN6Tk3C4GyvJ3Qtgk2j07xcCzdvA0Bz/ugAc0Gb5cgOcH5ac2EZ5O4vnNs3
         UkSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PB0m9gxhrqXIUqCxYwXzor327qBnTXWpH9xmdwbkgxQ=;
        fh=3hqtfpJYGpBFukSIprbs2fDhg1FPR3WC/GHCyDymFzo=;
        b=JJ4aZWzw/VM6VObTIuzh3xhTJCAucDBBXQ59zZWDWrvRNC195sz148iqxrWEjRaYNg
         aGkbUsnYMHEwm6Z15NZU/4figM2I2nYGkUe5DDOzO7nRncTdMtqpV2KZA8qUG8I9/3bm
         wMjU/Uju5KEeJv9YQXcC1Ihru6MWChN6s1/S4iroGPGQkfM5zlZt9Mfuy+0r57W5i8eJ
         nYmVI2jkmAZg73ioAnavS/gfT+TTg4bVGXeUKjdIbZ311XFzindLIb4XOeDJkGffycYx
         GRreWLOZm/GXfPKh2btkIgYkDauWW6bnEaOHzxmjKQO7zcOvcXvgAh1XLM5K4BFyaAcC
         MhpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769933864; x=1770538664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PB0m9gxhrqXIUqCxYwXzor327qBnTXWpH9xmdwbkgxQ=;
        b=XGFfZBC5n3TTNcRyisyMpMkkH0DDV1osRTKOzp2rxvaDTK1DNJFGZx76XQYN05CM5O
         gx0b6Kkr3k/EK+YZGq0htUi47AMFehMFqvRiktyV9mRmn0lTY9M+vQsagW2d1BW2kPni
         wtMuEl0sn3emxgq4eIBy3E+gyuOyoI+bTSdQgWSZ+ykuDRkyS5S2OD3JvGBI4qHyStwP
         mcSjNK5JirBkwqRXQUVDl3kfN0jRTcM0a7qKucfTpHGPuCDw4bn5N0EqRm519TpIZr16
         MDbavrQCq5f+BcMbfHeRVLsMi/ON7fluJX2jL4Hmh/OWc9KaEJoIrWeI4hCVP5FlMdKU
         5iGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769933864; x=1770538664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PB0m9gxhrqXIUqCxYwXzor327qBnTXWpH9xmdwbkgxQ=;
        b=fC4+7918nONVv30qnBO1Om5HOqKBWcYUcG5D/g/geXZ4vht7LfjDit9FX/0GOM5R0K
         5rN9gI0IJg9JX/JzCznp3oNH+mWRiMVksA8LEuC2zy+Xp2jzcAsTkO41zwKiPoc3UxXE
         s4voKyDJwiNX9UPXPBGOC3kSbQeKF9R2p5oMhRQn9ITQR00NQfpPv0AWC2Xrmb1UwcFx
         DEF03PpP8HdxJ9I8iByQ1LUSJ5BxaSq3riIpAv8kYTYUgC14zbB6S3AcgfjPyKWqT0O2
         gE8EFYoI0LyN1xL8WOd8oPVYNhACZR8jma0oumF5L5j1GIYIsZCbXVUHRWilwAL2WGCh
         7WDA==
X-Forwarded-Encrypted: i=1; AJvYcCWYvIlNNzyhYc0fYWA36q5pdwSMxhzPxzg8uFgq6ReBY2znt2NGAbVqHHbgqv0P20NXdXJ3xO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdnH5YeH56frC8YaFjfG1ZdRDk61STplvVRdovNN1FqM967HC7
	yxkHcuhB2GKvYfmQJ291PvWMvfw4fnwHlWbHcIfp7Pcsyku72eN0K2U92bkpodVTiuvaWs3D6FH
	Fd0OsmKbBXFmHRN9XsrojHHA0Vu8Qap5yFZJj/GxU
X-Gm-Gg: AZuq6aL6p9Ic063JrPGYHsPNBkD3YLihJIaPVls8Vsd33A0BgrbG2qO7BuUHOzwf2GG
	XiMqSWScFYrpBmLGbArzjqxYikb0ZIz59j+pZch02Orps4+9CL3nMx3/f78WldVK/KrWvSvSd4R
	gw+/12+m4EOoZ/+oRPV7eLwKDmUuKEcPJIDzryl2a4jmnDZKn8iREER/+htfmu8VPvSmadr8XaR
	6ffs7JcGZ9apvT/soQGDWKwqGc0vQDS6AC/w3tXYp+B5F/jiqGRH5W0w2UJSjHIzZE5gQAHqK04
	Gt2sXw==
X-Received: by 2002:ac8:7f49:0:b0:4ed:5f45:448a with SMTP id
 d75a77b69052e-505d212da0amr132861661cf.6.1769933864353; Sun, 01 Feb 2026
 00:17:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131171627.1852894-1-edumazet@google.com> <202602010830.7VDNDITy-lkp@intel.com>
In-Reply-To: <202602010830.7VDNDITy-lkp@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 1 Feb 2026 09:17:33 +0100
X-Gm-Features: AZwV_Qhyp2z7W_bgyb2YmyDk-fm0N4Cut2JyNVHPhM_8aq_boW5IWNZ1Z4-S3EY
Message-ID: <CANn89i+5d1-HqBPwr2c5U0dFw7WGg9ZOc3mYD3GPtanzyyBaQQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: move __reqsk_free() out of line
To: kernel test robot <lkp@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,lists.linux.dev,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-255582-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 9F042C53A0
X-Rspamd-Action: no action

On Sun, Feb 1, 2026 at 1:18=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Eric,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/tcp-m=
ove-__reqsk_free-out-of-line/20260201-011758
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20260131171627.1852894-1-edumaze=
t%40google.com
> patch subject: [PATCH net-next] tcp: move __reqsk_free() out of line
> config: um-randconfig-001-20260201 (https://download.01.org/0day-ci/archi=
ve/20260201/202602010830.7VDNDITy-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9=
b8addffa70cee5b2acc5454712d9cf78ce45710)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20260201/202602010830.7VDNDITy-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202602010830.7VDNDITy-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    /usr/bin/ld: warning: .tmp_vmlinux1 has a LOAD segment with RWX permis=
sions
>    /usr/bin/ld: net/core/request_sock.o: in function `reqsk_fastopen_remo=
ve':
> >> include/net/request_sock.h:137:(.ltext+0x103): undefined reference to =
`__reqsk_free'
>    clang: error: linker command failed with exit code 1 (use -v to see in=
vocation)
>
>
> vim +137 include/net/request_sock.h
>
> 9403cf23025880 Guillaume Nault  2019-03-19  133
> 1e2e01172fd11b Eric Dumazet     2015-03-12  134  static inline void reqsk=
_put(struct request_sock *req)
> 1e2e01172fd11b Eric Dumazet     2015-03-12  135  {
> 41c6d650f6537e Reshetova, Elena 2017-06-30  136         if (refcount_dec_=
and_test(&req->rsk_refcnt))
> c34506406dd5cf Eric Dumazet     2024-06-05 @137                 __reqsk_f=
ree(req);
> 1e2e01172fd11b Eric Dumazet     2015-03-12  138  }
> 1e2e01172fd11b Eric Dumazet     2015-03-12  139
>

Great, time to get rid of net/core/request_sock.c

I will send in V2 a series with these 3 patches before moving
__reqsk_free out of line.

commit a79b5cb06e365dc8d3e1fb4872ec861266306c14
Author: Eric Dumazet <edumazet@google.com>
Date:   Sun Feb 1 08:12:11 2026 +0000

    net: get rid of net/core/request_sock.c

    After DCCP removal, this file was not needed any more.

    Signed-off-by: Eric Dumazet <edumazet@google.com>

commit 58ab84ff63932e13f1c59aa45493333c04e6f4df
Author: Eric Dumazet <edumazet@google.com>
Date:   Sun Feb 1 08:08:40 2026 +0000

    tcp: move reqsk_fastopen_remove to net/ipv4/tcp_fastopen.c

    This function belongs to TCP stack, not to net/core/request_sock.c

    We get rid of the now empty request_sock.c n the following patch.

    Signed-off-by: Eric Dumazet <edumazet@google.com>

commit 1718fc81eb4742c1eab842852e600b906a08fded
Author: Eric Dumazet <edumazet@google.com>
Date:   Sun Feb 1 08:00:42 2026 +0000

    inet: move reqsk_queue_alloc() to net/ipv4/inet_connection_sock.c

    Only called once from inet_csk_listen_start(), it can be static.

    Signed-off-by: Eric Dumazet <edumazet@google.com>

