Return-Path: <netdev+bounces-255864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIc+BbWhgGni/wIAu9opvQ
	(envelope-from <netdev+bounces-255864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 14:08:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 653D3CC9A7
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 14:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2D43300A122
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 13:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F712365A1A;
	Mon,  2 Feb 2026 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ygN+K2ag"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E7819E819
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 13:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770037623; cv=pass; b=dsm0kMOmZ7815co/EG086Q6NAfxAxkDGl/j7u099DadUbHVn4fxdK6odUXMGZoXI/8hKwN/48w3STwdCKc18mWF3ecpgHWt+zxIIg9+UGRZRSSgLYsh79hMoq1D147Xo5GtAPZwApUNY0ZqWt0/GM4jbpJNli8+rCd7koLu3DeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770037623; c=relaxed/simple;
	bh=SFzJUY5InC0o8ABo0bpQLrRQoPtH0/Nku6j+0cIiWnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IrMEsd1xn+ObPZdhYSA3OXLqAuqm4hRpcFptpzhYJXfVIKLm+jXTz9RZLllL+YykYaskWtYFeI6AbJrkUj3zym0CwD7yxpnPn1rvyW7/nDOnAvNdw14UevH+25VjMlyt6sNrGGJE90p9hUYyWFZs59TKTfDRi2d/rgGPaSfEIrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ygN+K2ag; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5014b7de222so46359181cf.0
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 05:07:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770037621; cv=none;
        d=google.com; s=arc-20240605;
        b=E8H+oIDRDmA0MwyAP4cOKeElGa3UMPLvxm/pAFWT8tOg/gjVUKPgPpyewTuFE2v4Fs
         mf7ReapxmB6Y5/+WntpHe75TMeop5IrMNcvhLC30f5YQZE9Oap0FTUzactfrMyNrXpfF
         pBbGyVss00IwRMtUloOLW127EPqFzx0G/luHJas+wGTdWLLBB0vHTGcleN87lv1qqUxe
         7imiD1hW7yj3dl88R9EH0sbJLOoRj/8u+nhWq87Te9lAJKW81uyRvMDi08CsS3IqAZJD
         J6yF57l6+1FGTscgcis2fsl1H1YWwEvFqLp5pZKCJVpNqQdW1pj1IA0PRoayzytAzJEZ
         EDBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5ysVYcX4z3wSP8ygcbeX5BY7LjSKavbMYONse/syOu4=;
        fh=3sFhsovckh9Mk+tv7WS9How1EZZoEfVXKl2LffIPpZc=;
        b=HSHCX9Ijto43piiTHIsfZzmD68pQQKAhbBQm65Y7yAvhyytmEq038myP1dlea6GID7
         7jsQstorIotEjLAy6+bj2lmM6Yv4DNqAyH65evt2iZFeHN8MIk1UEJr7cCz8cJ0tfCaw
         4DHUqHqNs+gJBRGJCzqoVOBW2tGeHiW4vqLbheDyS/ZdMuSHl0SGI/w4l4RcYap4T+Uj
         MEScm3Zy7DbjFKS+IjHF2P5G7i8JijMtWu4wEhD2ntvzGHixHIH4w4/4nPIAVsYGb0Do
         X9wEKU3WpYOIzqCgSJrNM1y4b32g2+SaIqHTXAQL2bXkWEarkCL58GaeDs+uj3Momo8x
         4tEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770037621; x=1770642421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ysVYcX4z3wSP8ygcbeX5BY7LjSKavbMYONse/syOu4=;
        b=ygN+K2aghDjoWblzIkhdDi+4bbV/BfTlDRWFZhSBcrMokrLa2l/tHtDUMSQ1bLdx7y
         VLrNNsv+pFYebgWvNy3dXMKo4qFLkeS1PRE0+whLMFPuLKacwEh9x24g1xoqaRoKJaA9
         fa6sjr7OyuMkyekmhOQfZlAMSMBjYUz3WiONPRbU+Bq5bvR7uzlCOVUSyi9P8iCgsh4/
         wwMRo/VFK0lXI69qecOtFYRj8D9MWSfwB9kfc5YIN779d6oblfnCS2S0BINUkI61CBnH
         NRBj3wYffxeSDMNrV7NVxMof4AZskywxQaHeX+g3vlO8DjplFKcHYyOKyAHieh6TfjTc
         mL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770037621; x=1770642421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5ysVYcX4z3wSP8ygcbeX5BY7LjSKavbMYONse/syOu4=;
        b=s4iMdbkYT/z22++4VbA76njVLsLpWWGdgfGk5oKYID/7nst1chNbH0DB7pTi68I+4f
         usmM4RNVXZn08q9jNzB7UgJgNZXXWhkC7EiS2PrNo6JrFDLGT+7P3C90UMxE6BpN29VN
         ZtA2VRsfY+Hs80FruB+O1wGVeniB4Avry+14de3QyzOBFQykiRlt9e797mFV13q15JMJ
         YJmQdmlpmULN26KfqkE37d4lBkH3/+EublzOHxzeAz24gygeiiN8YK6O6O0IUrnU5TzM
         6gfX91jKIZwMdbY50ln7qEP4i0gH9D2WgKD57di3uv3cIjjcUlJMBAAKprsY6Rd11D83
         j4yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZpxdsWAAFv61usCtrMpPiHdmjRNnnqxV5BIJMvNOmh4dLindcLqINaJmQHDQQS76EHprJIRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIl0hLsA76OOfxwI4y/Cnnsbh6Ss7cYHUAz/Q+9lx4JBmJWlFU
	QxpmrrFJMFT0AlWcDj4znX+JfCm6UspCPIvc1JO2mgZ9Gc0jcuH1WA+Qe54oRTJQT9xlqsL64j9
	NUR0n2GKR30OSdDHjPKBbAPb9lFRpVeE6ch9qbWlf
X-Gm-Gg: AZuq6aIMer49RwE3RD+tvOGDMwum1T0g9i7O5EH0dPH3FWc+i3f1bFLrskAPSON0OdM
	w6DPTT+cNhtVdF6ab43IAqxuPY36PIjn2/ansaVyc58UHdC8mum/DmW9jvI1h7xxOALpropTlvU
	OBD3xgEdn0i0pcDrUWqqqUBE3z6C0rFkX6vNDVNmcHieuB/TpgDVqAJOii2mgmYL8+S568cJyjo
	UAIfnCWMZfefnFd5X5a2GfXXlaybmuItWWw7qq+tArNmipE1KkybSG5lKaPhoO29Wr6T8E=
X-Received: by 2002:ac8:5d05:0:b0:4f4:c7c0:bd15 with SMTP id
 d75a77b69052e-505d213104fmr156895641cf.12.1770037620383; Mon, 02 Feb 2026
 05:07:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202102658.858769-1-edumazet@google.com> <7befb796-be66-4518-96a5-6df607edd41d@huawei.com>
In-Reply-To: <7befb796-be66-4518-96a5-6df607edd41d@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 2 Feb 2026 14:06:48 +0100
X-Gm-Features: AZwV_Qjb2dvzjlXjP08H7Qq7Y4V-k_a9NpkeLJa9PZAbN5Qtd1AnqLbkhon-Kl4
Message-ID: <CANn89iLAhYVSH5sk+uV1Gfb4GUZL=03pCHw+xdy7_b2kdz8c5Q@mail.gmail.com>
Subject: Re: [PATCH v2 net] net: add RCU protection to (struct packet_type)->dev
To: "dongchenchen (A)" <dongchenchen2@huawei.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Yin Fengwei <fengwei_yin@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com,linux.alibaba.com];
	TAGGED_FROM(0.00)[bounces-255864-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 653D3CC9A7
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 1:53=E2=80=AFPM dongchenchen (A)
<dongchenchen2@huawei.com> wrote:
>
>
> =E5=9C=A8 2026/2/2 18:26, Eric Dumazet =E5=86=99=E9=81=93:
> > Yin Fengwei reported an RCU stall in ptype_seq_show() and provided a pa=
tch.
> >
> > Real issue is that (struct packet_type)->dev needs RCU protection:
> >
> > ptype_seq_show() runs under rcu_read_lock(), and reads pt->dev
> > to get device name without any barrier.
> >
> > At the same time, concurrent writer can remove a packet_type structure
> > (which is correctly freed after an RCU grace period) _and_ clear pt->de=
v
> > without an RCU grace period.
> >
> > Fix this issue by using proper RCU on pt->dev pointer.
> >
> > Then, we need to record this dev pointer in ptype_iter_state
> > so that ptype_seq_next() can properly detect the end of dev->ptype_all.
> >
> > We also need to add full RCU protection in ptype_seq_next().
> > (Missing READ_ONCE() when reading .next values)
> >
> > Many thanks to Dong Chenchen for providing a repro.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Fixes: 1d10f8a1f40b ("net-procfs: show net devices bound packet types")
> > Fixes: c353e8983e0d ("net: introduce per netns packet chains")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Reported-by: Yin Fengwei <fengwei_yin@linux.alibaba.com>
> > Reported-by: Dong Chenchen <dongchenchen2@huawei.com>
> > Closes: https://lore.kernel.org/netdev/CANn89iKRRKPnWjJmb-_3a=3Dsq+9h6D=
vTQM4DBZHT5ZRGPMzQaiA@mail.gmail.com/T/#m7b80b9fc9b9267f90e0b7aad557595f686=
f9c50d
> > ---
> >   drivers/net/ethernet/amd/xgbe/xgbe-selftest.c |  2 +-
> >   .../ethernet/mellanox/mlx5/core/en_selftest.c |  2 +-
> >   .../stmicro/stmmac/stmmac_selftests.c         | 12 ++---
> >   drivers/scsi/bnx2fc/bnx2fc_fcoe.c             |  4 +-
> >   drivers/scsi/fcoe/fcoe.c                      |  6 +--
> >   include/linux/netdevice.h                     |  2 +-
> >   net/batman-adv/hard-interface.c               |  2 +-
> >   net/core/dev.c                                | 30 ++++++-----
> >   net/core/net-procfs.c                         | 51 +++++++++++++-----=
-
> >   net/core/selftests.c                          |  2 +-
> >   net/ncsi/ncsi-manage.c                        |  2 +-
> >   net/packet/af_packet.c                        | 24 +++++----
> >   net/tipc/bearer.c                             |  6 +--
> >   13 files changed, 85 insertions(+), 60 deletions(-)
>
> Hi, Eric! Obtaining dev from ptype_iter_stateis sufficient to solve this =
issue, so it seems we do not need to add RCU
> protection for dev in ptype procfs. Perhaps the changes related to RCU
> could be moved to another patch? -----
> Best Regards,
> Dong Chenchen

Yeah, that is probably true.

