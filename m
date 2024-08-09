Return-Path: <netdev+bounces-117079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A98F794C961
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 06:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CB4F285589
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 04:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DFD13FD83;
	Fri,  9 Aug 2024 04:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=soulik.info header.i=@soulik.info header.b="i3kioic3"
X-Original-To: netdev@vger.kernel.org
Received: from kozue.soulik.info (kozue.soulik.info [108.61.200.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23241C2E;
	Fri,  9 Aug 2024 04:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.61.200.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723178843; cv=none; b=kMjtvrmiBKCDajAez3nd3k8n1huyQQEFgk8UsXqbGn20phm/pFDVVeHEaAYII2oMjnFEYRkkjzBdgmxdQ79xKIendm1J/WoHOm3aSIpF+zoAsZ7+Dy3VBLRzA2DxMwlQhVBRGEyKEPbhzs9rYxvJ4xU60r6bUFVMd89W4DkCxso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723178843; c=relaxed/simple;
	bh=UCTJXZEgTeJ7ZGqiWlAfphLFq0PYCgcy7hpAjIt8ZtQ=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=gxLSt6yVfnUOAHw/fnmS2thOz1Ave8Jl0TlPpRCqZ2tRbyv9RGFLArD1T1jPt4+QK85dLFmM7/D2KaW6ZxqO/0Jrmu4GCDPDxakfjd8ZcHNInRyW/vrkCrT1Oau8l1S8daIJebJH5pZSTJeE5VjIREmzQESVU9KNy3Jw2HMSVFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soulik.info; spf=pass smtp.mailfrom=soulik.info; dkim=pass (1024-bit key) header.d=soulik.info header.i=@soulik.info header.b=i3kioic3; arc=none smtp.client-ip=108.61.200.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soulik.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soulik.info
Received: from smtpclient.apple (unknown [199.33.119.15])
	by kozue.soulik.info (Postfix) with ESMTPSA id 221482FE4EF;
	Fri,  9 Aug 2024 13:47:49 +0900 (JST)
DMARC-Filter: OpenDMARC Filter v1.4.2 kozue.soulik.info 221482FE4EF
Authentication-Results: kozue.soulik.info; dmarc=fail (p=reject dis=none) header.from=soulik.info
Authentication-Results: kozue.soulik.info; spf=fail smtp.mailfrom=soulik.info
DKIM-Filter: OpenDKIM Filter v2.11.0 kozue.soulik.info 221482FE4EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soulik.info; s=mail;
	t=1723178870; bh=vEtguEeKJQYG5gd1qm8drx8J74xOsWmAcR1GkT6UCUM=;
	h=From:Subject:Date:References:Cc:In-Reply-To:To:From;
	b=i3kioic3PDSCaYvoRu1M+vsa/n2ZtwBZ2M7GrfWtAy2LzucUZ9yxWrcdhGVqPDHoX
	 pemFMBqAjJf8X+DKAMGnGpSicB42j6jddsJjwet3KIuXR+W0q5+oXV8LOdrA6lzyQV
	 mNweX7JWOD5Y0Qfozs8vBWzTNCTk7mMARSFeBbnU=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: ayaka <ayaka@soulik.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] net: tuntap: add ioctl() TUNGETQUEUEINDX to fetch queue index
Date: Fri, 9 Aug 2024 12:45:50 +0800
Message-Id: <9C79659E-2CB1-4959-B35C-9D397DF6F399@soulik.info>
References: <CAF=yD-JVs3h1PUqHaJAOFGXQQz-c36v_tP4vOiHpfeRhKh-UpA@mail.gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
In-Reply-To: <CAF=yD-JVs3h1PUqHaJAOFGXQQz-c36v_tP4vOiHpfeRhKh-UpA@mail.gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
X-Mailer: iPad Mail (21A351)


Sent from my iPad

> On Aug 9, 2024, at 2:49=E2=80=AFAM, Willem de Bruijn <willemdebruijn.kerne=
l@gmail.com> wrote:
>=20
> =EF=BB=BF
>>=20
>>> So I guess an application that owns all the queues could keep track of
>>> the queue-id to FD mapping. But it is not trivial, nor defined ABI
>>> behavior.
>>>=20
>>> Querying the queue_id as in the proposed patch might not solve the
>>> challenge, though. Since an FD's queue-id may change simply because
>> Yes, when I asked about those eBPF thing, I thought I don=E2=80=99t need t=
he queue id in those ebpf. It turns out a misunderstanding.
>> Do we all agree that no matter which filter or steering method we used he=
re, we need a method to query queue index assigned with a fd?
>=20
> That depends how you intend to use it. And in particular how to work
> around the issue of IDs not being stable. Without solving that, it
> seems like an impractical and even dangerous -because easy to misuse-
> interface.
>=20
First of all, I need to figure out when the steering action happens.
When I use multiq qdisc with skbedit, does it happens after the net_device_o=
ps->ndo_select_queue() ?
If it did, that will still generate unused rxhash and txhash and flow tracki=
ng. It sounds a big overhead.
Is it the same path for tc-bpf solution ?

I would reply with my concern about violating IDs in your last question.
>>> another queue was detached. So this would have to be queried on each
>>> detach.
>>>=20
>> Thank you Jason. That is why I mentioned I may need to submit another pat=
ch to bind the queue index with a flow.
>>=20
>> I think here is a good chance to discuss about this.
>> I think from the design, the number of queue was a fixed number in those h=
ardware devices? Also for those remote processor type wireless device(I thin=
k those are the modem devices).
>> The way invoked with hash in every packet could consume lots of CPU times=
. And it is not necessary to track every packet.
>=20
> rxhash based steering is common. There needs to be a strong(er) reason
> to implement an alternative.
>=20
I have a few questions about this hash steering, which didn=E2=80=99t reques=
t any future filter invoked:
1. If a flow happens before wrote to the tun, how to filter it?
2. Does such a hash operation happen to every packet passing through?
3. Is rxhash based on the flow tracking record in the tun driver?
Those CPU overhead may demolish the benefit of the multiple queues and filte=
rs in the kernel solution.
Also the flow tracking has a limited to 4096 or 1024, for a IPv4 /24 subnet,=
 if everyone opened 16 websites, are we run out of memory before some entrie=
s expired?

I want to  seek there is a modern way to implement VPN in Linux after so man=
y features has been introduced to Linux. So far, I don=E2=80=99t find a prop=
er way to make any advantage here than other platforms.
>> Could I add another property in struct tun_file and steering program retu=
rn wanted value. Then it is application=E2=80=99s work to keep this new prop=
erty unique.
>=20
> I don't entirely follow this suggestion?
>=20
>>> I suppose one underlying question is how important is the mapping of
>>> flows to specific queue-id's? Is it a problem if the destination queue
>>> for a flow changes mid-stream?
>> Yes, it matters. Or why I want to use this feature. =46rom all the open s=
ource VPN I know, neither enabled this multiqueu feature nor create more tha=
n one queue for it.
>> And virtual machine would use the tap at the most time(they want to emula=
te a real nic).
>> So basically this multiple queue feature was kind of useless for the VPN u=
sage.
>> If the filter can=E2=80=99t work atomically here, which would lead to unw=
anted packets transmitted to the wrong thread.
>=20
> What exactly is the issue if a flow migrates from one queue to
> another? There may be some OOO arrival. But these configuration
> changes are rare events.
I don=E2=80=99t know what the OOO means here.
If a flow would migrate from its supposed queue to another, that was against=
 the pretension to use the multiple queues here.
A queue presents a VPN node here. It means it would leak one=E2=80=99s data t=
o the other.
Also those data could be just garbage fragments costs bandwidth sending to a=
 peer that can=E2=80=99t handle it.=

