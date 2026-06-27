Return-Path: <netdev+bounces-302285-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /djWJNMdP2raOwkAu9opvQ
	(envelope-from <netdev+bounces-302285-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 02:48:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF346D0A4A
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 02:48:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZNTYYib8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302285-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302285-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A86F53015C18
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 00:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89B814AD20;
	Sat, 27 Jun 2026 00:48:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FABA81ACD
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 00:48:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782521297; cv=pass; b=kQ0l19bWrp3zSxXGNC8CHFVQ/BeBrQWOqmQFTz5toQejmuAsFwYkT616yzvQRbjcj6JJfQTCmUbaeDJyft/+P3xiMkNgwwa2bz+Ay+krcoPv7SUc2SLN2qHmNJl9QTPGyH1KanfO8s1SnEkdhqefhjJ5zgpHzVDyK8xlMrn9cpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782521297; c=relaxed/simple;
	bh=Bmz1WKyaVMmyeUHYDXRZy/G2uXyM9XjanlQdBBr06KU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGITXZ0X1/ggAWzGoF71wXia8NQtSfpX+KETNfdAj274R59LaDUO79hnEF26R+c0rR1ywiBnYtynjTFK7VS89U5R2g3rauZ8q4eXSMwyChQKBw0KiZDjhHCGt0Mym5mNJ8DJfE/SZURqDkXolIgLiMywf0qwisNynPBddfrCY/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNTYYib8; arc=pass smtp.client-ip=209.85.167.43
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aea722856cso764689e87.0
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 17:48:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782521294; cv=none;
        d=google.com; s=arc-20260327;
        b=pwWqBly3VDC9dv98ZNQ7WI2Ya1ZJIy1xbVRuDOhVk+6ck0kqX2tGniixLKKtMtq0V4
         qmd/fLreNFMg1Tk7xADPQC6ddRKHVbT8esMTObUSULcrz1x/5eMzT6fBCxR4Z7jMEDeT
         6grJc+m8BAZNoOA/CjBA/CmtoX6jmFGTg1Olh6OykVmu3HuEAPbfIB1tro6jcIy6Dxwg
         FE1P9KXSvsOzBBycgRvrMVASD6D5+DfSk/D5S4HDPfy+IfuqCAWwpGnUQNCSptlG5Jy7
         knB5eGuKovCgPv49uIGNGXYglFz91GfrUlNVsrOIKbm2RmPM65gzTaqiLNdjaDum2qNR
         bjUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i8oCl3yYNOYjny6JkpEjXGEO5YMr6q41v93XlfvgW5w=;
        fh=nj37LlY6TenP0rrBCEZyY0EyGwk+f7oXjLB1XvlvSXQ=;
        b=cMSW8kUklvocf2XiLLz0VDKJs68+cxN3ASUPIsUK+P4KKvR6qg4XMqaD92+pgIy7Vx
         mBTQn9w/DYTlG1s5BJZ0iEU25lK5cJc7YMTCbeMhlJUphuuee96/JTgd53bBPPV7pKrJ
         yazn7o/BLsCkSIW2id4rpSFzCC0/G+DqMtwKOZ9kHwCVgHH7XYOr3ogIH9hH2DvaOmfH
         jU1+KUx4o99ABQbBKzrPhAuTr4KUZYWzwW/E+P/5yYoHDAUCsJzq7wX6GKizrwk3+KQr
         k/ENeVNUaQM0wr1INrgHP/y+BLOn6I62BXyAwDaRWDGaknod/48j9ciRSynyDwxkijWI
         cFiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782521294; x=1783126094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8oCl3yYNOYjny6JkpEjXGEO5YMr6q41v93XlfvgW5w=;
        b=ZNTYYib8E7CYkRYTiMolPZwBa2y5iJ0QJ7UqPWRFoYXgQ5WAMJaNlIBFKy+O7Qp8GA
         4DEHGS5JRvSTIIA2iFkMmgNFtyNCFmTfOZ93EXAkgitJ1JmrxtojMDnxN5ILpBI3FUSc
         eb62pdUiMv8DrcK4cQBDce6lwswS1hWS4KH3n6uu66Iq5U9HEEB+LDg1MnRrJPzSdi6q
         b9nxeOCKutRCiicdMEZMyqQGAnC6FaJUNOg+F1jgJac5PoktkPdguKxtIdtwo+/h8i3Q
         lbuPyjRqTWiRNXDx6uKKlx10FhrRwCXHU3O5NBvl7T0AVZ0ttseTpBzEaiEbbSAtw9Ae
         Tg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782521294; x=1783126094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i8oCl3yYNOYjny6JkpEjXGEO5YMr6q41v93XlfvgW5w=;
        b=hRpl88fuWm8xeZQvc0r+IuFmtIJf06yMRbXg1RNVna/cOoPbY86mqqZUH523GuhDpO
         q0nN+jGaJz8jWMaGNCE063Q6eLAir9NqTGDKdN7tYOwFve7vddRTYT7Gh+NEDVhv8phT
         8OfrCtLnXkia7sjUywsfQ4zGGuvszWflmJdMh+CjwQqwA004Tv1KniP7Ca0ZvRvfttoW
         kx9DV2XWh+wJH6FxDZLmP2I2pBv97o8tZLMlKLmZsP4sgGnTRKtzLkFFpQ3h1p0yFrXS
         fXhrm0pQwOIOM3nk+be3N1+yiVgt84xAvg/+51PgGh+cXGni2Z4muEozZ4cln9WRYwek
         vQ7w==
X-Forwarded-Encrypted: i=1; AHgh+RrKcOM+dfMNP/BqzlBlSpDRJ609fZMBwLhAhFhZ8j3yZV4ptT7zSirbVVZqUyYsiIhT0cdSzbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC/244rMyI0DIqOoaqMlnLlgpKHtKnPyBhZinpCS2x5VVidPQt
	42mSmVBRGMxYPFxqscxXtgSuho0+kftXp4lk0wjXOQAXhAWUeZ6ZLIkhq3vqpgJuuatM1a+GXOo
	SjH17hNhdUKYpfU5Bfy0xJWkJ4SezT2U=
X-Gm-Gg: AfdE7ckqc5Zff9p2tG0gaMhZB6W197WQyvIoZYcG6QNvLmM1Sr4/Z2UQKEf38bZeIXn
	SSUUdHGyAukuUJVsKBuOLSXGA+bbGL6lfjDQrZpgwyCLPdtWurK4jSfhQ5XYlJWpIV1e4RZQY/c
	fMgqOdl8f3BwRZgceQIJTUvz/yya7Q9qmrOrplz4YX7e8ejZFtgGGsVx4DNMY+Oj+H2eaYgWsOL
	A88lb26iCduoEmLVhHPu5JivQTQLOEjvefXLpAjaRFNF1n/ltPuzhiJMsIleZmbMIYiKaeRBZEM
	qU4+wDDre5sdV2azNe9jcL2NuY2wmZmbpDZxtc+/0Nxlky7hr/UO31cCL8fw3/8dMiz/yp+07j/
	+zhjJ6x52Vg==
X-Received: by 2002:a05:6512:450c:b0:5ad:4cbc:ce9e with SMTP id
 2adb3069b0e04-5aea1f3d59emr2353400e87.5.1782521294123; Fri, 26 Jun 2026
 17:48:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
 <ajv23_r4M3FGrFNN@devvm7509.cco0.facebook.com> <ajwHuCp82SazSwKv@boxer>
 <CAL+tcoC789GrOXvvYVOfxhL4iLCdFEAZQ+WCENsMjbLrJnfiYw@mail.gmail.com>
 <aj1O4vKzCuodwgYL@devvm7509.cco0.facebook.com> <CAL+tcoDOFtTKavz8TWpU6BPrHCcL6TjY8xrmFA5y3P9Wn0T4ZA@mail.gmail.com>
 <aj6mr-cIcF2Tg73r@devvm7509.cco0.facebook.com>
In-Reply-To: <aj6mr-cIcF2Tg73r@devvm7509.cco0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 27 Jun 2026 08:47:36 +0800
X-Gm-Features: AVVi8CdyDIBQUVaqwVW16SE-8u2NgWuTXDypc7adtnCyKWlnX6IZ-ykD_71LcYo
Message-ID: <CAL+tcoAdBRUSFTJfaNKSh9hLK=pgvWTwp0T8u9aYps1dFENwvA@mail.gmail.com>
Subject: Re: [PATCH net 0/7] xsk: fix AF_XDP multi-buffer Tx descriptor reclaim
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302285-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sdf.kernel@gmail.com,m:maciej.fijalkowski@intel.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bjorn@kernel.org,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,gmail.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:email,mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,netdevconf.info:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2BF346D0A4A

On Sat, Jun 27, 2026 at 12:30=E2=80=AFAM Stanislav Fomichev
<sdf.kernel@gmail.com> wrote:
>
> On 06/26, Jason Xing wrote:
> > On Fri, Jun 26, 2026 at 12:05=E2=80=AFAM Stanislav Fomichev
> > <sdf.kernel@gmail.com> wrote:
> > >
> > > On 06/25, Jason Xing wrote:
> > > > On Thu, Jun 25, 2026 at 12:37=E2=80=AFAM Maciej Fijalkowski
> > > > <maciej.fijalkowski@intel.com> wrote:
> > > > >
> > > > > On Wed, Jun 24, 2026 at 08:38:20AM -0700, Stanislav Fomichev wrot=
e:
> > > > > > On 06/23, Maciej Fijalkowski wrote:
> > > > > > > Hi,
> > > > > > >
> > > > > > > This series fixes several AF_XDP multi-buffer Tx paths where =
descriptors
> > > > > > > consumed from the Tx ring are not consistently returned to us=
erspace
> > > > > > > through the completion ring when the packet is later dropped =
as invalid.
> > > > > > >
> > > > > > > The affected cases are invalid or oversized multi-buffer Tx p=
ackets in
> > > > > > > both the generic and zero-copy paths. In these cases, the ker=
nel can
> > > > > > > consume one or more Tx descriptors while building or validati=
ng a
> > > > > > > multi-buffer packet, then drop the packet before it reaches t=
he device.
> > > > > > > Userspace still owns the UMEM buffers only after the correspo=
nding
> > > > > > > addresses are returned through the CQ. Missing completions th=
erefore
> > > > > > > make userspace lose track of those buffers.
> > > > > > >
> > > > > > > The generic path fixes cover three related cases:
> > > > > > > * partially built multi-buffer skbs dropped by xsk_drop_skb()=
;
> > > > > > >   continuation descriptors left in the Tx ring after xsk_buil=
d_skb()
> > > > > > >   reports overflow;
> > > > > > > * invalid descriptors encountered in the middle of a multi-bu=
ffer
> > > > > > >   packet, including the offending invalid descriptor itself.
> > > > > > >
> > > > > > > The zero-copy path is handled separately. The batched Tx pars=
er now
> > > > > > > distinguishes descriptors that can be passed to the driver fr=
om
> > > > > > > descriptors that are consumed only because they belong to an =
invalid
> > > > > > > multi-buffer packet. Reclaim-only descriptors are written to =
the CQ
> > > > > > > address area and published in completion order, after any ear=
lier
> > > > > > > driver-visible Tx descriptors.
> > > > > > >
> > > > > > > The ZC batching path can also retain drain state when userspa=
ce has not
> > > > > > > yet provided the end of an invalid multi-buffer packet. To ke=
ep this
> > > > > > > state local to the singular batched path, the series prevents=
 a second
> > > > > > > Tx socket from joining the same pool while such drain state e=
xists.
> > > > > > > During the singular-to-shared transition, Tx batching is gate=
d,
> > > > > > > pre-existing readers are waited out, and bind fails with -EAG=
AIN if the
> > > > > > > existing socket still has pending drain state. This avoids ad=
ding
> > > > > > > multi-buffer drain handling to the shared-UMEM fallback path.
> > > > > > >
> > > > > > > The last two patches update xskxceiver so the tests account i=
nvalid
> > > > > > > multi-buffer Tx packets as descriptors that must be reclaimed=
, while
> > > > > > > still not expecting those invalid packets on the Rx side.
> > > > > > >
> > > > > > > This is a follow-up to Jason's changes [0] which were address=
ing generic
> > > > > > > xmit only and this set allows me to pass full xskxceiver test=
 suite run
> > > > > > > against ice driver.
> > > > > >
> > > > > > There is a fair amount of feedback from sashiko already :-( So =
the meta
> > > > > > question from me is: is it time to scrap our current approach w=
here
> > > > > > we parse descriptor by descriptor? (and maintain half-baked skb=
 and
> > > > > > half-consumed descriptor queues)
> > > > > >
> > > > > > Should we:
> > > > > >
> > > > > > 1. do desc[MAX_SKB_FRAGS] and xskq_cons_peek_desc until we exha=
ust
> > > > > > PKT_CONT (if the last packet has PKT_CONT, return EOVERFLOW to =
userspace
> > > > > > and do a full stop here)
> > > > > > 2. now that we really know the number of valid descriptors -> r=
eserve
> > > > > > the cq space (if not -> EAGAIN)
> > > > > > 3. pre-allocate everything here (if at any point we have ENOMEM=
 -> cleanup
> > > > > > locally, don't ever create semi-initialized skb)
> > > > > > 4. construct the skb
> > > > > > 5. xmit
> > > > >
> > > > > Yeah generic xmit became utterly horrible, haven't gone through s=
ashiko
> > > > > reviews yet, but bare in mind this set also aligns zc side to wha=
t was
> > > > > previously being addressed by Jason.
> > > > >
> > > > > I believe planned logistics were to get these fixes onto net and =
then
> > > > > Jason had an implementation of batching on generic xmit, directed=
 towards
> > > > > -next and that's where we could address current flow.
> > > >
> > > > Agreed. That's what I'm hoping for. There would be much more
> > > > discussion on how to do batch xmit in an elegant way, I believe.
> > >
> > > This doesn't have to depend on the batch rewrite, we should be able t=
o rewrite
> > > this non-zc in net, this is still technically fixes, not feature work=
..
> > >
> > > There was already a couple of revisions with this drain_cont approach
> > > and every time I look at it feels like the cure is worse than the
> > > decease :-( Obviously not gonna stop you from going with the current =
approach,
> > > but these fixes feel a bit of a wasted effort to me (since the bugs k=
eep
> > > coming and we are piling more complexity).
> >
> > I see your point, but rewriting is something that cannot be easily
> > applied to the stable branches? Until now, we fix issues one by one
> > which have an explicit target branch (because of the fixes tag). Cross
> > fingers :(
> >
> > Sashiko has the magic to find out the hidden bugs more than ever and
> > AF_XDP is not the only place where a pile of reports are coming in.
>
> net vs net-next is fixes vs feature work. If we can't fix the current
> code, I think we can justify a rewrite using a better approach and
> route it via net. This series is 7 patches anyway, it's not like
> it is a quick short fix :-) But I'm ok with pushing it as it, I'm just
> trying to see if someone on your side is fed up with that part as well
> and wants to fix it "properly" :-p
>
> > My take is that batch xmit has been appending too long and at least so
> > far less and less bugs are found by sashiko. I believe if the mode is
> > changed to batch xmit, there are likely to be new and challenging
> > problems to discuss. I prefer to solve questions of the batch xmit
> > series.
>
> We can redo this part separately, without batching. Move from "read
> one chunk at a time" to "pre-read all chunks". Batching vs current issue
> are separate.

If the implementation of 'pre-read' is clear and simple, yes, it's a
better way. (I really want to engage myself in this right now, but
sorry, I can't since I'm writing many slides for Netdev.)

Probably Maciej will give it one last try; we'll see then.

>
> > BTW, would you both come to Netdev 0x1a next month? I believe we could
> > sit around the table and discuss some future plans there (in xdp
> > workshop?).
> > https://netdevconf.info/0x1A/sessions/workshop/xdp-workshop.html
>
> Yes, I plan to be there in person.

Great.

Thanks,
Jason

