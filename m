Return-Path: <netdev+bounces-277206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBb3NyJf2GmZcggAu9opvQ
	(envelope-from <netdev+bounces-277206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 04:23:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 447D63D15DF
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 04:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD432300B9C0
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 02:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E510A2DAFBB;
	Fri, 10 Apr 2026 02:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1lnH9As"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01F52BCF4C;
	Fri, 10 Apr 2026 02:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775787802; cv=none; b=XoSHMtANImNeaeiThNt5oyfoRb3wN2dvS6VBA6j3DRXY0Op/7UZ85X2thybDcTc+6z3A4eRc2H5jzg6HgALUTHMxqUpJTTnz84qfgRa4bgSbkQPo8/1240SDr9jg9KMhnQ+jidULvRrGZC+zNCVJN49pFgGibJ7cBwY8rkrhtwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775787802; c=relaxed/simple;
	bh=YwNw2G4QEfrLK8XwvDWLLP6/jGzcHPp5ZDH4ieyn/uM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GsAsGEsgeZ8qub9REKzBLOhH6YI8ezCghBlLthHUQHSugvXF62Lz2mvWS2VXDpwPGcB6e8KgmAqGXgROhThEpKt0vCSNaWDZPW5QLHo9TSq7nBOb9Kk/e8FjFjA+ErnEZCC0WlPi5G3Vq+djs0DubxS8OfE3DRFnryS41eHW+Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1lnH9As; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA733C4CEF7;
	Fri, 10 Apr 2026 02:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775787802;
	bh=YwNw2G4QEfrLK8XwvDWLLP6/jGzcHPp5ZDH4ieyn/uM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g1lnH9AswsGS7fwu5XH5eBh0GQWNQyG+Yz0PFZkOvjp+YoR8iJp/E2CHVjHlb3JP/
	 WTh1ptirI1bgsRQ5LINki1kxSBJCfcIA74lMc0u5Crgv/oj0tGl+Udont2szv9li08
	 jVrkMAAb+05FC7s5z1WGC3pbY2ehmW1vQtiqEyR9Sbf5uSnA2trGbINffcGl9VRkS2
	 E5BbeRQRKFeicH9UkEwiPxXrcbN5Hp3AD4WQXxe1T2j5a6lAz2mzUpXz7ay8tcjhyS
	 UPa6W1iElrWK0l79WjvdxkGMcZPhlf5cT7XbCBGag9A3HIT25YW1Q1u1jYF7aNUic4
	 4Sq84QNVvFSEw==
Date: Thu, 9 Apr 2026 19:23:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xu Du <xudu@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 2/4] selftests: drv-net: tso: add helpers for
 double tunneling GSO
Message-ID: <20260409192320.1b0a90be@kernel.org>
In-Reply-To: <CAA92Kxmka9=GEvNwxOy7pSEuudqsaF3WGJttyQpYEkTyyYhgLg@mail.gmail.com>
References: <cover.1775527362.git.xudu@redhat.com>
	<b65f95793e03c1cb3ed3af4e1b2bee89fcf7e648.1775527362.git.xudu@redhat.com>
	<20260407080844.35368eaa@kernel.org>
	<CAA92KxmXOpH=CUqEdVV2948XhU1oFh8PBYLUt=ktSsK3sOh40g@mail.gmail.com>
	<20260408172741.39e65ab3@kernel.org>
	<CAA92Kxmka9=GEvNwxOy7pSEuudqsaF3WGJttyQpYEkTyyYhgLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-277206-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 447D63D15DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 9 Apr 2026 15:35:21 +0800 Xu Du wrote:
> > > I want to test the gro-hint parameter functionality of the GENEVE tunnel,
> > > so I intend to use YNL for the testing. I am conducting the test between
> > > two machines using SSH type. I want to add the gro-hint parameter on
> > > both the local and remote nodes; however, I am unable to invoke class
> > > RtnlFamily on the remote node via SSH.  
> >
> > Oh. But that's not really what you're doing:
> >
> > +def ynlcli(family, args, json=None, ns=None, host=None):
> > +    if (KSFT_DIR / "kselftest-list.txt").exists():
> > +        cli = KSFT_DIR / "net/lib/ynl/pyynl/cli.py"
> > +        spec = KSFT_DIR / f"net/lib/specs/{family}.yaml"
> > +    else:
> > +        cli = KSRC / "tools/net/ynl/pyynl/cli.py"
> > +        spec = KSRC / f"Documentation/netlink/specs/{family}.yaml"
> > +    if not cli.exists():
> > +        raise FileNotFoundError(f"cli not found at {cli}")
> > +    args = f"--spec {spec} --no-schema {args}"
> > +    return tool(cli.as_posix(), args, json=json, ns=ns, host=host, shell=True)
> >
> > You're not deploying anything to the remote system.
> > Are you assuming that the remote system magically has the same
> > filesystem layout?
> >
> > You can use the ynl CLI but it has to be whatever version is on
> > the remote system. Just call ynl --family rt-link, don't dig
> > around for the spec paths etc.
> >  
> 
> In fact, I have tested this from two different locations. The first is in
> tools/testing/selftests/drivers/net/hw/ using python3 tso.py,
> which utilizes the specs located in Documentation/netlink/specs/.
> The second follows the testing methodology described in the
> README.rst of tools/testing/selftests/drivers/net/, which uses the specs
> in net/lib/specs/. Based on this, I include that different processes utilize
> different spec locations.
> I also referred to the implementation in net/lib/py/ynl.py, which employs
> a similar handling logic. Both using the source code repository and
> installing the package can meet the requirements for remote testing.

On the local system you have Python bindings.
On the remote system you can't assume KSFT_DIR or KSRC exist.

You can use ynl CLI on the remote system, like we use ip, tc etc.
But then just use --family rt-link, don't try to find the filesystem
path to the spec.

Is this clear now? Am I misunderstanding your misunderstanding?

