Return-Path: <netdev+bounces-264630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DHUMd9AqmlQOAEAu9opvQ
	(envelope-from <netdev+bounces-264630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:50:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4749C21ABF0
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BCD6301751B
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 02:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86F03644DF;
	Fri,  6 Mar 2026 02:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yk2lFj1N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F71935E93E
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 02:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772765403; cv=pass; b=l0K+ZWQO3fALswcszw0Y2mWtSXRyD+we2B9iZNNW/KlIZeScCaM3ODSZwihNdgKzb7xuLi013vecbM5ep6v6d1eBqT9a31c4G3cSagxDkOBc9D1BUqkDeXIF962BmL+TqDVRQ5pUdnC1pm5jgxeULSFJt8I9dmjhUcpe9tSJROA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772765403; c=relaxed/simple;
	bh=usb+0/OYCmm2azlUDkmtyatBKkVTnaVBtDXwxXkwlEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogafeNDlH4xh4tswzwd8f8DDBNQRRyxvDhE2BXGqnscGx1Y7bu5JG3HTtv9Zs4B4Gq2p6w2v0aPGIlKei27zuEGmICCk9iZ5mZ+sYowo3nNwXz/AQEpp6BIcnOdNn+bl8LQInfVqL7JKPxw/tI/szF7vvkljy3nmvnm1UG13A6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yk2lFj1N; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5033b64256dso249381cf.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 18:50:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772765401; cv=none;
        d=google.com; s=arc-20240605;
        b=YUH02gz+h3Z1l4LObF1Tn9rHc8tZsJ6jgEw8S39l0eSnZ8Bac1FMEGqZOies4SrceY
         J7SfDM1OD/AmC85FJcZF37wZZmaKHeLdEYaTzNzyLFpYVyNXrYneRky8Y/ofN/uVRO5k
         mVTLQ6EZWaWucY2neOstlj8GKBPscGVj4pfwjovoFZQGoDRjt+xkG8vxY2jDapnIFRod
         ENU64Q7KelYRmPhKZ/dNwPApZjpoQYJepF469chGoeTTZteKg3GNO03amWmWIACOsl5n
         M3he/uzrCLram1vAG2mD2K2j6AagOu/UzwOwlsXaPJEJoPGPr/jkhGJut+nrSq7nG+na
         dW1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XeLib+h4K9bB5Z+emHdbT4Jqft8zcGaNYJJVWnccKR4=;
        fh=qGKalOxPmp+qmdZjW29r+g/k1v3aFGCxViSutUzX8d4=;
        b=H/HXOgL0DnafwuXpDfIDNDwmdFUnR2hKOEYpxdOmkVTm9o+LvYJDBI+QHpQGMSM2F5
         iw/2ZtPO+XvUSjlBJ0kxFR9dszZkzHqbgJKj73hJXKUtVKiwm6Xmwi85JGqBkPwgtnD2
         I4cb7plWd9Lnkjnj6G3xi5PCItBVFP6H+3SVNFnC2Q9p+WPl6VeDcdMnAFPd2i+HcGqB
         bFPxDaqURekXAXScEJXxCVFROwqqDS+Q9x3+gdQQHjsQ0QquYns8QGKBelPKuorwRbh+
         bhgjKfpJiHrMIKN1VH9/t7zkh0lQvqt8LgRCAyplQvL1iFoVgwhba7Rboc7ERlZqYwwb
         G8/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772765401; x=1773370201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeLib+h4K9bB5Z+emHdbT4Jqft8zcGaNYJJVWnccKR4=;
        b=Yk2lFj1N8dsevh+zZgz2jKDHZt4jcfks2k1bidHLyNdMw1p4lOwDaTsDZpKxoobWYl
         dUmGrVzm0BXakkNwBgn3e2TdjRzBwKWwYCJ6QIdFOsrOv/Ae8UEQueXI+6X0HD8xS8CJ
         fmN89MlAljZdZeJEI5CcxLbOXr01RSPMVau8Qome1Yotxkgsuav1IrdxZrsIgW+RgQ6N
         LfzMOy23B0kBj+M9z0JS+CjAz4F8RcERWFvDQ+VDXJ9aqZTfEsDxarkupJK6kSyC2MMx
         fVjuDrScuZx1SEDsAGRDXeNsuflPmU0p7dMMpAlMLrDYIdtvvHaDPhr5ZkLl81mgGCS5
         G30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772765401; x=1773370201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XeLib+h4K9bB5Z+emHdbT4Jqft8zcGaNYJJVWnccKR4=;
        b=OvZkd/psRXLi/2IFSKI5tyR/lmHWjJNxrQfOIoLAdVgSde0U/ZlHE/urkCU6dWCJGI
         6z5IDUdLGIAOFJ5qNnLvrE70J57TiZnRlJmQjGcgARPo+FkTcJ72EKheVMvMujzy/vrz
         M5iBXiE8eRu0It+Kcd/PsuXLAI52PV8vEATN6dTkGS/7Wz1Db3OKtgomUEgoCoigNOAV
         fKO618V3TWq4dBVeCzcM53WBqADOyPivXvRnMWdLInSyCcAMt1lT6uvdIB/6kBYwgD9F
         U5OLBMCLMPzSZe5uRm/x66jxMLScPsikR+MuZeA05aIDT5n9PwcuFpUN0KmyMXt+h2ev
         SpIQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/W9EP+VjPk3PNtazZj+u2XtHNVYT2cUQk0PHAfGQTdXcpMwn3Bix4yYKXsrqBksFQ91AUlqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4STuNouM59xuAixbLdJsn21EraMhXVIs6WRCRXhAunMTdA9Bc
	87oaVDFwo4b31HBYbN4i4LQi+OgMH+NUagOmqwYS4c0fYYSD+TgsapDqEPJ1PKFy4igQTcUuudZ
	87vfLZFKj+Q7kEwbt6YrU6Q0tumBoAQdZv5rDXXMD
X-Gm-Gg: ATEYQzy5MFVMwkP7Ewg41tbVa3wPpfDOH9f7WwQCx3Kps04zbOag6jjYmxXa/8RQa2y
	emwa5HkCtaL6+IiBWTIH5j9ENCrORSPoBnIhxOEm7EWJCsbIVZTRrSIgqg4moWTEbT/HiIVH1KM
	J5LyF6I9VrtuP9JFpK4oVAjp9hcTSYhGTDMP7tPvZACPjljsFsOxjhg069TX2vEH+eKaZMdHSGO
	2oiaZcwC5idNsLRg/Rm61Ite5s2jyUWdeBZtlHB3Z5RRRVlbdfKaZ3pSTgpi3vauvy6KhJ8Txfg
	MMaIj/qhENg5qiqHdWfJbXOCJMxbDe3iT7hOjtQms30NIg==
X-Received: by 2002:ac8:5d0e:0:b0:4f0:2e33:81aa with SMTP id
 d75a77b69052e-508f3a35643mr4043081cf.11.1772765401145; Thu, 05 Mar 2026
 18:50:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769509130.git.antony.antony@secunet.com>
 <7c30e7f8543048a384f693684ccba5f71fe8543b.1769509131.git.antony.antony@secunet.com>
 <aXyV028imsUPWSyq@krikkit> <aYCfVAeKGqF7MIRq@moon.secunet.de>
 <CADhJOfbkUFaPfxTBrmOnrEh2JvxPKpkxaRrSdJHZGxeoQsQTcw@mail.gmail.com>
 <aYD9O5qiA1R2KIJ_@Antony2201.local> <CADHa2dB+-nCHQK5nu0wKXKw+ut4wieUtoB9Gd-csr7sn8ZKjtg@mail.gmail.com>
 <aaBpuRFrbnpMPeK4@Antony2201.local>
In-Reply-To: <aaBpuRFrbnpMPeK4@Antony2201.local>
From: Yan Yan <evitayan@google.com>
Date: Thu, 5 Mar 2026 18:49:50 -0800
X-Gm-Features: AaiRm52XrcaoKmlwx7FOn7vVU1ZkHNRQ9cggWNxinNSzvy5T6Hx7UO91j-sZ0Hk
Message-ID: <CADHa2dBEE7_-mwsPH1RTsNSn8MTnSM-=eUjAOBuxeEQCgmy9cw@mail.gmail.com>
Subject: Re: [devel-ipsec] Re: [PATCH ipsec-next v5 3/8] xfrm: allow migration
 from UDP encapsulated to non-encapsulated ESP
To: Antony Antony <antony@phenome.org>
Cc: Nathan Harold <nharold@google.com>, antony.antony@secunet.com, 
	Sabrina Dubroca <sd@queasysnail.net>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Chiachang Wang <chiachangwang@google.com>, devel@linux-ipsec.org, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4749C21ABF0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264630-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[evitayan@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,phenome.org:email]
X-Rspamd-Action: no action

Hi Antony,

I am happy to be added with a Tested-by tag. I set up a few more tests
 to ensure full coverage. For the record, I verified the following 16
cases from Android userspace and with your patch, covering all address
family combinations (v4=E2=86=92v4, v4=E2=86=92v6, v6=E2=86=92v4, v6=E2=86=
=92v6) for each:

- Encap =E2=86=94 Non-Encap
- Encap =E2=86=94 Encap
- Non-Encap =E2=86=94 Non-Encap
- Non-Encap =E2=86=94 Encap

Everything works as expected.

Also I am following the discussion of "omit-to-clear" vs.
"omit-to-inherit" strategy on the other thread ([PATCH ipsec-next v5
8/8] xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration). I'm
not sure if that will result in any changes to your implementation,
but I'm looking forward to the v6 patch!

On Thu, Feb 26, 2026 at 7:41=E2=80=AFAM Antony Antony <antony@phenome.org> =
wrote:
>
> Hi Yan,
>
> On Mon, Feb 23, 2026 at 07:28:06PM -0800, Yan Yan wrote:
> > Hi Antony,
> >
> > Sorry for the late reply. We=E2=80=99ve prototyped this and confirmed t=
hat
> > Android can be changed to explicitly provide the encap_tmpl in the
> > MIGRATE requests. Also we are excited to have kernel support for
> > encap-to-non-encap migration.
>
> Thanks for the confirmation and prototype testing. I will send out v6 soo=
n.
>
> Would  you like to add any tags Tested or Reviewd...
>
> -antony



--
--
Best,
Yan

