Return-Path: <netdev+bounces-254969-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8A9ZAcoOfGlMKQIAu9opvQ
	(envelope-from <netdev+bounces-254969-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 02:52:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29043B6462
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 02:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFCC43002D0D
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 01:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C02E32F74B;
	Fri, 30 Jan 2026 01:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9Wh5HDC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="biWYdX9R"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C392301704
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 01:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769737917; cv=pass; b=DKbyhHvv7tdwf22j6i8E72gQVKnj/2otKHWVso3ThfPom8WnBILxBtE2eOmtlyVzLqgPyR3tGz23HuGKX8BhANu8IeUm+tqEvw/w6T1exXupwNM53LfGrbUmLzbbmEX4bT0vw+dQB+ss9TQyQnOF5rX3KkQpwhFZ4yxzyZOmtu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769737917; c=relaxed/simple;
	bh=ZLnDVfbWp/yZQBLKJOM2wdtYK6QMsNWA7K7ktPJ3oPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJk0xzgUbNiCaDylcSPd1JsESHHbUBBnVhyV283ApANyklLh+IbXRLhg7/JHb+20KS7Uw7WPxdJykwiqYZUMenoWB8B32Tj+GBr3QFu0UJXt3+ZpASJJH5m60IJpvjPddLt+hQ1J7J5YqL7B0e4bcH2ttTOZ4SHl6uQcy0/ScFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X9Wh5HDC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=biWYdX9R; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769737914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TL9UBP+wqsd8u+8sOecgy4UpsaP/ze6U3wGWd/ji2ro=;
	b=X9Wh5HDChSc8YI0/BiZdqJTXcs4undARDrrb8TmdTNOCfhbv/PCx6pNtUTcHI0z15Falo5
	5scUud9Uzuq5PDpqnzocCWxbJBsVYUZKq/zQHrlUBSXbz92Kx6SNo25Po9yf5gLInZCGIH
	0BuHEuDB3zdpoeUGVAX1TQRp/dBEVRs=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-AOhix5i-NKmlHex3B3xYxQ-1; Thu, 29 Jan 2026 20:51:51 -0500
X-MC-Unique: AOhix5i-NKmlHex3B3xYxQ-1
X-Mimecast-MFC-AGG-ID: AOhix5i-NKmlHex3B3xYxQ_1769737910
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a351686c17so13203715ad.0
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 17:51:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769737908; cv=none;
        d=google.com; s=arc-20240605;
        b=iukr1boyc8kOwYdVuPsvOe6Ssk2ftg+NHBkkujIbyoU0vRTe5VSM1kSiQgqP7CMmw9
         AdW7Qju8txyVoLpsL3wbuSliLjFV9HxbBOmrxmyE9uPgkwI4GLdMI/G9AgJZvJblCvtg
         l+hUtWkP3EnrY0BqbFvP6XXj2hudgWQBYcTQlRnt8LUVj59t0TMlfxi9YAS0qLcojBBH
         H9NUKq4hGuEGbN8WH6cEKvOhQ9iyvPvO3jNhNpUP/yHUK2c55L/Kk95MNDkMY6xa934F
         XxL2TW0S1Bud8yp1cUmNI0EWaxXc7ouWVATq+FP3s71ed5Sd6xv4QZnDRbHw3jspWW2o
         Hv2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TL9UBP+wqsd8u+8sOecgy4UpsaP/ze6U3wGWd/ji2ro=;
        fh=QCDPJRcsiBS8wNH11Ayqbi1NCT6lPon/g5Jzc38sAes=;
        b=kQ90G+liRMZ2qlQKJuFmlXOy4Eh63NBd3l913xbJUwGo5kYqHuM8wYzhkZiVG6ESma
         wHks86TDnf3RnxFsC9b349zuAG4C4fvEJU/QBifsXLX9lwy2TuIu+xxehJNzKLQJPoK4
         43/+596x67mHhN82tWl8X89oxw7GweGNd1eDogcaxg9LsXjuBi3jMqWECKc2ZHCsIk7u
         /1pzcCo0k3ZXDLA43XYvu7WOLmm+Hd8gFVns/yVxDBfhkOHLQcWp2O56SXFnfM/56cI3
         OF9KxAL82bbwcS/8xXdyAayVy6q0ogzTTjRIkcbN2vVWrg62Pwa7aNfWvosBdMDYSsyO
         Pdrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769737908; x=1770342708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TL9UBP+wqsd8u+8sOecgy4UpsaP/ze6U3wGWd/ji2ro=;
        b=biWYdX9RzGKi1NQZjKYaXGSP+ETvtWkh2iPEVZTsXOb/JUoSNy5Ma/Fk6udtZZQfea
         2UkfBw4JF8Cc8xnNnvk643LrEdGHKr64RdHW8TAKzpgPBykMBBkP7e5SwyvFSkg0/cRg
         6KomNeI0yeQfvf8wH9mtJpLh0ihHrA22V7g0NqB1EDK5EwNWGzeF6j+tUuNHNEypXlbM
         DI3j1nd7mWPADh0wXQDHlWtIV+u+ozO2MGW1kkaBMrhXB2y393SxO5YiNR7xwhFnJjwn
         s0caVRpoi+R4DObvuvoepyaJ89fk/xjTJl0+pF1QBqNdE2sKs2CnKVNEg12Q5BI73/U5
         CYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769737908; x=1770342708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TL9UBP+wqsd8u+8sOecgy4UpsaP/ze6U3wGWd/ji2ro=;
        b=aAMSzlmJcgBg5W9jzC+0G9lEKY4YUQsjOFKf0wHNkyVHr6vJYkWZ2bMPU42y3LsO/C
         +X+p12QM1jLzNjJJfUPMevkGTUEdQYTKBejxYJTCkxXgxCAkQ4tsyJwBtKvCFQxSjlct
         cDKCl6vwwFVguZrTlLaw4C282vpvLi2XwliCUVyNtclktNSbt5zeSBD1tGnEobDfKWYE
         GZpMo1GqnY32OUW+zMsnSxCGidQzqVTx8cznjCUeP0zemXWmb3pVk5oSfb7MiTnzaIdJ
         7BXSLYq7ECq/GQXGCZUGa3ghCLdjVi1p4GxPvd1Lk7MERaT0Fe+OgP3lK4cv1LigP0U6
         oytw==
X-Forwarded-Encrypted: i=1; AJvYcCWnWbesZIAa8C4wtWQqgv//0vlBKje3qamdnJEEIYkDnpMOSkX07sPNL7iAdCv7o/gIRvS+j30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuenFdStHY1iLdmIuMauTTnxCUzgAQfZV9Jgsai6TlO2q6Zya5
	CtlB+R93LwOSwrAVuiirgtScO8q46J7beM9r7zNvpd6qP/ZZNCG6My9ZvEYvRQbbyDmayNLB5IA
	mp+Vl3UPc5UHQVOhHS8AzqYpsh37nqLfuO6u9Gemu1h0F55CHcg073RO6JcTTfctuhmRKlK2ua5
	Y43027sdtgddc/iCGrhVrWNKYYFaCP2xy1
X-Gm-Gg: AZuq6aL6tecuStTLMEKhzByFfdTPCFiPufyMdj71Sl2volkH6TcdWGZQf00v7tLN/YB
	nIc9BQuNMKmP8DlMRR5/UQsa8SCexS9dl+Ku6OZWY5IYUoEPwtdtNGeyguSiWCZvgjI3YvoVYrs
	R1RSH5GxXSB6UZYmz8QZOmMQPDhKJ9s4TsBKikM9BS3Lrm33fRJzn7MznZZ7opLuya
X-Received: by 2002:a17:903:2f8a:b0:2a7:5171:9221 with SMTP id d9443c01a7336-2a8d99440eamr10390025ad.42.1769737908125;
        Thu, 29 Jan 2026 17:51:48 -0800 (PST)
X-Received: by 2002:a17:903:2f8a:b0:2a7:5171:9221 with SMTP id
 d9443c01a7336-2a8d99440eamr10389845ad.42.1769737907549; Thu, 29 Jan 2026
 17:51:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de>
 <20260107210448.37851-4-simon.schippers@tu-dortmund.de> <CACGkMEuSiEcyaeFeZd0=RgNpviJgNvUDq_ctjeMLT5jZTgRkwQ@mail.gmail.com>
 <1e30464c-99ae-441e-bb46-6d0485d494dc@tu-dortmund.de> <CACGkMEtzD3ORJuJcc8VeqwASiGeVFdQmJowsK6PYVEF_Zkcn8Q@mail.gmail.com>
 <afa40345-acbe-42b0-81d1-0a838343792d@tu-dortmund.de> <CACGkMEtxRoavBMTXom8Z=FM-pvu3pHbsuwCs+e450b1B=V7iWA@mail.gmail.com>
 <CACGkMEsJKeEsH=G8H5RzMNHY4g3HNdciMDMhciShawh-9Xb9hg@mail.gmail.com>
 <bc1078e5-65fc-4de6-8475-517f626d8d96@tu-dortmund.de> <3a1d6232-efe4-4e79-a196-44794fdc0f33@tu-dortmund.de>
 <CACGkMEv71kn91FPAUrxJg=YB3+B0MRTgOidMPHjK7Qq0WEhGtw@mail.gmail.com>
 <260f48cd-caa1-4684-a235-8e1192722b3a@tu-dortmund.de> <CACGkMEsVMz+vS3KxykYBGXvyt3MZcstnYWUiYJZhLSMoHC5Smw@mail.gmail.com>
 <ba17ba38-9f61-4a10-b375-d0da805e6b73@tu-dortmund.de>
In-Reply-To: <ba17ba38-9f61-4a10-b375-d0da805e6b73@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 30 Jan 2026 09:51:32 +0800
X-Gm-Features: AZwV_Qi_PeONPHTRd6Y8HlCZeAvUd6JxPD2mSyJe2b7JddIysyP7Df22_cIJF48
Message-ID: <CACGkMEtnLw2b8iDysQzRbXxTj2xbgzKqEZUbhmZz9tXPLTE6Sw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 3/9] tun/tap: add ptr_ring consume helper with
 netdev queue wakeup
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254969-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pktgen_sample02_multiqueue.sh:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,0.0.0.0:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 29043B6462
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 5:25=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> On 1/29/26 02:14, Jason Wang wrote:
> > On Wed, Jan 28, 2026 at 3:54=E2=80=AFPM Simon Schippers
> > <simon.schippers@tu-dortmund.de> wrote:
> >>
> >> On 1/28/26 08:03, Jason Wang wrote:
> >>> On Wed, Jan 28, 2026 at 12:48=E2=80=AFAM Simon Schippers
> >>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>
> >>>> On 1/23/26 10:54, Simon Schippers wrote:
> >>>>> On 1/23/26 04:05, Jason Wang wrote:
> >>>>>> On Thu, Jan 22, 2026 at 1:35=E2=80=AFPM Jason Wang <jasowang@redha=
t.com> wrote:
> >>>>>>>
> >>>>>>> On Wed, Jan 21, 2026 at 5:33=E2=80=AFPM Simon Schippers
> >>>>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>>>
> >>>>>>>> On 1/9/26 07:02, Jason Wang wrote:
> >>>>>>>>> On Thu, Jan 8, 2026 at 3:41=E2=80=AFPM Simon Schippers
> >>>>>>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On 1/8/26 04:38, Jason Wang wrote:
> >>>>>>>>>>> On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schippers
> >>>>>>>>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> Introduce {tun,tap}_ring_consume() helpers that wrap __ptr_r=
ing_consume()
> >>>>>>>>>>>> and wake the corresponding netdev subqueue when consuming an=
 entry frees
