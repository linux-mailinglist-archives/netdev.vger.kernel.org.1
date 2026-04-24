Return-Path: <netdev+bounces-280947-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFI8G9cC62lsHQAAu9opvQ
	(envelope-from <netdev+bounces-280947-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 07:42:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D0245A019
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 07:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 124E7300F9D5
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51454345731;
	Fri, 24 Apr 2026 05:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Lm/Az7wf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01B13451B5
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 05:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777009303; cv=fail; b=RczY2e7/MJjBi8WEi2oGjtAorE5Jxhm1e2L0HMw7K4M0StRUoq0aLYHWaCfd4eYfDSvSVoE+rQasu1NS53z9NeAxvr1NJaK9dpeswZAu5C9L/Usc0Pgj6k8+lgwatZYGmcN6TJ1L4cGO4Nw8GmsatlgvGc6qodRNz/qDn+C0dMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777009303; c=relaxed/simple;
	bh=Q0GtZzioBAe1xOAjDbkhlrB1hPU4MmLixdCpyIV7MDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IyQ9dKNV2nyH6iLp7RH8s97z5QLTCscK3l2/p+NjFsDy1uc5jTG/mkoH/uZghpOSJ/N7YS0af14phjtD14QdyNSpV5tUeLMfVJtpS2ElT2J4wE9H4T7c9jQa8StjMJKURFmKMVfTnQvCUMoTlFojgvAAJa32O1jwLEtmey0x2dU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Lm/Az7wf; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 63NH8rq41856899
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 22:41:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=9DPAzRc9hNFtKml/U1KgfOpti+rrtUBR6KtYeiX3hBQ=; b=Lm/Az7wf7xyF
	brokmQfLsNW68y66IP7SZ8nGC1KsXbutmXjSA8cmHA2Jk5qKrwkv66B6NLirRkP7
	QPJwKH1umKEEjOC/XCpEBPz8VR5HvrCHOhrvpKJ8eh9uddFh+K22h5l6zVDTktN7
	jLt8ikr16+iDaTHEYZBdj9EwQNQuPWk9M1lNVPnUjA9qvJyXuvqeoXu9WoHbWI9B
	L0t0VhbSUUEr2S6i4dfX70Bl57EMc2glo6cixMdYzAixPwMAfd/ptjPwyZbZODg2
	Ev/aMiLmg2rES2HuztP8JKZyiegA5AN6JmiDik/5gngMEQiS5J4atlbQWviM1YCu
	HCwba9g+jQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by m0001303.ppops.net (PPS) with ESMTPS id 4dpepbmkvq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 22:41:40 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7dccdbdf5c2so6719847a34.3
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 22:41:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777009300; cv=none;
        d=google.com; s=arc-20240605;
        b=ADwkxJxmyVqEEfdkIV0qMDu2vfI/+CZd5CBopH2PhJsWcQFiu3m1e1PAmz6vqrkH+n
         RxhSTucdcE7vjHNoJWEdx0mvqGe0hUIFOLhOVKyuMIzKGO0ni3Mya0jO4nFB81E+Peqz
         lKnD/7J8pkjOYsyn8MiK9XHTtiiRDUxuXPbulrhJDUeHqWfBTw0bX/YWgXEBS5k9S/cG
         QYAedF15ztIpE9jlC1lZjJaKPdcUUWJobWch4S0zPE24mlb55SkUdIPtbeJLg4HrXAaD
         Q9+WAV9w+AoG3zEEbufBhGAskt7GDOC4ohR6PkAsqJXCHiJZUQb/91i2lX3iSVQLFpCq
         bPxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=a9nQ1tVs6iATHtHJgJt0jwwPeY71kxSwK9rxJ53fqFI=;
        fh=P5DBiLq2YKJoL21HSt7izY2H4z5OtiuRtp2wxuFoiuk=;
        b=TWtBOY1zOBc/jkhCC8IifN1/M70ixXTjlN6j6sY/HDhdgm7CqeUPD4J5auxOscGmiG
         lz221FiIvQDGfBqSjh/+jeC87URQlrutlipP+gMBB8wYdPB4nWkf2SSXaX9iL7soEGco
         gn9ydpbClwe5DqwoVZ3cL40+9/MikqTkc2l2YDNlnC5oyH/wUbEvKoreeJ1Y3Bj6mD9b
         WmECdj76hFUrvxAnX9Ely10wmijkBlVJTBXLdaDm+t8v355BnenpJDq4qSUp2rZaOJCy
         c/BXKj+ZzojpWgfaIXUILa9SWZv71WEAGXFpepCJWU/HJdg7zGfU+56xEDd5XaJfyehS
         e1Lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009300; x=1777614100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a9nQ1tVs6iATHtHJgJt0jwwPeY71kxSwK9rxJ53fqFI=;
        b=o1iB5GkDX0JntIMe2mL8/rnj6JpVRhVgsJHj6NxaQSiM3b/E2uOkqyDHw8hTFn/baQ
         SJB8anksCjzI1HD4QEB/vmjCSYMljVEL9FuWVmibl29VTSXTIJ1r7OojMAefgA6T14WE
         Qdy1R5dlFjoaQb6KMW/aZMCFVcRCtRfd5Qr4FYuHUeRFjdS9b8QxUuXqSlv29Q7D+iPG
         4IgF4D6VIuERIwATVPQCiKX3Ylp2ZKJLeRbE/Ofrd/5Mq8RfChiHxmgVpSUk0wc05Lx+
         +uHHIXyYc67mhCgGU0gXd3Ape6c0gPvNLtfUyipTh0HejAIOGe1u0H1pk5xXEC7rkGie
         ev2A==
X-Forwarded-Encrypted: i=1; AFNElJ9MW1A57OQOM0XyRSJVyNmYxtK93Bvy1ijT5fkJDlvMbll/xyst1JfXXMVypld604qX7Sm3Vdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwniXaNtnLh3i3lFFxzF8ib2KUiOd7r75ypltvr6xXfPzn7eDn7
	VA4h5yIzFk4I1k5cMKfysRYZuH1HJLKhGCuZHA41RQCT8Ac8/1wBYgQT0kym1Qf6q33mbD+NSEz
	tmeZrmf6/ohRZJj1l/mAwjqXX8eJZLbeB2vijUL/ETPAL7PpvdgWxDjtfLd26TBWghN4Ze9VMql
	IEBPIMdXKDY63wlYtxCVXGn7A8mnWztVU=
X-Gm-Gg: AeBDieuTNfi9axVQUoutEF39k82xb6cZYegHXH6AG4KW011Qv3OsKCzFr0eq+JLJbUn
	bs+597zXFNcKHMsB3NUkc62Tr+4Yui2ErrmAPzILTratyTWLvsvaP3pNXfb8j+A4Bk9attGoL+3
	dpPpTXLz1PHklQd7xnmKwRFWgGZVWA14dGstRfJYGOZmHIVONdAU1KxrrASP2n6FhSqLGV584Q4
	9XgIR4zXTPVN0iTQqPiTCiXIYMiHOBJzNp5NPAcmsMfspX2UXU=
X-Received: by 2002:a05:6830:6583:b0:7dc:dd58:50c7 with SMTP id 46e09a7af769-7dcdd585530mr8104216a34.18.1777009299913;
        Thu, 23 Apr 2026 22:41:39 -0700 (PDT)
X-Received: by 2002:a05:6830:6583:b0:7dc:dd58:50c7 with SMTP id
 46e09a7af769-7dcdd585530mr8104199a34.18.1777009299430; Thu, 23 Apr 2026
 22:41:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420183920.3626389-1-zhipingz@meta.com> <20260420183920.3626389-2-zhipingz@meta.com>
 <20260422092327.3f629ad6@shazbot.org> <20260422162928.GL3611611@ziepe.ca>
 <20260422132740.5f809bf7@shazbot.org> <20260423142828.GQ3611611@ziepe.ca>
 <20260423132016.4a25e074@shazbot.org> <20260423224626.GV3611611@ziepe.ca>
In-Reply-To: <20260423224626.GV3611611@ziepe.ca>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 23 Apr 2026 22:41:28 -0700
X-Gm-Features: AQROBzB7q1PXr8uzLTg3LU7rQ4HbjUzfZl_SYDl7pi8tYSw_JSwSgZ8wHqWD6es
Message-ID: <CAH3zFs3z5WPBygyk+ZZcDhZitj3+e3=sDsyE5ZmL2iwa=Cxykw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] vfio: add callback to get tph info for dma-buf
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alex Williamson <alex@shazbot.org>, Stanislav Fomichev <sdf@meta.com>,
        Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA0OCBTYWx0ZWRfXy9EE/qpEuaTi
 /iUTJ0BmjwoT5MDabgOBzYPBqb9vFN1fkQFdbs91PYzmz8T/goVtiHTK2TtldMuUsf0NbB98zVC
 hEyoZGrbEa0rWufKyxARHxGJGHPxidIZrNGw9gbEGGtalrb9N19W14R3qG2rxi78Z4j1lylGnSk
 Fvj7559HhgupLt8S43iE4OexPtr/vm3QAYUFY5LxgKax6nv69Fi2bDd3eK453m8Z26h8r1oAb6p
 RmJArfeL4VfQtFahWgQdMd/Z/dq+nc3+Zcotnlpn1E5zzUoHlVU69npgZsURJldN8+Ap1x7YSvF
 TaAfUwG4x3mzpL0USpeyOCbvSwWYxxqrYq3B5gIfPdttOqrAAK104QgtwFxLnEWislpn1ND7Yl8
 IE6ZQe8LUTs65bF/wz6czpP5+/3pAspbbgqk8qi1/xUTjtYAYcUmiuRAAkln13sRXjg+Rs3p6rm
 D57odMevpbYJtafKJ1w==
