Return-Path: <netdev+bounces-265218-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8yiDA0TorGmLvwEAu9opvQ
	(envelope-from <netdev+bounces-265218-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 04:08:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3342E22E64A
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 04:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B837301C3EF
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 03:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2391E7C2E;
	Sun,  8 Mar 2026 03:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J1Us7Weu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F95F223DC9
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 03:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772939329; cv=pass; b=g/E9E4TCrXSCfPB+d94VsUPoafmuovcMbcb1dztA9/Z32+CIJ5X1Oc6iC3B6UCGZRkPwT3O4kYPVevDYfC/dB8UVmyTqZ11zuQ51FpJ4uCh3+7KghTGGMGXpjAbYukElV3GWA0y5ANtEwwvJwANchGzAxciM4NqyOCnwkqB0Z7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772939329; c=relaxed/simple;
	bh=urYB0CUwxtHfVVQokjPh2rco2JxICNlUyjAd+lTINpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwApTdTolwv5qEaQASugXCV5uEGwLTl1dLA/y5By+DdvPzNHPQwKDWi0mgzjfhivKLQllKH1UEwk/5rfr4P31xPbVY2qK8HOfQ+bXcztRwBlQ3AW6UrrOW0G/rRaezi/k/xxI75GVTUZQlstZFW+khhAUOaYLANITfBUGus02L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J1Us7Weu; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2be06c02f66so3396766eec.1
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 19:08:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772939326; cv=none;
        d=google.com; s=arc-20240605;
        b=QUygbz23mfrZhiDb3rfqJQy2mebCgl3M00WuweKk3bU26NftM8CPxwshzIkBH8KUQZ
         DIjlTKrvAWoJfjLrO3G8yLHYvHT0CNSfSGxCmlzSChzp/VapK+laQcG3EfdtLrOC1Y5k
         vBVHUrtA9fHpi2+79lOxvAupxApAy5d/XyXmPoJ6BERJr1mXo/SsJMgU6slS95vYVfqJ
         aX0V7bj5jy7o4DCaj/f7n9RjZywxZUpVQJ1KlvDz/hCVrq9Ep65FZ7MGe/cC6c/8kM3s
         ZEHp/ZVYB5LnHnx9Oah7zhFWBB2kfL97YWY6oMODLg6glUPevSbzyEAmZFTBmVF3+Lcr
         UI2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vL+kYgBcVaHGMpKP/KOcO6tTjJs1gho5KzlvMYmWcNg=;
        fh=4uf+hzWxbO7gMBF3CfX6pFyPzR+0KfyD3nrzbUSXrcs=;
        b=CdmBU2GcCrjFbKccfNM3azUOMJ6XlnPGyx4T2praZQtdqTJ1glsAS2Miu8IU78eLWs
         BW7L8MyDWJhshNeI7nowdLNWmk22NUlTPfxMeaaXHGQHSMiN2sDTUpRwQfdZDcixEjgA
         i1B2NL5ysF7CY9n0qwFzQa5A90sDrjvVKKW/Qr51rJ2gdIupT5NNF1sx59us+Cz5f5jG
         JTSZBRyVL9g9o1tT6KBEbNsOybcBXfGs2X4sOa1F+44Zv/E5AeeY9d6ClWLyyJgvL+Fi
         xtZ5ect8LoUNAIlgcLaIOjkjhT1NRBj/rpQECiXdsAsx3QZSsg4/Y09GDmxXKIVxgPOT
         ITeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772939326; x=1773544126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vL+kYgBcVaHGMpKP/KOcO6tTjJs1gho5KzlvMYmWcNg=;
        b=J1Us7Weu7b7VsgEqwi0gceR9u5/vHGzd5NLbhchn/jFYlN6vybCGW3Vf0+6X9d5qYu
         1MSq6v+J1j7LGrlTiQAfvEqHcNRL48rgl06e14UIaNA3FjfaGsGm0p74WnNN7y/2Ulue
         mrWXCYYUlzbPYdYNZ2e3aZkScAt6rZc+Bm2dYsF1XTUQXP/uxvRbnqa18teueLmgtXGt
         9vXlhvEEO4fBMOSXXqUXILN21Sftrywg98GXEo0KNPM6o2ZJjOf9+iFuNNwk3iIPMm8G
         oiMyPH9WodYKrrdjKfS05kz0bns/oKNRsSmZfjAlNPX/IWodqTX98gKKt+NWpwVD1Kg8
         lIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772939326; x=1773544126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vL+kYgBcVaHGMpKP/KOcO6tTjJs1gho5KzlvMYmWcNg=;
        b=AK20o7onb8NkvH1J2mVY21JhTeOHX8FXID29ezoxFmSLYAi3iHq/+o7ak7TIgQLK+1
         apt2iIDXup+AClLaBFUG7OFR/8Oj5mADkGGa6ihZnM7u9xlHVZmfIzcOwcTq7STXHZBQ
         whpNsDvTTmRGEbRCN4rV8EHO8U63gmvnnP0iZtdoH+A83WgGnrcJ0vSKW9Aa/e3nJzgv
         IrKeGhxGZMyynk0fTyVpIy962uHckNBnjJVi6os/yJcq0h+8OukQxcWIIXkNhlpoqpNJ
         soKdfFSqecD0BV76KBM85zTI3fGcSUBQIXbt4J1EYoM9Q6+TQvkz+W8mQE6W+n6hCrEV
         rDNA==
X-Forwarded-Encrypted: i=1; AJvYcCUsJn7cb4hyQtwnFJ/3oryCVrAbfcMSv8mYPssdxhsuLtsQt+Gg4p31gA9+UsW+Sy0Me9yGYe0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy04FFNQ9WKIc4zDdPNM/8mg5Fk9cxrR6/bCscNjPSlh8dXbfYK
	rMwgHwPJbUJBOADOqTcE9wqPB9ldbLtuuig7sQl82om0K8//oWSdRHBgYq2qU1p4F0L0WYzVxCB
	Zk3oVk4VCmZs84mRslQmbnoIj1dVSbWMboKPaEDeGxNE86lpir2AFqHb9
X-Gm-Gg: ATEYQzyGt9dj1nZ/qhGR4tLzzMa1whggt7qoycoOonh3ZOAylbBkym/zdRN721hm2pM
	RNd9jre2YQvPxGm0nKEXe8AOc49ecp3NaXfte4XcgkoOuaDXB3ZR5PSW6TcXId18mATt2GzWXhj
	UfTuScaP0c9CRAxbv0OuBk/GqSCO9g7+80p7zG9x7Zwotw3MCfXsvSrMgoIzjlmemZP0Yg3T/dk
	7m3dVtqkNDi2GqVFcy5xchBlvfAS80VfZX/YE6wLlowoUkeX4nIUeQHWDmA1K/MiO7/b/Mdti58
	GUIhsr1f62jgh0Dy8D+VpYBsfjysfwTofzAfk2IACIQNxaJT8+rc/9X0XFMIHMt5iCXqw3tD
X-Received: by 2002:a05:7022:117:b0:123:3407:1066 with SMTP id
 a92af1059eb24-128c2e8f192mr3059142c88.43.1772939325636; Sat, 07 Mar 2026
 19:08:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307024709.718395-3-kuniyu@google.com> <202603072124.nNhJgNnw-lkp@intel.com>
In-Reply-To: <202603072124.nNhJgNnw-lkp@intel.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 7 Mar 2026 19:08:34 -0800
X-Gm-Features: AaiRm530dp8zNSZFQaweLHDEXy6u7qeD2gjLWLlfefoma-wEY34m8E-f-DzfMgs
Message-ID: <CAAVpQUCFHWPYown66QVTaNDeVWERg0a99gcc3WBQeikXdUy1=w@mail.gmail.com>
Subject: Re: [PATCH v1 net 2/2] ipv6: Don't remove permanent routes with
 exceptions from tb6_gc_hlist.
To: kernel test robot <lkp@intel.com>
Cc: David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	Kui-Feng Lee <thinker.li@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3342E22E64A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265218-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,lists.linux.dev,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.990];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Mar 7, 2026 at 5:38=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Kuniyuki,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on net/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/=
ipv6-Remove-permanent-routes-from-tb6_gc_hlist-when-all-exceptions-expire/2=
0260307-104803
> base:   net/main
> patch link:    https://lore.kernel.org/r/20260307024709.718395-3-kuniyu%4=
0google.com
> patch subject: [PATCH v1 net 2/2] ipv6: Don't remove permanent routes wit=
h exceptions from tb6_gc_hlist.
> config: powerpc-currituck_defconfig (https://download.01.org/0day-ci/arch=
ive/20260307/202603072124.nNhJgNnw-lkp@intel.com/config)
> compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project c=
32caeec8158d634bb71ab8911a6031248b9fc47)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20260307/202603072124.nNhJgNnw-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202603072124.nNhJgNnw-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    In file included from net/core/sock.c:133:
>    In file included from include/net/xfrm.h:26:
> >> include/net/ip6_fib.h:557:35: error: no member named 'ipv6' in 'struct=
 net'
>      557 |         gc_args.timeout =3D READ_ONCE(net->ipv6.sysctl.ip6_rt_=
gc_interval),
>          |                                     ~~~  ^

Oops, I missed ip6_fib.h is included from many places.
I'll guard the GC functions with ifdef CONFIG_IPV6.

