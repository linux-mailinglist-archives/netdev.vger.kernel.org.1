Return-Path: <netdev+bounces-135613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842EA99E6F8
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 13:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49AE32857BD
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358EB1E7669;
	Tue, 15 Oct 2024 11:47:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C8B1D0492
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992853; cv=none; b=UGX+vw0tzcinvdNPW/74s6ZSegdAhJDmICx2ImJ/KKli8lVVVvrWEIbQtP44QoDdm+cFP4ExvIcVPoVcfGs2BlUw5HdTMaPOM8iI4f0pzRcpUS6IGYls7aUJ0rZdm/lU0QdzClc2s0GrmaRulTMFTHAs3qEeUA1JCTRanrC4zuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992853; c=relaxed/simple;
	bh=Mwj8t0g9irVrQ+b+ekQ9LDH1eHLuPOL0ztAzSYX+vGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YHbUj9CGBzCLvMgaqR3CkFkKeWZnhp5QCW/m7kz82UviPsimCHEbgk/76Wl8EMhZ9g2uzJFBeZPasJCbNgzXx87StTHKke2K1OgI0RtoeqKs2Q1UCWOodCXCsJeHz5jNwqGlf+ubsMqsPYSOrhzqd97+PADHvCpCSBb/e3rbTvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-Ijlk96LgNIOVXVw2fCSE6w-1; Tue,
 15 Oct 2024 07:47:26 -0400
X-MC-Unique: Ijlk96LgNIOVXVw2fCSE6w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AE061955F40;
	Tue, 15 Oct 2024 11:47:24 +0000 (UTC)
Received: from hog (unknown [10.39.192.7])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4029F3000198;
	Tue, 15 Oct 2024 11:47:21 +0000 (UTC)
Date: Tue, 15 Oct 2024 13:47:18 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>, Ales Nezbeda <anezbeda@redhat.com>
Cc: netdev@vger.kernel.org, sdf@fomichev.me, davem@davemloft.net
Subject: Re: [PATCH net v2] selftests: rtnetlink: add 'ethtool' as a
 dependency
Message-ID: <Zw5WRhrNqJCZp1mf@hog>
References: <20240909083410.60121-1-anezbeda@redhat.com>
 <20240909170737.1dbaa027@kernel.org>
 <CAL_-bo0QJJJootMQysNSLNmu0Fps3dqjPE0F0_=R23h7GqAkfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAL_-bo0QJJJootMQysNSLNmu0Fps3dqjPE0F0_=R23h7GqAkfQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

(this thread probably got buried in your inbox due to netconf/LPC)

2024-09-16, 11:18:13 +0200, Ales Nezbeda wrote:
> On Tue, Sep 10, 2024 at 2:17=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > Don't think it qualifies as a fix, it's an improvement.
>=20
> Well, if the `ethtool` is not present the test will fail with dubious
> results that would indicate that the test failed due to the system not
> supporting MACsec offload, which is not true. The error message
> doesn't reflect what went wrong, so I thought about it as an issue
> that is being fixed.

I also think it's a (pretty minor) fix, since the error message is
really misleading.

> If this is not the case please let me know,
> because based on the docs 'Fixes: tag indicates that the patch fixes
> an issue', which I would think that wrong error message is an issue. I
> might be wrong here though, so if the definition of 'issue' is more
> restrictive I can remove the 'Fixes:' tag.
>=20
> > You can use net/forwarding's lib.sh in net/, altnames.sh already
> > uses it.
>=20
> I see, the problem (and probably should have mentioned it in the patch
> itself) is that `rtnetlink.sh` is using one of the variables defined
> in the `net/lib.sh` - specifically `ksft_skip`.

net/forwarding/lib.sh seems to include net/lib.sh, and uses ksft_skip
too, so there should be no problem:

    source "$net_forwarding_dir/../lib.sh"
   =20
    #######################################################################=
#######
    # Sanity checks
   =20
    check_tc_version()
    {
    =09tc -j &> /dev/null
    =09if [[ $? -ne 0 ]]; then
    =09=09echo "SKIP: iproute2 too old; tc is missing JSON support"
    =09=09exit $ksft_skip
    =09fi
    }


> Furthermore, I felt
> like a more clean approach would be to add the `require_command()` to
> the `net/lib.sh` so that other tests down the road could potentially
> use it as well. Picking a different `lib.sh` would mean either

Moving require_command from net/forwarding/lib.sh to net/lib.sh also
seems pretty reasonable.

--=20
Sabrina


