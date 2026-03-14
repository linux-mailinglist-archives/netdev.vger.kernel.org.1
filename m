Return-Path: <netdev+bounces-267724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OA/pAUhMtWmzywAAu9opvQ
	(envelope-from <netdev+bounces-267724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 12:53:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 056C028CF19
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 12:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E4929300ADA8
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 11:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8072327BF79;
	Sat, 14 Mar 2026 11:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S2+oNPWE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F5D258EE0
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 11:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773489218; cv=pass; b=lCf4ZEmJrJty9TZZy4FipmOOYxjWus6GjBUBZSZ8d3L++5RRpuS7UGSgoDZSX/3ks849dApJY/aPu9a9RsgqjtivBh/UYrSHq2SoxSorZZ7Ju/pSUGK9ge4sSnpcuEcsT61AMgFC8UVsL5VgjrxloFW1gRtpbpp3E3Pay1kOm2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773489218; c=relaxed/simple;
	bh=+QQmwGPdXGB4HoJTTFd0Hqtbuzm/TOmCsBpzMevrgGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+d+rVEGZVVEBmK2hwc6CYhmouvSN2dboyvqKHzph57brHCPAGFhFPA4snIknVdQc0DkLtLwg417jiskh5boEGEblzvYAMw0IwimFjoS/qHdecs7q0ftEWoWdOBAPpYrxO9oWK4QejVxU9sThjiFbNvmB20uz4+LvVFtBan6iX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S2+oNPWE; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-89a14be4733so38495586d6.2
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 04:53:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773489216; cv=none;
        d=google.com; s=arc-20240605;
        b=AA36H5sZ81de2jTRr1yDWof1makeeWEqlqxcVD+UEPuWRZUSCreOZjOz6L2I5llnHn
         xi1ACtHEcb9FYavicECL8130XtWLmLxU17payyyMIvVHNlLn8iyxy55UzWok3l5mOGFA
         2VOs7HU3/lps2us++Vu6JIqihyGtrdW/nDpWcUwZu9jKpYqHYX6FGCKHIU6zBMRa1bHa
         BBNNuJaccGftXGuEtGMj5HJiN4lpYtZlD91/AKh+Y9gFhGOTmJNkRKZUyjKwvMOqudWQ
         NfRPVXoFQc9DDS7iz03WXkgDBe9MjOI03D3roHJvVouLTvi3UHpQiLoGhNn5tx57Cu7C
         dHmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5pxltFU+nIwpHD1RC5Gs7n4Yqa5L694B8ZC9DGyKfEw=;
        fh=29bbWsD+MbT6OFxfz0zZZCvVLyomyAxdKQ3BPqMrVgw=;
        b=Zf9nvE774gab6DuScEezYAOBWuyRFgwZO4Yj3Qy1Lw71XVA6SJ9CzoLvgbkUBpfsKH
         /9IChJ38HuFncRwfST+W5MZxOIE0A15xZqxtQqiitbRyRhu41Lp57QWiDSPnTl7xm4tw
         mo06CSo7uSr66PDnvetyrGpMghmzJwRgQqPNgsMlzBnHIwuP9NihPYC8TPQaWozONS56
         Rhnc+1emuIPRdy2mYY+X436VdilQBD6pwYHZQTlbA68uyKc2yy8gwUKTjBCnNF8F6eXT
         Kto2uWVyi5YMuEMyfT1ABzJo4DohJhg77mk4PzrPtGV5CWKr3VxfwiYLhLRFZjVM2PZg
         sNRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773489216; x=1774094016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pxltFU+nIwpHD1RC5Gs7n4Yqa5L694B8ZC9DGyKfEw=;
        b=S2+oNPWEo6h+5L8w6fee+jGhFaAYTuDBoMd4PT9UkaOUdigU/HKrmKQ2cYWokR6Q7/
         eC8ZTQW4FNgVYT5GF3eNKxvrHhCSDVTmvidnrM8yRsNoYJR1kX1uFjRd/RkJaitS9pgd
         uYqpwTd2aeU78AGiPnUY2mAMod/h54ChE8oMbcjgqRZoQAt86h14Mq3UP1lUSLYMVRnv
         Dq6lzFtr25HIrNaDOOn8YBUuDQBU4IFuL1MhtGOLIoihEcfH0BDOCPaT/txejL0SzL4R
         wHroHTtd1kDLCcOJGVgcZl7ozX43hYfJD6L/M8yRwX94pIcDpMiJWlu9urfUCOfJ8ZBm
         xE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773489216; x=1774094016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5pxltFU+nIwpHD1RC5Gs7n4Yqa5L694B8ZC9DGyKfEw=;
        b=TJpu/hCf0nMc3BxJi9t9UaNm0G0b5kcQGxeZcD7DSJfcPeEO8NfDInOeD5Y0w9kT38
         XQwRV2ajUWtS6gPGc+SQHeA7017PIIcpYtmJ5/ZUR5h/b91SPvbVDAIJffZYs/ZawDv5
         wu6ZveCXPgO+F12OBkn685H0fXTN3knamrD9sZ7qQCPJ+DDGivypO0c6+tu3OYbSkIaE
         XjTYMn4qXasvv59wMf0gANgxEZ262POUJkEiD0RYMV0AYEj5OWG3guSos7DAdc9cfQzY
         0pt4qRWbBB88RAxH4AoeNGKiFAHFJlW/JVEWdese7RhWFEfd8NlVWQnC2FTLxd+DgJZI
         Uy+w==
X-Gm-Message-State: AOJu0YxSh5/bJ/pw6RwEeHctaOwP480wYSAgkyfWyyaKIZBhoQTkEWyU
	USDMFZr4zbgtSS8EetdJ7RJg0ceCOVVUIFqosEDPemHJ3idSeAiuSBPOzamSo1eex8fFw6WVHAx
	SooRbm4OibTZomtzKzv97Uc7KesZgSnzn5mff75j+
X-Gm-Gg: ATEYQzz4npAC8X5o5ug+AdNXCvu7tZ17IF0BN5MAyIZsyPSg3dHrboyRZlmt/fSBNNz
	BP2D19iWfyag7UTYkbvz3yuNbdpkEc6+eVMBAfsZ7ZTt4oL/XkkSz6twuGeKDqJvkNrE/gcNv6V
	X7qrveUcEJtAxrrE4+GNhR/1G77nmE3R9nig9CjNZ0s8CxCvTlVBro3jaFkm5t4z5+4vz24vAwq
	3zhLXqK5uD5gHuBBl4/lK+TCyCqbXvFeKirT0WRXTNRY90vApzimXT7wFMwWBBTOLksO6k2JwOA
	70keSAA=
X-Received: by 2002:a05:6214:27e5:b0:899:edde:c4e1 with SMTP id
 6a1803df08f44-89a81d4e1c5mr93349576d6.18.1773489215882; Sat, 14 Mar 2026
 04:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314062306.212765-1-jiayuan.chen@linux.dev>
 <CANn89iJR9bjtoZGsybdpX6T4rg1+kzXL0qV00Bs_Fiduf_+2zw@mail.gmail.com>
 <CANn89iJwZfWtGrQw+hA9DumTuYKZm5MLh8O7nkz9mPCHHazUWw@mail.gmail.com>
 <bacc7c58-b6d5-4566-bd6a-b83a2a25c596@linux.dev> <CANn89iLp8eaAj4Qtu4dvGeh9zEw+aQFe=n2dMd-zs4n-cjV4QQ@mail.gmail.com>
 <d2f9bd52-f570-441b-b3aa-570cc7f37d0c@linux.dev>
In-Reply-To: <d2f9bd52-f570-441b-b3aa-570cc7f37d0c@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 14 Mar 2026 12:53:24 +0100
X-Gm-Features: AaiRm50Ug21Uo1bC3vSX2pZSspYqsVIr7r1vJjCmXLUsWSsTSQJp5gXuqk6FPN0
Message-ID: <CANn89iK2EURqsjtd=OVP4awYTJHGcR-UU-V9WovpWR1Z3f03oQ@mail.gmail.com>
Subject: Re: [PATCH net v1] team: fix header_ops type confusion with
 non-Ethernet ports
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	syzbot+3d8bc31c45e11450f24c@syzkaller.appspotmail.com, 
	Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267724-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,3d8bc31c45e11450f24c];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 056C028CF19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 12:51=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
>
> Thanks for the quick patch.
>
> I also verified it fixes the recursion issue after modifying all signatur=
es.

Could you turn your test in an official patch for  tools/testing/selftests =
?

Thanks !