X-Authority-Analysis: v=2.4 cv=aN3Ab79m c=1 sm=1 tr=0 ts=69eb0294 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22
 a=9jRdOu3wAAAA:8 a=4OgE2WNpP8yww339eGMA:9 a=QEXdDO2ut3YA:10
 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-ORIG-GUID: dvEGK9nY4sqoT21_Bwfn8NGnKgEyc5t1
X-Proofpoint-GUID: dvEGK9nY4sqoT21_Bwfn8NGnKgEyc5t1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Rspamd-Queue-Id: 06D0245A019
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280947-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[meta.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:dkim,mail.gmail.com:mid,ziepe.ca:email]

On Thu, Apr 23, 2026 at 3:46=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> >
> On Thu, Apr 23, 2026 at 01:20:16PM -0600, Alex Williamson wrote:
>
> > My suggestion would be that we leave VFIO_DEVICE_FEATURE_DMA_BUF
> > unchanged and add a VFIO_DEVICE_FEATURE_DMA_BUF_TPH ioctl which takes
> > the fd from VFIO_DEVICE_FEATURE_DMA_BUF, along with a steering tag and
> > processing hint.  It would fdget() the dmabuf fd, validate it's a
> > dmabuf via f_ops, validate it's a vfio exported dmabuf via dmabuf->ops,
> > find the matching vfio_pci_dma_buf via priv under memory_lock, and
> > stuff the provided TPH values into the object.  It would be left to the
> > user to sequence setting the TPH values on the dmabuf before the dmabuf
> > is consumed by the importer.
> >
> > Is that a more reasonable uAPI?  Thanks,
>
> Off hand I think it can work, with the proviso that if userspace uses
> the dmabuf before setting the tph the importer may ignore it. I don't
> think that is a problem in practice.
>
> Jason

Thanks Alex and Jason!

I agree that the separate feature sounds like a cleaner design and could av=
oid
the uAPI complications. For v2 I'll:
    - Leave VFIO_DEVICE_FEATURE_DMA_BUF unchanged,
    - Add VFIO_DEVICE_FEATURE_DMA_BUF_TPH as a SET-only feature that
      takes the dmabuf fd, steering tag, and processing hint,
    - Keep the dma_buf_ops.get_tph callback as-is.
and then the userspace sequence would become:
1. fd =3D VFIO_DEVICE_FEATURE_DMA_BUF  (create dmabuf, unchanged)
2. VFIO_DEVICE_FEATURE_DMA_BUF_TPH   (set TPH on fd)
3. pass fd to importer

Zhiping

