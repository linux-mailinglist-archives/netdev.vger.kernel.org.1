Return-Path: <netdev+bounces-116687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624D394B5DA
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 06:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2B0282115
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 04:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A022450EE;
	Thu,  8 Aug 2024 04:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=soulik.info header.i=@soulik.info header.b="TTRdXr8/"
X-Original-To: netdev@vger.kernel.org
Received: from kozue.soulik.info (kozue.soulik.info [108.61.200.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395CE9479;
	Thu,  8 Aug 2024 04:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.61.200.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723090624; cv=none; b=Nq/z1HgdUYAAz6HXCPdy6+ZsNMCJy1vG0tXcY5PjJRGMd7szfS6K5R6KKvcZlf5ZQAczHh1yf8+HwDG6utjiievIKl31Tsvss6UtbiLzabE05pJyKc+YWLSCr6SQIbHnIQp8ciJ2dsG9luEK4t4fbQpczfkpuddi5FGCmV/1idU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723090624; c=relaxed/simple;
	bh=0WNq99ZfluaYTPjXc7nR7wJqBcpbBEIkIYGyt86dLpw=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=HKvifwG/qzXU978+8+Bz7Q9hqsQf8jivTnti5zCpPFJCeqSRjcdlViBtTdAzaVoOGefIEj97wvMvA1ad6XNk/6tTM9wkgXBmq8XcMEsNHIPVYNjgcboP6melBnGyAx/0FDAfRoPP6OyaYrSMyD6rZe3LrcjyIZhZQhiR85qtwOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soulik.info; spf=pass smtp.mailfrom=soulik.info; dkim=pass (1024-bit key) header.d=soulik.info header.i=@soulik.info header.b=TTRdXr8/; arc=none smtp.client-ip=108.61.200.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soulik.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soulik.info
Received: from smtpclient.apple (unknown [199.33.119.15])
	by kozue.soulik.info (Postfix) with ESMTPSA id 6B0232FE480;
	Thu,  8 Aug 2024 13:17:34 +0900 (JST)
DMARC-Filter: OpenDMARC Filter v1.4.2 kozue.soulik.info 6B0232FE480
Authentication-Results: kozue.soulik.info; dmarc=fail (p=reject dis=none) header.from=soulik.info
Authentication-Results: kozue.soulik.info; spf=fail smtp.mailfrom=soulik.info
DKIM-Filter: OpenDKIM Filter v2.11.0 kozue.soulik.info 6B0232FE480
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soulik.info; s=mail;
	t=1723090654; bh=Mnh0ly5dKPF3Fv3lMn0gC47Yr+0psDOqag/mxp7ocS4=;
	h=From:Subject:Date:References:Cc:In-Reply-To:To:From;
	b=TTRdXr8/MM3EzFvktnfSRHB5fqvWfVKPp8Yv9CwOL1mK4rfCe9cCl5zxSchhToBGd
	 0M6FaaGY5itao/iQFoVVStb/AHY3b68nNCbxlb1o1ePW/Vt4Ed19rCNGhRssrwtMS8
	 QQRk7o+I3xSniL0vPzJp8OPvy7t308/78dJ8lzxw=
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
Date: Thu, 8 Aug 2024 12:16:46 +0800
Message-Id: <6C9DA933-5EAA-4711-BF89-0B71834DA211@soulik.info>
References: <CAF=yD-+2SnOzALmisVVBZAKNKrCMv07FdEDP1ov35APNMYOTew@mail.gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
In-Reply-To: <CAF=yD-+2SnOzALmisVVBZAKNKrCMv07FdEDP1ov35APNMYOTew@mail.gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
X-Mailer: iPad Mail (21A351)


Sent from my iPad

> On Aug 8, 2024, at 11:13=E2=80=AFAM, Willem de Bruijn <willemdebruijn.kern=
el@gmail.com> wrote:
>=20
> =EF=BB=BF
>>=20
>>> In that case, a tc egress tc_bpf program may be able to do both.
>>> Again, by writing to __sk_buff queue_mapping. Instead of u32 +
>>> skbedit.
>>>=20
>>> See also
>>>=20
>>> "
>>> commit 74e31ca850c1cddeca03503171dd145b6ce293b6
>>> Author: Jesper Dangaard Brouer <brouer@redhat.com>
>>> Date:   Tue Feb 19 19:53:02 2019 +0100
>>>=20
>>>    bpf: add skb->queue_mapping write access from tc clsact
>>> "
>>>=20
>>> But I suppose you could prefer u32 + skbedit.
>>>=20
>>> Either way, the pertinent point is that you want to map some flow
>>> match to a specific queue id.
>>>=20
>>> This is straightforward if all queues are opened and none are closed.
>>> But it is not if queues can get detached and attached dynamically.
>>> Which I guess you encounter in practice?
>>>=20
>>> I'm actually not sure how the current `tfile->queue_index =3D
>>> tun->numqueues;` works in that case. As __tun_detach will do decrement
>>> `--tun->numqueues;`. So multiple tfiles could end up with the same
>>> queue_index. Unless dynamic detach + attach is not possible.
>>=20
>> It is expected to work, otherwise there should be a bug.
>>=20
>>> But it
>>> seems it is. Jason, if you're following, do you know this?
>>=20
>> __tun_detach() will move the last tfile in the tfiles[] array to the
>> current tfile->queue_index, and modify its queue_index:
>>=20
>>        rcu_assign_pointer(tun->tfiles[index],
>>                                   tun->tfiles[tun->numqueues - 1]);
>>        ntfile =3D rtnl_dereference(tun->tfiles[index]);
>>        ntfile->queue_index =3D index;
>>        rcu_assign_pointer(tun->tfiles[tun->numqueues - 1],
>>                                   NULL);
>>=20
>>        --tun->numqueues;
>>=20
>> tun_attach() will move the detached tfile to the end of the tfiles[]
>> array and enable it:
>>=20
>>=20
>>        tfile->queue_index =3D tun->numqueues;
>>        ....
>>        rcu_assign_pointer(tun->tfiles[tun->numqueues], tfile);
>>        tun->numqueues++;
>>=20
>=20
> Ah right. Thanks. I had forgotten about that.
>=20
> So I guess an application that owns all the queues could keep track of
> the queue-id to FD mapping. But it is not trivial, nor defined ABI
> behavior.
>=20
> Querying the queue_id as in the proposed patch might not solve the
> challenge, though. Since an FD's queue-id may change simply because
Yes, when I asked about those eBPF thing, I thought I don=E2=80=99t need the=
 queue id in those ebpf. It turns out a misunderstanding.
Do we all agree that no matter which filter or steering method we used here,=
 we need a method to query queue index assigned with a fd?
> another queue was detached. So this would have to be queried on each
> detach.
>=20
Thank you Jason. That is why I mentioned I may need to submit another patch t=
o bind the queue index with a flow.

I think here is a good chance to discuss about this.
I think from the design, the number of queue was a fixed number in those har=
dware devices? Also for those remote processor type wireless device(I think t=
hose are the modem devices).
The way invoked with hash in every packet could consume lots of CPU times. A=
nd it is not necessary to track every packet.
Could I add another property in struct tun_file and steering program return w=
anted value. Then it is application=E2=80=99s work to keep this new property=
 unique.
> I suppose one underlying question is how important is the mapping of
> flows to specific queue-id's? Is it a problem if the destination queue
> for a flow changes mid-stream?
Yes, it matters. Or why I want to use this feature. =46rom all the open sour=
ce VPN I know, neither enabled this multiqueu feature nor create more than o=
ne queue for it.
And virtual machine would use the tap at the most time(they want to emulate a=
 real nic).
So basically this multiple queue feature was kind of useless for the VPN usa=
ge.
If the filter can=E2=80=99t work atomically here, which would lead to unwant=
ed packets transmitted to the wrong thread.=

