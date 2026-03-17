Return-Path: <netdev+bounces-268585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCqIK5tFuWmK+QEAu9opvQ
	(envelope-from <netdev+bounces-268585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:14:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CC82A9A35
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BBA4C301FB40
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253E63BD658;
	Tue, 17 Mar 2026 12:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWcxlJVG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B4C3BD630
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773749640; cv=none; b=Yu6AinBV4ZRxqNprGgHMDVs2zrbL50gEdiJ7t4QJceE1FBbb2X+M4Y5LjaIycMRS7AoumWnN8ELBWyLhYAqAVErh1mJlbgiiuCWuvkTzbmOgvtH6tQr4+m1YY2yemElhnlBfWN0Fquz2+kzE539Sz6F/kNAsSrrg89XI14T7eRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773749640; c=relaxed/simple;
	bh=NM15rF2ixpr9zdJXA845krHa+u0TL42/fXie+kPWl1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQMqCdtn27wulFqKdKzHoKhehq2Ks9fr8TWF99nWgQxxeVm3ClahhGwNE80CooKY+X9fFYgJOuJmj0p3wLKAK8r5uB0RpBmolq3hLfTmKlvA742+tmL0k1vYvDL1ewHiRgzIz6VjLyg2cpKXqJHK7b/+7tIt+oTqXNEvR7CQ1aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWcxlJVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3291C2BCB1
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 12:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773749639;
	bh=NM15rF2ixpr9zdJXA845krHa+u0TL42/fXie+kPWl1s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JWcxlJVGPBqhz9RXcLD6E0lS6FseglH23EQPEWTY72+jfKOks25hEGKjngVRjniQO
	 CmQ8rspgQZn8dRpPC3r1TJVX+qcDYnBSCIvs4RCpciFsQar5ddcjh381iJyaciNuRb
	 oovHU2pt1lKlSD/jtwDe/zD7yuZSQGbfjndbfEcWw6479ZYNzW+/9ArCALW3TXEZD8
	 88FPC9BtITi6vjghBQsAO/gJosHfzFdwd4cltWyWvKIzx+2No79UY4ReEMFco95j3N
	 LrUvswVkq/pmrHMDcUCg6Tn5noLn1LuBP5YnHsWw53a5O2c9cPAjYIDQ+KnV1cV3lr
	 sLTO4YEaMZmKw==
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-899fc265126so67749936d6.1
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 05:13:59 -0700 (PDT)
X-Gm-Message-State: AOJu0YyTY+CafM3Z+VKkpJkR7jLaP9vAMqzxvdfZk0EwGRKEDQK6Amlq
	zQUOkdCPBXHc7mh2BrRSD7BXqVhsppaKNs5pYtnywamzW0GZhst6WcHic37n7qsJuWQ8Ga2189P
	ETweEmZPUiUGV1YF+DttGx9x7N8gaEoA=
X-Received: by 2002:a05:6214:5185:b0:89a:c88:1fb4 with SMTP id
 6a1803df08f44-89a81fe41edmr247946196d6.52.1773749638930; Tue, 17 Mar 2026
 05:13:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316174550.462177-1-maciej.fijalkowski@intel.com>
 <20260316174550.462177-6-maciej.fijalkowski@intel.com> <87v7euq00g.fsf@all.your.base.are.belong.to.us>
 <abkzhZex8RtzNLdm@boxer>
In-Reply-To: <abkzhZex8RtzNLdm@boxer>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Tue, 17 Mar 2026 13:13:48 +0100
X-Gmail-Original-Message-ID: <CAJ+HfNh7z4ixgKiAON1rLZJ4gOW0piRam05wg3-qe1n_=6y3uA@mail.gmail.com>
X-Gm-Features: AaiRm52dLnnpovfMBmkDCVK3dZuOOfMS6DegDWG6l33XxAMg49NDsrzxOOmqdGg
Message-ID: <CAJ+HfNh7z4ixgKiAON1rLZJ4gOW0piRam05wg3-qe1n_=6y3uA@mail.gmail.com>
Subject: Re: [PATCH net 5/6] selftests: bpf: fix pkt grow tests
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	larysa.zaremba@intel.com, aleksander.lobakin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.45 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.71)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268585-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C0CC82A9A35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 at 11:57, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Tue, Mar 17, 2026 at 10:27:11AM +0100, Bj=C3=B6rn T=C3=B6pel wrote:
> > Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
> >
> > > Skip tail adjust tests in xskxceiver for SKB mode as it is not very
> > > friendly for it. multi-buffer case does not work as xdp_rxq_info that=
 is
> > > registered for generic XDP does not report ::frag_size. The non-mbuf
> > > path copies packet via skb_pp_cow_data() which only accounts for
> > > headroom, leaving us with no tailroom and causing underlying XDP prog=
 to
> > > drop packets therefore.
> > >
> > > For multi-buffer test on other modes, change the amount of bytes we u=
se
> > > for growth, assume worst-case scenario and take care of headroom and
> > > tailroom.
> > >
> > > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > ---
> > >  .../selftests/bpf/prog_tests/test_xsk.c       | 21 ++++++++++++++++-=
--
> > >  1 file changed, 18 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tool=
s/testing/selftests/bpf/prog_tests/test_xsk.c
> > > index 7e38ec6e656b..a496f1784b66 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> > > @@ -2551,16 +2551,31 @@ int testapp_adjust_tail_shrink_mb(struct test=
_spec *test)
> > >
> > >  int testapp_adjust_tail_grow(struct test_spec *test)
> > >  {
> > > +   if (test->mode =3D=3D TEST_MODE_SKB)
> > > +           return TEST_SKIP;
> > > +
> > >     /* Grow by 4 bytes for testing purpose */
> > >     return testapp_adjust_tail(test, 4, MIN_PKT_SIZE * 2);
> > >  }
> > >
> > >  int testapp_adjust_tail_grow_mb(struct test_spec *test)
> > >  {
> > > +   u32 grow_size;
> > > +
> > > +   if (test->mode =3D=3D TEST_MODE_SKB)
> > > +           return TEST_SKIP;
> > > +
> > > +   /* worst case scenario is when underlying setup will work on 3k
> > > +    * buffers, let us account for it; given that we will use 6k as
> > > +    * pkt_len, expect that it will be broken down to 2 descs each
> > > +    * with 3k payload;
> > > +    *
> > > +    * 4k is truesize, 3k payload, 256 HR, 320 TR;
> > > +    */
> > > +   grow_size =3D XSK_UMEM__MAX_FRAME_SIZE - XSK_UMEM__LARGE_FRAME_SI=
ZE - 256 - 320;
> >
> > nit: Use defines, XDP_PACKET_HEADROOM, and maybe
> > SKB_DATA_ALIGN(sizeof(struct skb_shared_info))?
>
> umm right, but the latter would have to be exposed via UAPI ?

Ah, good point. Another option would be document in the comments where
the magic numbers come from.