> >>>>>>>>>>>> space in the underlying ptr_ring.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Stopping of the netdev queue when the ptr_ring is full will =
be introduced
> >>>>>>>>>>>> in an upcoming commit.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>>>>>>>>>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>>>>>>>>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.=
de>
> >>>>>>>>>>>> ---
> >>>>>>>>>>>>  drivers/net/tap.c | 23 ++++++++++++++++++++++-
> >>>>>>>>>>>>  drivers/net/tun.c | 25 +++++++++++++++++++++++--
> >>>>>>>>>>>>  2 files changed, 45 insertions(+), 3 deletions(-)
> >>>>>>>>>>>>
> >>>>>>>>>>>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> >>>>>>>>>>>> index 1197f245e873..2442cf7ac385 100644
> >>>>>>>>>>>> --- a/drivers/net/tap.c
> >>>>>>>>>>>> +++ b/drivers/net/tap.c
> >>>>>>>>>>>> @@ -753,6 +753,27 @@ static ssize_t tap_put_user(struct tap_=
queue *q,
> >>>>>>>>>>>>         return ret ? ret : total;
> >>>>>>>>>>>>  }
> >>>>>>>>>>>>
> >>>>>>>>>>>> +static void *tap_ring_consume(struct tap_queue *q)
> >>>>>>>>>>>> +{
> >>>>>>>>>>>> +       struct ptr_ring *ring =3D &q->ring;
> >>>>>>>>>>>> +       struct net_device *dev;
> >>>>>>>>>>>> +       void *ptr;
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +       spin_lock(&ring->consumer_lock);
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +       ptr =3D __ptr_ring_consume(ring);
> >>>>>>>>>>>> +       if (unlikely(ptr && __ptr_ring_consume_created_space=
(ring, 1))) {
> >>>>>>>>>>>> +               rcu_read_lock();
> >>>>>>>>>>>> +               dev =3D rcu_dereference(q->tap)->dev;
> >>>>>>>>>>>> +               netif_wake_subqueue(dev, q->queue_index);
> >>>>>>>>>>>> +               rcu_read_unlock();
> >>>>>>>>>>>> +       }
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +       spin_unlock(&ring->consumer_lock);
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +       return ptr;
> >>>>>>>>>>>> +}
> >>>>>>>>>>>> +
> >>>>>>>>>>>>  static ssize_t tap_do_read(struct tap_queue *q,
> >>>>>>>>>>>>                            struct iov_iter *to,
> >>>>>>>>>>>>                            int noblock, struct sk_buff *skb)
> >>>>>>>>>>>> @@ -774,7 +795,7 @@ static ssize_t tap_do_read(struct tap_qu=
eue *q,
> >>>>>>>>>>>>                                         TASK_INTERRUPTIBLE);
> >>>>>>>>>>>>
> >>>>>>>>>>>>                 /* Read frames from the queue */
> >>>>>>>>>>>> -               skb =3D ptr_ring_consume(&q->ring);
> >>>>>>>>>>>> +               skb =3D tap_ring_consume(q);
> >>>>>>>>>>>>                 if (skb)
> >>>>>>>>>>>>                         break;
> >>>>>>>>>>>>                 if (noblock) {
> >>>>>>>>>>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >>>>>>>>>>>> index 8192740357a0..7148f9a844a4 100644
> >>>>>>>>>>>> --- a/drivers/net/tun.c
> >>>>>>>>>>>> +++ b/drivers/net/tun.c
> >>>>>>>>>>>> @@ -2113,13 +2113,34 @@ static ssize_t tun_put_user(struct t=
un_struct *tun,
> >>>>>>>>>>>>         return total;
> >>>>>>>>>>>>  }
> >>>>>>>>>>>>
> >>>>>>>>>>>> +static void *tun_ring_consume(struct tun_file *tfile)
> >>>>>>>>>>>> +{
> >>>>>>>>>>>> +       struct ptr_ring *ring =3D &tfile->tx_ring;
> >>>>>>>>>>>> +       struct net_device *dev;
> >>>>>>>>>>>> +       void *ptr;
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +       spin_lock(&ring->consumer_lock);
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +       ptr =3D __ptr_ring_consume(ring);
> >>>>>>>>>>>> +       if (unlikely(ptr && __ptr_ring_consume_created_space=
(ring, 1))) {
> >>>>>>>>>>>
> >>>>>>>>>>> I guess it's the "bug" I mentioned in the previous patch that=
 leads to
> >>>>>>>>>>> the check of __ptr_ring_consume_created_space() here. If it's=
 true,
> >>>>>>>>>>> another call to tweak the current API.
> >>>>>>>>>>>
> >>>>>>>>>>>> +               rcu_read_lock();
> >>>>>>>>>>>> +               dev =3D rcu_dereference(tfile->tun)->dev;
> >>>>>>>>>>>> +               netif_wake_subqueue(dev, tfile->queue_index)=
;
> >>>>>>>>>>>
> >>>>>>>>>>> This would cause the producer TX_SOFTIRQ to run on the same c=
pu which
> >>>>>>>>>>> I'm not sure is what we want.
> >>>>>>>>>>
> >>>>>>>>>> What else would you suggest calling to wake the queue?
> >>>>>>>>>
> >>>>>>>>> I don't have a good method in my mind, just want to point out i=
ts implications.
> >>>>>>>>
> >>>>>>>> I have to admit I'm a bit stuck at this point, particularly with=
 this
> >>>>>>>> aspect.
> >>>>>>>>
> >>>>>>>> What is the correct way to pass the producer CPU ID to the consu=
mer?
> >>>>>>>> Would it make sense to store smp_processor_id() in the tfile ins=
ide
> >>>>>>>> tun_net_xmit(), or should it instead be stored in the skb (simil=
ar to the
> >>>>>>>> XDP bit)? In the latter case, my concern is that this informatio=
n may
> >>>>>>>> already be significantly outdated by the time it is used.
> >>>>>>>>
> >>>>>>>> Based on that, my idea would be for the consumer to wake the pro=
ducer by
> >>>>>>>> invoking a new function (e.g., tun_wake_queue()) on the producer=
 CPU via
> >>>>>>>> smp_call_function_single().
> >>>>>>>> Is this a reasonable approach?
> >>>>>>>
> >>>>>>> I'm not sure but it would introduce costs like IPI.
> >>>>>>>
> >>>>>>>>
> >>>>>>>> More generally, would triggering TX_SOFTIRQ on the consumer CPU =
be
> >>>>>>>> considered a deal-breaker for the patch set?
> >>>>>>>
> >>>>>>> It depends on whether or not it has effects on the performance.
> >>>>>>> Especially when vhost is pinned.
> >>>>>>
> >>>>>> I meant we can benchmark to see the impact. For example, pin vhost=
 to
> >>>>>> a specific CPU and the try to see the impact of the TX_SOFTIRQ.
> >>>>>>
> >>>>>> Thanks
> >>>>>>
> >>>>>
> >>>>> I ran benchmarks with vhost pinned to CPU 0 using taskset -p -c 0 .=
..
> >>>>> for both the stock and patched versions. The benchmarks were run wi=
th
> >>>>> the full patch series applied, since testing only patches 1-3 would=
 not
> >>>>> be meaningful - the queue is never stopped in that case, so no
> >>>>> TX_SOFTIRQ is triggered.
> >>>>>
> >>>>> Compared to the non-pinned CPU benchmarks in the cover letter,
> >>>>> performance is lower for pktgen with a single thread but higher wit=
h
> >>>>> four threads. The results show no regression for the patched versio=
n,
> >>>>> with even slight performance improvements observed:
> >>>>>
> >>>>> +-------------------------+-----------+----------------+
> >>>>> | pktgen benchmarks to    | Stock     | Patched with   |
> >>>>> | Debian VM, i5 6300HQ,   |           | fq_codel qdisc |
> >>>>> | 100M packets            |           |                |
> >>>>> | vhost pinned to core 0  |           |                |
> >>>>> +-----------+-------------+-----------+----------------+
> >>>>> | TAP       | Transmitted | 452 Kpps  | 454 Kpps       |
> >>>>> |  +        +-------------+-----------+----------------+
> >>>>> | vhost-net | Lost        | 1154 Kpps | 0              |
> >>>>> +-----------+-------------+-----------+----------------+
> >>>>>
> >>>>> +-------------------------+-----------+----------------+
> >>>>> | pktgen benchmarks to    | Stock     | Patched with   |
> >>>>> | Debian VM, i5 6300HQ,   |           | fq_codel qdisc |
> >>>>> | 100M packets            |           |                |
> >>>>> | vhost pinned to core 0  |           |                |
> >>>>> | *4 threads*             |           |                |
> >>>>> +-----------+-------------+-----------+----------------+
> >>>>> | TAP       | Transmitted | 71 Kpps   | 79 Kpps        |
> >>>>> |  +        +-------------+-----------+----------------+
> >>>>> | vhost-net | Lost        | 1527 Kpps | 0              |
> >>>>> +-----------+-------------+-----------+----------------+
> >>>
> >>> The PPS seems to be low. I'd suggest using testpmd (rxonly) mode in
> >>> the guest or an xdp program that did XDP_DROP in the guest.
> >>
> >> I forgot to mention that these PPS values are per thread.
> >> So overall we have 71 Kpps * 4 =3D 284 Kpps and 79 Kpps * 4 =3D 326 Kp=
ps,
> >> respectively. For packet loss, that comes out to 1154 Kpps * 4 =3D
> >> 4616 Kpps and 0, respectively.
> >>
> >> Sorry about that!
> >>
> >> The pktgen benchmarks with a single thread look fine, right?
> >
> > Still looks very low. E.g I just have a run of pktgen (using
> > pktgen_sample03_burst_single_flow.sh) without a XDP_DROP in the guest,
> > I can get 1Mpps.
>
> Keep in mind that I am using an older CPU (i5-6300HQ). For the
> single-threaded tests I always used pktgen_sample01_simple.sh, and for
> the multi-threaded tests I always used pktgen_sample02_multiqueue.sh.
>
> Using pktgen_sample03_burst_single_flow.sh as you did fails for me (even
> though the same parameters work fine for sample01 and sample02):
>
> samples/pktgen/pktgen_sample03_burst_single_flow.sh -i tap0 -m
> 52:54:00:12:34:56 -d 10.0.0.2 -n 100000000
> /samples/pktgen/functions.sh: line 79: echo: write error: Operation not
> supported
> ERROR: Write error(1) occurred
> cmd: "burst 32 > /proc/net/pktgen/tap0@0"
>
> ...and I do not know what I am doing wrong, even after looking at
> Documentation/networking/pktgen.rst. Every burst size except 1 fails.
> Any clues?

Please use -b 0, and I'm Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz.

Another thing I can think of is to disable

1) mitigations in both guest and host
2) any kernel debug features in both host and guest

Thanks

>
> Thanks!
>
> >
> >>
> >> I'll still look into using an XDP program that does XDP_DROP in the
> >> guest.
> >>
> >> Thanks!
> >
> > Thanks
> >
> >>
> >>>
> >>>>>
> >>>>> +------------------------+-------------+----------------+
> >>>>> | iperf3 TCP benchmarks  | Stock       | Patched with   |
> >>>>> | to Debian VM 120s      |             | fq_codel qdisc |
> >>>>> | vhost pinned to core 0 |             |                |
> >>>>> +------------------------+-------------+----------------+
> >>>>> | TAP                    | 22.0 Gbit/s | 22.0 Gbit/s    |
> >>>>> |  +                     |             |                |
> >>>>> | vhost-net              |             |                |
> >>>>> +------------------------+-------------+----------------+
> >>>>>
> >>>>> +---------------------------+-------------+----------------+
> >>>>> | iperf3 TCP benchmarks     | Stock       | Patched with   |
> >>>>> | to Debian VM 120s         |             | fq_codel qdisc |
> >>>>> | vhost pinned to core 0    |             |                |
> >>>>> | *4 iperf3 client threads* |             |                |
> >>>>> +---------------------------+-------------+----------------+
> >>>>> | TAP                       | 21.4 Gbit/s | 21.5 Gbit/s    |
> >>>>> |  +                        |             |                |
> >>>>> | vhost-net                 |             |                |
> >>>>> +---------------------------+-------------+----------------+
> >>>>
> >>>> What are your thoughts on this?
> >>>>
> >>>> Thanks!
> >>>>
> >>>>
> >>>
> >>> Thanks
> >>>
> >>
> >
>


