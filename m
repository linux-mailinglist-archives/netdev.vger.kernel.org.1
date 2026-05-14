Return-Path: <netdev+bounces-287873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCnsILuTBWoxYwIAu9opvQ
	(envelope-from <netdev+bounces-287873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:19:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A6F53FB33
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E95063004D3E
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 09:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0A8394462;
	Thu, 14 May 2026 09:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SuCbw1lw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC69363084
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 09:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778750389; cv=pass; b=YCGquZfzFJwozifzyxdBmHjER7C8KB8v25GDKO9B7bzMtH2eMqagnoY5mtdNuWVbZpzEuU1TGzXYgP3vcM3mWh6+SwtXj65odxn1AUdheyI+c0gR451hi5SAAOhgAvqxfFtA8Mz63OPXiRE8smavEGBols1DDa5mkK4t4Qk3fPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778750389; c=relaxed/simple;
	bh=RaGVVqT+oGK/zm4IQxebitv8ci9jJwMuuAsMV+hnw9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDkJK1LoxcR+OHoe+3eypMvTjcdGkka/RzYX2+N36KS6iIAUEYITt6D6morgL2XlWbxxwLaBJQv6KaZ9L5yI8XZy5c4WM4gf6KQ2uKtJDJ0NTiJRcWxDcxB9XBgiH759gAm+cT0M22YEZq/iG8MImkvDtzVOcB4ugbYAolNsIDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SuCbw1lw; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50e5dbd8e0eso77988761cf.1
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 02:19:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778750386; cv=none;
        d=google.com; s=arc-20240605;
        b=QCZ7phXPMOBaUJjwCr0SbqL28UwjtURkOKzuQgbnjknekFEURCLtldnXhUjkbp2J5Q
         1bAcPURSg8q0/2+N/vsOACdxhB2Ry6gcHbgcVBNeBqfR/XZdqH4kyPKWUgVUt2iylRNI
         3m2haajFGd6T2/l8Tq3SnpImD4nUNFobuXNuuepLP2EAUR61SLv5SC7gQAModIJOy5My
         gJYkhagM/MSquTJB9sNToU/CT3V3szHJrjBXHhcnR40eO4FQdmNIeoh0Wa0PQ7/Mrwlc
         9bx22kLyOJhIZKroNMVOtcJ0EkNFdhJxK2r9CLyPPzlhz45VGbx17xfGUNFpaozdEupj
         dn1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TXmOg5OddZNyMOwwP3j/jTb9zTJrlZ+arxeAmdRCgTc=;
        fh=/8QGoGkKsQRxx3YBv4qpACIJ4YVkzly3ZKn0etaOH0c=;
        b=ImRc/lfvdewcQo1TaBxzSl6PkX+d/G4GjDsBg6Q0ah6PBoDsJ7VwIPal4y4PvLJXb9
         mfMtX4MHLRO+1GEgBCqysmkKb4kGBWue/SM5BpUmqASvQcFYvbnVbX8KXyX0sw0vo1mS
         x8OQ4XTMWGagFoJgBNTyxDew77oSZjne2zkNN9ld8ul2Jhh9JMriCMgt0LVwvoqolMsO
         qOJd/4Np0DU7E5tFS5F3moTfgf1lcbmMftsBXbviXMqbjYF6adL9Evgnnm9ZEVa1AN5V
         Uo5VL+RMtYSjdZ2eLpRrD0xfxZUdoNz+y9ovuuOcFiQssioIsLQnxr662gCEp0O/HykB
         SaMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778750386; x=1779355186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXmOg5OddZNyMOwwP3j/jTb9zTJrlZ+arxeAmdRCgTc=;
        b=SuCbw1lwjjKmVpfCGpmWyOwcMsI5u8/v2U/Z+tnlL2AybhFDDx4iac2XQopPFfAddH
         umtuVrb+W/bPlRTa2zSEnCPupNlrJxTgZpavEQ9meeHLP6XNNcRehRhY7rYa4UIs7YQ7
         hMXX8phuEGb6gX8+cIfD76qQMNs+jlIHS7XPtrb3SsVN7bPfb2X5832fH7laYS4ggJGk
         fkiVdKZ0pSXSbDx/gZUPo3qTfanw0u/jT6AqE4+o30ZNSDLKsLD+8cjV9ZK8D+ysGYMw
         ll63z3iEQxp9vaIETvedLBd2ao35dpFlmVgRJbEGXp+n+j8hlhLnXlgZ7Dtl9ilGbG8R
         FByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778750386; x=1779355186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TXmOg5OddZNyMOwwP3j/jTb9zTJrlZ+arxeAmdRCgTc=;
        b=WxqDf21ohxVEbRFvPchYFgpUoAfPevmBImk6pzY8VWGql5HAWcM/5T4mGwya3iRcj5
         B8uCNAu3ZtLvGsZVeD/vU8BDXW5dDrOOetAdVoKKwsK83t6as7RmL3m6wz9ttriHowYb
         g8lEJ0wqxKMVJ21rBvkY0RK41hCtiuhLyO5NQHkduQLHg1zOnRS1OPVrsBLBgTRkS2U0
         Se/nXMoqTiWFzoCZGKvpHL20a3ngDzWRa5XcFOni6k6iZEZ13PIdG1r/E3rxrVjRdDZ6
         wuGV6oRP2wLfiey9yqYoq29phIT8ZBM1pD2A8yaGr1d9TFe7N9YMOPcVJDODmfzEU2Qj
         q0ZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8XAL2BVEEJe718SQMFm5ccmx2J1qPbBi4VbIMnNtnTP0CFh95q640YdX8lBtNOk5NFg4+QyJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA4mYSjlnt7v6n+iq6X/tjIMlT4UdJacQCP+daMB7Izc/sRGFx
	BPt4yVeJPtiltLWEf2tPm6JWQDYfwQmAArzThyt/2MffI+K05t5suDFEGnrcULsLpqqQYjkFWp+
	959D3JZk1w8KxBggh19KhCsGPezUdlSJJh1hzCGG9ImMR0zm8OoaOGYnedSI=
X-Gm-Gg: Acq92OEa+kChTktjI/aivUyULteMFiwP6JHRMlJUDCb8NhEs5yR0GpYWA1UNleKAr4w
	1ZAk+9TtkgFmYM/QKEynfnnvn/rjIXPtqGQrAWPqTJQonB6lLYTKEXGLSLG7DA7tAWk53EXqnr/
	pbsTATlnYPq5EpNH4wX40UsCZMVtQGY8m1KnYWCTogEwg1+XRtIG9Qd9UPrW3TnRcjxl+GzgxyD
	C2EUlqR/ppg2XCWnaN7EUB/+r/wueiyYCZKC7uTj/xTUj8UB20mG1bS3+C6YrUSu/A1fuluQQMh
	oCgpzAQeL4/I+h8ASXGpL1e7VV0q4eH1Rxx64oRyDlXKQHgwyL+NFCK47jHHQrl4D+O+/IH7T66
	KNZJ38wC/SHrIShGMQDztBACKY5WG7g==
X-Received: by 2002:a05:622a:a06:b0:50e:635b:5579 with SMTP id
 d75a77b69052e-5162f4a89c4mr93189051cf.19.1778750385890; Thu, 14 May 2026
 02:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202605141607.mDXnYFKY-lkp@intel.com>
In-Reply-To: <202605141607.mDXnYFKY-lkp@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 14 May 2026 02:19:34 -0700
X-Gm-Features: AVHnY4JPO9Kp3asdux6FTUT3843yGhsaasenJKhz67v4uExVp_ZKVRDVsGgn9lk
Message-ID: <CANn89iKJ=ot1hQhCaUihs6nunWqRwYykDExphQq4b2ETMh87Pw@mail.gmail.com>
Subject: Re: [net-next:main 114/116] net/core/sock.c:2760:64: error:
 'tcp_wfree' undeclared; did you mean 'sock_wfree'?
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 84A6F53FB33
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287873-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 1:50=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.gi=
t main
> head:   18dc8e6d15d7a30888beec46a1e01ca0f98508fa
> commit: f0de88303d5e7e04a1224bc7a00512b5a1c4fe7a [114/116] net: make is_s=
kb_wmem() available to modules
> config: parisc-randconfig-002-20260514 (https://download.01.org/0day-ci/a=
rchive/20260514/202605141607.mDXnYFKY-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 15.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20260514/202605141607.mDXnYFKY-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202605141607.mDXnYFKY-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    In file included from include/net/inet_sock.h:23,
>                     from include/net/ip.h:29,
>                     from include/linux/errqueue.h:6,
>                     from net/core/sock.c:91:
>    include/net/sock.h: In function 'is_skb_wmem':
>    include/net/sock.h:1861:63: error: '__sock_wfree' undeclared (first us=
e in this function); did you mean 'sock_wfree'?
>     1861 |                (IS_ENABLED(CONFIG_INET) && skb->destructor =3D=
=3D __sock_wfree) ||
>          |                                                               =
^~~~~~~~~~~~
>          |                                                               =
sock_wfree
>    include/net/sock.h:1861:63: note: each undeclared identifier is report=
ed only once for each function it appears in
>    include/net/sock.h:1862:63: error: 'tcp_wfree' undeclared (first use i=
n this function); did you mean 'sock_wfree'?
>     1862 |                (IS_ENABLED(CONFIG_INET) && skb->destructor =3D=
=3D tcp_wfree);
>          |                                                               =
^~~~~~~~~
>          |                                                               =
sock_wfree
>    net/core/sock.c: In function 'can_skb_orphan_partial':
> >> net/core/sock.c:2760:64: error: 'tcp_wfree' undeclared (first use in t=
his function); did you mean 'sock_wfree'?
>     2760 |                 (IS_ENABLED(CONFIG_INET) && skb->destructor =
=3D=3D tcp_wfree));
>          |                                                               =
 ^~~~~~~~~
>          |                                                               =
 sock_wfree
>
>

I will send this, because compilers are sometimes a bit strict.

diff --git a/include/net/sock.h b/include/net/sock.h
index 219917959b54582fdd3d78e8042e1bdfc43decd0..e0263bae8da9870d517e7582650=
47faf96b940d0
100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1851,10 +1851,9 @@ static inline struct sock *sk_clone_lock(const
struct sock *sk, const gfp_t prio
 struct sk_buff *sock_wmalloc(struct sock *sk, unsigned long size, int forc=
e,
                             gfp_t priority);
 void sock_wfree(struct sk_buff *skb);
-#ifdef CONFIG_INET
 void __sock_wfree(struct sk_buff *skb);
 void tcp_wfree(struct sk_buff *skb);
-#endif
+
 static inline bool is_skb_wmem(const struct sk_buff *skb)
 {
        return skb->destructor =3D=3D sock_wfree ||

