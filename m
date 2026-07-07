Return-Path: <netdev+bounces-305579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6lVoKaxSTWp/yQEAu9opvQ
	(envelope-from <netdev+bounces-305579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 21:25:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C22271F2FC
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 21:25:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=oQpdttfb;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305579-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305579-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F4023043893
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 19:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B7F38837D;
	Tue,  7 Jul 2026 19:24:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BDC3876B8
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 19:24:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783452276; cv=pass; b=p+L4bLOVNoEulYCxQC3CNlPZHHe0AjFkNnH9Rliz5rLiptYbaMdQ0+FuK5Peh8DR+2mDqsWb1Dad8lu9+VzoUHucLbH4pgufBBe3ZOSjklhBjzS3FDk7ponf7eopfZbgnNOVNC5NahzzK+g3wQ49aT8SoBWsUhUe9mvzHu1tFlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783452276; c=relaxed/simple;
	bh=lqIqD3byUVDYSUFyysmtpZVvkzId65XXgC2avO2Zwzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HhFzWGCfN0tkCNdimImF3/yhhs4jhIE5rPyQ0VktfOUx+4BKiAax4qB6HhAnWthhIOAZBwqAINxBh8ZkZ3BXqfUp/uYjOLj3vtpfFsrxbdd0YVikBOUlMj6+kKtlSpuZ0dAkaf5/Wb+tgIorj+Fs0qPlmn6RXBiDgYoKORjvKcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oQpdttfb; arc=pass smtp.client-ip=209.85.214.173
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cb59f6ba26so21745ad.0
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 12:24:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783452274; cv=none;
        d=google.com; s=arc-20260327;
        b=QwX3hI2jOJilYoS/TtF7IVElxBTxu7Dc2RE8SIyT7yIDMun1pjHcNUdyKQIf29YZdF
         udPt4ue7vWFDHWN/V4q6YXupinlENOxlCQcHxDn9SSJJ+4vxz+IWQ/aql1m6LGWPTA7D
         sJN0tmXmEgf2646Do9peqrE1fheQppP1wLbWmHy6koLSTAON/0ooZaKCiyNEGzzy+Zgt
         lacEOqjl8Ej+cza6HRwOBA7xIP7RAbMasTE+GTsxRDJO0MYGgavtnFrrphFwsc1V7Cda
         syyucFfQruQ5qDWSHOWkVSI/u6jjhWTBrU8Fi5C0HN7OaP2MJ6apPBEiu6ZvaYy3kg08
         s47Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6Fm7QjNSE0IJ2/34q+H/eGUWaQNYPo+v65MhhotHihY=;
        fh=wxCE375euPwqdlUO2MGUIanW1g3BranRtV4U/Y8zAsU=;
        b=hrDGDqsb4fXbCPcbVjrP5qFCJeS2WqGp5mc0KNRFDD2OVT3UfIMCwzkhmJZHdDLVrD
         2fLDO1t6h9XLqnXNFFw6vC14AMdiqawoWs0MffZcOl5/l+AmVfD5GUIIeQPwQK36A3Cu
         Zh8hwpf0pzmg+YpxBgaQRqb6VVzUB1NA4NYFiSycE+kfTJeLuaIodE7TsVBptiC9/yhg
         Yj0ax/DSvKGRpFIiYe/biRz/UHsxT1SOZYNzbdBy4OZwAweY9P0mfqkJxiuGk6lJ1e1y
         raB4svbK4AqZBIkWx/47baHXM0hnsraUcDpnBdHy+l1XdjyYDJYqXpzaZU/wvcgjUiVt
         uDHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783452274; x=1784057074; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6Fm7QjNSE0IJ2/34q+H/eGUWaQNYPo+v65MhhotHihY=;
        b=oQpdttfb2FUCW91i+sJsbmx+R2UJzLCXaTuMELV3Qmry2LGXg5KMg9biadhTxnUize
         +dmbSO4yp/DpFMZIFGP/lDL1QbLOnCo69SlucqmyKG24GOjeOOxfUbaqwRk4VMG7Tf52
         llgULpThfoHNPXiGK6oM4oKc2S+haSl0KS1ThuIxH5qbfDEdK1BbyApiX3ggKfi1qLKH
         jgYqXCOQyQIflRXCoXZdlyJ3jkeBBPaADEgvuLOzDiW60E+KUxHdPPyel/jn9OMR6qLa
         QakHO0SF3XoMmf3Bie5rOn3xa7kZ4Auz+Hl6szRPsfoes+n4KG2Wa3tgcMPwXCup9dAm
         DbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783452274; x=1784057074;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Fm7QjNSE0IJ2/34q+H/eGUWaQNYPo+v65MhhotHihY=;
        b=UnAYOhO+AfjPdiR/dqjBDyGWFmaFS13N6HV8SBpMxSK+ABEyrNJnd3KOWWIiNMajyp
         /b7Kro367jBB8U59AwYnjM2yyivc3fbIkNKcIfClLmSaKLl89lSPABbCIfuQckocQij/
         cGD3/oVCu+bgcFOHnLEUyFO9aJGhIe7UHqmOWxEAQh63ioxEguBqjCDui64YAflBpqoa
         c2NdNaDrktB1Aola7Ye1wXavUqBPFmhUSF9NWJcOvaTdqS8t54IWqkKiQWgiDqUYKO11
         EKbJLqPJ3NaKzi6mrKZ7nX/D8PCE4h/wtaopspyY1bowKk5n6YGoQ43ZY7JGEeMEsf7S
         2lag==
X-Forwarded-Encrypted: i=1; AHgh+RoqykuwW4ePQMFFPr6mLU4eRpXyTpGh4/xrLMcApByx0rtg4YtchKZs5n4b1Jks5BhE7994bwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKBH8WPzHp4wJqbIgD1Zzw+fNsUujJSlixs088tuHR61EswBHP
	Sdnm3HydM6XE9F2sD3gPDYmC+0jcRJObc2ypYpLJKjs6lSVhwlAmr/frVR14M7fVuJD5pdm/RaW
	gUEnOnPlDNMVAhY59y9hTnhtaGR2vABXGd8iDRQWz
X-Gm-Gg: AfdE7cmE+wVD+JU3owIvUBA3v/vDYq8V7qCEt3iwl1Zq0bXBS+U58bCyoC2gFUU3aaM
	TWydeONF9YvtKq6XRxUl5d68nbTl6aW6KkqfiIDJENXwxgnKKA+Lz2zV+D2qy81fWnQc3rvcGCE
	NdBZsvfcJE7QEIVlHJND7cbSb6Ap2f/ZDho5ZNdzWbnUMzVakcom8CsBFioIM6ozgOuJbA/MKFT
	mGF3aVDT0TwY+YIYjU2wSWgYLB3FP0ycGg59ABZXdq0d5pYefvH4SwUv9VSQJ8O+Ns3JX3+aVeV
	iA7erR6T9qwbm0+v7nfvJIUiYGw=
X-Received: by 2002:a17:903:13c6:b0:2cc:a859:d404 with SMTP id
 d9443c01a7336-2cce6093926mr513125ad.23.1783452273682; Tue, 07 Jul 2026
 12:24:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701-tcpdm-large-niovs-v4-0-ca4654f37570@meta.com>
In-Reply-To: <20260701-tcpdm-large-niovs-v4-0-ca4654f37570@meta.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 7 Jul 2026 12:24:21 -0700
X-Gm-Features: AVVi8Cf2zkjvZFmISVUtPxc7XWtQGIP2yN30jA4uYxFxIOpN1CJ2PCF-gRvgh1w
Message-ID: <CAHS8izOmA_U=Q6WOO5mcoi2vBps_JFEtAQa3gXk=JcL3rqE1BA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/3] net: devmem: allow rx-buf-size >
 PAGE_SIZE per binding
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Gerd Hoffmann <kraxel@redhat.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org, 
	sdf@fomichev.me, razor@blackwall.org, daniel@iogearbox.net, 
	matttbe@kernel.org, skhawaja@google.com, dw@davidwei.uk, 
	Joe Damato <joe@dama.to>, Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:bobbyeshleman@gmail.com,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:kraxel@redhat.com,m:vivek.kasireddy@intel.com,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-media@vger.kernel.org,m:linaro-mm-sig@lists.linaro.org,m:linux-kselftest@vger.kernel.org,m:sdf@fomichev.me,m:razor@blackwall.org,m:daniel@iogearbox.net,m:matttbe@kernel.org,m:skhawaja@google.com,m:dw@davidwei.uk,m:joe@dama.to,m:bobbyeshleman@meta.com,m:donaldhunter@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[almasrymina@google.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-305579-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[almasrymina@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,intel.com,linaro.org,amd.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,fomichev.me,blackwall.org,iogearbox.net,davidwei.uk,dama.to,meta.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C22271F2FC

(I'm kinda reviewing this very late here. Some suggestions/comments
but feel free to ignore if not useful).

On Wed, Jul 1, 2026 at 12:22=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmail=
.com> wrote:
>
> Every devmem dmabuf binding hands the page_pool PAGE_SIZE niovs today.
> On NICs that consume one descriptor per netmem, this caps a single RX
> descriptor at PAGE_SIZE and burns CPU on buffer churn.
>
> In this series, we add a bind-time netlink attribute,
> NETDEV_A_DMABUF_RX_BUF_SIZE, that lets userspace request a larger niov si=
ze
> (power of two >=3D PAGE_SIZE).

FWIW we may be able to support arbitrary sizes with devmem. Because
the genpool supports byte-aligned allocations AFAIR. Also the
dma-mapping happens with the dma-buf size, so the actual niov size
doesn't matter. The only thing I can think off which may not be
flexible to arbitrary sizes is the driver itself. IDK what happens if
you ask the driver to dma into a buffer that is frag size 5023 or
something like that.

But that is something that can be relaxed in the future.

> Drivers must opt in via
> queue_mgmt_ops.QCFG_RX_PAGE_SIZE.
>

nit that probably doesn't matter: ...QCFG_RX_NETMEM_SIZE, or
(...NIOV_SIZE). This doesn't actually work with pages, right?

If you decide to extend to arbrary sizes, I would add to the
queue_mgmt ops supports_netmem_size(size_t size) function, and let the
driver enforce "it has to be power of 2" if it needs to. AFAICT core
doesn't need to.

> Selftests use udmabuf, but udmabuf sgtables were previously hardcoded to
> PAGE_SIZE. This series modifies udmabuf to respect folio sizes in its exp=
orted
> sgtable. The result is that when backing udmabuf with MFD_HUGETLB 2MB pag=
es,
> the sgtable is populated with 2MB entries, allowing devmem's gen_pool to =
carve
> out large (eg. 64K) niovs.
>
> Measurements
> ------------
>
> Setup: kperf devmem RX/TX cuda, 4 flows, 64 MB messages, 60s, dctcp,
> num-rx-queues=3D4, dmabuf-rx/tx-size-mb=3D2048, 10 runs per niov size,
> mlx5.
>
>    niov       RX dev Gbps   RX flow avg Gbps         app sys %
>   -----  ----------------  -----------------  ----------------
>      4K  300.63 +/- 53.21    75.16 +/- 13.30   54.15 +/- 10.23
>     16K  321.35 +/- 28.20    80.34 +/-  7.05   41.05 +/-  8.87
>     32K  347.63 +/-  2.20    86.91 +/-  0.55   44.54 +/-  3.51
>     64K  332.11 +/- 14.26    83.03 +/-  3.56   35.47 +/-  3.11
>
> RX app sys % drops ~19% from 4K to 64K.
>

Hard to read the columns for me but seems like good perf data. Did
performance become worse from 32K to 64K? I wonder why.

I have some devmem performance fixes that are very critical for our
production that I haven't gotten around to upstreaming yet. I wonder
if I can send them to you for upstream submission. Are you potentially
interested?

--=20
Thanks,
Mina

