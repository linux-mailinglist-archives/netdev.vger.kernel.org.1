Return-Path: <netdev+bounces-40043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC437C58B9
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 18:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87FEE1C20BBF
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 16:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7894430F88;
	Wed, 11 Oct 2023 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OL+keEpE"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A64101F6
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:01:55 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295B191
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 09:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ukvrUioNWbMdieGVVP0yXPp3At+mvG2IEJQ6NoeN2r0=;
	t=1697040114; x=1698249714; b=OL+keEpEjd8oppm48yxgK5SlpSldY0AChXIAkwG+uXP74+i
	+MmyvwlCHIsZvx3j5pXf/kxmqpnQUuryAIy+r1QdJyuRYZdOX9ZIfsup0YHmHJm+7Ut+stLfIdxzL
	wnMIoJ4NxwScXryABOLPdE5YPQtpjMJZ459XFkZXr72VfyGcoaVrVSyaxJ7SPCWzLUTSgZKc2F1Mh
	jAzWkOjZIlrkoOD8Te63hvAL1Orh2JysAgIMzF64ugn5PKVwcR7CYMUYCxzu3Dp2K4jBbjr0JdFfi
	8Vb4ph2mfka1y7ySohTcRut9c+PAr0Uho2drX1BqNu6WaWx+TbLRKiVaypshAxFQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qqbeg-00000001yUI-1CIF;
	Wed, 11 Oct 2023 18:01:50 +0200
Message-ID: <30be757c7a0bbe50b37e9f2e6f93c8cf4219bbc1.camel@sipsolutions.net>
Subject: Re: [RFC] netlink: add variable-length / auto integers
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>, Nicolas Dichtel
	 <nicolas.dichtel@6wind.com>
Cc: netdev@vger.kernel.org, fw@strlen.de, pablo@netfilter.org,
 jiri@resnulli.us,  mkubecek@suse.cz, aleksander.lobakin@intel.com, Thomas
 Haller <thaller@redhat.com>
Date: Wed, 11 Oct 2023 18:01:49 +0200
In-Reply-To: <20231011085230.2d3dc1ab@kernel.org>
References: <20231011003313.105315-1-kuba@kernel.org>
	 <f75851720c356fe43771a5c452d113ca25d43f0f.camel@sipsolutions.net>
	 <6ec63a78-b0cc-452e-9946-0acef346cac2@6wind.com>
	 <20231011085230.2d3dc1ab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-10-11 at 08:52 -0700, Jakub Kicinski wrote:

> > > > Even for arches which don't have good unaligned access - I'd think
> > > > that access aligned to 4B *is* pretty efficient, and that's all
> > > > we need. Plus kernel deals with unaligned input. Why can't user spa=
ce? =20
> > >=20
> > > Hmm. I have a vague recollection that it was related to just not doin=
g
> > > it - the kernel will do get_unaligned() or similar, but userspace if =
it
> > > just accesses it might take a trap on some architectures?
> > >=20
> > > But I can't find any record of this in public discussions, so ... =
=20
> > If I remember well, at this time, we had some (old) architectures that =
triggered
> > traps (in kernel) when a 64-bit field was accessed and unaligned. Maybe=
 a mix
> > between 64-bit kernel / 32-bit userspace, I don't remember exactly. The=
 goal was
> > to align u64 fields on 8 bytes.
>=20
> Reading the discussions I think we can chalk the alignment up=20
> to "old way of doing things". Discussion was about stats64,=20
> if someone wants to access stats directly in the message then yes,=20
> they care a lot about alignment.
>=20
> Today we try to steer people towards attr-per-field, rather than
> dumping structs. Instead of doing:
>=20
> 	struct stats *stats =3D nla_data(attr);
> 	print("A: %llu", stats->a);
>=20
> We will do:
>=20
> 	print("A: %llu", nla_get_u64(attrs[NLA_BLA_STAT_A]));

Well, yes, although the "struct stats" part _still_ even exists in the
kernel, we never fixed that with the nla_put_u64_64bit() stuff, that was
only for something that does

	print("A: %" PRIu64, *(uint64_t *)nla_data(attrs[NLA_BLA_STAT_A]));

> Assuming nla_get_u64() is unalign-ready the problem doesn't exist.

Depends on the library, but at least for libnl that's true since ever.
Same for libmnl and libnl-tiny. So I guess it only ever hit hand-coded
implementations.

For the record, I'm pretty sure (and was at the time) that for wifi
(nl80211) this was never an issue, but ...

> Does the above sounds like a fair summary? If so I'll use it in=20
> the commit message?

As I said above, not sure about the whole struct thing - that's still
kind of broken and was never addressed by this, but otherwise yes.

johannes

